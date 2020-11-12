package com.siren.impact.sms.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.foc.Globals;
import com.foc.list.FocListOrder;

import siren.fenix.covid.sms.SmsContent;
import siren.fenix.covid.sms.SmsMessage;
import siren.fenix.covid.sms.SmsMessageList;
import siren.fenix.covid.sms.smpp.FenixSMPPProvider;

public class SmsQueue implements Runnable {
	private int SMS_BUFFER_SLEEP_BEFORE_REFILL = 1000*20; // 20 Sec
	private int WORKER_SLEEP_BETWEEN_2_SENDING = 100;
	private int WORKER_SLEEP_BETWEEN_2_SENDING_WHEN_SUCCESSIVE_NO_RESERVE = 1000;
	private int SMS_BUFFER_MIN_SIZE_TO_REFILL  = 10; 
	private int NBR_OF_WORKERS = 5;

	private boolean started = false;
	
	private ArrayList<SmsContent>     messageList = null;
	private HashMap<Long, SmsContent> messageMap  = null;
	private ArrayList<SmsQueueWorker> workerList  = null;
	
	public SmsQueue(){
		messageList = new ArrayList<SmsContent>();
		messageMap = new HashMap<Long, SmsContent>();
		
		workerList = new ArrayList<SmsQueueWorker>();
		for (int i=0; i<NBR_OF_WORKERS; i++) {
			SmsQueueWorker worker = new SmsQueueWorker(this);
			workerList.add(worker);
		}
	}
	
	public void dispose() {
		messageList = null;
		for(int i=0; i<workerList.size(); i++) {
			SmsQueueWorker worker = workerList.get(i);
			worker.dispose();
		}
		workerList = null;
		messageMap = null;
	}

	public int getWORKER_SLEEP_BETWEEN_2_SENDING() {
		return WORKER_SLEEP_BETWEEN_2_SENDING;
	}
	
	public int getWORKER_SLEEP_BETWEEN_2_SENDING_WHEN_SUCCESSIVE_NO_RESERVE() {
		return WORKER_SLEEP_BETWEEN_2_SENDING_WHEN_SUCCESSIVE_NO_RESERVE;
	}
	
	public synchronized void pushSms(SmsMessage message) {
		if (message != null && messageList != null && messageMap != null) {
			long ref = message.getReferenceInt();
			SmsContent content = messageMap.get(ref);
			if (content == null) {
				content = message.newSmsContent();
				if (content != null) {
					messageList.add(content);
					messageMap.put(content.getRef(), content);
				}
			}
		}
	}

	public synchronized SmsContent reserveSms() {
		SmsContent selected = null;
		if(messageList != null) {
			for(int i=0; i<messageList.size() && selected == null; i++) {
				SmsContent content = messageList.get(i);
				if(!content.isInProgress()) {
					content.setInProgress(true);
					selected = content;
				}
			}
		}
		return selected;
	}
	
	public synchronized void removeSms(SmsContent content) {
		if (content != null) {
			if(messageList != null) messageList.remove(content);
			if(messageMap != null) messageMap.remove(content.getRef());
		}
	}
	
	public synchronized void refillSms() {
		SmsMessageList smsMessageList = new SmsMessageList();
		smsMessageList.filterOnStatus(SmsMessage.SMS_STATUS_READY);
		smsMessageList.loadIfNotLoadedFromDB();
		smsMessageList.setListOrder(new FocListOrder(SmsMessage.getFocDesc().getFieldIDByName(SmsMessage.FIELD_DateTime)));

		Globals.logString("Sending " + smsMessageList.size() + " SMS messages");
		for(int i = 0; i < smsMessageList.size(); i++){
			SmsMessage smsMessage = (SmsMessage) smsMessageList.getFocObject(i);
			pushSms(smsMessage);
		}
		smsMessageList.dispose();
	}
	
	private void startWorkers() {
		for(int i=0; i<workerList.size(); i++) {
			SmsQueueWorker worker = workerList.get(i);
			worker.setWorkerID(i);
			worker.start();
		}
	}
	
	@Override
	public void run() {

		FenixSMPPProvider.getInstance();
		startWorkers();
		
		while (true){
			try{
				if(messageList.size() < SMS_BUFFER_MIN_SIZE_TO_REFILL) {
					refillSms();
				}
				
				Thread.sleep(SMS_BUFFER_SLEEP_BEFORE_REFILL);				
			}catch (InterruptedException e){
				Globals.logException(e);
			}
		}

	}

	public void start() {
		if (!started) {
			Thread thread = new Thread(this);
			thread.run();
			started = true;
		}
	}
	
	private static SmsQueue instance = null;
	public static SmsQueue getInstance(){
		if (instance == null) {
			instance = new SmsQueue();
		}
		return instance;
	}
	
}

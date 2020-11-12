package com.siren.impact.sms.service;

import com.foc.Globals;

import siren.fenix.covid.sms.SmsContent;

public class SmsQueueWorker implements Runnable {
	
	private SmsQueue q        = null;
	private int      workerID = 0;
	private boolean  idle     = true; 
	private boolean  started  = false;
	
	public SmsQueueWorker(SmsQueue q) {
		this.q = q;
	}
	
	public void dispose() {
		q = null;
	}

	public boolean isIdle() {
		return idle;
	}

	public void setIdle(boolean idle) {
		this.idle = idle;
	}
	
	public int getWorkerID() {
		return workerID;
	}

	public void setWorkerID(int workerID) {
		this.workerID = workerID;
	}

	public void start() {
		if (!started) {
			Thread thread = new Thread(SmsQueueWorker.this);
			thread.start();
			started = true;
		}
	}
	
	@Override
	public void run() {
		System.out.println("Worker Beginning");
		int MAX_CONSECUTIVE_NON_RESERVE_BEFORE_SLOWING = 5;
		int consecutiveNoReserve = 0;
		while(true) {
			try{				
				if(q != null) {
					if (consecutiveNoReserve >= MAX_CONSECUTIVE_NON_RESERVE_BEFORE_SLOWING) {
						Thread.sleep(q.getWORKER_SLEEP_BETWEEN_2_SENDING_WHEN_SUCCESSIVE_NO_RESERVE());
					} else {
						Thread.sleep(q.getWORKER_SLEEP_BETWEEN_2_SENDING());
					}
					SmsContent content = q.reserveSms();
					if(content != null) {
						consecutiveNoReserve = 0;
						content.send(true);
						q.removeSms(content);
					} else {
						consecutiveNoReserve++;
						if(consecutiveNoReserve > MAX_CONSECUTIVE_NON_RESERVE_BEFORE_SLOWING) consecutiveNoReserve = MAX_CONSECUTIVE_NON_RESERVE_BEFORE_SLOWING;
					}
				}
				
			}catch (InterruptedException e){
				Globals.logException(e);
			}				
		}
	}

}

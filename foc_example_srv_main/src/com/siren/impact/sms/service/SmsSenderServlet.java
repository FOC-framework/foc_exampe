package com.siren.impact.sms.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import siren.fenix.covid.services.FenixMicroServlet;

public class SmsSenderServlet extends FenixMicroServlet {
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SessionAndApplication sessionAndApp = pushSessionLogin(request, response);
	  if(sessionAndApp != null) {

	  	SmsQueue queue = SmsQueue.getInstance();
	  	if (queue != null) {
	  		queue.start();
	  	}
	  	
//	  	sessionAndApp.logout();
	  }
	}
	
}
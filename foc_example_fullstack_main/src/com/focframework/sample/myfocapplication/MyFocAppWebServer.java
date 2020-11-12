package com.focframework.sample.myfocapplication;

import com.foc.FocMainClass;
import com.foc.Globals;
import com.foc.web.modules.business.BusinessEssentialsWebModule;
import com.foc.web.server.FocDefaultWebServer;
import com.foc.web.server.FocWebServer;
import com.foc.web.unitTesting.FocUnitDictionary;
import com.focframework.sample.myfocapplication.employee.EmployeeModule;

@SuppressWarnings("serial")
public class MyFocAppWebServer extends FocDefaultWebServer {// FocWebServer {

	private static String VERSION_TITLE = "My Foc Application - 2.0.08 (15/12/2017)";
		
	protected FocMainClass newMainClass() {
		Globals.logString("Init Web Server");
		String[] args = { "/IS_SERVER:1", "/nol:1" };
		MyFocAppMainClass main = new MyFocAppMainClass(this, args);
		main.init2(args);
		main.init3(args);
		return main;
	}

	@Override
	protected FocUnitDictionary newUnitDictionary() {
		return new FocUnitDictionary();
	}

	public void declareModules() {
		super.declareModules();
		setVersionTitle(VERSION_TITLE);
		FocWebServer.getInstance().modules_Add(new BusinessEssentialsWebModule());
	}

	@Override
	public void modules() {
		super.modules();
		
		// Employee Module
		EmployeeModule employeeModule = new EmployeeModule();
		employeeModule.declare();
	}
}

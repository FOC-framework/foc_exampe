package com.focframework.sample.myfocapplication.autotesting;

import com.foc.access.FocLogger;
import com.foc.web.unitTesting.FocUnitDictionary;
import com.foc.web.unitTesting.FocUnitTestingSuite;

public class MyFocApplicationTestSuite extends FocUnitTestingSuite {

	public MyFocApplicationTestSuite(FocUnitDictionary dictionary, String name){
		super(dictionary, name, null);
		setParsingDone(true);
		dictionary.put(this);
	}
	
	@Override
	public void runSuite() {
		FocLogger.getInstance().openNode("Suite : " + this.getName());		
		new EmployeeTest("Employee Test", this).runTest();		
		FocLogger.getInstance().closeNode();
	}
}

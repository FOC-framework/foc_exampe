package com.focframework.sample.myfocapplication;

import com.foc.vaadin.FocWebVaadinWindow;
import com.foc.web.unitTesting.FocUnitDictionary;
import com.focframework.sample.myfocapplication.autotesting.MyFocApplicationTestSuite;

public class MyFocApplicationMainWindow extends FocWebVaadinWindow {

	protected void executeAutomatedTesting() {
		FocUnitDictionary dictionary = new FocUnitDictionary();
		MyFocApplicationTestSuite suite = new MyFocApplicationTestSuite(dictionary, "My Testing Suite");
		suite.runSuite();
	};
}

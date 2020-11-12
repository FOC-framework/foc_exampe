package com.focframework.sample.myfocapplication;

import com.fab.FabModule;
import com.fab.parameterSheet.ParameterSheetFactory;
import com.foc.Application;
import com.foc.business.currency.CurrencyModule;
import com.foc.business.notifier.NotifierModule;
import com.foc.business.workflow.WorkflowModule;
import com.foc.db.migration.MigrationModule;
import com.foc.link.LinkModule;
import com.foc.pivot.PivotModule;
import com.foc.web.server.FocDefaultMainClass;
import com.foc.web.server.FocDefaultWebServer;

public class MyFocAppMainClass extends FocDefaultMainClass {

	public MyFocAppMainClass(FocDefaultWebServer server, String[] args) {
		super((FocDefaultWebServer) server, args);
	}
	
	protected void declareModules(Application app){
	    MigrationModule.getInstance().declare();    
	    FabModule.getInstance().declare();    
	    WorkflowModule.getInstance().declare();
	    NotifierModule.getInstance().declare();
	    PivotModule.getInstance().declare();
	    LinkModule.getInstance().declare();
	    ParameterSheetFactory.setEmptyParamSetAsDefaultParamSet();
	    CurrencyModule.includeCurrencyModule();
	}
}
package com.focframework.sample.myfocapplication.autotesting;

import com.foc.vaadin.gui.xmlForm.FocXMLAttributes;
import com.foc.web.unitTesting.FocUnitDictionary;
import com.foc.web.unitTesting.FocUnitTest;
import com.foc.web.unitTesting.FocUnitTestingCommand;
import com.foc.web.unitTesting.FocUnitTestingSuite;

public class EmployeeTest extends FocUnitTest {

	private FocUnitTestingCommand cmd = null; 
	
	public EmployeeTest(String name, FocUnitTestingSuite suite) {
		super(name, suite, null);
		cmd = new FocUnitTestingCommand(this, "Testing Employee Module", new FocXMLAttributes());
	}	

	@Override
  public void runTest(){
		boolean created = false;
		created = FocUnitDictionary.getInstance().getLogger().openTest("Testing Employee Reports");
		/*
		menu_Click("MNU_EMPLOYEE_LIST");
		long ref = cmd.table_Add("DB_TABLE_NAME_TABLE");
		cmd.component_SetValue("FirstName", "John", false);
		cmd.component_SetValue("LastName", "Smith", false);
		cmd.component_SetValue("StartShift", "08:00", false);
		cmd.component_SetValue("EndShift", "17:00", false);
		cmd.component_SetValue("Salary", "1000", false);
		cmd.button_ClickApply();
		*/
	}
	
	public void dispose(){
		super.dispose(FocUnitDictionary.MODE_DISPOSE);
		if(cmd != null){
			cmd.dispose();
			cmd = null;
		}
	}
}

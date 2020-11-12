package com.focframework.sample.myfocapplication.employee;

import com.foc.list.FocList;
import com.foc.menuStructure.FocMenuItem;
import com.foc.menuStructure.IFocMenuItemAction;
import com.foc.vaadin.FocWebModule;
import com.foc.vaadin.gui.menuTree.FVMenuTree;
import com.foc.vaadin.gui.menuTree.FocMenuItemAbstractAction_WithAddCommand;
import com.focframework.sample.convertDB2Entity.ConvertDB2Entity;

public class EmployeeModule extends FocWebModule {

	public static final int VERSION_ID = 1000;
	public static final String MODULE_NAME = "Employee";
	public static final String MNU_TODO_ROOT = "MNU_Tasks";
	public static final String MNU_EMPLOYEE_LIST = "MNU_EMPLOYEE_LIST";

	public EmployeeModule() {
		super(MODULE_NAME, "Employee Management", "com.focframework.sample.myfocapplication.employee", "com.focframework.sample.myfocapplication.employee.gui", "Todo tasks 1.0", VERSION_ID);
		//addPackages("siren.isf.fenix.report418.join", "siren.isf.fenix.report418.join.gui");
	}

	@Override
	public void declareFocObjectsOnce(){
		super.declareFocObjectsOnce();
	}
				
	@Override
	public void menu_FillMenuTree(FVMenuTree menuTree, FocMenuItem fatherMenuItem) {
		FocMenuItem mainMenu = menuTree.pushRootMenu(MNU_TODO_ROOT, "Employee Management");
		FocMenuItem menuItem = null;

		menuItem = mainMenu.pushMenu(MNU_EMPLOYEE_LIST, "Employee List");
		menuItem.setMenuAction(new FocMenuItemAbstractAction_WithAddCommand(menuItem) {
			@Override
			public FocList getFocList() {
				FocList list = Employee.getFocDesc().getFocList(FocList.LOAD_IF_NEEDED);
				return list;
			}
		});	
		
		//Under dev
		//---------
		/*
		menuItem = mainMenu.pushMenu("REVERSE_ENGINEERING", "Convert Database 2 Entity");
		menuItem.setMenuAction(new IFocMenuItemAction() {
			@Override
			public void actionPerformed(Object navigationWindow, FocMenuItem menuItem, int extraActionIndex) {
				ConvertDB2Entity convert = new ConvertDB2Entity();
				convert.dispose();
			}
		});
		*/
	}
}

package com.focframework.sample.myfocapplication.employee;

import com.foc.annotations.model.FocChoice;
import com.foc.annotations.model.FocEntity;
import com.foc.annotations.model.fields.FocBoolean;
import com.foc.annotations.model.fields.FocDate;
import com.foc.annotations.model.fields.FocDouble;
import com.foc.annotations.model.fields.FocMultipleChoice;
import com.foc.annotations.model.fields.FocString;
import com.foc.annotations.model.fields.FocTime;
import com.foc.desc.FocConstructor;
import com.foc.desc.parsers.ParsedFocDesc;
import com.foc.desc.parsers.pojo.PojoFocObject;
import com.foc.list.FocList;

@FocEntity
public class Employee extends PojoFocObject {

	public static final String DBNAME = "Employee";
	
	@FocString(mandatory=true, size=200)	
	public static final String FNAME_FirstName = "FirstName";
	@FocString(mandatory=true, size=200)
	public static final String FNAME_LastName = "LastName";
	@FocDate
	public static final String FNAME_DateOfBirth = "DateOfBirth";
	@FocBoolean
	public static final String FNAME_HasInsurance = "HasInsurance";
	@FocTime
	public static final String FNAME_StartShift = "StartShift";
	@FocTime
	public static final String FNAME_EndShift = "EndShift";	
	@FocDouble
	public static final String FNAME_Salary = "Salary";	
	@FocMultipleChoice(choices={
			@FocChoice(id=0, title="Disabled"), 
			@FocChoice(id=1, title="Probation"), 
			@FocChoice(id=2, title="Employee")})
	public static final String FNAME_EmployeeStatus = "EmployeeStatus";
	
	public Employee(FocConstructor constr) {
		super(constr);
	}

	@Override
	public void dispose() {
		super.dispose();
	}

	public static ParsedFocDesc getFocDesc() {
		return ParsedFocDesc.getInstance(DBNAME);
	}

	public String getFirstName() {
		return (String) getPropertyString(FNAME_FirstName);
	}
	
	public void setFirstName(String firstName) {
		setPropertyString(FNAME_FirstName, firstName);
	}

	public String getLastName() {
		return (String) getPropertyString(FNAME_LastName);
	}
	
	public void setLastName(String firstName) {
		setPropertyString(FNAME_LastName, firstName);
	}

	public int getEmployeeStatus() {
		return getPropertyInteger(FNAME_EmployeeStatus);
	}

	public void setEmployeeStatus(int value) {
		setPropertyInteger(FNAME_EmployeeStatus, value);
	}
	
	public FocList getAchievementList(){
		return getPropertyList(Achievement.getFocDesc().getFieldName_ForList());
	}
}

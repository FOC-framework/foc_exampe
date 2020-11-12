package com.focframework.sample.myfocapplication.employee;

import com.foc.annotations.model.FocEntity;
import com.foc.annotations.model.fields.FocDate;
import com.foc.annotations.model.fields.FocForeignEntity;
import com.foc.annotations.model.fields.FocInteger;
import com.foc.annotations.model.fields.FocString;
import com.foc.desc.FocConstructor;
import com.foc.desc.parsers.ParsedFocDesc;
import com.foc.desc.parsers.pojo.PojoFocObject;

@FocEntity
public class Achievement extends PojoFocObject {

	public static final String DBNAME = "Achievement";
	
	@FocString(mandatory=true, size=200)	
	public static final String FNAME_Description = "Description";
	@FocDate
	public static final String FNAME_Date = "Date";
	@FocInteger
	public static final String FNAME_Rating = "Rating";	
	@FocForeignEntity(table="Employee", cascade=true, saveOnebyOne=false)
	public static final String FNAME_Employee = "Employee";	
	
	public Achievement(FocConstructor constr) {
		super(constr);
	}

	@Override
	public void dispose() {
		super.dispose();
	}

	public static ParsedFocDesc getFocDesc() {
		return ParsedFocDesc.getInstance(DBNAME);
	}
}

package com.focframework.sample.convertDB2Entity;

import com.foc.focDataSourceDB.db.adaptor.DBReverseEngineering;
import com.foc.focDataSourceDB.db.adaptor.ITableFilter;
import com.foc.focDataSourceDB.db.connectionPooling.ConnectionCredentials;

public class ConvertDB2Entity {

	private DBReverseEngineering reverseEngineering = null;
	
	public ConvertDB2Entity(){
		ConnectionCredentials credentials = new ConnectionCredentials();
		credentials.setDrivers("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//		credentials.setUrl("localhost:49172;instance=SQLEXPRESS;databaseName=isfdev;integratedSecurity=true;useUnicode=true;characterEncoding=UTF-8;");
		credentials.setUrl("jdbc:sqlserver://localhost:49172;instance=SQLEXPRESS;databaseName=fenix_inspection;integratedSecurity=true;useUnicode=true;characterEncoding=UTF-8;");
		credentials.setUsername("root");
		credentials.setPassword("root");
		
		reverseEngineering = new DBReverseEngineering("REVERSE_DB", 
				"f:/eclipsews_focSamples", 
				"myfocapplication/src/main/java", 
				"com.focframework.sample.myfocapplication.reversed");
		
		reverseEngineering.setTableFilter(new ITableFilter() {
			@Override
			public boolean isIncluded(String tableName) {
				return tableName.toUpperCase().equals("CRIMETYPE") || tableName.toUpperCase().startsWith("ANTITORTURE");
			}
			
			@Override
			public void dispose() {
			}
		});
		
		reverseEngineering.writeCode();
		reverseEngineering.dispose();
	}
	
	public void dispose(){
		
	}
}

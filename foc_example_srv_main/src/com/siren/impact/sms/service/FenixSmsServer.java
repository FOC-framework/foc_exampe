package com.siren.impact.sms.service;

import java.util.TimeZone;

import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.HttpConfiguration;
import org.eclipse.jetty.server.HttpConnectionFactory;
import org.eclipse.jetty.server.NCSARequestLog;
import org.eclipse.jetty.server.SecureRequestCustomizer;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;
import org.eclipse.jetty.server.SslConnectionFactory;
import org.eclipse.jetty.server.handler.HandlerCollection;
import org.eclipse.jetty.server.handler.RequestLogHandler;
import org.eclipse.jetty.server.session.SessionHandler;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.util.ssl.SslContextFactory;

import com.foc.Globals;
import com.foc.util.Utils;

import siren.fenix.covid.services.GCCallServlet;

public class FenixSmsServer {
	
	public static boolean noJWT = false;

	public static void main(String[] args) throws Exception {
		String sslAlias = null; 
		String logDir = null;
		int    port = 2600;
		int    maxThread = 10000;		
		
		if(args != null) {
			for(int i=0; i<args.length; i++) {
				String token = args[i];
				if(token.startsWith("https:")) {
					sslAlias = token.substring("https:".length());
				}

				if(token.startsWith("maxThread:")) {
					String maxThreadStr = token.substring("maxThread:".length());
					if(maxThreadStr != null) {
						maxThread = Utils.parseInteger(maxThreadStr, 10000);
					}
				}
				
				if(token.startsWith("port:")) {
					String portStr = token.substring("port:".length());
					if (portStr != null) {
						port = Utils.parseInteger(portStr, 2600);
					}
				}
				
				if(token.startsWith("logdir:")) {
					logDir = token.substring("logdir:".length());
				}
			}
			
			if(args.length > 0) {
				String value = args[0];
				if(value.startsWith("https:")) {
					sslAlias = value.substring("https:".length());
				}
			}
			if(args.length > 1) {
				noJWT = Boolean.valueOf(args[1]);
			}
		}
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Beirut"));
		FenixSmsServer fenixServer = new FenixSmsServer();
		fenixServer.setCertificateAlias(sslAlias);
		fenixServer.setPort(port);
		fenixServer.setLogDir(logDir);
		fenixServer.setMaxThread(maxThread);
		fenixServer.start();
	}

	public void addServlets(ServletContextHandler contextHandler) {
		contextHandler.addServlet(GCCallServlet.class, "/gc");
		contextHandler.addServlet(SmsSenderServlet.class, "/start");
	}

	// -----------------------------------------------------
	// -----------------------------------------------------
	// -----------------------------------------------------

	private int    port = 0;
	private int    maxThread = 0;
	private String certificateAlias = null;
	private String firstCallService = "start";
	private String logDir = null;
	
	public void start() throws Exception {
		initJsonFieldFilter();
		
		ServletContextHandler contextHandler = new ServletContextHandler(ServletContextHandler.SESSIONS);
		contextHandler.setSessionHandler(new SessionHandler());
		addServlets(contextHandler);
		
		// contextHandler.setInitParameter("allowedOrigins", "*");
		// contextHandler.setInitParameter("allowedMethods", "GET, POST");


		//With Log
		//-------- 
		HandlerCollection handlers = new HandlerCollection();
				
		// log using NCSA (common log format)
		// http://en.wikipedia.org/wiki/Common_Log_Format
		NCSARequestLog requestLog = new NCSARequestLog();
		requestLog.setFilename(getLogDir()+"/yyyy_mm_dd.request.log");//"/tmp/jetty/yyyy_mm_dd.request.log"
		requestLog.setFilenameDateFormat("yyyy_MM_dd");
		requestLog.setRetainDays(90);
		requestLog.setAppend(true);
		requestLog.setExtended(true);
		requestLog.setLogCookies(false);
		requestLog.setLogTimeZone(TimeZone.getDefault().getID());
		RequestLogHandler requestLogHandler = new RequestLogHandler();
		requestLogHandler.setRequestLog(requestLog);
		
		handlers.addHandler(contextHandler);
		handlers.addHandler(requestLogHandler);

		Server server = new Server(port);
		server.setHandler(handlers);
		/*
		QueuedThreadPool threadPool = new QueuedThreadPool();
		threadPool.setMaxThreads(getMaxThread());
		threadPool.setMinThreads(8);
		server.setThreadPool(threadPool);
		*/

		//--------
		
//		Server server = new Server(port);
//		server.setHandler(contextHandler);
		
		if(!Utils.isStringEmpty(certificateAlias)) configureSSL(server);

		server.start();
		Thread th = new Thread(new Runnable() {
			@Override
			public void run() {
				try{
					Thread.sleep(1000);
					firstCall();
				}catch (InterruptedException e){
					e.printStackTrace();
				}
			}
		});
		th.start();
		server.join();
	}
	
	private void configureSSL(Server server) {
		Globals.logString("checking : configureSSLIfRequired()");
			
		Globals.logString("https configuring");
		
		HttpConfiguration http_config = new HttpConfiguration();
		http_config.setSecureScheme("https");
		http_config.setSecurePort(port);
		
		HttpConfiguration https_config = new HttpConfiguration(http_config);
		https_config.addCustomizer(new SecureRequestCustomizer());	      
		
		SslContextFactory sslContextFactory = new SslContextFactory("/home/carole/.keystore");
		sslContextFactory.setKeyStorePassword("changeit");
		sslContextFactory.setCertAlias(certificateAlias);
		//sslContextFactory.setKeyStoreType("RSA");
		
		ServerConnector httpsConnector = new ServerConnector(server, 
				new SslConnectionFactory(sslContextFactory, "http/1.1"),
				new HttpConnectionFactory(https_config));
		httpsConnector.setPort(port);
//				httpsConnector.setIdleTimeout(50000);	  			
		
		server.setConnectors(new Connector[]{ httpsConnector });
		Globals.logString("https setting server connector successfully");
	}

	private void firstCall() {
		String url = "http://localhost:" + port + "/" + firstCallService;
		if (!Utils.isStringEmpty(certificateAlias)) {
			url = "https://localhost:" + port + "/" + firstCallService;	
		}
		
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet request = new HttpGet(url);

		try{
			HttpResponse response = client.execute(request);
		}catch (Exception e){
			Globals.logException(e);
		}
	}

	public static void setCORS(HttpServletResponse response) {
		if(response != null){
			// The following are CORS headers. Max age informs the
			// browser to keep the results of this call for 1 day.
			response.setHeader("Access-Control-Allow-Origin", "*");
			response.setHeader("Access-Control-Allow-Methods", "POST, PUT, GET, OPTIONS,  DELETE");
			response.setHeader("Access-Control-Allow-Headers", "Content-Type, X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Date, X-Api-Version, X-File-Name, X-Pagination, Content-Disposition, showLoader");
			response.setHeader("Access-Control-Expose-Headers", "Content-Type, X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Date, X-Api-Version, X-File-Name, X-Pagination, Content-Disposition, showLoader");
			response.setHeader("Access-Control-Max-Age", "86400");
			// Tell the browser what requests we allow.
			response.setStatus(HttpServletResponse.SC_OK);
		}

		// setCORS(response); // required by angular framework; detailed CORS can be
		// set within the servlet
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getCertificateAlias() {
		return certificateAlias;
	}

	public void setCertificateAlias(String httpsAlias) {
		this.certificateAlias = httpsAlias;
	}

	public String getFirstCallService() {
		return firstCallService;
	}

	public void setFirstCallService(String firstCallService) {
		this.firstCallService = firstCallService;
	}
	
	public void initJsonFieldFilter() {
	}

	public String getLogDir() {
		return logDir;
	}

	public void setLogDir(String logDir) {
		this.logDir = logDir;
	}

	public int getMaxThread() {
		return maxThread;
	}

	public void setMaxThread(int maxThread) {
		this.maxThread = maxThread;
	}
}

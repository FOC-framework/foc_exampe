package com.focframework.sample.myfocapplication;

import javax.servlet.annotation.WebServlet;

import com.foc.vaadin.FocCentralPanel;
import com.foc.vaadin.FocWebApplication;
import com.foc.vaadin.FocWebVaadinWindow;
import com.vaadin.annotations.Theme;
import com.vaadin.annotations.VaadinServletConfiguration;
import com.vaadin.server.VaadinRequest;
import com.vaadin.server.VaadinServlet;

/**
 * This UI is the application entry point. A UI may either represent a browser window 
 * (or tab) or some part of a html page where a Vaadin application is embedded.
 * <p>
 * The UI is initialized using {@link #init(VaadinRequest)}. This method is intended to be 
 * overridden to add component to the user interface and initialize non-component functionality.
 */
@Theme("myfoctheme")
public class MyFocAppUI extends FocWebApplication { //UI {

	@Override
	public String getThemeName() {
		return "myfoctheme";
	}
	
	/*
	@WebServlet(value = "/*", asyncSupported = true)
	@VaadinServletConfiguration(productionMode = false, ui = MyFocAppUI.class)
	public static class Servlet extends VaadinServlet {
	}
	*/

	/*
    @Override
    protected void init(VaadinRequest vaadinRequest) {
        final VerticalLayout layout = new VerticalLayout();
        
        final TextField name = new TextField();
        name.setCaption("Type your name here:");

        Button button = new Button("Click Me");
        button.addClickListener( e -> {
            layout.addComponent(new Label("Thanks " + name.getValue() 
                    + ", it works!"));
        });
        
        layout.addComponents(name, button);
        layout.setMargin(true);
        layout.setSpacing(true);
        
        setContent(layout);
    }
    */

//    @WebServlet(urlPatterns = "/*", name = "FocUIServlet", asyncSupported = true)
//    @VaadinServletConfiguration(ui = MyFocAppUI.class, productionMode = false)
//    public static class FocUIServlet extends VaadinServlet {
//    }
    
    @Override
    public FocCentralPanel newWindow(){
    	return new MyFocApplicationMainWindow();
    }
}

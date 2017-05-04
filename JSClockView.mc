using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Calendar;
using Toybox.ActivityMonitor as Act;
using Toybox.Application as App;

class JSClockView extends Ui.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }
    function onShow() {
    }
    function onUpdate(dc) {
    
       	// Variable
    	var act = Act.getInfo();
    	var clockTime = Sys.getClockTime();
        var minString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        var dateInfo = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$ $2$", [dateInfo.day_of_week, dateInfo.day]);
        var monthString = Lang.format("$1$ $2$", [dateInfo.month, dateInfo.year]);
        var datemonthString = Lang.format("$1$ $2$ $3$ $4$", [dateInfo.day_of_week, dateInfo.day, dateInfo.month, dateInfo.year]);
        var batteryinfo = Lang.format("$1$%", [Sys.getSystemStats().battery.format("%02d")]);
        var stepinfo = Lang.format("$1$", [act.steps]);
    	var caloriesinfo = Lang.format("$1$", [act.calories.format("%02d")]);
    	var distanceinfo = act.distance / 100000.0;
    	var isConnected = Sys.getDeviceSettings().phoneConnected;
    	var not = Lang.format("$1$", [Sys.getDeviceSettings().notificationCount]);
    	var hours = clockTime.hour;
    	var activity1_1 = {}; 
    	var activity1_1_text = {}; 
    	var activity2_2 = {}; 
    	var activity2_2_text = {};
    	var floorsClimbed = {};
    	
    	if (dc.getHeight() == 205) {
    		floorsClimbed = Lang.format("$1$", [act.floorsClimbed]);
    		}
    		
    	// Graphics
    	// vivoactive HR 148 x 205
    	// forerunner 215 x 180
    	// vivoactive forerunner epix 205 x 148
    	dc.clear();
    	dc.setColor(App.getApp().getProperty("BackgroundColor"), App.getApp().getProperty("BackgroundColor"));
		dc.fillRectangle(0,0,dc.getWidth(), dc.getHeight());
		  dc.setColor(App.getApp().getProperty("GraphicsColor"),App.getApp().getProperty("BackgroundColor"));
         if (Sys.getSystemStats().battery< 20) {
        dc.setColor(Gfx.COLOR_RED,App.getApp().getProperty("BackgroundColor"));
        }
        dc.setPenWidth(4);
        dc.drawLine(1, dc.getHeight()-17, dc.getWidth(), dc.getHeight()-17);
         
         
        if (dc.getHeight() == 205) {
        dc.setPenWidth(4);
        dc.drawCircle(dc.getWidth()-38, 65, 30);
        dc.drawCircle(dc.getWidth()-38, 140, 30);
        
        }
        	else if (dc.getHeight() == 148) {
        	dc.setPenWidth(3);
        	dc.drawCircle(dc.getWidth()-33, 65, 30);
        	dc.drawCircle(dc.getWidth()-101, 65, 30);
        	}
        		else if (dc.getHeight() == 180) {
        		dc.setPenWidth(3);
        		dc.drawCircle(dc.getWidth()-55, 55, 30);
        		dc.drawCircle(dc.getWidth()-55, 125, 30);
        		}
        		
        // Time
        dc.setColor(App.getApp().getProperty("TimeColor"),App.getApp().getProperty("BackgroundColor"));
        if (!Sys.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
            }
        var hourString = Lang.format("$1$", [hours]);
        if (dc.getHeight() == 205) {
		dc.drawText(40, 20, Gfx.FONT_NUMBER_THAI_HOT, hourString, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(40, 80, Gfx.FONT_NUMBER_THAI_HOT, minString, Gfx.TEXT_JUSTIFY_CENTER);
        }
        	else if (dc.getHeight() == 148) {
        	dc.drawText(40, 25, Gfx.FONT_NUMBER_HOT, hourString, Gfx.TEXT_JUSTIFY_CENTER);
        	dc.drawText(40, 70, Gfx.FONT_NUMBER_HOT, minString, Gfx.TEXT_JUSTIFY_CENTER);
        	}
        		else if (dc.getHeight() == 180) {
        		dc.drawText(60, 20, Gfx.FONT_NUMBER_HOT, hourString, Gfx.TEXT_JUSTIFY_CENTER);
        		dc.drawText(60, 70, Gfx.FONT_NUMBER_HOT, minString, Gfx.TEXT_JUSTIFY_CENTER);
        		}
      
        // Date
        dc.setColor(App.getApp().getProperty("DateColor"),App.getApp().getProperty("BackgroundColor"));
        if (dc.getHeight() == 205) {
        dc.drawText(40, 142, Gfx.FONT_XTINY, dateString, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(40, 157, Gfx.FONT_XTINY, monthString, Gfx.TEXT_JUSTIFY_CENTER);
        }
        	else if (dc.getHeight() == 148) {
        	dc.drawText(142, 105, Gfx.FONT_XTINY, datemonthString, Gfx.TEXT_JUSTIFY_CENTER);
        	}
        		else if (dc.getHeight() == 180) {
        		dc.drawText(60, 124, Gfx.FONT_XTINY, dateString, Gfx.TEXT_JUSTIFY_CENTER);
        		dc.drawText(60, 139, Gfx.FONT_XTINY, monthString, Gfx.TEXT_JUSTIFY_CENTER);
        		}
        
        // Battery
        dc.setColor(App.getApp().getProperty("UpperfieldColor"),App.getApp().getProperty("BackgroundColor"));
        if (Sys.getSystemStats().battery< 20) {
        dc.setColor(Gfx.COLOR_RED,Gfx.COLOR_BLACK);
        }
        dc.drawText(dc.getWidth()/2, 1, Gfx.FONT_XTINY, batteryinfo, Gfx.TEXT_JUSTIFY_CENTER);
        
        
        //Set Activity field
        
        var Activity1_type =  App.getApp().getProperty("Activity1");
        if (Activity1_type == 1) {
        activity1_1 = stepinfo;
        activity1_1_text = "step";
        }
        	else if (Activity1_type == 2)  {
        	activity1_1 = caloriesinfo;
        	activity1_1_text = "kCal";
        	}
        		else if (Activity1_type == 3)  {
        			if (dc.getHeight() == 205) {
        			activity1_1 = floorsClimbed;
        			activity1_1_text = "floors";
        			}
        			else {
        			activity1_1 = "ONLY";
        			activity1_1_text = "Vivoactive HR";
        			}
        			
        		}
        			else if (Activity1_type == 4)  {
        			activity1_1 = distanceinfo.format("%01d");
        			activity1_1_text = "km";
        			}
        
        var Activity2_type =  App.getApp().getProperty("Activity2");
        if (Activity2_type == 1) {
        activity2_2 = stepinfo;
        activity2_2_text = "step";
        }
        	else if (Activity2_type == 2)  {
        	activity2_2 = caloriesinfo;
        	activity2_2_text = "kCal";
        	}
        		else if (Activity2_type == 3)  {
        				if (dc.getHeight() == 205) {
        					activity2_2 = floorsClimbed;
        					activity2_2_text = "floors";
        					}
        				else {
        					activity2_2 = "ONLY";
        					activity2_2_text = "Vivoactive HR";
        					}
        		}
        			else if (Activity2_type == 4)  {
        			activity2_2 = distanceinfo.format("%01d");
        			activity2_2_text = "km";
        			}
        
        // Steps Calories
        dc.setColor(App.getApp().getProperty("ActivityColor"),App.getApp().getProperty("BackgroundColor"));
        if (dc.getHeight() == 205) {
       	dc.drawText(110, 50, Gfx.FONT_TINY, activity1_1, Gfx.TEXT_JUSTIFY_CENTER);
       	dc.drawText(110, 66, Gfx.FONT_XTINY, activity1_1_text, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(110, 125, Gfx.FONT_TINY, activity2_2, Gfx.TEXT_JUSTIFY_CENTER);
      	dc.drawText(110, 141, Gfx.FONT_XTINY, activity2_2_text, Gfx.TEXT_JUSTIFY_CENTER);
         }
        	else if (dc.getHeight() == 148) {
        	dc.drawText(103, 47, Gfx.FONT_TINY, activity1_1, Gfx.TEXT_JUSTIFY_CENTER);
        	dc.drawText(103, 63, Gfx.FONT_XTINY, activity1_1_text, Gfx.TEXT_JUSTIFY_CENTER);
        	dc.drawText(173, 47, Gfx.FONT_TINY, activity2_2, Gfx.TEXT_JUSTIFY_CENTER);
        	dc.drawText(173, 63, Gfx.FONT_XTINY, activity2_2_text, Gfx.TEXT_JUSTIFY_CENTER);
        	}
        		else if (dc.getHeight() == 180) {
        		dc.drawText(162, 40, Gfx.FONT_TINY, activity1_1, Gfx.TEXT_JUSTIFY_CENTER);
       			dc.drawText(162, 56, Gfx.FONT_XTINY, activity1_1_text, Gfx.TEXT_JUSTIFY_CENTER);
        		dc.drawText(162, 112, Gfx.FONT_TINY, activity2_2, Gfx.TEXT_JUSTIFY_CENTER);
        		dc.drawText(162, 128, Gfx.FONT_XTINY, activity2_2_text, Gfx.TEXT_JUSTIFY_CENTER);
        		}
        	
		//Bluetooth
		if (isConnected) {
		dc.setColor(App.getApp().getProperty("UpperfieldColor"),App.getApp().getProperty("BackgroundColor"));
		if (dc.getHeight() == 148) {	
		dc.setPenWidth(1);
		dc.drawLine(195, 4, 200, 10);
		dc.drawLine(195, 4, 195, 18);
		dc.drawLine(195, 18, 200, 13);
		dc.drawLine(200, 13, 190, 7);
		dc.drawLine(200, 10, 190, 15);
		}
			else {
			dc.setPenWidth(1);
			dc.drawLine(140, 4, 145, 10);
			dc.drawLine(140, 4, 140, 18);
			dc.drawLine(140, 18, 145, 13);
			dc.drawLine(145, 13, 135, 7);
			dc.drawLine(145, 10, 135, 15);
			}
		} 
		
		//Notification
		if (Sys.getDeviceSettings().notificationCount >= 1) {
		if (dc.getHeight() == 180) { 
		dc.setPenWidth(2);
		dc.drawText(70, 1, Gfx.FONT_XTINY, not, Gfx.TEXT_JUSTIFY_LEFT);
		dc.drawRectangle(52, 8, 14, 9);
		dc.drawLine(52, 8, 59, 15);
		dc.drawLine(59, 15, 66, 8);
		}
			else {
			dc.setPenWidth(2);
			dc.drawText(22, 1, Gfx.FONT_XTINY, not, Gfx.TEXT_JUSTIFY_LEFT);
			dc.drawRectangle(5, 8, 14, 9);
			dc.drawLine(5, 8, 12, 15);
			dc.drawLine(12, 15, 19, 8);
			}
		}  
    }
    
    function onHide() {
    }

    function onExitSleep() {
    }

    function onEnterSleep() {
    }

}
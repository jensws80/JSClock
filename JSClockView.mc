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
    var dateInfoShort = Calendar.info(Time.now(), Time.FORMAT_SHORT);
    var batteryinfo = Lang.format("$1$%", [Sys.getSystemStats().battery.format("%02d")]);
    var stepinfo = Lang.format("$1$", [act.steps]);
    var stepgoal = Lang.format("$1$", [act.stepGoal]);
    var steparc = {};
   	var caloriesinfo = Lang.format("$1$", [act.calories.format("%02d")]);
    var distanceinfo = act.distance / 100000.0;
    var isConnected = Sys.getDeviceSettings().phoneConnected;
    var not = Lang.format("$1$", [Sys.getDeviceSettings().notificationCount]);
    var hours = clockTime.hour;
    var activity1_1 = {}; 
    var activity1_1_text = {};
    var activity1_1_arc = {};  
    var activity2_2 = {}; 
    var activity2_2_text = {};
    var activity2_2_arc = {};
    var activity3_3 = {}; 
    var activity3_3_text = {};
    var floorsClimbed = {};
    var floorsClimbedGoal = {};
    var floorsClimbedarc = {};
    	
    if (dc.getHeight() == 205) {
    	floorsClimbed = Lang.format("$1$", [act.floorsClimbed]);
    	floorsClimbedGoal = Lang.format("$1$", [act.floorsClimbedGoal]);
    }
    		
    // Graphics
    // vivoactive HR 148 x 205
    // forerunner 215 x 180
    // vivoactive forerunner epix 205 x 148
    dc.clear();
    dc.setColor(App.getApp().getProperty("BackgroundColor"), App.getApp().getProperty("BackgroundColor"));
	dc.fillRectangle(0,0,dc.getWidth(), dc.getHeight());
	
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
        dc.drawText(40, 18, Gfx.FONT_NUMBER_HOT, hourString + ":" + minString, Gfx.TEXT_JUSTIFY_CENTER);
   	}
   	else if (dc.getHeight() == 180) {
       	dc.drawText(65, 35, Gfx.FONT_NUMBER_HOT, hourString + ":" + minString, Gfx.TEXT_JUSTIFY_CENTER);
   	}
      
	// Date
  	dc.setColor(App.getApp().getProperty("DateColor"),App.getApp().getProperty("BackgroundColor"));
       
  	if (dc.getHeight() == 205) {
        week.weektext(dc,dateInfoShort,dateInfo,40,142,2,App.getApp().getProperty("Week"));
   	}
   	else if (dc.getHeight() == 148) {
      week.weektext(dc,dateInfoShort,dateInfo,40,55,2,App.getApp().getProperty("Week"));
   	}
  	else if (dc.getHeight() == 180) {
       	week.weektext(dc,dateInfoShort,dateInfo,65,90,2,App.getApp().getProperty("Week"));
  	}
        
  	// Battery
  	dc.setColor(App.getApp().getProperty("UpperfieldColor"),App.getApp().getProperty("BackgroundColor"));
        
  	if (Sys.getSystemStats().battery< App.getApp().getProperty("Alarm")) {
        dc.setColor(App.getApp().getProperty("AlarmColor"),App.getApp().getProperty("BackgroundColor"));
   	}
  	dc.drawText(dc.getWidth()/2, 1, Gfx.FONT_XTINY, batteryinfo, Gfx.TEXT_JUSTIFY_CENTER);
    
    // Step goal arc calculation
    steparc = (stepinfo.toFloat() / stepgoal.toFloat())*360.0;
    
    //Floor goal arc calculation
    if (dc.getHeight() == 205 ) {
    	floorsClimbedarc = (floorsClimbed.toFloat() / floorsClimbedGoal.toFloat())*360.0;
    	}      
  	//Set Activity field
 	var Activity1_type =  App.getApp().getProperty("Activity1");
  
  	if (Activity1_type == 1) {
     	activity1_1 = stepinfo;
  		if (App.getApp().getProperty("Goals") == 0) {
     		activity1_1_text = "step";
     		activity1_1_arc = 360;
      	}
        else if (App.getApp().getProperty("Goals") == 1) {
        	activity1_1_text ="/" + stepgoal;
        	activity1_1_arc = steparc.toLong();
        }
  	}
   	else if (Activity1_type == 2)  {
        activity1_1 = caloriesinfo;
        activity1_1_text = "kCal";
        activity1_1_arc = 360;
  	}
  	else if (Activity1_type == 3)  {
       	if (dc.getHeight() == 205 ) {
        	activity1_1 = floorsClimbed;
        		if (App.getApp().getProperty("Goals") == 0) {
        			activity1_1_text = "floors";
        			activity1_1_arc = 360;
        		}
        		else if (App.getApp().getProperty("Goals") == 1) {
        			activity1_1_text ="/" + floorsClimbedGoal;
        			activity1_1_arc = floorsClimbedarc.toLong();
        		}
    }
 		else {
    		activity1_1 = "NO";
        	activity1_1_text = "NO SUPPORT";
        	activity1_1_arc = 360;
    }      			
    }
        			else if (Activity1_type == 4)  {
        			activity1_1 = distanceinfo.format("%0.01f");
        			activity1_1_text = "km";
        			activity1_1_arc = 360;
        			}
        
        var Activity2_type =  App.getApp().getProperty("Activity2");
        if (Activity2_type == 1) {
        activity2_2 = stepinfo;
        if (App.getApp().getProperty("Goals") == 0) {
        	activity2_2_text = "step";
        	activity2_2_arc = 360;
        	}
        	else if (App.getApp().getProperty("Goals") == 1) {
        	activity2_2_text ="/" + stepgoal;
        	activity2_2_arc = steparc.toLong();
        	}
        }
        	else if (Activity2_type == 2)  {
        	activity2_2 = caloriesinfo;
        	activity2_2_text = "kCal";
        	activity2_2_arc = 360;
        	}
        		else if (Activity2_type == 3)  {
        				if (dc.getHeight() == 205){
        					activity2_2 = floorsClimbed;
        					if (App.getApp().getProperty("Goals") == 0) {
        					activity2_2_text = "floors";
        					activity2_2_arc = 360;
        					}
        					else if (App.getApp().getProperty("Goals") == 1) {
        					activity2_2_text ="/" + floorsClimbedGoal;
        					activity2_2_arc = floorsClimbedarc.toLong();
        					}
        					}
        				else {
        					activity2_2 = "NO";
        					activity2_2_text = "SUPPORT";
        					activity2_2_arc = 360;
        					}
        		}
        			else if (Activity2_type == 4)  {
        			activity2_2 = distanceinfo.format("%0.01f");
        			activity2_2_text = "km";
        			activity2_2_arc = 360;
        			}
        			
         var Activity3_type =  App.getApp().getProperty("Activity3");
        if (Activity3_type == 2) {
        activity3_3 = stepinfo;
        if (App.getApp().getProperty("Goals") == 0) {
        	activity3_3_text = "step";
        	}
        	else if (App.getApp().getProperty("Goals") == 1) {
        	activity3_3_text ="/" + stepgoal;
        	}
        }
        	else if (Activity3_type == 3)  {
        	activity3_3 = caloriesinfo;
        	activity3_3_text = "kCal";
        	}
        		else if (Activity3_type == 4)  {
        				if (dc.getHeight() == 205){
        					activity3_3 = floorsClimbed;
        					activity3_3_text = "floors";
        					if (App.getApp().getProperty("Goals") == 0) {
        					activity3_3_text = "floors";
        					}
        					else if (App.getApp().getProperty("Goals") == 1) {
        					activity3_3_text ="/" + floorsClimbedGoal;
        					}
        					}
        				else {
        					activity3_3 = "NO";
        					activity3_3_text = "SUPPORT";
        					}
        		}
        			else if (Activity3_type == 5)  {
        			activity3_3 = distanceinfo.format("%0.01f");
        			activity3_3_text = "km";
        			}
        
	// Steps Calories
   	dc.setColor(App.getApp().getProperty("ActivityColor"),	Gfx.COLOR_TRANSPARENT);
   
    if (dc.getHeight() == 205) {
       	dc.drawText(110, 50, Gfx.FONT_TINY, activity1_1, Gfx.TEXT_JUSTIFY_CENTER);
       	dc.drawText(110, 66, Gfx.FONT_XTINY, activity1_1_text, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(110, 125, Gfx.FONT_TINY, activity2_2, Gfx.TEXT_JUSTIFY_CENTER);
      	dc.drawText(110, 141, Gfx.FONT_XTINY, activity2_2_text, Gfx.TEXT_JUSTIFY_CENTER);
   	}
  	else if (dc.getHeight() == 148) {
       	dc.drawText(103, 69, Gfx.FONT_TINY, activity1_1, Gfx.TEXT_JUSTIFY_CENTER);
       	dc.drawText(103, 85, Gfx.FONT_XTINY, activity1_1_text, Gfx.TEXT_JUSTIFY_CENTER);
       	dc.drawText(171, 69, Gfx.FONT_TINY, activity2_2, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(171, 85, Gfx.FONT_XTINY, activity2_2_text, Gfx.TEXT_JUSTIFY_CENTER);
  	}
   	else if (dc.getHeight() == 180) {
       	dc.drawText(158, 39, Gfx.FONT_TINY, activity1_1, Gfx.TEXT_JUSTIFY_CENTER);
       	dc.drawText(158, 55, Gfx.FONT_XTINY, activity1_1_text, Gfx.TEXT_JUSTIFY_CENTER);
       	dc.drawText(158, 106, Gfx.FONT_TINY, activity2_2, Gfx.TEXT_JUSTIFY_CENTER);
       	dc.drawText(158, 122, Gfx.FONT_XTINY, activity2_2_text, Gfx.TEXT_JUSTIFY_CENTER);
  	}
        		
    //Graphics
    dc.setColor(App.getApp().getProperty("GraphicsColor"),App.getApp().getProperty("BackgroundColor"));
    
    if (Sys.getSystemStats().battery < App.getApp().getProperty("Alarm")) {
        dc.setColor(App.getApp().getProperty("AlarmColor"),App.getApp().getProperty("BackgroundColor"));
    }
    
    if (App.getApp().getProperty("Graphics") == 1) {
        dc.setPenWidth(4);
        dc.drawLine(1, dc.getHeight()-17, dc.getWidth(), dc.getHeight()-17);
               
        if (dc.getHeight() == 205) {
        	dc.setPenWidth(4);
        	dc.drawArc(dc.getWidth()-38, 65, 30, 1, 90, (360-activity1_1_arc+90)%360);
        	dc.drawArc(dc.getWidth()-38, 140, 30, 1, 90, (360-activity2_2_arc+90)%360);
        }
        else if (dc.getHeight() == 148) {
        	dc.setPenWidth(3);
        	dc.drawArc(dc.getWidth()-33, 87, 30, 1, 90, (360-activity1_1_arc+90)%360);
        	dc.drawArc(dc.getWidth()-101, 87, 30, 1, 90, (360-activity2_2_arc+90)%360);
        }
        else if (dc.getHeight() == 180) {
        	dc.setPenWidth(4);
        	dc.drawArc(dc.getWidth()-55, 55, 30, 1, 90, (360-activity1_1_arc+90)%360);
        	dc.drawArc(dc.getWidth()-55, 122, 30, 1, 90, (360-activity2_2_arc+90)%360);
        }
     }
     
     //Activity field bottom line
 	dc.setColor(App.getApp().getProperty("ActivityColor"),App.getApp().getProperty("BackgroundColor"));
  	if (Activity3_type >= 2)
       {
       dc.drawText(dc.getWidth()/2, dc.getHeight()-29, Gfx.FONT_TINY, " " + activity3_3 + " " + activity3_3_text + " ", Gfx.TEXT_JUSTIFY_CENTER);
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
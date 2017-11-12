//                     GNU GENERAL PUBLIC LICENSE
//                       Version 3, 29 June 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Calendar;
using Toybox.ActivityMonitor as Act;
using Toybox.Application as App;

class JSClockView extends Ui.WatchFace {
	hidden var active = true;

    function initialize() {
        WatchFace.initialize();
    }
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }
    function onShow() {
    }
    function onUpdate(dc) {
    
    //------------------ Variable ------------------

    var act = Act.getInfo();
    var dateInfo = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
    var dateInfoShort = Calendar.info(Time.now(), Time.FORMAT_SHORT);
    var batteryinfo = Lang.format("$1$%", [Sys.getSystemStats().battery.format("%02d")]);
    var stepinfo = Lang.format("$1$", [act.steps]);
    var stepgoal = Lang.format("$1$", [act.stepGoal]);
    var steparc = {};
   	var caloriesinfo = Lang.format("$1$", [act.calories.format("%02d")]);
    var distanceinfo = act.distance / 100000.0;
    var not = Lang.format("$1$", [Sys.getDeviceSettings().notificationCount]);
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
    var heart_rate = {};
    var Activity1_type =  App.getApp().getProperty("Activity1");
   	var Activity2_type =  App.getApp().getProperty("Activity2");
    var Activity3_type =  App.getApp().getProperty("Activity3");
        	
    if (dc.getHeight() == 205 || dc.getHeight() == 240) {
    	floorsClimbed = Lang.format("$1$", [act.floorsClimbed]);
    	floorsClimbedGoal = Lang.format("$1$", [act.floorsClimbedGoal]);
    }
    
    //Heartrate
    	if (Activity1_type == 5 or Activity2_type == 5 or Activity3_type == 6){
    	if(ActivityMonitor has :HeartRateIterator) {
    	var hrHistory = Act.getHeartRateHistory(null, true);
	    
    		if(hrHistory != null){
       	 		var hr = hrHistory.next();
				heart_rate = (hr.heartRate != ActivityMonitor.INVALID_HR_SAMPLE && hr.heartRate > 0) ? hr.heartRate : 0; 
    		}
    	else { 
    		heart_rate = 0;
    		}
    	}
    	}
    			
    // Step goal arc calculation (not in use only in 1.6)
    if (stepinfo.toFloat() < stepgoal.toFloat())
    	{
    	steparc = (stepinfo.toFloat() / stepgoal.toFloat())*360.0;
    	}
    else 
    	{
    	steparc = 360.0;
    	}
    
    //Floor goal arc calculation (not in use only in 1.6) 
    if (dc.getHeight() == 205 ) {
    	floorsClimbedarc = (floorsClimbed.toFloat() / floorsClimbedGoal.toFloat())*360.0;
    	}      
  	//Set Activity field  
  	if (Activity1_type == 1) {
     	activity1_1 = stepinfo;
  		if (App.getApp().getProperty("Goals") == 0) {
     		activity1_1_text = "step";
     		activity1_1_arc = 360;
      	}
        else if (App.getApp().getProperty("Goals") == 1) {
        	activity1_1_text ="/" + stepgoal;
        	activity1_1_arc = 360;
        	//activity1_1_arc = steparc.toLong();
        }
  	}
   	else if (Activity1_type == 2)  {
        activity1_1 = caloriesinfo;
        activity1_1_text = "kCal";
        activity1_1_arc = 360;
  	}
  	else if (Activity1_type == 3)  {
       	if (dc.getHeight() == 205 || 240) {
        	activity1_1 = floorsClimbed;
        		if (App.getApp().getProperty("Goals") == 0) {
        			activity1_1_text = "floors";
        			activity1_1_arc = 360;
        		}
        		else if (App.getApp().getProperty("Goals") == 1) {
        			activity1_1_text ="/" + floorsClimbedGoal;
        			activity1_1_arc = 360;
        			//activity1_1_arc = floorsClimbedarc.toLong();
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
        			    if (Sys.getDeviceSettings().distanceUnits == 0) {
        				activity1_1_text = "km";
        				}
        				else if (Sys.getDeviceSettings().distanceUnits == 1) {
        				activity1_1_text = "mi";
        				}
        				else {
        				activity1_1_text = "xx";
        				}
        			activity1_1_arc = 360;
        			}
       	else if (Activity1_type == 5)  {
       		activity1_1 = heart_rate;
        	activity1_1_text = "bpm";
        	activity1_1_arc = 360;
        	}

        if (Activity2_type == 1) {
        activity2_2 = stepinfo;
        if (App.getApp().getProperty("Goals") == 0) {
        	activity2_2_text = "step";
        	activity2_2_arc = 360;
        	}
        	else if (App.getApp().getProperty("Goals") == 1) {
        	activity2_2_text ="/" + stepgoal;
        	activity2_2_arc = 360;
        	//activity2_2_arc = steparc.toLong();
        	}
        }
        	else if (Activity2_type == 2)  {
        	activity2_2 = caloriesinfo;
        	activity2_2_text = "kCal";
        	activity2_2_arc = 360;
        	}
        		else if (Activity2_type == 3)  {
        				if (dc.getHeight() == 205 || 240){
        					activity2_2 = floorsClimbed;
        					if (App.getApp().getProperty("Goals") == 0) {
        					activity2_2_text = "floors";
        					activity2_2_arc = 360;
        					}
        					else if (App.getApp().getProperty("Goals") == 1) {
        					activity2_2_text ="/" + floorsClimbedGoal;
        					activity2_2_arc = 360;
        					//activity2_2_arc = floorsClimbedarc.toLong();
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
        				if (Sys.getDeviceSettings().distanceUnits == 0){
        				activity2_2_text = "km";
        				}
        				else if (Sys.getDeviceSettings().distanceUnits == 1){
        				activity2_2_text = "mi";
        				}
        				else {
        				activity2_2_text = "xx";
        				}
        			activity2_2_arc = 360;
        			}
        		else if (Activity2_type == 5)  {
       			activity2_2 = heart_rate;
        		activity2_2_text = "bpm";
        		activity2_2_arc = 360;
        		}
        			
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
        				if (dc.getHeight() == 205 || 240){
        					activity3_3 = floorsClimbed;
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
        			if (Sys.getDeviceSettings().distanceUnits == 0){
        				activity3_3_text = "km";
        				}
        				else if (Sys.getDeviceSettings().distanceUnits == 1){
        				activity3_3_text = "mi";
        				}
        				else {
        				activity3_3_text = "xx";
        				}
        			}
        		else if (Activity3_type == 6)  {
       			activity3_3 = heart_rate;
        		activity3_3_text = "bpm";
        		}
        	
      

  	//------------------ GRAPHICS ------------------
  	
  	// vivoactive HR 148 x 205
    // forerunner 215 x 180
    // vivoactive forerunner epix 205 x 148
    // vivoactive 3 240 x 240
  	
  	if (active == true or (App.getApp().getProperty("Graphics") == 0)){
  	
  	// Background
    dc.clear();
    dc.setColor(App.getApp().getProperty("BackgroundColor"), App.getApp().getProperty("BackgroundColor"));
	dc.fillRectangle(0,0,dc.getWidth(), dc.getHeight());
  	
  	// Time and Date Graphics 
  	if (dc.getHeight() == 205) {
  		Graphics.Time(dc,40,20,Gfx.FONT_NUMBER_THAI_HOT,2);
  		Graphics.Date(dc,40,142,2,dateInfoShort,dateInfo);
    }
   	else if (dc.getHeight() == 148) {
   		Graphics.Time(dc,40,18,Gfx.FONT_NUMBER_HOT,1);
   		Graphics.Date(dc,40,55,2,dateInfoShort,dateInfo);
   	}
   	else if (dc.getHeight() == 180) {
   	   	Graphics.Time(dc,65,35,Gfx.FONT_NUMBER_HOT,1);
   	   	Graphics.Date(dc,65,90,2,dateInfoShort,dateInfo);
   	}
   	else if (dc.getHeight() == 240) {
   		Graphics.Date(dc,80,115,3,dateInfoShort,dateInfo);
   	   	Graphics.Time(dc,80,40,Gfx.FONT_NUMBER_HOT,1);
   	}
  	
  	// Battery
  	Graphics.Battery(dc,batteryinfo,dc.getWidth()/2, 1);
  	   
  	//Bluetooth
		if (dc.getHeight() == 148) {
		Graphics.Bluetooth(dc,195,4);	
		}
		else if (dc.getHeight() == 240) {
		Graphics.Bluetooth(dc,155,20);	
		}
		else {
		Graphics.Bluetooth(dc,140,4);
		}
		
	//Notification
	if (dc.getHeight() == 180) {
		Graphics.Notification(dc,not,52,8);
	}
	else if (dc.getHeight() == 240) {
		Graphics.Notification(dc,not,95,20);
	}
	else {
		Graphics.Notification(dc,not,5,8);
	} 
	
	//Graphics circle
    dc.setColor(App.getApp().getProperty("GraphicsColor"),App.getApp().getProperty("BackgroundColor"));
    
    if (Sys.getSystemStats().battery < App.getApp().getProperty("Alarm")) {
        dc.setColor(App.getApp().getProperty("AlarmColor"),App.getApp().getProperty("BackgroundColor"));
    }
    
    if (App.getApp().getProperty("Graphics") == 1) {
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
        else if (dc.getHeight() == 240) {
        	dc.setPenWidth(4);
        	dc.drawArc(dc.getWidth()-55, 55, 30, 1, 90, (360-activity1_1_arc+90)%360);
        	dc.drawArc(dc.getWidth()-55, 122, 30, 1, 90, (360-activity2_2_arc+90)%360);
        }
     }
  	
 	// Activity field 1 2 graphics
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
  	else if (dc.getHeight() == 240) {
       	dc.drawText(158, 39, Gfx.FONT_TINY, activity1_1, Gfx.TEXT_JUSTIFY_CENTER);
       	dc.drawText(158, 55, Gfx.FONT_XTINY, activity1_1_text, Gfx.TEXT_JUSTIFY_CENTER);
       	dc.drawText(158, 106, Gfx.FONT_TINY, activity2_2, Gfx.TEXT_JUSTIFY_CENTER);
       	dc.drawText(158, 122, Gfx.FONT_XTINY, activity2_2_text, Gfx.TEXT_JUSTIFY_CENTER);
  	} 	
  	
    // Activity field bottom line
 	dc.setColor(App.getApp().getProperty("ActivityColor"),App.getApp().getProperty("BackgroundColor"));
  	if (Activity3_type >= 2)
       {
       dc.drawText(dc.getWidth()/2, dc.getHeight()-29, Gfx.FONT_TINY, " " + activity3_3 + " " + activity3_3_text + " ", Gfx.TEXT_JUSTIFY_CENTER);
  	}	
  	}
  	
	// Sleep mode
	if (active == false and (App.getApp().getProperty("Sleepmode") == 1)){
    dc.clear();
    dc.setColor(App.getApp().getProperty("BackgroundColor"), App.getApp().getProperty("BackgroundColor"));
	dc.fillRectangle(0,0,dc.getWidth(), dc.getHeight());
	
	// Time and Date Graphics sleep mode
  	if (dc.getHeight() == 205) {
  		Graphics.Time(dc,74,20,Gfx.FONT_NUMBER_THAI_HOT,2);
  		Graphics.Date(dc,74,142,2,dateInfoShort,dateInfo);
    }
   	else if (dc.getHeight() == 148) {
   		Graphics.Time(dc,102,38,Gfx.FONT_NUMBER_HOT,1);
   		Graphics.Date(dc,102,75,2,dateInfoShort,dateInfo);
   	}
   	else if (dc.getHeight() == 180) {
   	   	Graphics.Time(dc,107,35,Gfx.FONT_NUMBER_HOT,1);
   	   	Graphics.Date(dc,107,90,2,dateInfoShort,dateInfo);
   	}
   	else if (dc.getHeight() == 240) {
   		Graphics.Date(dc,120,115,3,dateInfoShort,dateInfo);
   	   	Graphics.Time(dc,120,40,Gfx.FONT_NUMBER_HOT,1);
   	}
   	
    }
    	
	 	
}
    
    function onHide() {
    }

    function onExitSleep() {
        active=true;
    	Ui.requestUpdate();

    }

    function onEnterSleep() {
        active=false;
    	Ui.requestUpdate();

    }

}
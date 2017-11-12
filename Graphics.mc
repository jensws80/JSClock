using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Time.Gregorian as Calendar;

module Graphics{

	function Notification(dc,not,x,y){
	dc.setColor(App.getApp().getProperty("UpperfieldColor"),App.getApp().getProperty("BackgroundColor"));
	if (Sys.getDeviceSettings().notificationCount >= 1) {
		dc.setPenWidth(2);
		dc.drawText(x+17, y-7, Gfx.FONT_XTINY, not, Gfx.TEXT_JUSTIFY_LEFT);
		dc.drawRectangle(x, y, x+9, y+1);
		dc.drawLine(x, y, x+7, y+7);
		dc.drawLine(x+7, y+7, x+14, y);
		}
	}
	
	function Bluetooth(dc,x,y){
	dc.setColor(App.getApp().getProperty("UpperfieldColor"),App.getApp().getProperty("BackgroundColor"));
	if (Sys.getDeviceSettings().phoneConnected) {
		dc.setPenWidth(1);
		dc.drawLine(x, y, x+5, y+6);
		dc.drawLine(x, y, x, y+14);
		dc.drawLine(x, y+14, x+5, y+9);
		dc.drawLine(x+5, y+9, x-5, y+3);
		dc.drawLine(x+5, y+6, x-5, y+9);
		}
	}

	function Battery(dc,batteryinfo,x,y){
	dc.setColor(App.getApp().getProperty("UpperfieldColor"),App.getApp().getProperty("BackgroundColor"));
	  	dc.drawText(x, y, Gfx.FONT_XTINY, batteryinfo, Gfx.TEXT_JUSTIFY_CENTER);
	}
		function Time(dc,x,y,type,lines){
		var clockTime = Sys.getClockTime();
		var hours = clockTime.hour;
				
		dc.setColor(App.getApp().getProperty("TimeColor"),App.getApp().getProperty("BackgroundColor"));   
	  		
	  		if (!Sys.getDeviceSettings().is24Hour) {
           		 if (hours > 12) {
                	hours = hours - 12;
            		}
  				}
  		
  		var hourString = Lang.format("$1$", [hours]);
		var minString = Lang.format("$1$", [clockTime.min.format("%02d")]);
  		
  				
  			if (lines == 2) {
  					dc.drawText(x, y, type, hourString, Gfx.TEXT_JUSTIFY_CENTER);
       			 	dc.drawText(x, y+60, type, minString, Gfx.TEXT_JUSTIFY_CENTER);
  			}
  			else {
    				dc.drawText(x, y, type, hourString + ":" + minString, Gfx.TEXT_JUSTIFY_CENTER);
    		}		
		}
		function Date(dc,x,y,lines,dateInfoShort,dateInfo){
		  	dc.setColor(App.getApp().getProperty("DateColor"),App.getApp().getProperty("BackgroundColor"));
		  	week.weektext(dc,dateInfoShort,dateInfo,x,y,lines,App.getApp().getProperty("Week"));	
		}
		
	}

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Calendar;
using Toybox.ActivityMonitor as Act;
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
        var batteryinfo = Lang.format("$1$%", [Sys.getSystemStats().battery.format("%02d")]);
        var stepinfo = Lang.format("$1$", [act.steps]);
    	var caloriesinfo = Lang.format("$1$", [act.calories.format("%02d")]);
    	var isConnected = Sys.getDeviceSettings().phoneConnected;
    	var not = Lang.format("$1$", [Sys.getDeviceSettings().notificationCount]);
    	var hours = clockTime.hour;	
    	
    	// Graphics
    	dc.clear();
    	dc.setColor(Gfx.COLOR_BLACK,Gfx.COLOR_BLACK);
		dc.fillRectangle(0,0,dc.getWidth(), dc.getHeight());
		  dc.setColor(Gfx.COLOR_YELLOW,Gfx.COLOR_BLACK);
         if (Sys.getSystemStats().battery< 20) {
        dc.setColor(Gfx.COLOR_RED,Gfx.COLOR_BLACK);
        }
        dc.setPenWidth(4);
        dc.drawLine(1, 188, dc.getWidth(), 188);
         dc.setPenWidth(3);
        dc.drawCircle(110, 65, 30);
        dc.drawCircle(110, 140, 30);

        // Time
        dc.setColor(Gfx.COLOR_WHITE,Gfx.COLOR_BLACK);
        if (!Sys.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
            }
        var hourString = Lang.format("$1$", [hours]);
		dc.drawText(40, 20, Gfx.FONT_NUMBER_THAI_HOT, hourString, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(40, 80, Gfx.FONT_NUMBER_THAI_HOT, minString, Gfx.TEXT_JUSTIFY_CENTER);
      
        // Date
        dc.setColor(0xAAAAAA,Gfx.COLOR_BLACK);
        dc.drawText(40, 142, Gfx.FONT_XTINY, dateString, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(40, 157, Gfx.FONT_XTINY, monthString, Gfx.TEXT_JUSTIFY_CENTER);
        
        // Battery
        dc.setColor(0xAAAAAA,Gfx.COLOR_BLACK);
        if (Sys.getSystemStats().battery< 20) {
        dc.setColor(Gfx.COLOR_RED,Gfx.COLOR_BLACK);
        }
        dc.drawText(71, 1, Gfx.FONT_XTINY, batteryinfo, Gfx.TEXT_JUSTIFY_CENTER);
        
        // Steps
        dc.setColor(Gfx.COLOR_WHITE,Gfx.COLOR_BLACK);
        dc.drawText(110, 50, Gfx.FONT_TINY, stepinfo, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(110, 66, Gfx.FONT_XTINY, "step", Gfx.TEXT_JUSTIFY_CENTER);
        
        // Calories
        dc.drawText(110, 125, Gfx.FONT_TINY, caloriesinfo, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(110, 141, Gfx.FONT_XTINY, "kCal", Gfx.TEXT_JUSTIFY_CENTER);
		
		//Bluetooth
		if (isConnected) {
		dc.setColor(0xAAAAAA,Gfx.COLOR_BLACK);	
		dc.setPenWidth(1);
		dc.drawLine(140, 4, 145, 10);
		dc.drawLine(140, 4, 140, 18);
		dc.drawLine(140, 18, 145, 13);
		dc.drawLine(145, 13, 135, 7);
		dc.drawLine(145, 10, 135, 15);
		} 
		
		//Notification
		if (Sys.getDeviceSettings().notificationCount >= 1) {
		dc.setPenWidth(2);
		dc.drawText(22, 1, Gfx.FONT_XTINY, not, Gfx.TEXT_JUSTIFY_LEFT);
		dc.drawRectangle(5, 8, 14, 9);
		dc.drawLine(5, 8, 12, 15);
		dc.drawLine(12, 15, 19, 8);
		}  
    }
    
    function onHide() {
    }

    function onExitSleep() {
    }

    function onEnterSleep() {
    }

}

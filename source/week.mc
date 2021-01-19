using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;

module week{
	function weektext(dc,dateInfoShort,dateInfoLong,x,y,lines,weekonoff){
       	var day_date = Lang.format("$1$ $2$", [dateInfoLong.day_of_week, dateInfoLong.day]);
        var month_year = Lang.format("$1$ $2$", [dateInfoLong.month, dateInfoLong.year]);
       	var ordinalday = {};
       	var weekcalc1 = {};
       	var weekcalc2 = {};
      	var weekcalc3 = {};
		var weekcalc4 = {};
		var day7 = 0.0;
		var leapyear = 0;
		
		if (dateInfoShort.year % 100 != 0) {
        	leapyear = 1;
        }
        else if (dateInfoShort.year % 400 != 0) {
        	leapyear = 1;
        }
        else {
        	leapyear = 0;
        }       
    
		if (dateInfoShort.month == 1) {
			ordinalday = 0 + dateInfoShort.day;
		} 
		else if (dateInfoShort.month == 2) {
        	ordinalday = 31 + dateInfoShort.day;
        } 
        else if (dateInfoShort.month == 3) {
        	ordinalday = 59 + dateInfoShort.day + leapyear;
        }
        else if (dateInfoShort.month == 4) {
        	ordinalday = 90 + dateInfoShort.day + leapyear;
        }
        else if (dateInfoShort.month == 5) {
        	ordinalday = 120 + dateInfoShort.day + leapyear;
        }
        else if (dateInfoShort.month == 6) {
        	ordinalday = 151 + dateInfoShort.day + leapyear;
        }
        else if (dateInfoShort.month == 7) {
        	ordinalday = 181 + dateInfoShort.day + leapyear;
        }
        else if (dateInfoShort.month == 8) {
        	ordinalday = 212 + dateInfoShort.day + leapyear;
        }
        else if (dateInfoShort.month == 9) {
        	ordinalday = 243 + dateInfoShort.day + leapyear;
        }
        else if (dateInfoShort.month == 10) {
        	ordinalday = 273 + dateInfoShort.day + leapyear;
        }
        else if (dateInfoShort.month == 11) {
        	ordinalday = 304 + dateInfoShort.day + leapyear;
        }
        else if (dateInfoShort.month == 12) {
        	ordinalday = 334 + dateInfoShort.day + leapyear;
        }
        	
        if (dateInfoShort.day_of_week == 1) {
        	day7 = 1.0;
        }
        else {
        	day7 = 0.0;
        }
        	
        weekcalc1 = ordinalday - dateInfoShort.day_of_week + 10;
        weekcalc2 = weekcalc1 / 7.0;
        weekcalc3 = weekcalc2 - day7;
        weekcalc4 = weekcalc3.format("%d");
        	
        if (weekonoff == 0) {
        	if (lines == 1) {
				dc.drawText(x, y, Gfx.FONT_XTINY, day_date + month_year, Gfx.TEXT_JUSTIFY_CENTER);
		 	}
		 	else if (lines == 2) {
				dc.drawText(x, y, Gfx.FONT_XTINY, day_date , Gfx.TEXT_JUSTIFY_CENTER);
       			dc.drawText(x, y+15, Gfx.FONT_XTINY, month_year, Gfx.TEXT_JUSTIFY_CENTER);
       		}
       		else if (lines == 3) {
				dc.drawText(x, y, Gfx.FONT_XTINY, day_date , Gfx.TEXT_JUSTIFY_CENTER);
       			dc.drawText(x, y+20, Gfx.FONT_XTINY, month_year, Gfx.TEXT_JUSTIFY_CENTER);
       		}
        }
        else {
        	if (lines == 1) {
				dc.drawText(x, y, Gfx.FONT_XTINY, day_date +" w" + weekcalc4 + " " + month_year, Gfx.TEXT_JUSTIFY_CENTER);
			}
		 	else if (lines == 2) {
				dc.drawText(x, y, Gfx.FONT_XTINY, day_date +" w" + weekcalc4, Gfx.TEXT_JUSTIFY_CENTER);
       			dc.drawText(x, y+15, Gfx.FONT_XTINY, month_year, Gfx.TEXT_JUSTIFY_CENTER);
       		}
       		else if (lines == 3) {
				dc.drawText(x, y, Gfx.FONT_XTINY, day_date, Gfx.TEXT_JUSTIFY_CENTER);
				dc.drawText(x, y+20, Gfx.FONT_XTINY, +"week " + weekcalc4, Gfx.TEXT_JUSTIFY_CENTER);
       			dc.drawText(x, y+40, Gfx.FONT_XTINY, month_year, Gfx.TEXT_JUSTIFY_CENTER);
       		}
        }
	}
}
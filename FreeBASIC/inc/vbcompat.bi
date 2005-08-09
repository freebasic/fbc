#ifndef __VBCOMPAT_BI__
#define __VBCOMPAT_BI__

#include "datetime.bi"
#include "string.bi"

#ifndef vbUseSystem
#define vbUseSystem           fbUseSystem
#endif

'' DATE/TIME

#define vbFirstJan1           fbFirstJan1
#define vbFirstFourDays       fbFirstFourDays
#define vbFirstFullWeek       fbFirstFullWeek

#define vbSunday              fbSunday
#define vbMonday              fbMonday
#define vbTuesday             fbTuesday
#define vbWednesday           fbWednesday
#define vbThursday            fbThursday
#define vbFriday              fbFriday
#define vbSaturday            fbSaturday

#define DateSerial            fb_DateSerial
#define DateValue             fb_DateValue
#define Year                  fb_Year
#define Month                 fb_Month
#define Day                   fb_Day
#define Weekday               fb_Weekday

#define TimeSerial            fb_TimeSerial
#define TimeValue             fb_TimeValue
#define Hour                  fb_Hour
#define Minute                fb_Minute
#define Second                fb_Second

#define Now                   fb_Now

#define DateAdd               fb_DateAdd
#define DatePart              fb_DatePart
#define DateDiff              fb_DateDiff

#define MonthName             fb_MonthName
#define WeekdayName           fb_WeekdayName

'' STRING

#define Format                fb_Format

#endif

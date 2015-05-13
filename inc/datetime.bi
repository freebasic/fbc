#ifndef __DATETIME_BI__
#define __DATETIME_BI__

#ifndef fbUseSystem
#define fbUseSystem           0
#endif

#define fbFirstJan1           1
#define fbFirstFourDays       2
#define fbFirstFullWeek       3

#define fbSunday              1
#define fbMonday              2
#define fbTuesday             3
#define fbWednesday           4
#define fbThursday            5
#define fbFriday              6
#define fbSaturday            7

declare function DateSerial          alias "fb_DateSerial" _
          ( byval year as long, _
            byval month as long, _
            byval day as long ) as long

declare function DateValue           alias "fb_DateValue" _
          ( byref s as const string ) as long

declare function IsDate           alias "fb_IsDate" _
          ( byref s as const string ) as long

declare function Year                alias "fb_Year" _
          ( byval serial as double ) as long

declare function Month               alias "fb_Month" _
          ( byval serial as double ) as long

declare function Day                 alias "fb_Day" _
          ( byval serial as double ) as long

declare function Weekday             alias "fb_Weekday" _
          ( byval serial as double, _
            byval FirstDayOfWeek as long = fbUseSystem ) as long

declare function TimeSerial          alias "fb_TimeSerial" _
          ( byval hour as long, _
            byval minute as long, _
            byval second as long ) as double

declare function TimeValue           alias "fb_TimeValue" _
          ( byref s as const string ) as double

declare function Hour                alias "fb_Hour" _
          ( byval serial as double ) as long

declare function Minute              alias "fb_Minute" _
          ( byval serial as double ) as long

declare function Second              alias "fb_Second" _
          ( byval serial as double ) as long

declare function Now                 alias "fb_Now" _
          ( ) as double

declare function DateAdd             alias "fb_DateAdd" _
          ( byref interval as const string, _
            byval number as double, _
            byval serial as double ) as double

declare function DatePart            alias "fb_DatePart" _
          ( byref interval as const string, _
            byval serial as double, _
            byval FirstDayOfWeek as long = fbUseSystem, _
            byval FirstDayOfYear as long = fbUseSystem ) as long

#if __FB_LANG__ = "qb"
declare function DateDiff            alias "fb_DateDiff" _
          ( byref interval as const string, _
            byval serial1 as double, _
            byval serial2 as double, _
            byval FirstDayOfWeek as long = fbUseSystem, _
            byval FirstDayOfYear as long = fbUseSystem ) as __longint
#else
declare function DateDiff            alias "fb_DateDiff" _
          ( byref interval as const string, _
            byval serial1 as double, _
            byval serial2 as double, _
            byval FirstDayOfWeek as long = fbUseSystem, _
            byval FirstDayOfYear as long = fbUseSystem ) as longint
#endif

declare function MonthName           alias "fb_MonthName" _
          ( byval month as long, _
            byval abbreviate as long = 0 ) as string

declare function WeekdayName         alias "fb_WeekdayName" _
          ( byval weekday as long, _
            byval abbreviate as long = 0, _
            byval FirstDayOfWeek as long = fbUseSystem ) as string

#endif

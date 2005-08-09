#ifndef __DATETIME_BI__
#define __DATETIME_BI__

#ifdef __FB_MT__
#if __FB_MT__
'$inclib: "fbxmt"
#else
'$inclib: "fbx"
#endif
#else
'$inclib: "fbx"
#endif

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

declare function fb_DateSerial          alias "fb_DateSerial" _
          ( byval year as integer, _
            byval month as integer, _
            byval day as integer ) as integer

declare function fb_DateValue           alias "fb_DateValue" _
          ( s as string ) as integer

declare function fb_Year                alias "fb_Year" _
          ( byval serial as double ) as integer

declare function fb_Month               alias "fb_Month" _
          ( byval serial as double ) as integer

declare function fb_Day                 alias "fb_Day" _
          ( byval serial as double ) as integer

declare function fb_Weekday             alias "fb_Weekday" _
          ( byval serial as double, _
            byval FirstDayOfWeek as integer = fbUseSystem ) as integer

declare function fb_TimeSerial          alias "fb_TimeSerial" _
          ( byval hour as integer, _
            byval minute as integer, _
            byval second as integer ) as double

declare function fb_TimeValue           alias "fb_TimeValue" _
          ( s as string ) as double

declare function fb_Hour                alias "fb_Hour" _
          ( byval serial as double ) as integer

declare function fb_Minute              alias "fb_Minute" _
          ( byval serial as double ) as integer

declare function fb_Second              alias "fb_Second" _
          ( byval serial as double ) as integer

declare function fb_Now                 alias "fb_Now" _
          ( ) as double

declare function fb_DateAdd             alias "fb_DateAdd" _
          ( interval as string, _
            byval number as double, _
            byval serial as double ) as double

declare function fb_DatePart            alias "fb_DatePart" _
          ( interval as string, _
            byval serial as double, _
            byval FirstDayOfWeek as integer = fbUseSystem, _
            byval FirstDayOfYear as integer = fbUseSystem ) as integer

declare function fb_DateDiff            alias "fb_DateDiff" _
          ( interval as string, _
            byval serial1 as double, _
            byval serial2 as double, _
            byval FirstDayOfWeek as integer = fbUseSystem, _
            byval FirstDayOfYear as integer = fbUseSystem ) as integer

declare function fb_MonthName           alias "fb_MonthName" _
          ( byval month as integer, _
            byval abbreviate as integer = 0 ) as string

declare function fb_WeekdayName         alias "fb_WeekdayName" _
          ( byval weekday as integer, _
            byval abbreviate as integer = 0, _
            byval FirstDayOfWeek as integer = fbUseSystem ) as string

'' format ( byval value as double, mask as string=""

#endif

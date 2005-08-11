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

'' STRING

#endif

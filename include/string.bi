#ifndef __STRING_BI__
#define __STRING_BI__

declare function format    alias "fb_StrFormat" _
          ( byval value as double, _
            byref mask as const string="" ) as string

#endif

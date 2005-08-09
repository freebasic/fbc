#ifndef __STRING_BI__
#define __STRING_BI__

#ifdef __FB_MT__
#if __FB_MT__
'$inclib: "fbxmt"
#else
'$inclib: "fbx"
#endif
#else
'$inclib: "fbx"
#endif

declare function fb_Format    alias "fb_StrFormat" _
          ( byval value as double, _
            mask as string="" ) as string

#endif

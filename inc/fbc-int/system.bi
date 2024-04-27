#ifndef __FBC_INT_SYSTEM_BI__
#define __FBC_INT_SYSTEM_BI__

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

'' DISCLAIMER!!!
''
''   1) this header documents runtime library internals
''      and is subject to change without notice
''
'' declarations must follow ./src/rtlib/fb.h
''                          ./src/rtlib/fb_system.h

namespace FBC

#ifdef __FB_X86__
#ifndef __FB_64_BIT__

'' fb's rtlib doesn't support fb_CpuDetect() anywhere but 32-bit x86

extern "rtlib"
	declare function CpuDetect alias "fb_CpuDetect" as ulong
end extern

#endif
#endif

#if __FB_MT__
extern "rtlib"
	declare sub fbLock alias "fb_Lock" ()
	declare sub fbUnlock alias "fb_Unlock" ()
	declare sub fbStrLock alias "fb_StrLock" ()
	declare sub fbStrUnlock alias "fb_StrUnlock" ()
	declare sub fbGraphicsLock alias "fb_GraphicsLock" ()
	declare sub fbGraphicsUnlock alias "fb_GraphicsUnlock" ()
end extern
#endif

end namespace

#endif

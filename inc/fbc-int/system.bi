#ifndef __FBC_INT_SYSTEM_BI__
#define __FBC_INT_SYSTEM_BI__

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

'' declarations must follow ./src/rtlib/fb_system.h


namespace FBC

#ifdef __FB_X86__
#ifndef __FB_64_BIT__

'' fb's rtlib doesn't support fb_CpuDetect() anywhere but 32-bit x86

extern "rtlib"
	declare function CpuDetect alias "fb_CpuDetect" as ulong
end extern

#endif
#endif

end namespace

#endif

#ifndef __FBC_INT_SYSTEM_BI__
#define __FBC_INT_SYSTEM_BI__

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

'' declarations must follow ./src/rtlib/fb_system.h


namespace FBC

extern "rtlib"
	declare function CpuDetect alias "fb_CpuDetect" as ulong
end extern

end namespace

#endif

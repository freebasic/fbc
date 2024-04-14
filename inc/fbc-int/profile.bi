#ifndef __FBC_INT_PROFILE_BI__
#define __FBC_INT_PROFILE_BI__

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

'' DISCLAIMER!!!
''
''   1) this header documents runtime library internals
''      and is subject to change without notice
''
'' declarations must follow ./src/rtlib/profile.c
''

namespace FBC

enum PROFILE_OPTIONS
	PROFILE_OPTION_REPORT_DEFAULT = 0
	PROFILE_OPTION_REPORT_RAWLIST = 1
	PROFILE_OPTION_REPORT_MASK = 255
end enum


extern "rtlib"
	declare sub InitProfile alias "fb_InitProfile" ()
	declare function ProfileSetFileName alias "fb_ProfileSetFileName" ( byval filename as const zstring ptr ) as long
	declare function ProfileGetOptions alias "fb_ProfileSetOptions" ( ) as PROFILE_OPTIONS
	declare function ProfileSetOptions alias "fb_ProfileSetOptions" ( byval options as PROFILE_OPTIONS ) as PROFILE_OPTIONS
end extern

end namespace

#endif

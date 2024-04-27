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
	PROFILE_OPTION_REPORT_DEFAULT    = &h0000
	PROFILE_OPTION_REPORT_CALLS      = &h0001
	PROFILE_OPTION_REPORT_CALLTREE   = &h0002
	PROFILE_OPTION_REPORT_RAWLIST    = &h0004 
	PROFILE_OPTION_REPORT_RAWDATA    = &h0008
	PROFILE_OPTION_REPORT_RAWSTRINGS = &h0010

	PROFILE_OPTION_REPORT_MASK       = &h00FF

	PROFILE_OPTION_HIDE_HEADER       = &h0100
	PROFILE_OPTION_HIDE_TITLES       = &h0200
	PROFILE_OPTION_HIDE_COUNTS       = &h0400
	PROFILE_OPTION_HIDE_TIMES        = &h0800
	PROFILE_OPTION_SHOW_DEBUGGING    = &h1000
	PROFILE_OPTION_GRAPHICS_CHARS    = &h2000
end enum

extern "rtlib"
	declare sub InitProfile alias "fb_InitProfile" ()
	declare function ProfileSetFileName alias "fb_ProfileSetFileName" ( byval filename as const zstring ptr ) as long
	declare function ProfileGetOptions alias "fb_ProfileSetOptions" ( ) as PROFILE_OPTIONS
	declare function ProfileSetOptions alias "fb_ProfileSetOptions" ( byval options as PROFILE_OPTIONS ) as PROFILE_OPTIONS
	declare sub ProfileIgnore alias "fb_ProfileIgnore" ( byval procedurename as zstring ptr ) 
end extern

#if __FB_MT__
extern "rtlib"
	declare sub fbProfileLock alias "fb_ProfileLock" ()
	declare sub fbProfileUnlock alias "fb_ProfileUnlock" ()
end extern
#endif

end namespace

#endif

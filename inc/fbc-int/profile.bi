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

extern "rtlib"
	declare sub InitProfile alias "fb_InitProfile" ()
	declare function ProfileSetFileName alias "fb_ProfileSetFileName" ( byval filename as const zstring ptr ) as long
end extern

end namespace

#endif

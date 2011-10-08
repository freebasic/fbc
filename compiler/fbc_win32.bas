'' main module, Windows front-end
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "fbc.bi"
#include once "hlp.bi"
#include once "list.bi"

'':::::
private function _getCStdType _
	( _
		byval ctype as FB_CSTDTYPE _
	) as integer

	if( ctype = FB_CSTDTYPE_SIZET ) then
		function = FB_DATATYPE_UINT
	end if

end function


'':::::
function fbcInit_win32( ) as integer

	static as FBC_VTBL vtbl = _
	( _
		@_getCStdType _
	)

	fbc.vtbl = vtbl

	env.target.wchar.type = FB_DATATYPE_USHORT
	env.target.wchar.size = 2

	env.target.triplet = @ENABLE_WIN32
	env.target.define = @"__FB_WIN32__"
	env.target.entrypoint = @"main"
	env.target.underprefix = TRUE
	env.target.constsection = @"rdata"

    '' Default calling convention, must match the rtlib's FBCALL
    env.target.fbcall = FB_FUNCMODE_STDCALL

    '' Specify whether stdcall or EXTERN "windows" result in STDCALL (with @N),
    '' or STDCALL_MS (without @N).
    env.target.stdcall = FB_FUNCMODE_STDCALL

	return TRUE

end function

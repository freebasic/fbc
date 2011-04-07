
#include once "spidermonkey/jsapi.bi"

type sm
	as JSRuntime ptr rt
    as JSContext ptr cx
    as JSObject ptr global
end type

declare function sm_create _
	( _
		byval rt_maxbytes as integer = &h100000, _
		byval cx_stacksize as integer = &h1000 _
	) as sm ptr

declare sub sm_destroy _
	( _
		byval sm as sm ptr _
	)

declare function sm_eval _
	( _
		byval sm as sm ptr, _
		byval script as zstring ptr _
	) as zstring ptr

declare function sm_addfunction _
	( _
		byval sm as sm ptr, _
		byval funcname as zstring ptr, _
		byval funcaddr as JSNative, _
		byval params as integer, _
		byval attributes as integer = 0 _
	) as JSFunction ptr

declare function sm_load _
	( _
		byval filename as string _
	) as string

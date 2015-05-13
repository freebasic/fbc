''
''
'' gd_io -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gd_io_bi__
#define __gd_io_bi__

type gdIOCtx
	getC as function(byval as gdIOCtx ptr) as integer
	getBuf as function(byval as gdIOCtx ptr, byval as any ptr, byval as integer) as integer
	putC as sub(byval as gdIOCtx ptr, byval as integer)
	putBuf as function(byval as gdIOCtx ptr, byval as any ptr, byval as integer) as integer
	seek as function(byval as gdIOCtx ptr, byval as integer) as integer
	tell as function(byval as gdIOCtx ptr) as integer
	gd_free as sub(byval as gdIOCtx ptr)
end type

type gdIOCtxPtr as gdIOCtx ptr

declare sub Putword alias "Putword" (byval w as integer, byval ctx as gdIOCtx ptr)
declare sub Putchar_ alias "Putchar" (byval c as integer, byval ctx as gdIOCtx ptr)
declare sub gdPutC alias "gdPutC" (byval c as ubyte, byval ctx as gdIOCtx ptr)
declare function gdPutBuf alias "gdPutBuf" (byval as any ptr, byval as integer, byval as gdIOCtx ptr) as integer
declare sub gdPutWord alias "gdPutWord" (byval w as integer, byval ctx as gdIOCtx ptr)
declare sub gdPutInt alias "gdPutInt" (byval w as integer, byval ctx as gdIOCtx ptr)
declare function gdGetC alias "gdGetC" (byval ctx as gdIOCtx ptr) as integer
declare function gdGetBuf alias "gdGetBuf" (byval as any ptr, byval as integer, byval as gdIOCtx ptr) as integer
declare function gdGetByte alias "gdGetByte" (byval result as integer ptr, byval ctx as gdIOCtx ptr) as integer
declare function gdGetWord alias "gdGetWord" (byval result as integer ptr, byval ctx as gdIOCtx ptr) as integer
declare function gdGetInt alias "gdGetInt" (byval result as integer ptr, byval ctx as gdIOCtx ptr) as integer
declare function gdSeek alias "gdSeek" (byval ctx as gdIOCtx ptr, byval as integer) as integer
declare function gdTell alias "gdTell" (byval ctx as gdIOCtx ptr) as integer

#endif

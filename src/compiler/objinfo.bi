#include once "list.bi"

enum
	OBJINFO_LIB = 0
	OBJINFO_LIBPATH
	OBJINFO_MT
	OBJINFO_GFX
	OBJINFO_LANG
	OBJINFO__COUNT
end enum

declare sub objinfoReadObj( byref objfile as string )
declare sub objinfoReadLibfile( byref libfile as string )
declare sub objinfoReadLib( byref libname as string, byval libpaths as TLIST ptr )
declare function objinfoReadNext( byref dat as string ) as integer
declare function objinfoGetFilename( ) as zstring ptr
declare sub objinfoReadEnd( )
declare function objinfoEncode( byval entry as integer ) as zstring ptr

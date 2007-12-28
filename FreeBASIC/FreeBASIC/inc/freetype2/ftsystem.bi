''
''
'' ftsystem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ftsystem_bi__
#define __ftsystem_bi__

type FT_Memory as FT_MemoryRec_ ptr
type FT_Alloc_Func as sub cdecl(byval as FT_Memory, byval as integer)
type FT_Free_Func as sub cdecl(byval as FT_Memory, byval as any ptr)
type FT_Realloc_Func as sub cdecl(byval as FT_Memory, byval as integer, byval as integer, byval as any ptr)

type FT_MemoryRec_
	user as any ptr
	alloc as FT_Alloc_Func
	free as FT_Free_Func
	realloc as FT_Realloc_Func
end type

type FT_Stream as FT_StreamRec_ ptr

union FT_StreamDesc_
	value as integer
	pointer as any ptr
end union

type FT_StreamDesc as FT_StreamDesc_
type FT_Stream_IoFunc as function cdecl(byval as FT_Stream, byval as uinteger, byval as ubyte ptr, byval as uinteger) as uinteger
type FT_Stream_CloseFunc as sub cdecl(byval as FT_Stream)

type FT_StreamRec_
	base as ubyte ptr
	size as uinteger
	pos as uinteger
	descriptor as FT_StreamDesc
	pathname as FT_StreamDesc
	read as FT_Stream_IoFunc
	close as FT_Stream_CloseFunc
	memory as FT_Memory
	cursor as ubyte ptr
	limit as ubyte ptr
end type

type FT_StreamRec as FT_StreamRec_

#endif

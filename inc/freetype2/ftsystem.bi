#pragma once

#include once "crt/long.bi"

extern "C"

#define __FTSYSTEM_H__
type FT_Memory as FT_MemoryRec_ ptr
type FT_Alloc_Func as function(byval memory as FT_Memory, byval size as clong) as any ptr
type FT_Free_Func as sub(byval memory as FT_Memory, byval block as any ptr)
type FT_Realloc_Func as function(byval memory as FT_Memory, byval cur_size as clong, byval new_size as clong, byval block as any ptr) as any ptr

type FT_MemoryRec_
	user as any ptr
	alloc as FT_Alloc_Func
	free as FT_Free_Func
	realloc as FT_Realloc_Func
end type

type FT_Stream as FT_StreamRec_ ptr

union FT_StreamDesc_
	value as clong
	pointer as any ptr
end union

type FT_StreamDesc as FT_StreamDesc_
type FT_Stream_IoFunc as function(byval stream as FT_Stream, byval offset as culong, byval buffer as ubyte ptr, byval count as culong) as culong
type FT_Stream_CloseFunc as sub(byval stream as FT_Stream)

type FT_StreamRec_
	base as ubyte ptr
	size as culong
	pos as culong
	descriptor as FT_StreamDesc
	pathname as FT_StreamDesc
	read as FT_Stream_IoFunc
	close as FT_Stream_CloseFunc
	memory as FT_Memory
	cursor as ubyte ptr
	limit as ubyte ptr
end type

type FT_StreamRec as FT_StreamRec_

end extern

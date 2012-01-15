''
''
'' cst_track -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_track_bi__
#define __cst_track_bi__

type cst_track_struct
	type as zstring ptr
	num_frames as integer
	num_channels as integer
	times as single ptr
	frames as single ptr ptr
end type

type cst_track as cst_track_struct

declare function new_track cdecl alias "new_track" () as cst_track ptr
declare sub delete_track cdecl alias "delete_track" (byval val as cst_track ptr)
declare function track_frame_shift cdecl alias "track_frame_shift" (byval t as cst_track ptr, byval frame as integer) as single
declare sub cst_track_resize cdecl alias "cst_track_resize" (byval t as cst_track ptr, byval num_frames as integer, byval num_channels as integer)
declare function cst_track_save_est cdecl alias "cst_track_save_est" (byval t as cst_track ptr, byval filename as zstring ptr) as integer
declare function cst_track_save_est_binary cdecl alias "cst_track_save_est_binary" (byval t as cst_track ptr, byval filename as zstring ptr) as integer
declare function cst_track_load_est cdecl alias "cst_track_load_est" (byval t as cst_track ptr, byval filename as zstring ptr) as integer

#endif

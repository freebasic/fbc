''
''
'' allegro\file -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_file_bi__
#define __allegro_file_bi__

#include once "allegro/base.bi"

declare function fix_filename_case cdecl alias "fix_filename_case" (byval path as zstring ptr) as zstring ptr
declare function fix_filename_slashes cdecl alias "fix_filename_slashes" (byval path as zstring ptr) as zstring ptr
declare function fix_filename_path cdecl alias "fix_filename_path" (byval dest as zstring ptr, byval path as zstring ptr, byval size as integer) as zstring ptr
declare function replace_filename cdecl alias "replace_filename" (byval dest as zstring ptr, byval path as zstring ptr, byval filename as zstring ptr, byval size as integer) as zstring ptr
declare function replace_extension cdecl alias "replace_extension" (byval dest as zstring ptr, byval filename as zstring ptr, byval ext as zstring ptr, byval size as integer) as zstring ptr
declare function append_filename cdecl alias "append_filename" (byval dest as zstring ptr, byval path as zstring ptr, byval filename as zstring ptr, byval size as integer) as zstring ptr
declare function get_filename cdecl alias "get_filename" (byval path as zstring ptr) as zstring ptr
declare function get_extension cdecl alias "get_extension" (byval filename as zstring ptr) as zstring ptr
declare sub put_backslash cdecl alias "put_backslash" (byval filename as zstring ptr)
declare function file_exists cdecl alias "file_exists" (byval filename as zstring ptr, byval attrib as integer, byval aret as integer ptr) as integer
declare function exists cdecl alias "exists" (byval filename as zstring ptr) as integer
declare function file_size cdecl alias "file_size" (byval filename as zstring ptr) as integer
declare function file_time cdecl alias "file_time" (byval filename as zstring ptr) as time_t
declare function delete_file cdecl alias "delete_file" (byval filename as zstring ptr) as integer
declare function for_each_file cdecl alias "for_each_file" (byval name as zstring ptr, byval attrib as integer, byval callback as sub cdecl(byval as zstring ptr, byval as integer, byval as integer), byval param as integer) as integer
declare function find_allegro_resource cdecl alias "find_allegro_resource" (byval dest as zstring ptr, byval resource as zstring ptr, byval ext as zstring ptr, byval datafile as zstring ptr, byval objectname as zstring ptr, byval envvar as zstring ptr, byval subdir as zstring ptr, byval size as integer) as integer

type al_ffblk
	attrib as integer
	time as time_t
	size as integer
	name as zstring * 512
	ff_data as any ptr
end type

declare function al_findfirst cdecl alias "al_findfirst" (byval pattern as zstring ptr, byval info as al_ffblk ptr, byval attrib as integer) as integer
declare function al_findnext cdecl alias "al_findnext" (byval info as al_ffblk ptr) as integer
declare sub al_findclose cdecl alias "al_findclose" (byval info as al_ffblk ptr)

#define F_READ "r"
#define F_WRITE "w"
#define F_READ_PACKED "rp"
#define F_WRITE_PACKED "wp"
#define F_WRITE_NOPACK "w!"
#define F_BUF_SIZE 4096
#define F_PACK_MAGIC &h736C6821L
#define F_NOPACK_MAGIC &h736C682EL
#define F_EXE_MAGIC &h736C682BL
#define PACKFILE_FLAG_WRITE 1
#define PACKFILE_FLAG_PACK 2
#define PACKFILE_FLAG_CHUNK 4
#define PACKFILE_FLAG_EOF 8
#define PACKFILE_FLAG_ERROR 16
#define PACKFILE_FLAG_OLD_CRYPT 32
#define PACKFILE_FLAG_EXEDAT 64

type PACKFILE
	hndl as integer
	flags as integer
	buf_pos as ubyte ptr
	buf_size as integer
	todo as integer
	parent as PACKFILE ptr
	pack_data as any ptr
	filename as zstring ptr
	passdata as zstring ptr
	passpos as zstring ptr
	buf(0 to 4096-1) as ubyte
end type

declare sub packfile_password cdecl alias "packfile_password" (byval password as zstring ptr)
declare function pack_fopen cdecl alias "pack_fopen" (byval filename as zstring ptr, byval mode as zstring ptr) as PACKFILE ptr
declare function pack_fclose cdecl alias "pack_fclose" (byval f as PACKFILE ptr) as integer
declare function pack_fseek cdecl alias "pack_fseek" (byval f as PACKFILE ptr, byval offset as integer) as integer
declare function pack_fopen_chunk cdecl alias "pack_fopen_chunk" (byval f as PACKFILE ptr, byval pack as integer) as PACKFILE ptr
declare function pack_fclose_chunk cdecl alias "pack_fclose_chunk" (byval f as PACKFILE ptr) as PACKFILE ptr
declare function pack_igetw cdecl alias "pack_igetw" (byval f as PACKFILE ptr) as integer
declare function pack_igetl cdecl alias "pack_igetl" (byval f as PACKFILE ptr) as integer
declare function pack_iputw cdecl alias "pack_iputw" (byval w as integer, byval f as PACKFILE ptr) as integer
declare function pack_iputl cdecl alias "pack_iputl" (byval l as integer, byval f as PACKFILE ptr) as integer
declare function pack_mgetw cdecl alias "pack_mgetw" (byval f as PACKFILE ptr) as integer
declare function pack_mgetl cdecl alias "pack_mgetl" (byval f as PACKFILE ptr) as integer
declare function pack_mputw cdecl alias "pack_mputw" (byval w as integer, byval f as PACKFILE ptr) as integer
declare function pack_mputl cdecl alias "pack_mputl" (byval l as integer, byval f as PACKFILE ptr) as integer
declare function pack_fread cdecl alias "pack_fread" (byval p as any ptr, byval n as integer, byval f as PACKFILE ptr) as integer
declare function pack_fwrite cdecl alias "pack_fwrite" (byval p as any ptr, byval n as integer, byval f as PACKFILE ptr) as integer
declare function pack_fgets cdecl alias "pack_fgets" (byval p as zstring ptr, byval max as integer, byval f as PACKFILE ptr) as zstring ptr
declare function pack_fputs cdecl alias "pack_fputs" (byval p as zstring ptr, byval f as PACKFILE ptr) as integer
declare function _sort_out_getc cdecl alias "_sort_out_getc" (byval f as PACKFILE ptr) as integer
declare function _sort_out_putc cdecl alias "_sort_out_putc" (byval c as integer, byval f as PACKFILE ptr) as integer

#include "allegro/inline/file.bi"

#endif

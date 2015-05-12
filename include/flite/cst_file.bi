''
''
'' cst_file -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_file_bi__
#define __cst_file_bi__

#define CST_WRONG_FORMAT -2
#define CST_ERROR_FORMAT -1
#define CST_OK_FORMAT 0

type cst_file as FILE ptr

type cst_filemap_struct
	mem as any ptr
	fh as cst_file
	mapsize as size_t
	fd as integer
end type

type cst_filemap as cst_filemap_struct

#define CST_OPEN_WRITE (1 shl 0)
#define CST_OPEN_READ (1 shl 1)
#define CST_OPEN_APPEND (1 shl 2)
#define CST_OPEN_BINARY (1 shl 3)
#define CST_SEEK_ABSOLUTE 0
#define CST_SEEK_RELATIVE 1
#define CST_SEEK_ENDREL 2

declare function cst_fopen cdecl alias "cst_fopen" (byval path as zstring ptr, byval mode as integer) as cst_file
declare function cst_fwrite cdecl alias "cst_fwrite" (byval fh as cst_file, byval buf as any ptr, byval size as integer, byval count as integer) as integer
declare function cst_fread cdecl alias "cst_fread" (byval fh as cst_file, byval buf as any ptr, byval size as integer, byval count as integer) as integer
declare function cst_fprintf cdecl alias "cst_fprintf" (byval fh as cst_file, byval fmt as zstring ptr, ...) as integer
declare function cst_sprintf cdecl alias "cst_sprintf" (byval s as zstring ptr, byval fmt as zstring ptr, ...) as integer
declare function cst_fclose cdecl alias "cst_fclose" (byval fh as cst_file) as integer
declare function cst_fgetc cdecl alias "cst_fgetc" (byval fh as cst_file) as integer
declare function cst_ftell cdecl alias "cst_ftell" (byval fh as cst_file) as integer
declare function cst_fseek cdecl alias "cst_fseek" (byval fh as cst_file, byval pos as integer, byval whence as integer) as integer
declare function cst_filesize cdecl alias "cst_filesize" (byval fh as cst_file) as integer
declare function cst_mmap_file cdecl alias "cst_mmap_file" (byval path as zstring ptr) as cst_filemap ptr
declare function cst_munmap_file cdecl alias "cst_munmap_file" (byval map as cst_filemap ptr) as integer
declare function cst_read_whole_file cdecl alias "cst_read_whole_file" (byval path as zstring ptr) as cst_filemap ptr
declare function cst_free_whole_file cdecl alias "cst_free_whole_file" (byval map as cst_filemap ptr) as integer
declare function cst_read_part_file cdecl alias "cst_read_part_file" (byval path as zstring ptr) as cst_filemap ptr
declare function cst_free_part_file cdecl alias "cst_free_part_file" (byval map as cst_filemap ptr) as integer

#endif

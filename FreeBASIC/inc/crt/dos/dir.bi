''
''
'' dir -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_dos_dir_bi__
#define __crt_dos_dir_bi__

type ffblk
	lfn_magic as zstring * 6
	lfn_handle as short
	lfn_ctime as ushort
	lfn_cdate as ushort
	lfn_atime as ushort
	lfn_adate as ushort
	_ff_reserved as zstring * 5
	ff_attrib as ubyte
	ff_ftime as ushort
	ff_fdate as ushort
	ff_fsize as uinteger
	ff_name as zstring * 260
end type

type ffblklfn
	fd_attrib as uinteger
	fd_ctime as ulongint
	fd_atime as ulongint
	fd_mtime as ulongint
	fd_sizehi as uinteger
	fd_size as uinteger
	fd_reserved as ulongint
	fd_longname as zstring * 260
	fd_name as zstring * 14
end type

#define FA_RDONLY 1
#define FA_HIDDEN 2
#define FA_SYSTEM 4
#define FA_LABEL 8
#define FA_DIREC 16
#define FA_ARCH 32
#define MAXPATH 260
#define MAXDRIVE 3
#define MAXDIR 256
#define MAXFILE 256
#define MAXEXT 255
#define WILDCARDS_ &h01
#define EXTENSION_ &h02
#define FILENAME_ &h04
#define DIRECTORY_ &h08
#define DRIVE_ &h10

declare function __file_tree_walk cdecl alias "__file_tree_walk" (byval _dir as zstring ptr, byval _fn as function cdecl(byval as zstring ptr, byval as ffblk ptr) as integer) as integer
declare function findfirst cdecl alias "findfirst" (byval _pathname as zstring ptr, byval _ffblk as ffblk ptr, byval _attrib as integer) as integer
declare function findnext cdecl alias "findnext" (byval _ffblk as ffblk ptr) as integer
declare sub fnmerge cdecl alias "fnmerge" (byval _path as zstring ptr, byval _drive as zstring ptr, byval _dir as zstring ptr, byval _name as zstring ptr, byval _ext as zstring ptr)
declare function fnsplit cdecl alias "fnsplit" (byval _path as zstring ptr, byval _drive as zstring ptr, byval _dir as zstring ptr, byval _name as zstring ptr, byval _ext as zstring ptr) as integer
declare function getdisk cdecl alias "getdisk" () as integer
declare function searchpath cdecl alias "searchpath" (byval _program as zstring ptr) as zstring ptr
declare function setdisk cdecl alias "setdisk" (byval _drive as integer) as integer

#endif
' Copyright (C) 1998 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
' converted by DrV for FreeBASIC 07-Feb-2005

#ifndef __dj_include_dir_h_
#define __dj_include_dir_h_

' !!!hack!!! - DrV
type ulonglong field = 4
	a as uinteger
	b as uinteger
end type

' ffblk is also enhanced for LFNs; the dos 21 byte reserved area is used to
' hold the extra information.  Fields marked LFN are only valid if the magic
' is set to LFN32

type ffblk field = 1
	lfn_magic(5)	as byte		' LFN
	lfn_handle	as short	' LFN
	lfn_ctime	as ushort	' LFN
	lfn_cdate	as ushort	' LFN
	lfn_atime	as ushort	' LFN
	lfn_adate	as ushort	' LFN
	ff_reserved(4)	as byte
	ff_attrib	as ubyte
	ff_ftime	as ushort
	ff_fdate	as ushort
	ff_fsize	as uinteger
	ff_name(259)	as byte
end type

type ffblklfn field = 1
	fd_attrib		as uinteger
	fd_ctime		as ulonglong
	fd_atime		as ulonglong
	fd_mtime		as ulonglong
	fd_sizehi		as uinteger
	fd_size			as uinteger
	fd_reserved		as ulonglong
	fd_longname(259)	as byte
	fd_name(13)		as byte
end type


#define FA_RDONLY	1
#define FA_HIDDEN	2
#define FA_SYSTEM	4
#define FA_LABEL	8
#define FA_DIREC	16
#define FA_ARCH		32

' for fnmerge/fnsplit
#define MAXPATH   260
#define MAXDRIVE  3
#define MAXDIR	  256
#define MAXFILE   256
#define MAXEXT	  255

#define WILDCARDS &H01
#define EXTENSION &H02
#define FILENAME  &H04
#define DIRECTORY &H08
#define DRIVE	  &H10

declare function	file_tree_walk	cdecl alias "__file_tree_walk"	(byval dir as string, byval fn as function(byval path as string, byval ff as ffblk ptr) as integer) as integer
declare function	findfirst	cdecl alias "findfirst"		(byval pathname as string, byval ffblk_ as ffblk ptr, byval attrib as integer) as integer
declare function	findnext	cdecl alias "findnext"		(byval ffblk_ as ffblk ptr) as integer
declare function	fnmerge		cdecl alais "fnmerge"		(byval path as string, byval drive as string, byval sdir as string, byval sname as string, byval ext as string) as integer
declare function	fnsplit		cdecl alias "fnsplit"		(byval path as string, byval drive as string, byval sdir as string, byval sname as string, byval ext as string) as integer
declare function	getdisk		cdecl alias "getdisk"		() as integer
declare function	searchpath	cdecl alias "searchpath"	(byval program as string) as byte ptr
declare function	setdisk		cdecl alias "setdisk"		(byval drive as integer) as integer

#endif ' !__dj_include_dir.h_

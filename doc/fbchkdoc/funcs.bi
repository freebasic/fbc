#ifndef __FBCHKDOC_FUNCS_BI__
#define __FBCHKDOC_FUNCS_BI__

''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008-2018 Jeffery R. Marshall (coder[at]execulink[dot]com)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.

#inclib "funcs"

#ifndef FALSE
const FALSE = 0
#endif

#ifndef TRUE
const TRUE = NOT FALSE
#endif

'' funcs.bas
declare function ParsePageName( byref x as string, byref comment as string ) as string
declare function ReplacePathChar( byref a as string, byval ch as integer ) as string
declare function GetUrlFileName( byref url as string ) as string

'' funcsdir.bas
declare function ReadFileAsText( byref filename as string ) as string
declare function WriteFileAsText( byref filename as string, byref text as string, byval overwrite as integer = FALSE ) as integer
declare function ScanSourceDirs( byref path as string, byref path2 as string, dirs() as string, byref ndirs as integer, exfilters() as string, byval nexfiltes as integer ) as integer
declare function ScanSourceFiles( byref path as string, byref src_dir as string, files() as string, byref nfiles as integer ) as integer
declare function ScanSourceDirsAndFiles( byref path as string, dirs() as string, byref ndirs as integer, files() as string, byref nfiles as integer, filters() as string, byval nfilters as integer, exfilters() as string, byval nexfiltes as integer ) as integer

'' fmtcode.bas
declare function FormatFbCode( byref txt as string ) as string
declare function FormatFbCodeLoadKeywords( byref filename as string ) as boolean


'' cmd_opts.bas
enum CMD_OPTS_ENABLE_FLAGS
	CMD_OPTS_ENABLE_NONE = 0
	CMD_OPTS_ENABLE_URL = 1
	CMD_OPTS_ENABLE_CACHE = 2
	CMD_OPTS_ENABLE_LOGIN = 4
	CMD_OPTS_ENABLE_IMAGE = 8
	CMD_OPTS_ENABLE_PAGELIST = 16
	CMD_OPTS_ENABLE_MANUAL = 32

	CMD_OPTS_ENABLE_AUTOCACHE = &h1000

end enum

declare sub cmd_opts_init( byval opts_flags as const CMD_OPTS_ENABLE_FLAGS ) 
declare sub cmd_opts_die( byref msg as const string )
declare sub cmd_opts_unrecognized_die( byval i as const integer )
declare sub cmd_opts_unexpected_die( byval i as const integer )
declare function cmd_opts_read( byref i as integer ) as boolean
declare function cmd_opts_resolve() as boolean
declare function cmd_opts_check() as boolean

#endif

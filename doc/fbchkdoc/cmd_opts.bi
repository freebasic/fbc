#ifndef __FBCHKDOC_CMD_OPTS_BI__
#define __FBCHKDOC_CMD_OPTS_BI__

''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2019 Jeffery R. Marshall (coder[at]execulink[dot]com)
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
declare sub cmd_opts_show_help( byref action as const string = "", byval locations as boolean = true )
declare sub cmd_opts_show_help_item( byref opt_name as const string, byref opt_desc as const string )

type CMD_OPTS_GLOBAL

	'' command line options
	help as boolean
	verbose as boolean

	''resolved options
	wiki_url as string
	cache_dir as string
	ca_file as string
	wiki_username as string
	wiki_password as string
	image_dir as string
	manual_dir as string

	webPageCount as integer
	webPageList(any) as string
	webPageComments(any) as string

end type

extern app_opt as CMD_OPTS_GLOBAL

#endif

#ifndef __FBCHKDOC_FUNCS_BI__
#define __FBCHKDOC_FUNCS_BI__

''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008 Jeffery R. Marshall (coder[at]execulink[dot]com)
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
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.

#inclib "funcs"

declare function ParsePageName( byref x as string, byref comment as string ) as string
declare function ReplacePathChar( byref a as string, byval ch as integer ) as string
declare function GetUrlFileName( byref url as string ) as string

#endif

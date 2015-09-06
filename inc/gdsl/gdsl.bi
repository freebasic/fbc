'' FreeBASIC binding for gdsl-1.8
''
'' based on the C header files:
''   This file is part of the Generic Data Structures Library (GDSL).
''   Copyright (C) 1998-2006 Nicolas Darnis <ndarnis@free.fr>.
''
''   The GDSL library is free software; you can redistribute it and/or 
''   modify it under the terms of the GNU General Public License as 
''   published by the Free Software Foundation; either version 2 of
''   the License, or (at your option) any later version.
''
''   The GDSL library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''   GNU General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with the GDSL library; see the file COPYING.
''   If not, write to the Free Software Foundation, Inc., 
''   51 Franklin Street, Fifth Floor, Boston, MA  02111-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "gdsl"
#inclib "gdsl"

#include once "gdsl/gdsl_types.bi"
#include once "gdsl/gdsl_macros.bi"
#include once "gdsl/gdsl_list.bi"
#include once "gdsl/gdsl_stack.bi"
#include once "gdsl/gdsl_queue.bi"
#include once "gdsl/gdsl_2darray.bi"
#include once "gdsl/gdsl_bstree.bi"
#include once "gdsl/gdsl_perm.bi"
#include once "gdsl/gdsl_rbtree.bi"
#include once "gdsl/gdsl_hash.bi"
#include once "gdsl/gdsl_sort.bi"
#include once "gdsl/gdsl_heap.bi"
#include once "gdsl/gdsl_interval_heap.bi"
#include once "gdsl/_gdsl_list.bi"
#include once "gdsl/_gdsl_bintree.bi"
#include once "gdsl/_gdsl_bstree.bi"

extern "C"

#define _GDSL_H_
declare function gdsl_get_version() as const zstring ptr

end extern

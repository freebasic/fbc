#
#  libfb - FreeBASIC's runtime library
#  Copyright (C) 2004-2008 The FreeBASIC development team.
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

#
# alloca.s -- alloca() implementation for Win32, as it's not part of m$'s crt
#
# note: code came from mingw
#
#

		.intel_syntax noprefix
/*		.arch i386 */ /* This option is only for ALPHA */

/* MinGW now includes it's own alloca() */
#if __GNUC__ < 4

.section .text
#:::::
# void _alloca( size_t size -- passed in EAX! );
.globl __alloca
__alloca:
		push	ecx
		mov 	ecx ,esp
		add 	ecx ,8
_loop:		cmp 	eax, 1000
		jb 	_rem
		sub 	ecx, 1000
		or 	dword ptr [ecx], 0
		sub 	eax, 1000
		jmp 	_loop

_rem:		sub 	ecx, eax
		or 	dword ptr [ecx], 0
		mov 	eax, esp
		mov 	esp, ecx
		mov 	ecx, [eax]
		mov 	eax, [eax+4]
		jmp 	eax


#endif
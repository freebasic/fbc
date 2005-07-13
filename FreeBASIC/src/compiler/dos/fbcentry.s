#	FreeBASIC - 32-bit BASIC Compiler.
#	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
#
#	This program is free software; you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation; either version 2 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program; if not, write to the Free Software
#	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


# fbc DOS entrypoint hack for compiler (assemble this file using GAS for DJGPP only)
#
# chng: jan/2005 written [DrV]
#

.section .text
.globl _main
_main:
movl 8(%esp), %edx
movl 4(%esp), %eax
pushl %edx
pushl %eax
call _fb_Main_fbc


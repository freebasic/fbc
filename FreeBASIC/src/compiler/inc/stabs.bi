''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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


const STAB_TYPE_GSYM 	= 32 'Global symbol
const STAB_TYPE_FNAME 	= 34 'Function name (for BSD Fortran)
const STAB_TYPE_FUN 	= 36 'Function
const STAB_TYPE_STSYM 	= 38 'Data segment file-scope variable
const STAB_TYPE_LCSYM 	= 40 'BSS segment file-scope variable
const STAB_TYPE_MAIN 	= 42 'Name of main routine
const STAB_TYPE_ROSYM 	= 44 'Variable in .rodata section
const STAB_TYPE_PC 		= 48 'Global symbol (for Pascal)
const STAB_TYPE_NSYMS 	= 50 'Number of symbols
const STAB_TYPE_NOMAP 	= 52 'No DST map
const STAB_TYPE_OBJ 	= 56 'Object file
const STAB_TYPE_OPT 	= 60 'Debugger options
const STAB_TYPE_RSYM 	= 64 'Register variable
const STAB_TYPE_M2C 	= 66 'Modula-2 compilation unit
const STAB_TYPE_SLINE 	= 68 'Line number in text segment
const STAB_TYPE_DSLINE 	= 70 'Line number in data segment
const STAB_TYPE_BSLINE 	= 72 'Line number in bss segment
const STAB_TYPE_BROWS 	= 72 'Sun source code browser, path to ‘.cb’ file
const STAB_TYPE_DEFD 	= 74 'GNU Modula2 definition module dependency
const STAB_TYPE_FLINE 	= 76 'Function start/body/end line numbers
const STAB_TYPE_EHDECL 	= 80 'GNU C++ exception variable
const STAB_TYPE_MOD2 	= 80 'Modula2 info "for imc" (according to Ultrix V4.0)
const STAB_TYPE_CATCH 	= 84 'GNU C++ catch clause9
const STAB_TYPE_SSYM 	= 96 'Structure of union element
const STAB_TYPE_ENDM 	= 98 'Last stab for module
const STAB_TYPE_SO 		= 100 'Path and name of source file
const STAB_TYPE_LSYM 	= 128 'Stack variable
const STAB_TYPE_BINCL 	= 130 'Beginning of an include file (Sun only)
const STAB_TYPE_SOL 	= 132 'Name of include file
const STAB_TYPE_PSYM 	= 160 'Parameter variable
const STAB_TYPE_EINCL 	= 162 'End of an include file
const STAB_TYPE_ENTRY 	= 164 'Alternate entry point
const STAB_TYPE_LBRAC 	= 192 'Beginning of a lexical block
const STAB_TYPE_EXCL 	= 194 'Place holder for a deleted include file
const STAB_TYPE_SCOPE 	= 196 'Modula2 scope information (Sun linker)
const STAB_TYPE_RBRAC 	= 224 'End of a lexical block
const STAB_TYPE_BCOMM 	= 226 'Begin named common block
const STAB_TYPE_ECOMM 	= 228 'End named common block
const STAB_TYPE_ECOML 	= 230 'Member of a common block
const STAB_TYPE_WITH 	= 232 'Pascal with statement: type,,0,0,offset

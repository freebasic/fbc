''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


const N_GSYM 	= 32 'Global symbol
const N_FNAME 	= 34 'Function name (for BSD Fortran)
const N_FUN 	= 36 'Function
const N_STSYM 	= 38 'Data segment file-scope variable
const N_LCSYM 	= 40 'BSS segment file-scope variable
const N_MAIN 	= 42 'Name of main routine
const N_ROSYM 	= 44 'Variable in .rodata section
const N_PC 		= 48 'Global symbol (for Pascal)
const N_NSYMS 	= 50 'Number of symbols
const N_NOMAP 	= 52 'No DST map
const N_OBJ 	= 56 'Object file
const N_OPT 	= 60 'Debugger options
const N_RSYM 	= 64 'Register variable
const N_M2C 	= 66 'Modula-2 compilation unit
const N_SLINE 	= 68 'Line number in text segment
const N_DSLINE 	= 70 'Line number in data segment
const N_BSLINE 	= 72 'Line number in bss segment
const N_BROWS 	= 72 'Sun source code browser, path to ‘.cb’ file
const N_DEFD 	= 74 'GNU Modula2 definition module dependency
const N_FLINE 	= 76 'Function start/body/end line numbers
const N_EHDECL 	= 80 'GNU C++ exception variable
const N_MOD2 	= 80 'Modula2 info "for imc" (according to Ultrix V4.0)
const N_CATCH 	= 84 'GNU C++ catch clause9
const N_SSYM 	= 96 'Structure of union element
const N_ENDM 	= 98 'Last stab for module
const N_SO 		= 100 'Path and name of source file
const N_LSYM 	= 128 'Stack variable
const N_BINCL 	= 130 'Beginning of an include file (Sun only)
const N_SOL 	= 132 'Name of include file
const N_PSYM 	= 160 'Parameter variable
const N_EINCL 	= 162 'End of an include file
const N_ENTRY 	= 164 'Alternate entry point
const N_LBRAC 	= 192 'Beginning of a lexical block
const N_EXCL 	= 194 'Place holder for a deleted include file
const N_SCOPE 	= 196 'Modula2 scope information (Sun linker)
const N_RBRAC 	= 224 'End of a lexical block
const N_BCOMM 	= 226 'Begin named common block
const N_ECOMM 	= 228 'End named common block
const N_ECOML 	= 230 'Member of a common block
const N_WITH 	= 232 'Pascal with statement: type,,0,0,offset

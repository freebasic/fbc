#ifndef __FBC_BI__
#define __FBC_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

const QUOTE = "\""

const FB_MAXARGS	  = 250
const FB_MINSTACKSIZE = 32 * 1024
const FB_DEFSTACKSIZE = 1024 * 1024

'' command-line options (linked to the fbc::optionTb() array)
enum FBC_OPT
	FBC_OPT_E				= 1
	FBC_OPT_EX
	FBC_OPT_EXX
	FBC_OPT_MT
	FBC_OPT_PROFILE
	FBC_OPT_NOERRLINE
	FBC_OPT_NODEFLIBS
	FBC_OPT_EXPORT
	FBC_OPT_NOSTDCALL
	FBC_OPT_STDCALL
	FBC_OPT_NOUNDERSCORE
	FBC_OPT_UNDERSCORE
	FBC_OPT_SHOWSUSPERR
	FBC_OPT_ARCH
	FBC_OPT_DEBUG
	FBC_OPT_COMPILEONLY
	FBC_OPT_SHAREDLIB
	FBC_OPT_STATICLIB
	FBC_OPT_PRESERVEFILES
	FBC_OPT_VERBOSE
	FBC_OPT_VERSION
	FBC_OPT_OUTPUTNAME
	FBC_OPT_MAINMODULE
	FBC_OPT_MAPFILE
	FBC_OPT_MAXERRORS
	FBC_OPT_WARNLEVEL
	FBC_OPT_LIBPATH
	FBC_OPT_INCPATH
	FBC_OPT_DEFINE
	FBC_OPT_INPFILE
	FBC_OPT_OUTFILE
	FBC_OPT_OBJFILE
	FBC_OPT_LIBFILE
	FBC_OPT_INCLUDE

	FBC_OPTS
end enum

type FBC_OPTION
	id			as FBC_OPT
	name		as zstring ptr
end type

type FBCCTX
	'' methods
	processOptions				as function ( _
												byval opt as zstring ptr, _
												byval argv as zstring ptr _
											) as integer
	listFiles					as function ( _
												byval argv as zstring ptr _
											) as integer
	compileResFiles				as function ( _
											) as integer
	linkFiles                   as function ( _
											) as integer
	archiveFiles                as function ( _
												byval cmdline as zstring ptr _
											) as integer
	delFiles                    as function ( _
											) as integer

	''
	compileonly					as integer
	preserveasm					as integer
	verbose						as integer
	debug 						as integer
	stacksize					as integer
	outtype						as integer
	showversion					as integer
	target						as integer

    libs						as integer
    objs						as integer
    inps						as integer
    outs						as integer
    defs						as integer
    incs						as integer
    pths						as integer
    preincs						as integer

	inplist(0 to FB_MAXARGS-1) 	as string
	asmlist(0 to FB_MAXARGS-1) 	as string
	outlist(0 to FB_MAXARGS-1) 	as string
	liblist(0 to FB_MAXARGS-1) 	as string
	objlist(0 to FB_MAXARGS-1) 	as string
	deflist(0 to FB_MAXARGS-1) 	as string
	inclist(0 to FB_MAXARGS-1) 	as string
	pthlist(0 to FB_MAXARGS-1) 	as string
	preinclist(0 to FB_MAXARGS-1) as string

	outname 					as zstring * FB_MAXPATHLEN+1
	outaddext					as integer
	mainpath					as zstring * FB_MAXPATHLEN+1
	mainfile					as zstring * FB_MAXNAMELEN+1
	mapfile						as zstring * FB_MAXNAMELEN+1
	mainset						as integer
	subsystem					as zstring * FB_MAXNAMELEN+1

	opthash						as THASH
end type


''
'' macros
''
#define safeKill(f)														_
	if( kill( f ) <> 0 ) then                                           :_
	end if



''
'' prototypes
''
declare function fbcInit_dos			( ) as integer
declare function fbcInit_linux			( ) as integer
declare function fbcInit_win32			( ) as integer
declare function fbcInit_cygwin			( ) as integer
declare function fbcInit_xbox			( ) as integer

''
'' globals
''
extern fbc as FBCCTX

#endif '' __FBC_BI__

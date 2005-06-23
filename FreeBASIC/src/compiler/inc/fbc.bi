#ifndef __FBC_BI__
#define __FBC_BI__

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

const QUOTE = "\""

const FB_MAXARGS	  = 100
const FB_MINSTACKSIZE = 32 * 1024
const FB_DEFSTACKSIZE = 1024 * 1024

type FBCCTX
	'' methods
	processOptions				as function ( byval opt as string, byval argv as string ) as integer
	listFiles					as function ( byval argv as string ) as integer
	processCompOptions			as function ( byval argv as string ) as integer
	setCompOptions				as function ( ) as integer
	compileResFiles				as function ( ) as integer
	linkFiles                   as function ( ) as integer
	archiveFiles                as function ( byval cmdline as string ) as integer
	delFiles                    as function ( ) as integer

	''
	compileonly					as integer
	preserveasm					as integer
	verbose						as integer
	debug 						as integer
	stacksize					as integer
	outtype						as integer
	showversion					as integer
	target						as integer
	cputype						as integer
	warnlevel					as integer

    libs						as integer
    objs						as integer
    inps						as integer
    outs						as integer
    defs						as integer
    incs						as integer
    pths						as integer

	inplist(0 to FB_MAXARGS-1) 	as string
	asmlist(0 to FB_MAXARGS-1) 	as string
	outlist(0 to FB_MAXARGS-1) 	as string
	liblist(0 to FB_MAXARGS-1) 	as string
	objlist(0 to FB_MAXARGS-1) 	as string
	deflist(0 to FB_MAXARGS-1) 	as string
	inclist(0 to FB_MAXARGS-1) 	as string
	pthlist(0 to FB_MAXARGS-1) 	as string

	outname 					as zstring * FB_MAXPATHLEN+1
	entrypoint 					as zstring * 3+FB_MAXNAMELEN+6+1
	subsystem					as zstring * FB_MAXNAMELEN+1
end type


''
'' macros
''
#define SETUP_OUTNAME()													_
	if( fbc.inps > 0 ) then	                 							:_
		fbc.outname = hStripExt( fbc.inplist(0) )                   	:_
	else                                                            	:_
		if( fbc.objs > 0 ) then                                     	:_
			fbc.outname = hStripExt( fbc.objlist(0) )               	:_
		else                                                        	:_
			fbc.outname = "noname"                                  	:_
		end if                                                      	:_
	end if


#define SETUP_ENTRYPOINT()												_
	if( fbc.inps > 0 ) then                                         	:_
		fbc.entrypoint = hStripPath( hStripExt( fbc.inplist(0) ) )		:_
	else                                                            	:_
		if( fbc.objs > 0 ) then                                     	:_
			fbc.entrypoint = hStripPath( hStripExt( fbc.objlist(0) ) )  :_
		else                                                        	:_
			fbc.entrypoint = "noentry"                              	:_
		end if                                                      	:_
	end if                                                          	:_
                                                                    	:_
	fbc.entrypoint = hMakeEntryPointName( fbc.entrypoint )

#define safeKill(f)														_
	if( kill( f ) <> 0 ) then                                           :_
	end if



''
'' prototypes
''
declare function fbcInit				( ) as integer

''
'' globals
''
extern fbc as FBCCTX

#endif '' __FBC_BI__

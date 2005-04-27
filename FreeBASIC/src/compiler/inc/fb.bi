#ifndef __FB_BI__
#define __FB_BI__

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


''
const FB.MAXPATHLEN			= 260

const FB.MAXINCRECLEVEL		= 16
const FB.MAXWITHLEVELS		= 4

const FB.MAXINCPATHS		= 16
const FB.INITINCFILES		= 256

const FB_MAXPROCARGS		= 64
const FB.MAXARRAYDIMS		= FB_MAXPROCARGS \ 4

const FB.MAXNAMELEN			= 96
const FB.MAXLITLEN			= 1024				'' literal strings max length
const FB.MAXNUMLEN			= 64
const FB.MAXOPERANDLEN		= FB.MAXNAMELEN + 2 + 16 + 2 + 1
const FB.MAXWITHLEN			= FB.MAXNAMELEN * FB.MAXWITHLEVELS
const FB.MAXDEFINELEN		= FB.MAXLITLEN*4

''
const TRUE			= -1
const FALSE			= 0
const NULL			= 0
const INVALID		= -1

''
#define FB.VERSION				"0.14"
#define FB.SIGN					"FreeBASIC v0.14b"

'' paths
#if defined(TARGET_WIN32)
const FB.BINPATH$				= "\\bin\\win32\\"
const FB.INCPATH$				= "\\inc\\"
const FB.LIBPATH$				= "\\lib\\win32"
#elseif defined(TARGET_DOS)
const FB.BINPATH$				= "\\bin\\dos\\"
const FB.INCPATH$				= "\\inc\\"
const FB.LIBPATH$				= "\\lib\\dos"
#else
const FB.BINPATH$				= "/usr/share/freebasic/bin/"
const FB.INCPATH$				= "/usr/share/freebasic/inc/"
const FB.LIBPATH$				= "/usr/share/freebasic/lib"
#endif

'' compiler options
enum FBCOMPOPT_ENUM
	FB.COMPOPT.DEBUG
	FB.COMPOPT.CPUTYPE
	FB.COMPOPT.NOSTDCALL
	FB.COMPOPT.NOUNDERPREFIX
	FB.COMPOPT.ERRORCHECK
	FB.COMPOPT.OUTTYPE
	FB.COMPOPT.RESUMEERROR
	FB.COMPOPT.WARNINGLEVEL
	FB.COMPOPT.EXPORT
	FB.COMPOPT.NODEFLIBS
	FB.COMPOPT.SHOWERROR
	FB.COMPOPT.MULTITHREADED
	FB.COMPOPT.PROFILE
end enum

type FBCMMLINEOPT
	debug			as integer					'' true=add debug info (def= false)
	cputype			as integer
	errorcheck		as integer					'' runtime error check (def= false)
	nostdcall		as integer
	nounderprefix	as integer					'' don't add underscore's the function names
	outtype			as integer					'' EXECUTABLE, STATICLIB, DYNAMICLIB, etc
	resumeerr 		as integer					'' add support for RESUME (def= false)
	warninglevel	as integer					'' (def = 0)
	export			as integer					'' export all symbols declared as EXPORT (def= true)
	nodeflibs		as integer					'' don't include default libs (def= false)
	showerror		as integer					'' show line giving error (def= true)
	multithreaded	as integer					'' link against thread-safe runtime library (def= false)
	profile			as integer					'' build profiling code (def= false)
end type


'' errors
enum FBERRMSG_ENUM
	FB.ERRMSG.OK
	FB.ERRMSG.ARGCNTMISMATCH
	FB.ERRMSG.EXPECTEDEOF
	FB.ERRMSG.EXPECTEDEOL
	FB.ERRMSG.DUPDEFINITION
	FB.ERRMSG.EXPECTINGAS
	FB.ERRMSG.EXPECTEDLPRNT
	FB.ERRMSG.EXPECTEDRPRNT
	FB.ERRMSG.UNDEFINEDSYMBOL
	FB.ERRMSG.EXPECTEDEXPRESSION
	FB.ERRMSG.EXPECTEDEQ
	FB.ERRMSG.EXPECTEDCONST
	FB.ERRMSG.EXPECTEDTO
	FB.ERRMSG.EXPECTEDNEXT
	FB.ERRMSG.EXPECTEDVAR
	FB.ERRMSG.EXPECTEDIDENTIFIER		= FB.ERRMSG.EXPECTEDVAR
	FB.ERRMSG.TABLESFULL
	FB.ERRMSG.EXPECTEDMINUS
	FB.ERRMSG.EXPECTEDCOMMA
	FB.ERRMSG.SYNTAXERROR
	FB.ERRMSG.ELEMENTNOTDEFINED
	FB.ERRMSG.EXPECTEDENDTYPE
	FB.ERRMSG.TYPEMISMATCH
	FB.ERRMSG.INTERNAL
	FB.ERRMSG.PARAMTYPEMISMATCH
	FB.ERRMSG.FILENOTFOUND
	FB.ERRMSG.ILLEGALOUTSIDEASTMT
	FB.ERRMSG.INVALIDDATATYPES
	FB.ERRMSG.INVALIDCHARACTER
	FB.ERRMSG.FILEACCESSERROR
	FB.ERRMSG.RECLEVELTOODEPTH
	FB.ERRMSG.EXPECTEDPOINTER
	FB.ERRMSG.EXPECTEDLOOP
	FB.ERRMSG.EXPECTEDWEND
	FB.ERRMSG.EXPECTEDTHEN
	FB.ERRMSG.EXPECTEDENDIF
	FB.ERRMSG.ILLEGALEND
	FB.ERRMSG.EXPECTEDCASE
	FB.ERRMSG.EXPECTEDENDSELECT
	FB.ERRMSG.WRONGDIMENSIONS
	FB.ERRMSG.INNERPROCNOTALLOWED
	FB.ERRMSG.EXPECTEDENDSUBORFUNCT
	FB.ERRMSG.ILLEGALPARAMSPEC
	FB.ERRMSG.VARIABLENOTDECLARED
	FB.ERRMSG.VARIABLEREQUIRED
	FB.ERRMSG.ILLEGALOUTSIDECOMP
	FB.ERRMSG.EXPECTEDENDASM
	FB.ERRMSG.PROCNOTDECLARED
	FB.ERRMSG.EXPECTEDSEMICOLON
	FB.ERRMSG.UNDEFINEDLABEL
	FB.ERRMSG.TOOMANYDIMENSIONS
	FB.ERRMSG.EXPECTEDSCALAR
	FB.ERRMSG.ILLEGALOUTSIDEASUB
	FB.ERRMSG.EXPECTEDDYNAMICARRAY
	FB.ERRMSG.CANNOTRETURNSTRUCTSFROMFUNCTS
	FB.ERRMSG.CANNOTRETURNFIXLENFROMFUNCTS
	FB.ERRMSG.ARRAYALREADYDIMENSIONED
	FB.ERRMSG.LITSTRINGTOOBIG
	FB.ERRMSG.IDNAMETOOBIG
	FB.ERRMSG.ILLEGALRESUMEERROR
	FB.ERRMSG.PARAMTYPEMISMATCHAT
	FB.ERRMSG.ILLEGALPARAMSPECAT
	FB.ERRMSG.EXPECTEDENDWITH
	FB.ERRMSG.ILLEGALINSIDEASUB
	FB.ERRMSG.EXPECTEDARRAY
	FB.ERRMSG.EXPECTEDLBRACKET
	FB.ERRMSG.EXPECTEDRBRACKET
	FB.ERRMSG.TOOMANYEXPRESSIONS
	FB.ERRMSG.EXPECTEDRESTYPE
	FB.ERRMSG.RANGETOOLARGE
	FB.ERRMSG.FORWARDREFNOTALLOWED
	FB.ERRMSG.INCOMPLETETYPE
	FB.ERRMSG.ARRAYNOTALLOCATED
	FB.ERRMSG.EXPECTEDINDEX
	FB.ERRMSG.EXPECTEDENDENUM
	FB.ERRMSG.CANTINITDYNAMICARRAYS
	FB.ERRMSG.INVALIDBITFIELD
	FB.ERRMSG.NUMBERTOOBIG
	FB.ERRMSG.TOOMANYPARAMS
end enum

enum FBWARNINGMSG_ENUM
	FB.WARNINGMSG.INVALIDPOINTER	= 1
end enum

'' cpu types
enum FBCPUTYPE_ENUM
	FB.CPUTYPE.386
	FB.CPUTYPE.486
	FB.CPUTYPE.586
	FB.CPUTYPE.686
end enum

const FB.DEFAULTCPUTYPE%	= FB.CPUTYPE.486

'' output file type
enum FBOUTTYPE_ENUM
	FB_OUTTYPE_EXECUTABLE
	FB_OUTTYPE_STATICLIB
	FB_OUTTYPE_DYNAMICLIB
end enum


''
''
''
declare function 	fbInit			( ) as integer
declare sub 		fbEnd			( )
declare function 	fbCompile		( byval infname as string, _
									  byval outfname as string ) as integer

declare sub 		fbSetDefaultOptions ( )
declare sub 		fbSetOption		( byval opt as integer, _
									  byval value as integer )
declare function 	fbGetOption 	( byval opt as integer ) as integer

declare function 	fbListLibs		( namelist() as string, _
									  byval index as integer ) as integer
declare sub 		fbAddIncPath	( byval path as string )
declare function	fbAddLibPath	( byval path as string ) as integer
declare sub 		fbAddDefine		( byval dname as string, _
									  byval dtext as string )

declare function 	fbIncludeFile	( byval filename as string, _
									  byval isonce as integer ) as integer

declare sub 		fbAddDefaultLibs( )

#endif '' __FB_BI__

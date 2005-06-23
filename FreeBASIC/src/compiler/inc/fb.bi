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
const FB_MAXPATHLEN			= 260

const FB_MAXINCRECLEVEL		= 16
const FB_MAXWITHLEVELS		= 4
const FB_MAXARGRECLEVEL		= 8

const FB_MAXINCPATHS		= 16
const FB_INITINCFILES		= 256

const FB_MAXPROCARGS		= 64
const FB_MAXARRAYDIMS		= FB_MAXPROCARGS \ 4

const FB_MAXNAMELEN			= 96
const FB_MAXLITLEN			= 1024				'' literal strings max length
const FB_MAXNUMLEN			= 64
const FB_MAXOPERANDLEN		= FB_MAXNAMELEN + 2 + 16 + 2 + 1
const FB_MAXWITHLEN			= FB_MAXNAMELEN * FB_MAXWITHLEVELS
const FB_MAXDEFINELEN		= FB_MAXLITLEN*4

''
const TRUE			= -1
const FALSE			= 0
const NULL			= 0
const INVALID		= -1

''
#define FB_VERSION				"0.14"
#define FB_SIGN					"FreeBASIC v0.14b"

'' compiler options
enum FBCOMPOPT_ENUM
	FB_COMPOPT_DEBUG
	FB_COMPOPT_CPUTYPE
	FB_COMPOPT_NOSTDCALL
	FB_COMPOPT_NOUNDERPREFIX
	FB_COMPOPT_ERRORCHECK
	FB_COMPOPT_OUTTYPE
	FB_COMPOPT_RESUMEERROR
	FB_COMPOPT_WARNINGLEVEL
	FB_COMPOPT_EXPORT
	FB_COMPOPT_NODEFLIBS
	FB_COMPOPT_SHOWERROR
	FB_COMPOPT_MULTITHREADED
	FB_COMPOPT_PROFILE
	FB_COMPOPT_TARGET
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
	target			as integer					'' target platform
end type


'' errors
enum FBERRMSG_ENUM
	FB_ERRMSG_OK
	FB_ERRMSG_ARGCNTMISMATCH
	FB_ERRMSG_EXPECTEDEOF
	FB_ERRMSG_EXPECTEDEOL
	FB_ERRMSG_DUPDEFINITION
	FB_ERRMSG_EXPECTINGAS
	FB_ERRMSG_EXPECTEDLPRNT
	FB_ERRMSG_EXPECTEDRPRNT
	FB_ERRMSG_UNDEFINEDSYMBOL
	FB_ERRMSG_EXPECTEDEXPRESSION
	FB_ERRMSG_EXPECTEDEQ
	FB_ERRMSG_EXPECTEDCONST
	FB_ERRMSG_EXPECTEDTO
	FB_ERRMSG_EXPECTEDNEXT
	FB_ERRMSG_EXPECTEDVAR
	FB_ERRMSG_EXPECTEDIDENTIFIER		= FB_ERRMSG_EXPECTEDVAR
	FB_ERRMSG_TABLESFULL
	FB_ERRMSG_EXPECTEDMINUS
	FB_ERRMSG_EXPECTEDCOMMA
	FB_ERRMSG_SYNTAXERROR
	FB_ERRMSG_ELEMENTNOTDEFINED
	FB_ERRMSG_EXPECTEDENDTYPE
	FB_ERRMSG_TYPEMISMATCH
	FB_ERRMSG_INTERNAL
	FB_ERRMSG_PARAMTYPEMISMATCH
	FB_ERRMSG_FILENOTFOUND
	FB_ERRMSG_ILLEGALOUTSIDEASTMT
	FB_ERRMSG_INVALIDDATATYPES
	FB_ERRMSG_INVALIDCHARACTER
	FB_ERRMSG_FILEACCESSERROR
	FB_ERRMSG_RECLEVELTOODEPTH
	FB_ERRMSG_EXPECTEDPOINTER
	FB_ERRMSG_EXPECTEDLOOP
	FB_ERRMSG_EXPECTEDWEND
	FB_ERRMSG_EXPECTEDTHEN
	FB_ERRMSG_EXPECTEDENDIF
	FB_ERRMSG_ILLEGALEND
	FB_ERRMSG_EXPECTEDCASE
	FB_ERRMSG_EXPECTEDENDSELECT
	FB_ERRMSG_WRONGDIMENSIONS
	FB_ERRMSG_INNERPROCNOTALLOWED
	FB_ERRMSG_EXPECTEDENDSUBORFUNCT
	FB_ERRMSG_ILLEGALPARAMSPEC
	FB_ERRMSG_VARIABLENOTDECLARED
	FB_ERRMSG_VARIABLEREQUIRED
	FB_ERRMSG_ILLEGALOUTSIDECOMP
	FB_ERRMSG_EXPECTEDENDASM
	FB_ERRMSG_PROCNOTDECLARED
	FB_ERRMSG_EXPECTEDSEMICOLON
	FB_ERRMSG_UNDEFINEDLABEL
	FB_ERRMSG_TOOMANYDIMENSIONS
	FB_ERRMSG_EXPECTEDSCALAR
	FB_ERRMSG_ILLEGALOUTSIDEASUB
	FB_ERRMSG_EXPECTEDDYNAMICARRAY
	FB_ERRMSG_CANNOTRETURNSTRUCTSFROMFUNCTS
	FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS
	FB_ERRMSG_ARRAYALREADYDIMENSIONED
	FB_ERRMSG_LITSTRINGTOOBIG
	FB_ERRMSG_IDNAMETOOBIG
	FB_ERRMSG_ILLEGALRESUMEERROR
	FB_ERRMSG_PARAMTYPEMISMATCHAT
	FB_ERRMSG_ILLEGALPARAMSPECAT
	FB_ERRMSG_EXPECTEDENDWITH
	FB_ERRMSG_ILLEGALINSIDEASUB
	FB_ERRMSG_EXPECTEDARRAY
	FB_ERRMSG_EXPECTEDLBRACKET
	FB_ERRMSG_EXPECTEDRBRACKET
	FB_ERRMSG_TOOMANYEXPRESSIONS
	FB_ERRMSG_EXPECTEDRESTYPE
	FB_ERRMSG_RANGETOOLARGE
	FB_ERRMSG_FORWARDREFNOTALLOWED
	FB_ERRMSG_INCOMPLETETYPE
	FB_ERRMSG_ARRAYNOTALLOCATED
	FB_ERRMSG_EXPECTEDINDEX
	FB_ERRMSG_EXPECTEDENDENUM
	FB_ERRMSG_CANTINITDYNAMICARRAYS
	FB_ERRMSG_INVALIDBITFIELD
	FB_ERRMSG_NUMBERTOOBIG
	FB_ERRMSG_TOOMANYPARAMS
	FB_ERRMSG_MACROTEXTTOOLONG
	FB_ERRMSG_INVALIDCMDOPTION
	FB_ERRMSG_CANTINITDYNAMICSTRINGS
	FB_ERRMSG_RECURSIVEUDT
	FB_ERRMSG_CANTREDIMARRAYFIELDS
	FB_ERRMSG_CANTINCLUDEPERIODS
	FB_ERRMSGS
end enum

enum FBWARNINGMSG_ENUM
	FB_WARNINGMSG_INVALIDPOINTER			= 1
	FB_WARNINGMSG_SUSPICIOUSPTRASSIGN
	FB_WARNINGMSG_IMPLICITCONVERTION
	FB_WARNINGMSGS
end enum

'' cpu types
enum FBCPUTYPE_ENUM
	FB_CPUTYPE_386
	FB_CPUTYPE_486
	FB_CPUTYPE_586
	FB_CPUTYPE_686
end enum

const FB_DEFAULTCPUTYPE	= FB_CPUTYPE_486

'' output file type
enum FBOUTTYPE_ENUM
	FB_OUTTYPE_EXECUTABLE
	FB_OUTTYPE_STATICLIB
	FB_OUTTYPE_DYNAMICLIB
end enum

'' target platform
enum FB_COMPTARGET_ENUM
	FB_COMPTARGET_WIN32
	FB_COMPTARGET_LINUX
	FB_COMPTARGET_DOS
end enum

#if defined(TARGET_WIN32)
const FB_DEFAULTTARGET = FB_COMPTARGET_WIN32
#elseif defined(TARGET_LINUX)
const FB_DEFAULTTARGET = FB_COMPTARGET_LINUX
#elseif defined(TARGET_DOS)
const FB_DEFAULTTARGET = FB_COMPTARGET_DOS
#else
#error Unsupported target
#endif

'' paths
enum FB_PATH_ENUM
	FB_PATH_BIN
	FB_PATH_INC
	FB_PATH_LIB
	FB_MAXPATHS
end enum


''
''
''
declare function 	fbInit			( ) as integer
declare sub 		fbEnd			( )
declare function 	fbCompile		( byval infname as string, _
									  byval outfname as string ) as integer

declare sub 		fbSetPaths		( byval target as integer )
declare function 	fbGetPath		( byval path as integer ) as zstring ptr

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

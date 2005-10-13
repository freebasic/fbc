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
const FB_MAXARGRECLEVEL		= 8
const FB_MAXPRAGMARECLEVEL	= 8

const FB_MAXINCPATHS		= 16
const FB_INITINCFILES		= 256

const FB_MAXPROCARGS		= 64
const FB_MAXARRAYDIMS		= FB_MAXPROCARGS \ 4
const FB_MAXDEFINEARGS		= FB_MAXPROCARGS \ 2

const FB_MAXNAMELEN			= 96
const FB_MAXLITLEN			= 1024				'' literal strings max length
const FB_MAXNUMLEN			= 64
const FB_MAXOPERANDLEN		= FB_MAXNAMELEN + 2 + 16 + 2 + 1
const FB_MAXDEFINELEN		= FB_MAXLITLEN*4

const FB_MAXSCOPEDEPTH		= 32

''
const TRUE			= -1
const FALSE			= 0
const NULL			= 0
const INVALID		= -1

''
#define FB_VER_MAJOR            0
#define FB_VER_MINOR            15
#define FB_VER_PATCH            0
#define FB_VERSION				"0.15"
#define FB_SIGN					"FreeBASIC v0.15b"

#define FB_TO_STRING(v)         #v

#define FB_VER_STR_MAJOR        FB_TO_STRING(FB_VER_MAJOR)
#define FB_VER_STR_MINOR        FB_TO_STRING(FB_VER_MINOR)
#define FB_VER_STR_PATCH        FB_TO_STRING(FB_VER_PATCH)

#ifndef __FB_VER_MAJOR__
#define __FB_VER_MAJOR__ 0
#endif

#ifndef __FB_VER_MINOR__
#define __FB_VER_MINOR__ 14
#endif

#ifndef __FB_VER_PATCH__
#define __FB_VER_PATCH__ 2
#endif

#ifndef __FB_MIN_VERSION__
#define __FB_MIN_VERSION__(major,minor,patch_level) _
	((__FB_VER_MAJOR__ > major) or _
     ((__FB_VER_MAJOR__ = major) and ((__FB_VER_MINOR__ > minor) or _
                                      (__FB_VER_MINOR__ = minor and __FB_VER_PATCH__ >= patch_level))))
#endif

#ifdef TARGET_WIN32
#define FB_TARGET				"win32"
#elseif defined(TARGET_CYGWIN)
#define FB_TARGET				"cygwin"
#elseif defined(TARGET_LINUX)
#define FB_TARGET				"linux"
#elseif defined(TARGET_DOS)
#define FB_TARGET				"dos"
#elseif defined(TARGET_XBOX)
#define FB_TARGET				"xbox"
#endif

#ifdef __FB_WIN32__
#define FB_HOST					"win32"
#elseif defined(__FB_CYGWIN__)
#define FB_HOST					"cygwin"
#elseif defined(__FB_LINUX__)
#define FB_HOST					"linux"
#elseif defined(__FB_DOS__)
#define FB_HOST					"dos"
#elseif defined(__FB_XBOX__)
#define FB_HOST					"xbox"
#endif


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
	FB_COMPOPT_NAMING
	FB_COMPOPT_EXTRAERRCHECK
	FB_COMPOPT_MSBITFIELDS

	FB_COMPOPTIONS
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
	naming			as integer					'' target naming
	extraerrchk		as integer					'' add bounds plus null pointer checking
	msbitfields		as integer					'' use M$'s bitfields packing
end type


'' cpu types
enum FBCPUTYPE_ENUM
	FB_CPUTYPE_386 = 3
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
	FB_OUTTYPE_OBJECT
end enum

'' target platform
enum FB_COMPTARGET_ENUM
	FB_COMPTARGET_WIN32
	FB_COMPTARGET_CYGWIN
	FB_COMPTARGET_LINUX
	FB_COMPTARGET_DOS
	FB_COMPTARGET_XBOX
end enum

'' target naming
enum FB_COMPNAMING_ENUM
    FB_COMPNAMING_DEFAULT
	FB_COMPNAMING_WIN32
	FB_COMPNAMING_CYGWIN
	FB_COMPNAMING_LINUX
	FB_COMPNAMING_DOS
	FB_COMPNAMING_XBOX
end enum

#if defined(TARGET_WIN32)
const FB_DEFAULTTARGET = FB_COMPTARGET_WIN32
#elseif defined(TARGET_CYGWIN)
const FB_DEFAULTTARGET = FB_COMPTARGET_CYGWIN
#elseif defined(TARGET_LINUX)
const FB_DEFAULTTARGET = FB_COMPTARGET_LINUX
#elseif defined(TARGET_DOS)
const FB_DEFAULTTARGET = FB_COMPTARGET_DOS
#elseif defined(TARGET_XBOX)
const FB_DEFAULTTARGET = FB_COMPTARGET_XBOX
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


#include once "inc\error.bi"


''
''
''
declare function 	fbInit			( byval ismain as integer ) as integer
declare sub 		fbEnd			( )
declare function 	fbCompile		( byval infname as string, _
									  byval outfname as string, _
									  byval ismain as integer ) as integer

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

declare function 	fbGetIncFile	( byval index as integer ) as string

declare function    fbGetNaming     ( ) as integer

declare function 	fbGetEntryPoint ( ) as string

declare function 	fbGetModuleEntry( ) as string

declare sub 		fbAddDefaultLibs( )

#endif '' __FB_BI__

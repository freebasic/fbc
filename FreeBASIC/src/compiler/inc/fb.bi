#ifndef __FB_BI__
#define __FB_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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

#define QUOTE !"\""
#define NEWLINE !"\r\n"
#define RSLASH !"\\"
#define TABCHAR !"\t"
#define ESCCHAR !"\27"
#define LFCHAR !"\n"

#include once "inc\list.bi"
#include once "inc\hash.bi"

'' \'s are reversed in Linux
const FB_BINPATH = RSLASH + "bin" + RSLASH
const FB_INCPATH = RSLASH + "inc" + RSLASH
const FB_LIBPATH = RSLASH + "lib" + RSLASH

''
const FB_MAXPATHLEN         = 260

const FB_MAXINCRECLEVEL     = 16
const FB_MAXARGRECLEVEL     = 8
const FB_MAXPRAGMARECLEVEL  = 8
const FB_MAXNAMESPCRECLEVEL = 64

const FB_MAXINCPATHS        = 16

const FB_MAXARRAYDIMS       = 8
const FB_MAXDEFINEARGS      = 32

const FB_MAXNAMELEN         = 64
const FB_MAXLITLEN          = 1024              '' literal strings max length
const FB_MAXNUMLEN          = 64
const FB_MAXOPERANDLEN      = FB_MAXNAMELEN + 2 + 16 + 2 + 1
const FB_MAXDEFINELEN       = FB_MAXLITLEN*4

const FB_MAXSCOPEDEPTH      = 128

const FB_DEFAULT_MAXERRORS  = 10

const FB_ERR_INFINITE       = &h7fffffff

''
#ifndef TRUE
const TRUE                  = -1
const FALSE                 = 0
#endif

#ifndef NULL
const NULL                  = 0
#endif

const INVALID               = -1

''
const FB_VER_MAJOR          = 0
const FB_VER_MINOR          = 18
const FB_VER_PATCH          = 0
const FB_VERSION            = str( FB_VER_MAJOR ) + "." + str( FB_VER_MINOR )
const FB_BUILD_DATE         = __DATE__
const FB_SIGN               = "FreeBASIC v" +  FB_VERSION + "b"


#define FB_TO_STRING(v)     #v

#define FB_VER_STR_MAJOR    str(FB_VER_MAJOR)
#define FB_VER_STR_MINOR    str(FB_VER_MINOR)
#define FB_VER_STR_PATCH    str(FB_VER_PATCH)

#ifndef __FB_MIN_VERSION__
#define __FB_MIN_VERSION__(major,minor,patch_level) _
    ((__FB_VER_MAJOR__ > major) or _
    ((__FB_VER_MAJOR__ = major) and ((__FB_VER_MINOR__ > minor) or _
                                     (__FB_VER_MINOR__ = minor and __FB_VER_PATCH__ >= patch_level))))
#endif

#if defined(TARGET_WIN32)
const FB_TARGET             = "win32"
#elseif defined(TARGET_CYGWIN)
const FB_TARGET             = "cygwin"
#elseif defined(TARGET_LINUX)
const FB_TARGET             = "linux"
#elseif defined(TARGET_DOS)
const FB_TARGET             = "dos"
#elseif defined(TARGET_XBOX)
const FB_TARGET             = "xbox"
#elseif defined(TARGET_FREEBSD)
const FB_TARGET             = "freebsd"
#endif

#if defined(__FB_WIN32__)
const FB_HOST               = "win32"
#elseif defined(__FB_CYGWIN__)
const FB_HOST               = "cygwin"
#elseif defined(__FB_LINUX__)
const FB_HOST               = "linux"
#elseif defined(__FB_DOS__)
const FB_HOST               = "dos"
#elseif defined(__FB_XBOX__)
const FB_HOST               = "xbox"
#elseif defined(__FB_FREEBSD__)
const FB_HOST               = "freebsd"
#endif


'' compiler options
enum FB_COMPOPT
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
	FB_COMPOPT_EXTRAERRCHECK
	FB_COMPOPT_MSBITFIELDS
	FB_COMPOPT_MAXERRORS
	FB_COMPOPT_SHOWSUSPERRORS
	FB_COMPOPT_LANG
	FB_COMPOPT_PEDANTICCHK
	FB_COMPOPT_BACKEND

	FB_COMPOPTIONS
end enum

'' pedantic checks
enum FB_PDCHECK
    FB_PDCHECK_NONE         = &h00000000

    FB_PDCHECK_ESCSEQ       = &h00000001
    FB_PDCHECK_PARAMMODE    = &h00000002
    FB_PDCHECK_PARAMSIZE    = &h00000004

    FB_PDCHECK_ALL          = &hffffffff
end enum

'' cpu types
enum FB_CPUTYPE
	FB_CPUTYPE_386 = 3
	FB_CPUTYPE_486
	FB_CPUTYPE_586
	FB_CPUTYPE_686
end enum

const FB_DEFAULT_CPUTYPE    = FB_CPUTYPE_486

'' output file type
enum FB_OUTTYPE
    FB_OUTTYPE_EXECUTABLE
    FB_OUTTYPE_STATICLIB
    FB_OUTTYPE_DYNAMICLIB
    FB_OUTTYPE_OBJECT
end enum

const FB_DEFAULT_OUTTYPE    = FB_OUTTYPE_EXECUTABLE

'' target platform
enum FB_COMPTARGET
	FB_COMPTARGET_WIN32
	FB_COMPTARGET_CYGWIN
	FB_COMPTARGET_LINUX
	FB_COMPTARGET_DOS
	FB_COMPTARGET_XBOX
	FB_COMPTARGET_FREEBSD
end enum

#if defined(TARGET_WIN32)
const FB_DEFAULT_TARGET = FB_COMPTARGET_WIN32
#elseif defined(TARGET_CYGWIN)
const FB_DEFAULT_TARGET = FB_COMPTARGET_CYGWIN
#elseif defined(TARGET_LINUX)
const FB_DEFAULT_TARGET = FB_COMPTARGET_LINUX
#elseif defined(TARGET_DOS)
const FB_DEFAULT_TARGET = FB_COMPTARGET_DOS
#elseif defined(TARGET_XBOX)
const FB_DEFAULT_TARGET = FB_COMPTARGET_XBOX
#elseif defined(TARGET_FREEBSD)
const FB_DEFAULT_TARGET = FB_COMPTARGET_FREEBSD
#else
#error Unsupported target
#endif

'' languages (update the fb.bas::langTb() array when changing this list)
enum FB_LANG
	FB_LANG_FB
	FB_LANG_FB_DEPRECATED
	FB_LANG_QB

	FB_LANGS
end enum

const FB_DEFAULT_LANG = FB_LANG_FB

''
enum FB_BACKEND
	FB_BACKEND_GAS
	FB_BACKEND_GCC

	FB_BACKENDS
end enum

const FB_DEFAULT_BACKEND = FB_BACKEND_GAS

''
type FBCMMLINEOPT
	debug			as integer					'' true=add debug info (def= false)
	cputype			as FB_CPUTYPE
	errorcheck		as integer					'' runtime error check (def= false)
	nostdcall		as integer
	nounderprefix	as integer					'' don't add underscore's the function names
	outtype			as FB_OUTTYPE
	resumeerr 		as integer					'' add support for RESUME (def= false)
	warninglevel	as integer					'' (def = 0)
	export			as integer					'' export all symbols declared as EXPORT (def= true)
	nodeflibs		as integer					'' don't include default libs (def= false)
	showerror		as integer					'' show line giving error (def= true)
	multithreaded	as integer					'' link against thread-safe runtime library (def= false)
	profile			as integer					'' build profiling code (def= false)
	target			as FB_COMPTARGET            '' target platform
	extraerrchk		as integer					'' add bounds plus null pointer checking
	msbitfields		as integer					'' use M$'s bitfields packing
	maxerrors		as integer					'' max number errors until the parser quit
	showsusperrors	as integer					'' show suspicious errors (def= false)
	lang			as FB_LANG					'' lang compatibility
	pdcheckopt		as FB_PDCHECK				'' pedantic checks
	backend			as FB_BACKEND				'' backend
end type


'' features allowed in the selected language
enum FB_LANG_OPT
	FB_LANG_OPT_MT          = &h00000001
    FB_LANG_OPT_SCOPE       = &h00000002
    FB_LANG_OPT_NAMESPC     = &h00000004
    FB_LANG_OPT_EXTERN      = &h00000008
    FB_LANG_OPT_FUNCOVL     = &h00000010
    FB_LANG_OPT_OPEROVL     = &h00000020
    FB_LANG_OPT_CLASS       = &h00000040
    FB_LANG_OPT_INITIALIZER = &h00000080
    FB_LANG_OPT_SINGERRLINE = &h00000100
    FB_LANG_OPT_VBSYMB      = &h00000200
    FB_LANG_OPT_ALWAYSOVL   = &h00000400
    FB_LANG_OPT_AUTOVAR     = &h00000800

    FB_LANG_OPT_GOSUB       = &h00010000
    FB_LANG_OPT_CALL        = &h00020000
    FB_LANG_OPT_LET         = &h00040000
    FB_LANG_OPT_PERIODS     = &h00080000
    FB_LANG_OPT_NUMLABEL    = &h00100000
    FB_LANG_OPT_IMPLICIT    = &h00200000
    FB_LANG_OPT_DEFTYPE     = &h00400000
    FB_LANG_OPT_SUFFIX      = &h00800000
    FB_LANG_OPT_METACMD     = &h01000000
    FB_LANG_OPT_QBOPT       = &h02000000
    FB_LANG_OPT_DEPRECTOPT  = &h04000000
    FB_LANG_OPT_ONERROR     = &h08000000
    FB_LANG_OPT_SHAREDLOCAL = &h10000000
    FB_LANG_OPT_QUIRKFUNC   = &h20000000
end enum

'' paths
enum FB_PATH
	FB_PATH_BIN
	FB_PATH_INC
	FB_PATH_LIB
	FB_MAXPATHS
end enum

'' info section
const FB_INFOSEC_VERSION = &h10
const FB_INFOSEC_NAME = "fbctinf"
const FB_INFOSEC_OBJNAME = "__fb_ct.inf"

enum IR_INFOSEC
	FB_INFOSEC_EOL = 0
	FB_INFOSEC_LIB
	FB_INFOSEC_PTH
	FB_INFOSEC_CMD
end enum

'' lib symbol, declared here to be usable by the fbc module
type FBS_LIB
	name			as zstring ptr
	isdefault		as integer
	hashitem		as HASHITEM ptr
	hashindex		as uinteger
end type

'' callbcks used when scanning object files for libraries
type FB_CALLBACK_ADDLIB as sub _
	( _
		byval libName as zstring ptr, _
		byval objName as zstring ptr _
	)

type FB_CALLBACK_ADDLIBPATH as sub _
	( _
		byval pathName as zstring ptr, _
		byval objName as zstring ptr _
	)

type FB_CALLBACK_ADDOPTION as sub _
	( _
		byval opt as FB_COMPOPT, _
		byval value as zstring ptr, _
		byval objName as zstring ptr _
	)


#include once "inc\error.bi"

''
''
''
declare function fbInit _
	( _
		byval ismain as integer _
	) as integer

declare sub fbEnd _
	( _
	)

declare function fbCompile _
	( _
		byval infname as zstring ptr, _
		byval outfname as zstring ptr, _
		byval ismain as integer, _
	  	byval preinclist as TLIST ptr _
	) as integer

declare sub fbSetPaths _
	( _
		byval target as integer _
	)

declare function fbGetPath _
	( _
		byval path as integer _
	) as zstring ptr

declare sub fbSetDefaultOptions _
	( _
	)

declare sub fbSetOption _
	( _
		byval opt as integer, _
		byval value as integer _
	)

declare function fbGetOption _
	( _
		byval opt as integer _
	) as integer

declare sub fbListLibs _
	( _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr, _
		byval delnodes as integer _
	)

declare sub fbListLibsEx _
	( _
		byval srclist as TLIST ptr, _
		byval srchash as THASH ptr, _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr, _
		byval delnodes as integer _
	)

declare sub fbListLibPaths _
	( _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr, _
		byval delnodes as integer _
	)

declare sub fbListLibPathsEx _
	( _
		byval srclist as TLIST ptr, _
		byval srchash as THASH ptr, _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr, _
		byval delnodes as integer _
	)

declare sub fbAddIncPath _
	( _
		byval path as zstring ptr _
	)

declare function fbAddLib _
	( _
		byval libname as zstring ptr _
	) as FBS_LIB ptr

declare function fbaddLibEx _
	( _
		byval liblist as TLIST ptr, _
		byval libhash as THASH ptr, _
		byval libname as zstring ptr, _
		byval isdefault as integer _
	) as FBS_LIB ptr

declare function fbAddLibPath _
	( _
		byval path as zstring ptr _
	) as FBS_LIB ptr

declare function fbaddLibPathEx _
	( _
		byval pathlist as TLIST ptr, _
		byval pathhash as THASH ptr, _
		byval pathname as zstring ptr, _
		byval isdefault as integer _
	) as FBS_LIB ptr

declare sub fbAddDefine _
	( _
		byval dname as zstring ptr, _
		byval dtext as zstring ptr _
	)

declare function fbPragmaOnce _
	( _
	) as integer

declare function fbIncludeFile _
	( _
		byval filename as zstring ptr, _
		byval isonce as integer _
	) as integer

declare function fbGetEntryPoint _
	( _
	) as string

declare function fbGetModuleEntry _
	( _
	) as string

declare function fbIsCrossComp _
	( _
	) as integer

declare sub fbGetDefaultLibs _
	( _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr _
	)

declare sub fbMainBegin _
	( _
	)

declare sub fbMainEnd _
	( _
	)

declare sub fbReportRtError _
	( _
		byval modname as zstring ptr, _
		byval funname as zstring ptr, _
		byval errnum as integer _
	)

declare function fbGetLangOptions _
	( _
		byval lang as FB_LANG _
	) as FB_LANG_OPT

declare function fbGetLangName _
	( _
		byval lang as FB_LANG _
	) as string

declare function fbObjInfoWriteObj _
	( _
		byval liblist as TLIST ptr, _
		byval libpathlist as TLIST ptr _
	) as integer

declare function fbObjInfoReadObj _
	( _
		byval objName as zstring ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	) as integer

declare function fbObjInfoReadLib _
	( _
		byval libName as zstring ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION, _
		byval libpathlist as TLIST ptr _
	) as integer

''
'' macros
''

'' datatype accessors/manipulators
#define typeGetDatatype(dt)     (iif(dt >= FB_DATATYPE_POINTER, FB_DATATYPE_POINTER, dt)) '' dt
#define typeSetType(typ,ptrcnt) (ptrcnt * FB_DATATYPE_POINTER + typ) '' FB_DATATYPE_POINTER
#define typeAddrOf(dt)          (dt + FB_DATATYPE_POINTER) '' FB_DATATYPE_POINTER

#macro typeDeref(dt/', somewhere'/) ''type/ptr info has to come from somewhere besides dtype
	iif(dt >= FB_DATATYPE_POINTER, dt-FB_DATATYPE_POINTER, INVALID)
#endmacro
#macro typeGetPtrCnt(dt/', somewhere'/) ''ditto
	(dt \ FB_DATATYPE_POINTER)
#endmacro
#macro typeGetPtrType(dt/', somewhere'/) ''ditto
	(iif(dt >= FB_DATATYPE_POINTER, dt Mod FB_DATATYPE_POINTER, dt))
#endmacro

#macro typeIsPtrTo(dt, ptrcnt, np)
	iif( typeGetDatatype( dt ) = FB_DATATYPE_POINTER, _ 
	     iif( typeGetPtrCnt( dt ) = ptrcnt, _ 
	          iif( typeGetPtrType( dt ) = np, _ 
	               TRUE, _ 
	               FALSE ), FALSE ), FALSE )
#endmacro

#define fbLangOptIsSet( opt ) ((env.langopt and (opt)) <> 0)

#define fbLangIsSet( opt ) (env.clopt.lang = opt)

#define fbPdCheckIsSet( opt ) ((env.clopt.pdcheckopt and (opt)) <> 0)

''
'' new implementation
''

#endif '' __FB_BI__

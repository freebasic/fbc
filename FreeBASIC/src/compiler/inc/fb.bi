#ifndef __FB_BI__
#define __FB_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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

const FB_VER_MAJOR          = 0
const FB_VER_MINOR          = 21
const FB_VER_PATCH          = 0


#define QUOTE !"\""
#define NEWLINE !"\r\n"
#define RSLASH !"\\"
#define TABCHAR !"\t"
#define ESCCHAR !"\27"
#define LFCHAR !"\n"

#include once "inc\list.bi"
#include once "inc\hash.bi"

#define FB_STRINGIZE(_x) #_x

const FB_ARCH_PREFIX = FB_STRINGIZE(ARCH_PREFIX)

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
const FB_VERSION            = FB_VER_MAJOR & "." & FB_VER_MINOR & "." & FB_VER_PATCH
const FB_BUILD_DATE         = __DATE__
const FB_SIGN               = "FreeBASIC v" &  FB_VERSION & "b"
const FB_VER_STR_MAJOR    	= str( FB_VER_MAJOR )
const FB_VER_STR_MINOR    	= str( FB_VER_MINOR )
const FB_VER_STR_PATCH    	= str( FB_VER_PATCH )

#if defined(__FB_WIN32__)
const FB_HOST               = "win32"
const FB_HOST_EXEEXT        = ".exe"
const FB_HOST_PATHDIV       = RSLASH
#elseif defined(__FB_CYGWIN__)
const FB_HOST               = "cygwin"
const FB_HOST_EXEEXT        = ".exe"
const FB_HOST_PATHDIV       = "/"
#elseif defined(__FB_LINUX__)
const FB_HOST               = "linux"
const FB_HOST_EXEEXT        = ""
const FB_HOST_PATHDIV       = "/"
#elseif defined(__FB_DOS__)
const FB_HOST               = "dos"
const FB_HOST_EXEEXT        = ".exe"
const FB_HOST_PATHDIV       = RSLASH
#elseif defined(__FB_FREEBSD__)
const FB_HOST               = "freebsd"
const FB_HOST_EXEEXT        = ""
const FB_HOST_PATHDIV       = "/"
#elseif defined(__FB_OPENBSD__)
const FB_HOST               = "openbsd"
const FB_HOST_EXEEXT        = ""
const FB_HOST_PATHDIV       = "/"
#else
#error Unsupported host
#endif

'' compiler options
enum FB_COMPOPT
	FB_COMPOPT_DEBUG
	FB_COMPOPT_CPUTYPE
	FB_COMPOPT_FPUTYPE
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
	FB_COMPOPT_FINDBIN
	FB_COMPOPT_EXTRAOPT

	FB_COMPOPTIONS
end enum

'' pedantic checks
enum FB_PDCHECK
	FB_PDCHECK_NONE         = &h00000000

	FB_PDCHECK_ESCSEQ       = &h00000001
	FB_PDCHECK_PARAMMODE    = &h00000002
	FB_PDCHECK_PARAMSIZE    = &h00000004
	FB_PDCHECK_NEXTVAR      = &h00000008
	FB_PDCHECK_CASTTONONPTR = &h00000010

	FB_PDCHECK_ALL          = &hffffffff

	FB_PDCHECK_DEFAULT      = FB_PDCHECK_ALL xor ( FB_PDCHECK_NEXTVAR )
end enum

'' cpu types
enum FB_CPUTYPE
	FB_CPUTYPE_386 = 3
	FB_CPUTYPE_486
	FB_CPUTYPE_586
	FB_CPUTYPE_686
end enum

const FB_DEFAULT_CPUTYPE    = FB_CPUTYPE_486


'' fpu types
enum FB_FPUTYPE
	FB_FPUTYPE_FPU
	FB_FPUTYPE_SSE
end enum

const FB_DEFAULT_FPUTYPE    = FB_FPUTYPE_FPU


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
	FB_COMPTARGET_OPENBSD
end enum

#if defined(TARGET_WIN32)
const FB_TARGET         = "win32"
const FB_DEFAULT_TARGET = FB_COMPTARGET_WIN32
#elseif defined(TARGET_CYGWIN)
const FB_TARGET         = "cygwin"
const FB_DEFAULT_TARGET = FB_COMPTARGET_CYGWIN
#elseif defined(TARGET_LINUX)
const FB_TARGET         = "linux"
const FB_DEFAULT_TARGET = FB_COMPTARGET_LINUX
#elseif defined(TARGET_DOS)
const FB_TARGET         = "dos"
const FB_DEFAULT_TARGET = FB_COMPTARGET_DOS
#elseif defined(TARGET_XBOX)
const FB_TARGET         = "xbox"
const FB_DEFAULT_TARGET = FB_COMPTARGET_XBOX
#elseif defined(TARGET_FREEBSD)
const FB_TARGET         = "freebsd"
const FB_DEFAULT_TARGET = FB_COMPTARGET_FREEBSD
#elseif defined(TARGET_OPENBSD)
const FB_TARGET         = "openbsd"
const FB_DEFAULT_TARGET = FB_COMPTARGET_OPENBSD
#else
#error Unsupported target
#endif

'' languages (update the fb.bas::langTb() array when changing this list)
enum FB_LANG
	FB_LANG_INVALID = -1

	FB_LANG_FB = 0
	FB_LANG_FB_DEPRECATED
	FB_LANG_FB_FBLITE
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
enum FB_FINDBIN
	FB_FINDBIN_USE_DEFAULT = 0
	FB_FINDBIN_ALLOW_ENVVAR = 1
	FB_FINDBIN_ALLOW_BINDIR = 2
	FB_FINDBIN_ALLOW_SYSTEM = 4
end enum

const FB_DEFAULT_FINDBIN = FB_FINDBIN_ALLOW_ENVVAR or FB_FINDBIN_ALLOW_BINDIR

'' Extra options
enum FB_EXTRAOPT
	FB_EXTRAOPT_NONE              = &h00000000

	FB_EXTRAOPT_GOSUB_SETJMP = &h00000001

	FB_EXTRAOPT_DEFAULT           = FB_EXTRAOPT_NONE
end enum

''
'' Track options explicitly set on the command line
type FBCMMLINEOPTEXPL
	lang			as integer					'' TRUE if -lang was specified
end type

''
type FBCMMLINEOPT
	debug			as integer					'' true=add debug info (def= false)
	cputype			as FB_CPUTYPE
	fputype			as FB_FPUTYPE
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
	findbin			as FB_FINDBIN				'' find bin file search options
	extraopt		as FB_EXTRAOPT				'' Extra (misc) options
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
    FB_LANG_OPT_OPTION      = &h02000000

    FB_LANG_OPT_ONERROR     = &h08000000
    FB_LANG_OPT_SHAREDLOCAL = &h10000000
    FB_LANG_OPT_QUIRKFUNC   = &h20000000
end enum

'' paths
enum FB_PATH
	FB_PATH_BIN
	FB_PATH_INC
	FB_PATH_LIB
	FB_PATH_SCRIPT
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

#include once "inc\error.bi"
#include once "inc\fb-obj.bi"

''
''
''
declare function fbInit _
	( _
		byval ismain as integer, _
		byval restarts as integer _
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

declare function fbCheckRestartCompile _
	( _
	) as integer

declare sub fbSetPaths _
	( _
		byval target as integer _
	)

declare function fbGetPath _
	( _
		byval path as integer _
	) as string

declare sub fbSetDefaultOptions _
	( _
	)

declare sub fbSetOption _
	( _
		byval opt as integer, _
		byval value as integer _
	)

declare sub fbSetOptionIsExplicit _
	( _
		byval opt as integer _
	)

declare function fbGetOption _
	( _
		byval opt as integer _
	) as integer

declare function fbChangeOption _
	( _
		byval opt as integer, _
		byval value as integer _
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

declare sub fbAddGccLib _
	( _
		byval lib_filename as zstring ptr, _
		byval lib_id as integer _
	)

declare function fbGetGccLib _
	( _
		byval lib_id as integer _
	) as string

declare sub fbSetGccLib _
	( _
		byval lib_id as integer, _
		byref lib_name as string _
	)

declare function fbFindGccLib _
	( _
		byval lib_id as integer _
	) as string

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

declare sub fbSetPrefix _
	( _
		byref prefix as string _
	)

declare function fbFindBinFile _
	( _
		byval filename as zstring ptr, _
		byval findopts as FB_FINDBIN = FB_FINDBIN_USE_DEFAULT _
	) as string

declare function fbGetLangId _
	( _
		byval txt as zstring ptr _
	) as FB_LANG


''
'' macros
''

#define fbLangOptIsSet( op ) ((env.lang.opt and (op)) <> 0)

#define fbLangIsSet( op ) (env.clopt.lang = op)

#define fbLangGetType( tp ) env.lang.typeremap.tp

#define fbLangGetSize( tp ) env.lang.sizeremap.tp

#define fbLangGetDefLiteral( tp ) env.lang.litremap.tp

#define fbPdCheckIsSet( op ) ((env.clopt.pdcheckopt and (op)) <> 0)


''
'' new implementation
''

#endif '' __FB_BI__

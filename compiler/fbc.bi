#ifndef __FBC_BI__
#define __FBC_BI__

#include once "hash.bi"
#include once "list.bi"
#include once "fb.bi"
#include once "fbint.bi"

const FBC_INITARGS	  = 64
const FBC_INITFILES	  = 64

const FBC_MINSTACKSIZE = 32 * 1024
const FBC_DEFSTACKSIZE = 1024 * 1024

'' Maximum nesting/recursion limit for command-line option files (@filename)
const FBC_MAXCMDFILE_RECLEVEL = 128

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
	FBC_OPT_FPU
	FBC_OPT_FPMODE
	FBC_OPT_VECTORIZE
	FBC_OPT_DEBUG
	FBC_OPT_COMPILEONLY
	FBC_OPT_EMITONLY
	FBC_OPT_SHAREDLIB
	FBC_OPT_STATICLIB
	FBC_OPT_PRESERVEOBJ
	FBC_OPT_PRESERVEASM
	FBC_OPT_PPONLY
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
	FBC_OPT_LANG
	FBC_OPT_FORCELANG
	FBC_OPT_WA
	FBC_OPT_WL
	FBC_OPT_WC
	FBC_OPT_GEN
	FBC_OPT_PREFIX
	FBC_OPT_OPTIMIZE
	FBC_OPT_EXTRAOPT

	FBC_OPTS
end enum

type FBC_OPTION
	id			as FBC_OPT
	name		as zstring ptr
end type

type FBC_EXTOPT
	gas			as zstring * 128
	ld			as zstring * 128
	gcc			as zstring * 128
end type

type FBC_IOFILE
	inf			as string 							'' input file (*.bas)
	asmf		as string 							'' intermediate file (*.asm)
	outf		as string 							'' output file (*.o)
end type

type FBC_OBJINF
	lang		as FB_LANG
	mt			as integer
end type

'' if changed, update the fbcInit_* functions at each fbc_*.bas file
type FBC_VTBL
	linkFiles as function _
	( _
	) as integer

	getCStdType as function _
	( _
		byval ctype as FB_CSTDTYPE _
	) as integer

end type

'' global context
type FBCCTX
	arglist				as TLIST					'' of string ptr

	emitonly			as integer
	compileonly			as integer
	preserveasm			as integer
	preserveobj			as integer
	verbose				as integer
	stacksize			as integer
	showversion			as integer
	target				as integer

	'' file and path passed on cmd-line
	inoutlist			as TLIST					'' of FBC_IOFILE
	objlist				as TLIST					'' of string ptr
	deflist				as TLIST					'' of string ptr
	preinclist			as TLIST					'' of string ptr
	incpathlist			as TLIST					'' of string ptr
	liblist				as TLIST					'' of string ptr
	libpathlist			as TLIST					'' of string ptr
	rclist				as TLIST   '' List of input .rc's (for win32)

	'' libs and paths passed to LD
	ld_liblist			as TLIST					'' of FBS_LIB
	ld_libhash			as THASH
	ld_libpathlist		as TLIST					'' of FBS_LIB
	ld_libpathhash		as THASH

	iof_head			as FBC_IOFILE ptr			'' to keep track of the .bas' and -o's

	outname 			as zstring * FB_MAXPATHLEN+1
	outaddext			as integer
	mainpath			as zstring * FB_MAXPATHLEN+1
	mainfile			as zstring * FB_MAXNAMELEN+1
	mapfile				as zstring * FB_MAXNAMELEN+1
	mainset				as integer
	subsystem			as zstring * FB_MAXNAMELEN+1
	extopt				as FBC_EXTOPT
	prefix				as zstring * FB_MAXPATHLEN+1  '' Prefix path, either the default exepath() or hard-coded $prefix, or from -prefix
	triplet 			as zstring * FB_MAXNAMELEN+1  '' GNU triplet to prefix in front of cross-compiling tool names
	xbe_title 			as zstring * FB_MAXNAMELEN+1  '' For the '-title <title>' xbox option
	xpmfile				as zstring * FB_MAXPATHLEN+1

	'' Compiler paths
	binpath				as zstring * FB_MAXPATHLEN+1
	incpath				as zstring * FB_MAXPATHLEN+1
	libpath				as zstring * FB_MAXPATHLEN+1

	objinf				as FBC_OBJINF

	vtbl				as FBC_VTBL
end type


''
'' prototypes
''
declare function fbcInit_dos _
	( _
	) as integer

declare function fbcInit_linux _
	( _
	) as integer

declare function fbcInit_win32 _
	( _
	) as integer

declare function fbcInit_cygwin _
	( _
	) as integer

declare function fbcInit_xbox _
	( _
	) as integer

declare function fbcInit_freebsd _
	( _
	) as integer

declare function fbcInit_openbsd _
	( _
	) as integer

declare function fbcInit_darwin _
	( _
	) as integer

declare function fbcInit_netbsd _
	( _
	) as integer

declare function fbcGetLibList _
	( _
		byval dllname as zstring ptr _
	) as zstring ptr

declare function fbcGetLibPathList _
	( _
	) as zstring ptr

declare function fbcFindGccLib(byref file as string) as string
declare function fbcMakeLibFileName(byref libname as string) as string
declare sub fbcAddLibPathFor(byref libname as string)
declare function fbcFindBin(byval filename as zstring ptr) as string
declare function fbcRunBin _
	( _
		byval action as zstring ptr, _
		byref tool as string, _
		byref ln as string _
	) as integer

''
'' macros
''

#macro safeKill(f)
	if( kill( f ) <> 0 ) then
	end if
#endmacro

#define fbcAddDefLibPath( path ) _
	fbAddLibPathEx( @fbc.ld_libpathlist, _
					@fbc.ld_libpathhash, _
					path, _
					TRUE )


''
'' globals
''
extern fbc as FBCCTX

#endif '' __FBC_BI__

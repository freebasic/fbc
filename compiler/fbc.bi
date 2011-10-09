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

'' global context
type FBCCTX
	'' Current optin during command line parsing
	optid				as integer

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
end type

declare sub fbcAssert_ _
	( _
		byval test as integer, _
		byval testtext as zstring ptr, _
		byval filename as zstring ptr, _
		byval funcname as zstring ptr, _
		byval linenum as integer _
	)
#define fbcAssert(test) fbcAssert_((test), #test, __FILE__, __FUNCTION__, __LINE__)

extern fbc as FBCCTX

#endif '' __FBC_BI__

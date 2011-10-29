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

type FBCIOFILE
	as string srcfile '' input file
	as string objfile '' output .o file
end type

type FBC_OBJINF
	lang		as FB_LANG
	mt			as integer
end type

'' global context
type FBCCTX
	'' For command line parsing
	optid				as integer       '' Current option
	lastiofile			as FBCIOFILE ptr '' Input file that receives the next -o filename
	objfile				as string '' -o filename waiting for next input file

	emitonly			as integer
	compileonly			as integer
	preserveasm			as integer
	preserveobj			as integer
	verbose				as integer
	stacksize			as integer
	showversion			as integer

	'' Command line input
	modules				as TLIST '' FBCIOFILE's for input .bas files
	rcs				as TLIST '' FBCIOFILE's for input .rc/.res files
	xpm				as FBCIOFILE '' .xpm input file
	temps				as TLIST '' Temporary files to delete at shutdown
	objlist				as TLIST '' Objects from command line and from compilation
	libfiles			as TLIST
	libs				as TSTRSET
	libpaths			as TSTRSET

	'' Final list of libs and paths for linking
	'' (each module can have #inclibs and #libpaths and add more, and for
	'' objinfo emitting only the module-specific libs are wanted, so there
	'' are multiple lists necessary to allow each module to start fresh
	'' with the same input libs)
	finallibs			as TSTRSET
	finallibpaths			as TSTRSET

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

	'' Compiler paths
	binpath				as zstring * FB_MAXPATHLEN+1
	incpath				as zstring * FB_MAXPATHLEN+1
	libpath				as zstring * FB_MAXPATHLEN+1

	objinf				as FBC_OBJINF
end type

extern fbc as FBCCTX

#endif '' __FBC_BI__

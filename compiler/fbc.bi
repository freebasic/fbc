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

enum
	FBCMODULE_BAS = 0
	FBCMODULE_RC
	FBCMODULE_XPM
end enum

type FBCMODULE
	as integer type   '' FBCMODULE_*
	as string srcfile '' input file
	as string asmfile '' intermediate .asm/.c file
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
	nextmodule			as FBCMODULE ptr '' Input file that receives the next -o filename

	emitonly			as integer
	compileonly			as integer
	preserveasm			as integer
	preserveobj			as integer
	verbose				as integer
	stacksize			as integer
	showversion			as integer

	modules				as TLIST '' FBCMODULE's
	temps				as TLIST '' Temporary files to delete at shutdown
	objlist				as TLIST '' Objects from command line and from compilation
	deflist				as TLIST
	preinclist			as TLIST
	incpathlist			as TLIST
	liblist				as TLIST
	libpathlist			as TLIST

	'' libs and paths passed to LD
	ld_liblist			as TLIST					'' of FBS_LIB
	ld_libhash			as THASH
	ld_libpathlist		as TLIST					'' of FBS_LIB
	ld_libpathhash		as THASH

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

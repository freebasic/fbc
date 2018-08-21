#ifndef __FB_BI__
#define __FB_BI__

const FB_VER_MAJOR  = "1"
const FB_VER_MINOR  = "06"
const FB_VER_PATCH  = "0"
const FB_VERSION    = FB_VER_MAJOR + "." + FB_VER_MINOR + "." + FB_VER_PATCH
const FB_BUILD_DATE = __DATE__
const FB_SIGN       = "FreeBASIC " + FB_VERSION

#define QUOTE !"\""
#if defined( __FB_WIN32__ ) or defined( __FB_CYGWIN__ ) or defined( __FB_DOS__ )
	#define NEWLINE !"\r\n"
#else
	#define NEWLINE !"\n"
#endif
#define RSLASH !"\\"
#define TABCHAR !"\t"
#define ESCCHAR !"\27"
#define LFCHAR !"\n"

#include once "list.bi"
#include once "hash.bi"

''
const FB_MAXPATHLEN         = 260

const FB_MAXINCRECLEVEL     = 16
const FB_MAXARGRECLEVEL     = 8
const FB_MAXPRAGMARECLEVEL  = 8
const FB_MAXNAMESPCRECLEVEL = 64

const FB_MAXARRAYDIMS       = 8
const FB_MAXDEFINEARGS      = 32

const FB_MAXNAMELEN         = 128
const FB_MAXLITLEN          = 1024              '' literal strings max length
const FB_MAXNUMLEN          = 64
const FB_MAXOPERANDLEN      = FB_MAXNAMELEN + 2 + 16 + 2 + 1
const FB_MAXDEFINELEN       = FB_MAXLITLEN*4

const FB_MAXSCOPEDEPTH      = 128

const FB_DEFAULT_MAXERRORS  = 10

const FB_ERR_INFINITE       = &h7fffffff

const INVALID               = -1

'' compiler options corresponding to the FBCMMLINEOPT struct
'' (for use with the public fbSet/GetOption() interface)
enum FB_COMPOPT
	'' compiler output file type
	FB_COMPOPT_OUTTYPE              '' FB_OUTTYPE_*
	FB_COMPOPT_PPONLY               '' boolean: TRUE for preprocessor-only mode

	'' backend, target, code generation
	FB_COMPOPT_BACKEND              '' FB_BACKEND_*
	FB_COMPOPT_TARGET               '' FB_COMPTARGET_*
	FB_COMPOPT_CPUTYPE              '' FB_CPUTYPE_*
	FB_COMPOPT_FPUTYPE              '' FB_FPUTYPE_*
	FB_COMPOPT_FPMODE               '' FB_FPMODE_*
	FB_COMPOPT_VECTORIZE            '' FB_VECTORIZELEVEL_*
	FB_COMPOPT_OPTIMIZELEVEL        '' integer, for -gen gcc's gcc -O<N>
	FB_COMPOPT_ASMSYNTAX            '' FB_ASMSYNTAX_*, for -gen gcc

	'' parser -lang mode
	FB_COMPOPT_LANG                 '' FB_LANG_*: lang compatibility
	FB_COMPOPT_FORCELANG            '' boolean: TRUE if -forcelang was specified

	'' debugging/error checking
	FB_COMPOPT_DEBUGINFO            '' boolean: debugging info (affects code generation)
	FB_COMPOPT_ASSERTIONS           '' boolean: enable assert() and __FB_DEBUG__
	FB_COMPOPT_ERRORCHECK           '' boolean: runtime error checks
	FB_COMPOPT_RESUMEERROR          '' boolean: RESUME support
	FB_COMPOPT_EXTRAERRCHECK        '' boolean: NULL pointer/array bounds checks
	FB_COMPOPT_PROFILE              '' boolean: -profile

	'' error/warning reporting behaviour
	FB_COMPOPT_WARNINGLEVEL         '' integer
	FB_COMPOPT_SHOWERROR            '' boolean: show source code line containing error?
	FB_COMPOPT_MAXERRORS            '' -maxerr integer
	FB_COMPOPT_PEDANTICCHK          '' FB_PDCHECK_* flags

	'' the rest
	FB_COMPOPT_GOSUBSETJMP          '' boolean: implement GOSUB using setjmp/longjump?
	FB_COMPOPT_EXPORT               '' boolean: export all symbols declared as EXPORT?
	FB_COMPOPT_MSBITFIELDS          '' boolean: use M$'s bitfields packing?
	FB_COMPOPT_MULTITHREADED        '' boolean: -mt
	FB_COMPOPT_GFX                  '' boolean: -gfx (whether gfxlib should be linked)
	FB_COMPOPT_PIC                  '' boolean: -pic (whether to use position-independent code)
	FB_COMPOPT_STACKSIZE            '' integer
	FB_COMPOPT_OBJINFO              '' boolean: write/read .fbctinf sections etc.?
	FB_COMPOPT_SHOWINCLUDES         '' boolean: -showincludes

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
	FB_PDCHECK_SIGNEDNESS   = &h00000020
	FB_PDCHECK_CONSTNESS    = &h00000040

	FB_PDCHECK_ALL          = &hffffffff

	FB_PDCHECK_DEFAULT      = FB_PDCHECK_ALL xor ( FB_PDCHECK_NEXTVAR or FB_PDCHECK_SIGNEDNESS or FB_PDCHECK_CONSTNESS )
end enum

'' cpu types
'' When changing, update fb.bas:cputypeinfo()
enum FB_CPUTYPE
	FB_CPUTYPE_386 = 0
	FB_CPUTYPE_486
	FB_CPUTYPE_586
	FB_CPUTYPE_686
	FB_CPUTYPE_ATHLON
	FB_CPUTYPE_ATHLONXP
	FB_CPUTYPE_ATHLONFX
	FB_CPUTYPE_ATHLONSSE3
	FB_CPUTYPE_PENTIUMMMX
	FB_CPUTYPE_PENTIUM2
	FB_CPUTYPE_PENTIUM3
	FB_CPUTYPE_PENTIUM4
	FB_CPUTYPE_PENTIUMSSE3
	FB_CPUTYPE_X86_64
	FB_CPUTYPE_ARMV6
	FB_CPUTYPE_ARMV7A
	FB_CPUTYPE_AARCH64
	FB_CPUTYPE__COUNT
end enum

enum
	FB_CPUFAMILY_X86 = 0
	FB_CPUFAMILY_X86_64
	FB_CPUFAMILY_ARM
	FB_CPUFAMILY_AARCH64
	FB_CPUFAMILY__COUNT
end enum

'' fpu types
enum FB_FPUTYPE
	FB_FPUTYPE_FPU
	FB_FPUTYPE_SSE
end enum

'' floating-point modes
enum FB_FPMODE
	FB_FPMODE_PRECISE
	FB_FPMODE_FAST
end enum

const FB_DEFAULT_FPMODE		= FB_FPMODE_PRECISE
const FB_DEFAULT_FPUTYPE		= FB_FPUTYPE_FPU

enum FB_VECTORIZELEVEL
	FB_VECTORIZE_NONE				'' no vectorization
	FB_VECTORIZE_NORMAL				'' complete expression merging
	FB_VECTORIZE_INTRATREE			'' intra-expression merging
	FB_VECTORIZE_SUBEXPRESSION		'' sub-expression merging (not implemented yet)
end enum

const FB_DEFAULT_VECTORIZELEVEL    = FB_VECTORIZE_NONE

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
	FB_COMPTARGET_DARWIN
	FB_COMPTARGET_NETBSD
	FB_COMPTARGETS
end enum

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
	FB_BACKEND_LLVM

	FB_BACKENDS
end enum

enum FB_ASMSYNTAX
	FB_ASMSYNTAX_INTEL = 0
	FB_ASMSYNTAX_ATT
end enum

'' Compiler internal settings, same order as FB_COMPOPT_*
type FBCMMLINEOPT
	'' compiler output file type
	outtype         as FB_OUTTYPE
	pponly          as integer              '' TRUE for preprocessor-only mode

	'' backend, target, code generation
	backend         as FB_BACKEND           '' backend (-gen gas/gcc)
	target          as FB_COMPTARGET        '' target platform
	cputype         as FB_CPUTYPE           '' target CPU architecture
	fputype         as FB_FPUTYPE           '' target FPU
	fpmode          as FB_FPMODE            '' precise or fast fp mode (SSE+ only)
	vectorize       as FB_VECTORIZELEVEL    '' enable automatic vectorization
	optlevel        as integer              '' -gen gcc optimization level (gcc -O<N>)
	asmsyntax       as FB_ASMSYNTAX         '' asm syntax mode for -gen gcc

	'' parser -lang mode
	lang            as FB_LANG              '' lang compatibility
	forcelang       as integer              '' TRUE if -forcelang was specified

	'' debugging/error checking
	debuginfo       as integer              '' true = add debug info (default = false)
	assertions      as integer              '' true = enable assert() and __FB_DEBUG__ (default = false)
	errorcheck      as integer              '' enable runtime error checks?
	resumeerr       as integer              '' enable RESUME support?
	extraerrchk     as integer              '' enable NULL pointer/array bounds checks?
	profile         as integer              '' build profiling code (default = false)

	'' error/warning reporting behaviour
	warninglevel    as integer              '' (default = 0)
	showerror       as integer              '' show line giving error (default = true)
	maxerrors       as integer              '' max number errors the parser will show
	pdcheckopt      as FB_PDCHECK           '' pedantic checks

	'' the rest
	gosubsetjmp     as integer              '' implement GOSUB using setjmp/longjump? (default = false)
	export          as integer              '' export all symbols declared as EXPORT (default = true)
	msbitfields     as integer              '' use M$'s bitfields packing
	multithreaded   as integer              '' link against thread-safe runtime library (default = false)
	gfx             as integer              '' Link against gfx library (default = false)
	pic             as integer              '' Whether to use position-independent code (default = false)
	stacksize       as integer
	objinfo         as integer
	showincludes    as integer
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

    FB_LANG_OPT_QUIRKFUNC   = &h20000000
end enum

#if defined(__FB_WIN32__)
const FB_HOST_EXEEXT        = ".exe"
const FB_HOST_PATHDIV       = RSLASH
const FB_DEFAULT_TARGET     = FB_COMPTARGET_WIN32
#elseif defined(__FB_CYGWIN__)
const FB_HOST_EXEEXT        = ".exe"
const FB_HOST_PATHDIV       = "/"
const FB_DEFAULT_TARGET     = FB_COMPTARGET_CYGWIN
#elseif defined(__FB_LINUX__)
const FB_HOST_EXEEXT        = ""
const FB_HOST_PATHDIV       = "/"
const FB_DEFAULT_TARGET     = FB_COMPTARGET_LINUX
#elseif defined(__FB_DOS__)
const FB_HOST_EXEEXT        = ".exe"
const FB_HOST_PATHDIV       = RSLASH
const FB_DEFAULT_TARGET     = FB_COMPTARGET_DOS
#elseif defined(__FB_FREEBSD__)
const FB_HOST_EXEEXT        = ""
const FB_HOST_PATHDIV       = "/"
const FB_DEFAULT_TARGET     = FB_COMPTARGET_FREEBSD
#elseif defined(__FB_OPENBSD__)
const FB_HOST_EXEEXT        = ""
const FB_HOST_PATHDIV       = "/"
const FB_DEFAULT_TARGET     = FB_COMPTARGET_OPENBSD
#elseif defined(__FB_DARWIN__)
const FB_HOST_EXEEXT        = ""
const FB_HOST_PATHDIV       = "/"
const FB_DEFAULT_TARGET     = FB_COMPTARGET_DARWIN
#elseif defined(__FB_NETBSD__)
const FB_HOST_EXEEXT        = ""
const FB_HOST_PATHDIV       = "/"
const FB_DEFAULT_TARGET     = FB_COMPTARGET_NETBSD
#else
#error Unsupported host
#endif

const FB_DEFAULT_CPUTYPE_X86     = FB_CPUTYPE_486
const FB_DEFAULT_CPUTYPE_X86_64  = FB_CPUTYPE_X86_64
const FB_DEFAULT_CPUTYPE_ARM     = FB_CPUTYPE_ARMV7A
const FB_DEFAULT_CPUTYPE_AARCH64 = FB_CPUTYPE_AARCH64

#ifdef __FB_ARM__
	const FB_DEFAULT_CPUTYPE32 = FB_DEFAULT_CPUTYPE_ARM
	const FB_DEFAULT_CPUTYPE64 = FB_DEFAULT_CPUTYPE_AARCH64
#else
	const FB_DEFAULT_CPUTYPE32 = FB_DEFAULT_CPUTYPE_X86
	const FB_DEFAULT_CPUTYPE64 = FB_DEFAULT_CPUTYPE_X86_64
#endif

#if defined( __FB_64BIT__ ) or defined( __FB_ARM__ )
	const FB_DEFAULT_BACKEND = FB_BACKEND_GCC
#else
	const FB_DEFAULT_BACKEND = FB_BACKEND_GAS
#endif

#ifdef __FB_64BIT__
	const FB_DEFAULT_CPUTYPE = FB_DEFAULT_CPUTYPE64
#else
	const FB_DEFAULT_CPUTYPE = FB_DEFAULT_CPUTYPE32
#endif

'' info section
const FB_INFOSEC_NAME = "fbctinf"
const FB_INFOSEC_OBJNAME = "__fb_ct.inf"
#ifdef __FB_DOS__
	const FB_INFOSEC_BASNAME = "__fb_ct.bas"
#else
	const FB_INFOSEC_BASNAME = "__fb_ct.inf.bas"
#endif

#include once "error.bi"

declare sub fbInit(byval ismain as integer, byval restarts as integer)
declare sub fbEnd()

declare sub fbCompile _
	( _
		byval infname as zstring ptr, _
		byval outfname as zstring ptr, _
		byref pponlyfile as string, _
		byval ismain as integer _
	)

declare function fbShouldRestart() as integer
declare function fbShouldContinue() as integer

declare sub fbGlobalInit()
declare sub fbAddIncludePath(byref path as string)
declare sub fbAddPreDefine(byref def as string)
declare sub fbAddPreInclude(byref file as string)

declare sub fbSetOption( byval opt as integer, byval value as integer )
declare function fbGetOption( byval opt as integer ) as integer

declare sub fbChangeOption(byval opt as integer, byval value as integer)
declare sub fbSetLibs(byval libs as TSTRSET ptr, byval libpaths as TSTRSET ptr)
declare sub fbGetLibs(byval libs as TSTRSET ptr, byval libpaths as TSTRSET ptr)
declare sub fbPragmaOnce()
declare sub fbIncludeFile(byval filename as zstring ptr, byval isonce as integer)
declare sub fbOverrideFilename(byval filename as zstring ptr)

declare function fbGetTargetId( ) as string
declare function fbGetHostId( ) as string
declare function fbIdentifyOs( byref osid as string ) as integer
declare function fbIdentifyCpuFamily( byref osid as string ) as integer
declare function fbCpuTypeFromCpuFamilyId( byref cpufamilyid as string ) as integer
declare function fbGetGccArch( ) as zstring ptr
declare function fbGetFbcArch( ) as zstring ptr
declare function fbIs64Bit( ) as integer
declare function fbGetBits( ) as integer
declare function fbGetHostBits( ) as integer
declare function fbGetCpuFamily( ) as integer
declare function fbIdentifyFbcArch( byref fbcarch as string ) as integer
declare function fbTargetSupportsELF( ) as integer
declare function fbTargetSupportsCOFF( ) as integer

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

declare function fbGetLangOptions _
	( _
		byval lang as FB_LANG _
	) as FB_LANG_OPT

declare function fbGetLangName _
	( _
		byval lang as FB_LANG _
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

#define fbPdCheckIsSet( op ) ((env.clopt.pdcheckopt and (op)) <> 0)


''
'' new implementation
''

'' !!!TODO!!! - remove when 1.05 or later is released
#ifndef cbool
	#define cbool(x_) iif((x_),-1,0)
	#define INT_BOOL_TO_STR(y_) *iif(y_,@"true",@"false")
	#define INT_BOOL_TO_WSTR(y_) *iif(y_,@wstr("true"),@wstr("false"))
#else
	#define INT_BOOL_TO_STR(y_) str(y_)
	#define INT_BOOL_TO_WSTR(y_) wstr(y_)
#endif

#endif '' __FB_BI__

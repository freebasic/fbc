#ifndef __FBINT_BI__
#define __FBINT_BI__

''
'' internal compiler definitions
''

#include once "fb.bi"

const FB_MINSTACKSIZE32 = 32 * 1024
const FB_DEFSTACKSIZE32 = 1024 * 1024
const FB_MINSTACKSIZE64 = 64 * 1024
const FB_DEFSTACKSIZE64 = 2048 * 1024

const FB_MAXINTNAMELEN      = 1 + FB_MAXNAMELEN + 1 + 1 + 2
const FB_MAXINTLITLEN       = FB_MAXLITLEN + 32

const FB_MAXGOTBITEMS       = 64

''
const FB_INITSYMBOLNODES    = 8000
const FB_INITFIELDNODES     = 16
const FB_INITDEFARGNODES    = 500
const FB_INITDEFTOKNODES    = 1000
const FB_INITDIMNODES       = 400
const FB_INITLIBNODES       = 20
const FB_INITFWDREFNODES    = 500
const FB_INITVARININODES    = 1000
const FB_INITINCFILES       = 256
const FB_INITSTMTSTACKNODES = 128

'' DATA stmt internal format
enum FB_DATASTMT_ID
	FB_DATASTMT_ID_NULL     = &h0000
	FB_DATASTMT_ID_WSTR     = &h8000                '' start point
	FB_DATASTMT_ID_LINK     = &hffff
	FB_DATASTMT_ID_OFFSET   = &hfffe

	FB_DATASTMT_ID_ZSTR     = &h0001                '' used by AST only
	FB_DATASTMT_ID_CONST    = &h0002                '' /
end enum

const FB_DATASTMT_PREFIX    = "_{fbdata}_"


'' print modes (same as in rtlib/fb_console.h)
enum FBPRINTMASK
	FB_PRINTMASK_NEWLINE      = &h00000001
	FB_PRINTMASK_PAD          = &h00000002
	FB_PRINTMASK_APPEND_SPACE = &h00000010
	FB_PRINTMASK_ISLAST       = &h80000000
end enum

'' file constants (same as in rtlib/fb_file.h)
enum FBFILEMODE
	FB_FILE_MODE_BINARY
	FB_FILE_MODE_RANDOM
	FB_FILE_MODE_INPUT
	FB_FILE_MODE_OUTPUT
	FB_FILE_MODE_APPEND
end enum

enum FBFILEACCESS
	FB_FILE_ACCESS_ANY
	FB_FILE_ACCESS_READ
	FB_FILE_ACCESS_WRITE
	FB_FILE_ACCESS_READWRITE
end enum

enum FBFILELOCK
	FB_FILE_LOCK_SHARED
	FB_FILE_LOCK_READ
	FB_FILE_LOCK_WRITE
	FB_FILE_LOCK_READWRITE
end enum

enum FBOPENKIND
	FB_FILE_TYPE_FILE
	FB_FILE_TYPE_CONS
	FB_FILE_TYPE_ERR
	FB_FILE_TYPE_PIPE
	FB_FILE_TYPE_SCRN
	FB_FILE_TYPE_LPT
	FB_FILE_TYPE_COM
	FB_FILE_TYPE_QB
end enum

'' FB runtime errors (same as rtlib/fb_error.h)
enum FB_RTERROR
	FB_RTERROR_OK = 0
	FB_RTERROR_ILLEGALFUNCTIONCALL
	FB_RTERROR_FILENOTFOUND
	FB_RTERROR_FILEIO
	FB_RTERROR_OUTOFMEM
	FB_RTERROR_ILLEGALRESUME
	FB_RTERROR_OUTOFBOUNDS
	FB_RTERROR_NULLPTR
	FB_RTERROR_NOPRIVILEGES
	FB_RTERROR_SIGINT
	FB_RTERROR_SIGILL
	FB_RTERROR_SIGFPE
	FB_RTERROR_SIGSEGV
	FB_RTERROR_SIGTERM
	FB_RTERROR_SIGABRT
	FB_RTERROR_SIGQUIT
	FB_RTERROR_RETURNWITHOUTGOSUB
	FB_RTERROR_ENDOFFILE
end enum

''
const FB_MAINSCOPE = 0
const FB_MAINPROCNAME = "__FB_MAINPROC__"
const FB_MODLEVELNAME = "__FB_MODLEVELPROC__"
const FB_GLOBCTORNAME = "_GLOBAL__I"
const FB_GLOBDTORNAME = "_GLOBAL__D"

const FB_INSTANCEPTR = "THIS"

''
''
''

'' some chars
const CHAR_NULL     = 00, _
	CHAR_BELL       = 07, _
	CHAR_BKSPC  = 08, _
	CHAR_TAB        = 09, _
	CHAR_LF         = 10, _
	CHAR_VTAB   = 11, _
	CHAR_FORMFEED = 12, _
	CHAR_CR         = 13, _
	CHAR_SPACE      = 32, _
	CHAR_0          = 48, _
	CHAR_1          = 49, _
	CHAR_2          = 50, _
	CHAR_3          = 51, _
	CHAR_4          = 52, _
	CHAR_5          = 53, _
	CHAR_6          = 54, _
	CHAR_7          = 55, _
	CHAR_8          = 56, _
	CHAR_9          = 57, _
	CHAR_AUPP       = 65, CHAR_ALOW     =  97, _
	CHAR_BUPP       = 66, CHAR_BLOW     =  98, _
	CHAR_CUPP       = 67, CHAR_CLOW     =  99, _
	CHAR_DUPP       = 68, CHAR_DLOW     = 100, _
	CHAR_EUPP       = 69, CHAR_ELOW     = 101, _
	CHAR_FUPP       = 70, CHAR_FLOW     = 102, _
	CHAR_GUPP       = 71, CHAR_GLOW     = 103, _
	CHAR_HUPP       = 72, CHAR_HLOW     = 104, _
	CHAR_IUPP       = 73, CHAR_ILOW     = 105, _
	CHAR_JUPP       = 74, CHAR_JLOW     = 106, _
	CHAR_KUPP       = 75, CHAR_KLOW     = 107, _
	CHAR_LUPP       = 76, CHAR_LLOW     = 108, _
	CHAR_MUPP       = 77, CHAR_MLOW     = 109, _
	CHAR_NUPP       = 78, CHAR_NLOW     = 110, _
	CHAR_OUPP       = 79, CHAR_OLOW     = 111, _
	CHAR_PUPP       = 80, CHAR_PLOW     = 112, _
	CHAR_QUPP       = 81, CHAR_QLOW     = 113, _
	CHAR_RUPP       = 82, CHAR_RLOW     = 114, _
	CHAR_SUPP       = 83, CHAR_SLOW     = 115, _
	CHAR_TUPP       = 84, CHAR_TLOW     = 116, _
	CHAR_UUPP       = 85, CHAR_ULOW     = 117, _
	CHAR_VUPP       = 86, CHAR_VLOW     = 118, _
	CHAR_WUPP       = 87, CHAR_WLOW     = 119, _
	CHAR_XUPP       = 88, CHAR_XLOW     = 120, _
	CHAR_YUPP       = 89, CHAR_YLOW     = 121, _
	CHAR_ZUPP       = 90, CHAR_ZLOW     = 122, _
	CHAR_LPRNT      = 40, _
	CHAR_RPRNT      = 41, _
	CHAR_COMMA  = 44, _
	CHAR_DOT        = 46, _
	CHAR_PLUS       = 43, _
	CHAR_MINUS      = 45, _
	CHAR_RSLASH     = 92, _
	CHAR_SLASH      = 47, _
	CHAR_CART       = 94, _
	CHAR_EQ         = 61, _
	CHAR_LT         = 60, _
	CHAR_GT         = 62, _
	CHAR_AMP        = 38, _
	CHAR_UNDER  = 95, _
	CHAR_EXCL       = 33, _
	CHAR_SHARP  = 35, _
	CHAR_DOLAR  = 36, _
	CHAR_PERC       = 37, _
	CHAR_QUOTE  = 34, _
	CHAR_APOST  = 39, _
	CHAR_TIMES  = 42, _
	CHAR_STAR       = CHAR_TIMES, _
	CHAR_COLON  = 58, _
	CHAR_SEMICOLON= 59, _
	CHAR_AT     = 64, _
	CHAR_QUESTION   = 63, _
	CHAR_TILD       = 126, _
	CHAR_ESC        = 27, _
	CHAR_LBRACE = 123, _
	CHAR_RBRACE = 125, _
	CHAR_LBRACKET   = 91, _
	CHAR_RBRACKET   = 93


'' assuming it won't ever be used inside lit strings
const FB_INTSCAPECHAR       = CHAR_ESC


'' tokens
enum FB_TOKEN
	FB_TK_EOF                   = 256
	FB_TK_EOL
	FB_TK_STMTSEP
	FB_TK_COMMENT
	FB_TK_REM

	FB_TK_NUMLIT
	FB_TK_STRLIT
	FB_TK_STRLIT_ESC
	FB_TK_STRLIT_NOESC
	FB_TK_ID

	FB_TK_IF
	FB_TK_THEN
	FB_TK_ELSE
	FB_TK_ELSEIF
	FB_TK_SELECT
	FB_TK_CASE
	FB_TK_IS
	FB_TK_WHILE
	FB_TK_UNTIL
	FB_TK_WEND
	FB_TK_CONTINUE
	FB_TK_EXIT
	FB_TK_DO
	FB_TK_LOOP
	FB_TK_WITH
	FB_TK_FOR
	FB_TK_STEP
	FB_TK_NEXT
	FB_TK_TO
	FB_TK_SCOPE
	FB_TK_NAMESPACE
	FB_TK_USING

	FB_TK_AND
	FB_TK_OR
	FB_TK_ANDALSO
	FB_TK_ORELSE
	FB_TK_XOR
	FB_TK_EQV
	FB_TK_IMP
	FB_TK_NOT
	FB_TK_MOD
	FB_TK_SHL
	FB_TK_SHR
	FB_TK_EQ
	FB_TK_GT
	FB_TK_LT
	FB_TK_NE
	FB_TK_LE
	FB_TK_GE
	FB_TK_DBLEQ

	FB_TK_EXTERN
	FB_TK_STATIC
	FB_TK_DIM
	FB_TK_VAR
	FB_TK_REDIM
	FB_TK_COMMON
	FB_TK_SHARED
	FB_TK_PRESERVE

	FB_TK_ENDIF
	FB_TK_DEFINED

	FB_TK_INCLUDE
	FB_TK_DYNAMIC

	FB_TK_EXPLICIT
	FB_TK_BYVAL
	FB_TK_BYREF

	FB_TK_DEFBYTE
	FB_TK_DEFUBYTE
	FB_TK_DEFSHORT
	FB_TK_DEFUSHORT
	FB_TK_DEFINT
	FB_TK_DEFUINT
	FB_TK_DEFLNG
	FB_TK_DEFULNG
	FB_TK_DEFLNGINT
	FB_TK_DEFULNGINT
	FB_TK_DEFSNG
	FB_TK_DEFDBL
	FB_TK_DEFSTR

	FB_TK_DECLARE
	FB_TK_CONST
	FB_TK_TYPE
	FB_TK_UNION
	FB_TK_ENUM
	FB_TK_CLASS
	FB_TK_END
	FB_TK_EXPORT
	FB_TK_IMPORT
	FB_TK_OPTION
	FB_TK_ASM
	FB_TK_SUB
	FB_TK_FUNCTION
	FB_TK_CONSTRUCTOR
	FB_TK_DESTRUCTOR
	FB_TK_OPERATOR
	FB_TK_PROPERTY
	FB_TK_EXTENDS
	FB_TK_IMPLEMENTS
	FB_TK_BASE
	FB_TK_VIRTUAL
	FB_TK_ABSTRACT

	FB_TK_BOOLEAN
	FB_TK_BYTE
	FB_TK_UBYTE
	FB_TK_SHORT
	FB_TK_USHORT
	FB_TK_INTEGER
	FB_TK_UINT
	FB_TK_LONG
	FB_TK_ULONG
	FB_TK_LONGINT
	FB_TK_ULONGINT
	FB_TK_SINGLE
	FB_TK_DOUBLE
	FB_TK_STRING
	FB_TK_ZSTRING
	FB_TK_WSTRING
	FB_TK_ANY
	FB_TK_PTR
	FB_TK_POINTER
	FB_TK_UNSIGNED
	FB_TK_AS

	FB_TK_TYPEOF

	FB_TK_PUBLIC
	FB_TK_PRIVATE
	FB_TK_PROTECTED
	FB_TK_PASCAL
	FB_TK_CDECL
	FB_TK_STDCALL
	FB_TK_THISCALL
	FB_TK_FASTCALL
	FB_TK_ALIAS
	FB_TK_LIB
	FB_TK_OVERLOAD
	FB_TK_NEW
	FB_TK_DELETE

	FB_TK_LET
	FB_TK_RETURN
	FB_TK_GOTO
	FB_TK_GOSUB

	FB_TK_CALL

	FB_TK_VARPTR
	FB_TK_STRPTR
	FB_TK_PROCPTR
	FB_TK_SADD

	FB_TK_FIELDDEREF
	FB_TK_CBOOL
	FB_TK_CBYTE
	FB_TK_CUBYTE
	FB_TK_CSHORT
	FB_TK_CUSHORT
	FB_TK_CINT
	FB_TK_CUINT
	FB_TK_CLNG
	FB_TK_CULNG
	FB_TK_CLNGINT
	FB_TK_CULNGINT
	FB_TK_CSNG
	FB_TK_CDBL
	FB_TK_CSIGN
	FB_TK_CUNSG
	FB_TK_CPTR
	FB_TK_CAST

	FB_TK_LSET
	FB_TK_RSET
	FB_TK_ASC
	FB_TK_CHR
	FB_TK_WCHR
	FB_TK_STR
	FB_TK_CVD
	FB_TK_CVS
	FB_TK_CVI
	FB_TK_CVL
	FB_TK_CVSHORT
	FB_TK_CVLONGINT
	FB_TK_MKD
	FB_TK_MKS
	FB_TK_MKI
	FB_TK_MKL
	FB_TK_MKSHORT
	FB_TK_MKLONGINT
	FB_TK_WSTR
	FB_TK_MID
	FB_TK_INSTR
	FB_TK_INSTRREV
	FB_TK_TRIM
	FB_TK_RTRIM
	FB_TK_LTRIM
	FB_TK_LCASE
	FB_TK_UCASE
	FB_TK_RESTORE
	FB_TK_READ
	FB_TK_DATA
	FB_TK_ABS
	FB_TK_SGN
	FB_TK_FIX
	FB_TK_FRAC
	FB_TK_SIN
	FB_TK_ASIN
	FB_TK_COS
	FB_TK_ACOS
	FB_TK_TAN
	FB_TK_ATN
	FB_TK_SQR
	FB_TK_LOG
	FB_TK_EXP
	FB_TK_INT
	FB_TK_ATAN2
	FB_TK_PRINT
	FB_TK_LPRINT
	FB_TK_LEN
	FB_TK_SIZEOF
	FB_TK_PEEK
	FB_TK_POKE
	FB_TK_SWAP
	FB_TK_OPEN
	FB_TK_CLOSE
	FB_TK_SEEK
	FB_TK_PUT
	FB_TK_GET
	FB_TK_ACCESS
	FB_TK_WRITE
	FB_TK_LOCK
	FB_TK_INPUT
	FB_TK_WINPUT
	FB_TK_OUTPUT
	FB_TK_BINARY
	FB_TK_RANDOM
	FB_TK_APPEND
	FB_TK_ENCODING
	FB_TK_NAME
	FB_TK_SPC
	FB_TK_TAB
	FB_TK_LINE
	FB_TK_VIEW
	FB_TK_UNLOCK
	FB_TK_WIDTH
	FB_TK_COLOR
	FB_TK_FIELD
	FB_TK_ERASE
	FB_TK_LBOUND
	FB_TK_UBOUND
	FB_TK_VA_FIRST

	FB_TK_ON
	FB_TK_ERROR
	FB_TK_LOCAL
	FB_TK_ERR
	FB_TK_RESUME
	FB_TK_IIF

	FB_TK_PSET
	FB_TK_PRESET
	FB_TK_POINT
	FB_TK_CIRCLE
	FB_TK_WINDOW
	FB_TK_PALETTE
	FB_TK_SCREEN
	FB_TK_SCREENQB
	FB_TK_PAINT
	FB_TK_DRAW
	FB_TK_IMAGECREATE

	FB_TK_CVA_START
	FB_TK_CVA_ARG
	FB_TK_CVA_END
	FB_TK_CVA_COPY

	FB_TK_THREADCALL

	FB_TOKENS = FB_TK_THREADCALL - FB_TK_EOF
end enum

'' single char tokens
const FB_TK_DIRECTIVECHAR       = CHAR_DOLAR    '' $
const FB_TK_DECLSEPCHAR         = CHAR_COMMA    '' ,
const FB_TK_ASSIGN              = FB_TK_EQ      '' special case, because lex
const FB_TK_DEREFCHAR           = CHAR_STAR     '' *
const FB_TK_ADDROFCHAR          = CHAR_AT       '' @

const FB_TK_INTTYPECHAR         = CHAR_PERC
const FB_TK_LNGTYPECHAR         = CHAR_AMP
const FB_TK_SNGTYPECHAR         = CHAR_EXCL
const FB_TK_DBLTYPECHAR         = CHAR_SHARP
const FB_TK_STRTYPECHAR         = CHAR_DOLAR


'' token classes
enum FB_TKCLASS
	FB_TKCLASS_IDENTIFIER
	FB_TKCLASS_KEYWORD
	FB_TKCLASS_QUIRKWD
	FB_TKCLASS_NUMLITERAL
	FB_TKCLASS_STRLITERAL
	FB_TKCLASS_OPERATOR
	FB_TKCLASS_DELIMITER
	FB_TKCLASS_UNKNOWN
end enum

#include once "hash.bi"
#include once "stack.bi"
#include once "symb.bi"

''
enum FBFILE_FORMAT
	FBFILE_FORMAT_ASCII
	FBFILE_FORMAT_UTF8
	FBFILE_FORMAT_UTF16LE
	FBFILE_FORMAT_UTF16BE
	FBFILE_FORMAT_UTF32LE
	FBFILE_FORMAT_UTF32BE
end enum

type FBFILE
	num             as integer
	name            as zstring * FB_MAXPATHLEN+1
	incfile         as zstring ptr
	ismain          as integer
	format          as FBFILE_FORMAT
end type

enum FB_TARGETOPT
	FB_TARGETOPT_UNIX       = &h00000001  '' Unix-like system? (for __FB_UNIX__ #define)
	''                      = &h00000002
	FB_TARGETOPT_EXPORT     = &h00000004  '' Support for exporting symbols from DLLs?

	'' Whether callee always pops the hidden struct result ptr
	'' i386 SysV ABI (MinGW GCC 4.6, Linux, DJGPP, etc.):
	''    callee always pops hidden param, even for cdecl ("hybrid")
	'' MinGW GCC 4.7, MSVC ABI:
	''    hidden param is popped according to calling convention
	FB_TARGETOPT_CALLEEPOPSHIDDENPTR = &h00000008

	'' Returning structures in registers only exists on Win32 and Darwin/MacOSX, and
	'' - neither Linux GCC (following the i386 SysV ABI),
	'' - nor DJGPP
	'' do it. TODO: what about the BSDs?
	FB_TARGETOPT_RETURNINREGS        = &h00000010   '' mingw-w64 & winlibs / BSD's
	FB_TARGETOPT_RETURNINFLTS        = &h00000020   '' mingw-w64 / BSD, but not win-libs

	'' Whether the stack needs to be aligned to 16 bytes before any
	'' call to external code (x86/x86_64 GNU/Linux and Darwin)
	FB_TARGETOPT_STACKALIGN16        = &h00000040

	FB_TARGETOPT_ELF                 = &h00000080
	FB_TARGETOPT_COFF                = &h00000100
	FB_TARGETOPT_MACHO               = &h00000200
end enum

type FBTARGET
	id              as zstring ptr
	wchar           as FB_DATATYPE  '' Real wstring data type
	fbcall          as FB_FUNCMODE  '' Default calling convention, must match the rtlib's FBCALL
	stdcall         as FB_FUNCMODE  '' Calling convention to use for stdcall (stdcall or stdcallms)
	options         as FB_TARGETOPT
end type

type FBOPTION
	base            as integer                  '' default= 0
	parammode       as integer                  '' def    = byref
	explicit        as integer                  '' def    = false
	procpublic      as integer                  '' def    = true
	escapestr       as integer                  '' def    = false
	dynamic         as integer                  '' def    = false
	gosub           as integer                  '' def    = true in FB_LANG_QB, false in all other dialects
end type

type FBMAIN
	proc            as FBSYMBOL ptr
	initnode        as ASTNODE ptr
end type

type FB_LANG_CTX
	opt                     as FB_LANG_OPT  '' language supported features
	integerkeyworddtype     as FB_DATATYPE  '' dtype produced by INTEGER (and related) keywords
	int15literaldtype       as FB_DATATYPE  '' default dtype for integer number literals that fit into 15 bits
	int16literaldtype       as FB_DATATYPE  '' etc.
	int31literaldtype       as FB_DATATYPE
	int32literaldtype       as FB_DATATYPE
	int63literaldtype       as FB_DATATYPE
	int64literaldtype       as FB_DATATYPE
	floatliteraldtype       as FB_DATATYPE  '' default dtype for float number literals
end type

type FBENV
	'' Global fb interface data
	predefines      as TLIST
	preincludes     as TLIST
	includepaths    as TLIST

	clopt               as FBCMMLINEOPT    '' cmm-line options
	target              as FBTARGET        '' target specific
	wchar_doconv        as integer         '' ok to convert literals at compile-time?
	underscoreprefix    as integer         '' Whether ASM symbols need a leading underscore on the current target
	pointersize         as integer

	'' Parse-specific things

	inf             as FBFILE                   '' source file
	outf            as FBFILE                   '' destine file

	ppfile_num      as integer                  '' -pp output file

	'' include files
	filenamehash    as THASH
	incfilehash     as THASH                    '' A subset of filenamehash
	inconcehash     as THASH                    '' A subset of filenamehash
	includerec      as integer                  '' >0 if parsing an include file

	entry           as zstring * FB_MAXNAMELEN  '' name of main function if overridden
	main            as FBMAIN

	lang            as FB_LANG_CTX              '' language supported features

	opt             as FBOPTION                 '' context-sensitive options

	'' initialization state
	inited          as integer                  '' set to TRUE if ready to parse source code
	module_count    as integer                  '' module (.bas) count, 1 = first

	'' restart state
	restart_request  as FB_RESTART_FLAGS        '' request parser or fbc restart on a trigger later (e.g #cmdline "-end")
	restart_action   as FB_RESTART_FLAGS        '' restart as soon as possible
	restart_status   as FB_RESTART_FLAGS        '' current status of restarts #lang/#cmdline/parser/fbc
	restart_count    as integer                 '' number of restarts
	restart_lang     as FB_LANG                 '' lang compatibility on restart if processed in #cmdline "-lang LANG"

	'' Lists to collect #inclibs and #libpaths
	libs            as TSTRSET
	libpaths        as TSTRSET

	fbctinf_started     as integer
end type

#include once "hlp.bi"

declare function fbGetInputFileParentDir( ) as string
declare sub fbAddLib(byval libname as zstring ptr)
declare sub fbAddLibPath(byval path as zstring ptr)

extern env as FBENV

#endif ''__FBINT_BI__

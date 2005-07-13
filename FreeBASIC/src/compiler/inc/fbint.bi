#ifndef __FBINT_BI__
#define __FBINT_BI__

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
'' internal compiler definitions
''

#include once "inc\fb.bi"

const FB_MAXINTNAMELEN		= FB_MAXNAMELEN + 1 + 1 + 2 + 1 + _
							  (FB_MAXPROCARGS * len( integer ))		'' mangling..

const FB_MAXINTLITLEN		= FB_MAXLITLEN + 32

const FB_MAXINTDEFINELEN	= FB_MAXDEFINELEN + _
							  (FB_MAXPROCARGS * (len( short ) + 2))	'' arg pattern..

const FB_MAXGOTBITEMS		= 64

''
const FB_INITSYMBOLNODES	= 8000

const FB_INITDEFARGNODES	= 400

const FB_INITDIMNODES		= 400

const FB_INITLIBNODES		= 20

const FB_INITFWDREFNODES	= 500


''
const FB_POINTERSIZE		= 4
const FB_INTEGERSIZE		= 4

const FB_ARRAYDESCSIZE		= FB_INTEGERSIZE*5
const FB_ARRAYDESC_DATAOFFS = 0

const FB_STRSTRUCTSIZE		= FB_POINTERSIZE+FB_INTEGERSIZE+FB_INTEGERSIZE

'' "fake" descriptors as UDT's
const FB_DESCTYPE_ARRAY 	= -2
const FB_DESCTYPE_STR 		= -3

''
const FB_DATALABELNAME 		= "_{fbdata}_begin"
const FB_DATALABELPREFIX	= "_{fbdata}_"


'' print modes (same as in rtlib/fb.h)
enum FBPRINTMASK
	FB_PRINTMASK_NEWLINE	= &h00000001
	FB_PRINTMASK_PAD        = &h00000002
	FB_PRINTMASK_ISLAST		= &h80000000
end enum

'' file constants (same as in rtlib/fb.h)
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

''
''
''

'' some chars
const CHAR_NULL   	= 00, _
      CHAR_BELL		= 07, _
      CHAR_BKSPC	= 08, _
      CHAR_TAB    	= 09, _
      CHAR_LF  	  	= 10, _
      CHAR_VTAB 	= 11, _
      CHAR_FORMFEED = 12, _
      CHAR_CR  	  	= 13, _
      CHAR_SPACE  	= 32, _
      CHAR_0   		= 48, _
      CHAR_1    	= 49, _
      CHAR_7  		= 56, _
      CHAR_9   		= 57, _
      CHAR_AUPP    	= 65, _
      CHAR_ALOW  	= 97, _
      CHAR_BUPP    	= 66, _
      CHAR_BLOW    	= 98, _
      CHAR_DUPP    	= 68, _
      CHAR_DLOW  	= 100, _
      CHAR_EUPP    	= 69, _
      CHAR_ELOW    	= 101, _
      CHAR_FUPP    	= 70, _
      CHAR_FLOW    	= 102, _
      CHAR_HUPP    	= 72, _
      CHAR_HLOW    	= 104, _
      CHAR_LUPP    	= 76, _
      CHAR_LLOW  	= 108, _
      CHAR_OUPP    	= 79, _
      CHAR_OLOW    	= 111, _
      CHAR_UUPP    	= 85, _
      CHAR_ULOW  	= 117, _
      CHAR_ZUPP    	= 90, _
      CHAR_ZLOW  	= 122, _
	  CHAR_NLOW		= 110, _
	  CHAR_RLOW		= 114, _
	  CHAR_TLOW		= 116, _
      CHAR_LPRNT  	= 40, _
      CHAR_RPRNT  	= 41, _
      CHAR_COMMA 	= 44, _
      CHAR_DOT    	= 46, _
      CHAR_PLUS   	= 43, _
      CHAR_MINUS  	= 45, _
      CHAR_RSLASH  	= 92, _
      CHAR_CARET   	= 42, _
      CHAR_SLASH   	= 47, _
      CHAR_CART   	= 94, _
      CHAR_EQ     	= 61, _
      CHAR_LT     	= 60, _
      CHAR_GT     	= 62, _
      CHAR_AMP		= 38, _
      CHAR_UNDER	= 95, _
      CHAR_EXCL		= 33, _
      CHAR_SHARP	= 35, _
      CHAR_DOLAR	= 36, _
      CHAR_PERC		= 37, _
      CHAR_QUOTE	= 34, _
      CHAR_APOST	= 39, _
      CHAR_TIMES	= 42, _
      CHAR_STAR		= CHAR_TIMES, _
      CHAR_COLON	= 58, _
      CHAR_SEMICOLON= 59, _
      CHAR_AT		= 64, _
      CHAR_QUESTION	= 63, _
      CHAR_TILD		= 126, _
      CHAR_ESC		= 27, _
      CHAR_LBRACE	= 123, _
      CHAR_RBRACE	= 125, _
      CHAR_LBRACKET	= 91, _
      CHAR_RBRACKET	= 93


const FB_INTSCAPECHAR		= CHAR_ESC			'' assuming it won't ever be used inside lit strings


'' tokens
enum FBTK_ENUM
	FB_TK_EOF					= 256
	FB_TK_EOL
	FB_TK_NUMLIT
	FB_TK_STRLIT
	FB_TK_ID

	FB_TK_REM

	FB_TK_AND
	FB_TK_OR
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

	FB_TK_INCLUDE
	FB_TK_DYNAMIC
	FB_TK_INCLIB
	FB_TK_LIBPATH

	FB_TK_BASE
	FB_TK_EXPLICIT
	FB_TK_BYVAL
	FB_TK_BYREF
	FB_TK_VARARG

	FB_TK_STATIC
	FB_TK_DIM
	FB_TK_REDIM
	FB_TK_COMMON
	FB_TK_EXTERN
	FB_TK_SHARED
	FB_TK_PRESERVE

	FB_TK_DEFINT
	FB_TK_DEFLNG
	FB_TK_DEFSNG
	FB_TK_DEFDBL
	FB_TK_DEFSTR
	FB_TK_DEFBYTE
	FB_TK_DEFUBYTE
	FB_TK_DEFSHORT
	FB_TK_DEFUSHORT
	FB_TK_DEFUINT
	FB_TK_DEFLNGINT
	FB_TK_DEFULNGINT

	FB_TK_DECLARE
	FB_TK_CONST
	FB_TK_TYPE
	FB_TK_UNION
	FB_TK_ENUM
	FB_TK_END
	FB_TK_EXPORT
	FB_TK_IMPORT
	FB_TK_OPTION
	FB_TK_ASM
	FB_TK_SUB
	FB_TK_FUNCTION

	FB_TK_INTEGER
	FB_TK_LONG
	FB_TK_SINGLE
	FB_TK_DOUBLE
	FB_TK_STRING
	FB_TK_BYTE
	FB_TK_UBYTE
	FB_TK_SHORT
	FB_TK_USHORT
	FB_TK_UINT
	FB_TK_LONGINT
	FB_TK_ULONGINT
	FB_TK_ANY
	FB_TK_PTR
	FB_TK_POINTER
	FB_TK_UNSIGNED
	FB_TK_AS
	FB_TK_ZSTRING

	FB_TK_PUBLIC
	FB_TK_PRIVATE
	FB_TK_PASCAL
	FB_TK_CDECL
	FB_TK_STDCALL
	FB_TK_ALIAS
	FB_TK_LIB
	FB_TK_OVERLOAD

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
	FB_TK_CINT
	FB_TK_CLNG
	FB_TK_CSNG
	FB_TK_CDBL
	FB_TK_CBYTE
	FB_TK_CSHORT
	FB_TK_CSIGN
	FB_TK_CUNSG
	FB_TK_CUINT
	FB_TK_CUBYTE
	FB_TK_CUSHORT
	FB_TK_CLNGINT
	FB_TK_CULNGINT
	FB_TK_CPTR

	FB_TK_LSET
	FB_TK_ASC
	FB_TK_CHR
	FB_TK_STR
	FB_TK_MID
	FB_TK_RESTORE
	FB_TK_READ
	FB_TK_DATA
	FB_TK_ABS
	FB_TK_SGN
	FB_TK_FIX
	FB_TK_SIN
	FB_TK_ASIN
	FB_TK_COS
	FB_TK_ACOS
	FB_TK_TAN
	FB_TK_ATN
	FB_TK_SQR
	FB_TK_LOG
	FB_TK_INT
	FB_TK_ATAN2
	FB_TK_PRINT
	FB_TK_USING
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
	FB_TK_OUTPUT
	FB_TK_BINARY
	FB_TK_RANDOM
	FB_TK_APPEND
    FB_TK_NAME
	FB_TK_SPC
	FB_TK_TAB
	FB_TK_LINE
	FB_TK_VIEW
	FB_TK_UNLOCK
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

	FB_TK_DEFINE
	FB_TK_UNDEF
	FB_TK_IFDEF
	FB_TK_IFNDEF
	FB_TK_ENDIF
	FB_TK_DEFINED

	FB_TK_PSET
	FB_TK_PRESET
	FB_TK_POINT
	FB_TK_CIRCLE
	FB_TK_WINDOW
	FB_TK_PALETTE
	FB_TK_SCREEN
	FB_TK_SCREENRES
	FB_TK_PAINT
	FB_TK_DRAW
end enum

'' single char tokens
const FB_TK_STATSEPCHAR			= CHAR_COLON	'' :
const FB_TK_COMMENTCHAR			= CHAR_APOST	'' '
const FB_TK_DIRECTIVECHAR		= CHAR_DOLAR	'' $
const FB_TK_DECLSEPCHAR			= CHAR_COMMA	'' ,
const FB_TK_ASSIGN				= FB_TK_EQ		'' special case, due the way lex processes comparators
const FB_TK_DEREFCHAR			= CHAR_CARET	'' *
const FB_TK_ADDROFCHAR			= CHAR_AT		'' @

const FB_TK_INTTYPECHAR			= CHAR_PERC
const FB_TK_LNGTYPECHAR			= CHAR_AMP
const FB_TK_SGNTYPECHAR			= CHAR_EXCL
const FB_TK_DBLTYPECHAR			= CHAR_SHARP
const FB_TK_STRTYPECHAR			= CHAR_DOLAR


'' token classes
enum FBTKCLASS_ENUM
	FB_TKCLASS_UNKNOWN
	FB_TKCLASS_KEYWORD
	FB_TKCLASS_IDENTIFIER
	FB_TKCLASS_NUMLITERAL
	FB_TKCLASS_STRLITERAL
	FB_TKCLASS_OPERATOR
	FB_TKCLASS_DELIMITER
end enum


'' argument modes
enum FBARGMODE_ENUM
	FB_ARGMODE_BYVAL 			= 1				'' must start at 1! used for mangling
	FB_ARGMODE_BYREF
	FB_ARGMODE_BYDESC
	FB_ARGMODE_VARARG
end enum

'' call conventions
enum FBFUNCMODE_ENUM
	FB_FUNCMODE_STDCALL			= 1             '' ditto
	FB_FUNCMODE_CDECL
	FB_FUNCMODE_PASCAL
end enum

const FB_DEFAULT_FUNCMODE		= FB_FUNCMODE_STDCALL


'' symbol types (same order as IR.DATATYPES!)
enum FBSYMBTYPE_ENUM
	FB_SYMBTYPE_VOID
	FB_SYMBTYPE_BYTE
	FB_SYMBTYPE_UBYTE
	FB_SYMBTYPE_CHAR
	FB_SYMBTYPE_SHORT
	FB_SYMBTYPE_USHORT
	FB_SYMBTYPE_INTEGER
	FB_SYMBTYPE_LONG			= FB_SYMBTYPE_INTEGER
	FB_SYMBTYPE_UINT
	FB_SYMBTYPE_ENUM
	FB_SYMBTYPE_LONGINT
	FB_SYMBTYPE_ULONGINT
	FB_SYMBTYPE_SINGLE
	FB_SYMBTYPE_DOUBLE
	FB_SYMBTYPE_STRING
	FB_SYMBTYPE_FIXSTR
	FB_SYMBTYPE_USERDEF
	FB_SYMBTYPE_FUNCTION
	FB_SYMBTYPE_FWDREF
	FB_SYMBTYPE_POINTER            				'' must be the last
end enum

const FB_SYMBOLTYPES			= 19


'' allocation types mask
enum FBALLOCTYPE_ENUM
	FB_ALLOCTYPE_SHARED			= 1
	FB_ALLOCTYPE_STATIC			= 2
	FB_ALLOCTYPE_DYNAMIC		= 4
	FB_ALLOCTYPE_COMMON			= 8
	FB_ALLOCTYPE_TEMP			= 16
	FB_ALLOCTYPE_ARGUMENTBYDESC	= 32
	FB_ALLOCTYPE_ARGUMENTBYVAL	= 64
	FB_ALLOCTYPE_ARGUMENTBYREF 	= 128
	FB_ALLOCTYPE_PUBLIC 		= 256
	FB_ALLOCTYPE_PRIVATE 		= 512
	FB_ALLOCTYPE_EXTERN			= 1024			'' extern's become public when DIM'ed
	FB_ALLOCTYPE_EXPORT			= 2048
	FB_ALLOCTYPE_IMPORT			= 4096
	FB_ALLOCTYPE_OVERLOADED		= 8192			'' functions only
	FB_ALLOCTYPE_JUMPTB			= 16384
	FB_ALLOCTYPE_MAINPROC		= 32768
end enum

#include once "inc\hash.bi"

''
type FBARRAYDIM
	lower			as integer
	upper			as integer
end type

type FBVARDIM
	ll_prv			as FBVARDIM ptr				'' linked-list nodes
	ll_nxt			as FBVARDIM ptr				'' /

	lower			as integer
	upper			as integer

	next			as FBVARDIM ptr
end type

''
type FBLIBRARY
	ll_prv			as FBLIBRARY ptr			'' linked-list nodes
	ll_nxt			as FBLIBRARY ptr			'' /

	name			as zstring * FB_MAXPATHLEN+1

	hashitem		as HASHITEM ptr
	hashindex		as uinteger
end type


''
enum SYMBCLASS_ENUM
	FB_SYMBCLASS_VAR			= 1
	FB_SYMBCLASS_CONST
	FB_SYMBCLASS_PROC
	FB_SYMBCLASS_PROCARG
	FB_SYMBCLASS_DEFINE
	FB_SYMBCLASS_KEYWORD
	FB_SYMBCLASS_LABEL
	FB_SYMBCLASS_ENUM
	FB_SYMBCLASS_UDT
	FB_SYMBCLASS_UDTELM
	FB_SYMBCLASS_TYPEDEF
	FB_SYMBCLASS_FWDREF
end enum


type FBSYMBOL_ as FBSYMBOL


''
union FBVALUE
	valuestr		as FBSYMBOL_ ptr
	valuei			as integer
	valuef			as double
	value64			as longint
end union

''
type FBSKEYWORD
	id				as integer
	class			as integer
end type

type FBDEFARG
	ll_prv			as FBDEFARG ptr				'' linked-list nodes
	ll_nxt			as FBDEFARG ptr				'' /

	name			as string
	id				as short					'' unique id

	next			as FBDEFARG ptr
end type

''
type FBSDEFINE
	text			as string
	args			as integer
	arghead 		as FBDEFARG ptr
	isargless		as integer
    flags           as integer          '' flags:
                                        '' bit    meaning
                                        '' 0      1=numeric, 0=string
	proc			as function( ) as string
end type

''
type FBFWDREF
	ll_prv			as FBFWDREF ptr				'' linked-list nodes
	ll_nxt			as FBFWDREF ptr				'' /

	ref				as FBSYMBOL_ ptr
	prev			as FBFWDREF ptr
end type

type FBSFWDREF
	refs			as integer
	reftail			as FBFWDREF ptr
end type

''
type FBLABEL
	declared		as integer
end type

''
type FBSARRAY
	dims			as integer
	dimhead 		as FBVARDIM ptr
	dimtail			as FBVARDIM ptr
	dif				as integer
	elms			as integer

	desc			as FBSYMBOL_ ptr
end type

''
type FBSUDT
	isunion			as integer
	elements		as integer
	head			as FBSYMBOL_ ptr			'' first element
	tail			as FBSYMBOL_ ptr			'' last  /
	ofs				as integer
	align			as integer
	lfldlen			as integer					'' largest field len (used with unions)
	innerlgt		as integer					'' used with inner nameless unions
	bitpos			as uinteger
end type

type FBSUDTELM
	ofs				as integer
	bitpos			as integer
	bits			as integer
	parent			as FBSYMBOL_ ptr

	prev			as FBSYMBOL_ ptr
	next			as FBSYMBOL_ ptr
end type

''
type FBSENUM
	elements		as integer
	head			as FBSYMBOL_ ptr			'' first element
	tail			as FBSYMBOL_ ptr			'' last  /
end type

type FBSENUMELM
	nxt				as FBSYMBOL_ ptr			'' next element
end type

''
type FBSCONST
	text			as string
	eelm			as FBSENUMELM
end type

''
type FBSPROCARG
	mode			as integer
	suffix			as integer					'' QB quirk..

	optional		as integer					'' true or false
	optval			as FBVALUE                  '' default value

	prev			as FBSYMBOL_ ptr
	next			as FBSYMBOL_ ptr
end type

type FBRTLCALLBACK as function( byval sym as FBSYMBOL_ ptr ) as integer

type FBPROCOVL
	maxargs			as integer
	nxt				as FBSYMBOL_ ptr
end type

type FBPROCSTK
	localptr		as integer
	argptr			as integer					'' /
end type

type FBPROCDBG
	iniline			as integer					'' sub|function
	endline			as integer					'' end sub|function
	incfile			as integer
end type

type FBSPROC
	mode			as integer					'' calling convention (STDCALL, PASCAL, C)
	realtype		as integer					'' used with STRING and UDT functions

	lib				as FBLIBRARY ptr

	args			as integer
	arghead 		as FBSYMBOL_ ptr
	argtail			as FBSYMBOL_ ptr

	isdeclared		as byte						'' FALSE = just the prototype
	iscalled		as byte
	isrtl			as byte
	doerrorcheck	as byte

	rtlcallback		as FBRTLCALLBACK

	ovl				as FBPROCOVL				'' overloading

	stk				as FBPROCSTK				'' to keep track of the stack frame

	dbg				as FBPROCDBG				'' debugging
end type

type FBSVAR
	suffix			as integer					'' QB quirk..
	initialized		as integer
	inittext		as string

	emited			as integer

	array			as FBSARRAY

	elm				as FBSUDTELM
end type

type FBDBG
	typenum			as integer
end type

''
type FBSYMBOL
	ll_prv			as FBSYMBOL ptr				'' linked-list nodes
	ll_nxt			as FBSYMBOL ptr				'' /

	class			as integer					'' VAR, CONST, PROC, ..
	typ				as integer					'' integer, float, string, pointer, ..
	subtype			as FBSYMBOL ptr				'' used by UDT's
	ptrcnt 			as integer
	alloctype		as integer					'' STATIC, DYNAMIC, SHARED, ARG, ..

	name			as string					'' original name, shared by hash tb
	alias			as string

	hashitem		as HASHITEM ptr
	hashindex		as uinteger

	scope			as integer

	lgt				as integer
	ofs				as integer					'' used with local vars and args

	acccnt			as integer					'' access counter (number of lookup's)

	union
		var			as FBSVAR
		con			as FBSCONST
		udt			as FBSUDT
		proc		as FBSPROC
		arg			as FBSPROCARG
		lbl			as FBLABEL
		def			as FBSDEFINE
		key			as FBSKEYWORD
		fwd			as FBSFWDREF
		enum		as FBSENUM
	end union

	dbg				as FBDBG

	left			as FBSYMBOL ptr 			'' same name symbols list
	right			as FBSYMBOL ptr				'' /

	prev			as FBSYMBOL ptr				'' symbol tb list
	next			as FBSYMBOL ptr             '' /
end type

type FBSYMBOLTB
    head			as FBSYMBOL ptr				'' first node
    tail			as FBSYMBOL ptr				'' last node
end type


''
type FBCMPSTMT
	cmplabel		as FBSYMBOL ptr				'' or inilabel
    endlabel		as FBSYMBOL ptr
end type

type FBENUMCTX
    sym				as FBSYMBOL ptr
    value 			as integer
    elements 		as integer
end type

type FBTYPECTX
    innercnt		as integer
    elements 		as integer
    isunion			as integer
    symbol			as FBSYMBOL ptr
end type

''
type FBFILE
	num				as integer
	name			as zstring * FB_MAXPATHLEN+1
	incfile			as integer
end type

type FBOPTION
	base			as integer					'' default= 0
	argmode			as integer					'' def    = byref
	explicit		as integer					'' def    = false
	procpublic		as integer					'' def    = true
	escapestr		as integer					'' def    = false
	dynamic			as integer					'' def    = false
end type

type FBENV
	inf				as FBFILE					'' source file
	outf			as FBFILE					'' destine file

	'' include files
	incpaths		as integer
	incfiles 		as integer

	'' stmt recursion
	forstmt			as FBCMPSTMT
	dostmt			as FBCMPSTMT
	whilestmt		as FBCMPSTMT
	procstmt		as FBCMPSTMT

	'' internal contexts
	union
		enumctx 	as FBENUMCTX
		typectx 	as FBTYPECTX
	end union

	'' globals
	scope			as integer					'' current scope (0=main module)
	reclevel		as integer					'' >0 if parsing an include file
	currproc 		as FBSYMBOL ptr				'' current proc (def= NULL)
	withtext		as zstring * FB_MAXWITHLEN+1'' WITH's text

	compoundcnt		as integer					'' checked when parsing EXIT
	lastcompound	as integer					'' last compound stmt (token), def= INVALID
	isprocstatic	as integer					'' TRUE with SUB/FUNCTION (...) STATIC
	procerrorhnd	as FBSYMBOL ptr				'' var holding the old error handler inside a proc

	'' hacks
	prntcnt			as integer					'' ()'s count, to allow optional ()'s on SUB's
	prntopt			as integer					'' /
	checkarray		as integer					'' used by LEN() to handle expr's and ()-less arrays

	clopt			as FBCMMLINEOPT				'' cmm-line options

	opt				as FBOPTION					'' context-sensitive options
end type


#include once "inc\symb.bi"

#include once "inc\hlp.bi"


''
'' super globals
''
common shared env as FBENV

#endif ''__FBINT_BI__

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

const FB.MAXINCRECLEVEL		= 16
const FB.MAXWITHLEVELS		= 4

const FB.MAXINCPATHS		= 16
const FB.INITINCFILES		= 256

const FB.MAXNAMELEN			= 64
const FB.MAXLITLEN			= 1024				'' literal strings max length
const FB.MAXNUMLEN			= 32
const FB.MAXOPERANDLEN		= FB.MAXNAMELEN + 2 + 16 + 2 + 1
const FB.MAXWITHLEN			= FB.MAXNAMELEN * FB.MAXWITHLEVELS

const FB_MAXPROCARGS		= 64
const FB.MAXARRAYDIMS		= FB_MAXPROCARGS \ 4

const FB.MAXGOTBITEMS		= 64

''
const FB.INITSYMBOLNODES	= 15000
const FB.INITLOCSYMBOLNODES	= FB.INITSYMBOLNODES \ 30

const FB.INITDEFARGNODES	= 400

const FB.INITDIMNODES		= 400

const FB.INITLIBNODES		= 50

const FB.INITFWDREFNODES	= 200


''
const FB.POINTERSIZE		= 4
const FB.INTEGERSIZE		= 4

const FB.ARRAYDESCSIZE		= FB.INTEGERSIZE*5
const FB.ARRAYDESC.DATAOFFS = 0

const FB.STRSTRUCTSIZE		= FB.POINTERSIZE+FB.INTEGERSIZE+FB.INTEGERSIZE

'' "fake" descriptors as UDT's
const FB.DESCTYPE.ARRAY 	= -2
const FB.DESCTYPE.STR 		= -3

''
const FB.DATALABELNAME 		= "_fbdata_begin"
const FB.DATALABELPREFIX	= "_fbdata_"


'' print modes (same as in rtlib/fb.h)
enum FBPRINTMASK
	FB.PRINTMASK.NEWLINE	= &h00000001
	FB.PRINTMASK.PAD        = &h00000002
	FB.PRINTMASK.ISLAST		= &h80000000
end enum

'' file constants (same as in rtlib/fb.h)
enum FBFILEMODE
	FB.FILE.MODE.BINARY
	FB.FILE.MODE.RANDOM
	FB.FILE.MODE.INPUT
	FB.FILE.MODE.OUTPUT
	FB.FILE.MODE.APPEND
end enum

enum FBFILEACCESS
	FB.FILE.ACCESS.ANY
	FB.FILE.ACCESS.READ
	FB.FILE.ACCESS.WRITE
	FB.FILE.ACCESS.READWRITE
end enum

enum FBFILELOCK
	FB.FILE.LOCK.SHARED
	FB.FILE.LOCK.READ
	FB.FILE.LOCK.WRITE
	FB.FILE.LOCK.READWRITE
end enum

''
''
''

'' some chars
const CHAR_NULL   	= 00, _
      CHAR_CR  	  	= 13, _
      CHAR_LF  	  	= 10, _
      CHAR_SPACE  	= 32, _
      CHAR_TAB    	= 09, _
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


const FB.INTSCAPECHAR		= CHAR_ESC			'' assuming it won't ever be used inside lit strings


'' tokens
enum FBTK_ENUM
	FB.TK.EOF					= 256
	FB.TK.EOL
	FB.TK.NUMLIT
	FB.TK.STRLIT
	FB.TK.ID

	FB.TK.REM

	FB.TK.AND
	FB.TK.OR
	FB.TK.XOR
	FB.TK.EQV
	FB.TK.IMP
	FB.TK.NOT
	FB.TK.MOD
	FB.TK.SHL
	FB.TK.SHR
	FB.TK.EQ
	FB.TK.GT
	FB.TK.LT
	FB.TK.NE
	FB.TK.LE
	FB.TK.GE

	FB.TK.IF
	FB.TK.THEN
	FB.TK.ELSE
	FB.TK.ELSEIF
	FB.TK.SELECT
	FB.TK.CASE
	FB.TK.IS
	FB.TK.WHILE
	FB.TK.UNTIL
	FB.TK.WEND
	FB.TK.CONTINUE
	FB.TK.EXIT
	FB.TK.DO
	FB.TK.LOOP
	FB.TK.WITH
	FB.TK.FOR
	FB.TK.STEP
	FB.TK.NEXT
	FB.TK.TO

	FB.TK.INCLUDE
	FB.TK.DYNAMIC
	FB.TK.INCLIB
	FB.TK.LIBPATH

	FB.TK.BASE
	FB.TK.EXPLICIT
	FB.TK.BYVAL
	FB.TK.BYREF
	FB.TK.VARARG

	FB.TK.STATIC
	FB.TK.DIM
	FB.TK.REDIM
	FB.TK.COMMON
	FB.TK.EXTERN
	FB.TK.SHARED
	FB.TK.PRESERVE

	FB.TK.DEFINT
	FB.TK.DEFLNG
	FB.TK.DEFSNG
	FB.TK.DEFDBL
	FB.TK.DEFSTR
	FB.TK.DEFBYTE
	FB.TK.DEFUBYTE
	FB.TK.DEFSHORT
	FB.TK.DEFUSHORT
	FB.TK.DEFUINT
	FB.TK.DEFLNGINT
	FB.TK.DEFULNGINT

	FB.TK.DECLARE
	FB.TK.CONST
	FB.TK.TYPE
	FB.TK.UNION
	FB.TK.ENUM
	FB.TK.END
	FB.TK.EXPORT
	FB.TK.IMPORT
	FB.TK.OPTION
	FB.TK.ASM
	FB.TK.SUB
	FB.TK.FUNCTION

	FB.TK.INTEGER
	FB.TK.LONG
	FB.TK.SINGLE
	FB.TK.DOUBLE
	FB.TK.STRING
	FB.TK.BYTE
	FB.TK.UBYTE
	FB.TK.SHORT
	FB.TK.USHORT
	FB.TK.UINT
	FB.TK.LONGINT
	FB.TK.ULONGINT
	FB.TK.ANY
	FB.TK.PTR
	FB.TK.POINTER
	FB.TK.UNSIGNED
	FB.TK.AS
	FB.TK.ZSTRING

	FB.TK.PUBLIC
	FB.TK.PRIVATE
	FB.TK.PASCAL
	FB.TK.CDECL
	FB.TK.STDCALL
	FB.TK.ALIAS
	FB.TK.LIB

	FB.TK.LET
	FB.TK.RETURN
	FB.TK.GOTO
	FB.TK.GOSUB

	FB.TK.CALL

	FB.TK.VARPTR
	FB.TK.STRPTR
	FB.TK.PROCPTR
	FB.TK.SADD

	FB.TK.FIELDDEREF
	FB.TK.CINT
	FB.TK.CLNG
	FB.TK.CSNG
	FB.TK.CDBL
	FB.TK.CBYTE
	FB.TK.CSHORT
	FB.TK.CSIGN
	FB.TK.CUNSG
	FB.TK.CUINT
	FB.TK.CUBYTE
	FB.TK.CUSHORT
	FB.TK.CLNGINT
	FB.TK.CULNGINT

	FB.TK.ASC
	FB.TK.CHR
	FB.TK.STR
	FB.TK.INSTR
	FB.TK.MID
	FB.TK.RESTORE
	FB.TK.READ
	FB.TK.DATA
	FB.TK.ABS
	FB.TK.SGN
	FB.TK.FIX
	FB.TK.PRINT
	FB.TK.USING
	FB.TK.LEN
	FB.TK.SIZEOF
	FB.TK.PEEK
	FB.TK.POKE
	FB.TK.SWAP
	FB.TK.OPEN
	FB.TK.CLOSE
	FB.TK.SEEK
	FB.TK.PUT
	FB.TK.GET
	FB.TK.ACCESS
	FB.TK.WRITE
	FB.TK.LOCK
	FB.TK.INPUT
	FB.TK.OUTPUT
	FB.TK.BINARY
	FB.TK.RANDOM
	FB.TK.APPEND
	FB.TK.SPC
	FB.TK.TAB
	FB.TK.LINE
	FB.TK.VIEW
	FB.TK.UNLOCK
	FB.TK.FIELD
	FB.TK.ERASE
	FB.TK.LBOUND
	FB.TK.UBOUND
	FB.TK.VA_FIRST

	FB.TK.ON
	FB.TK.ERROR
	FB.TK.LOCAL
	FB.TK.ERR
	FB.TK.RESUME
	FB.TK.IIF

	FB.TK.DEFINE
	FB.TK.UNDEF
	FB.TK.IFDEF
	FB.TK.IFNDEF
	FB.TK.ENDIF
	FB.TK.DEFINED

	FB.TK.THREADCREATE

	FB.TK.PSET
	FB.TK.PRESET
	FB.TK.POINT
	FB.TK.CIRCLE
	FB.TK.WINDOW
	FB.TK.PALETTE
	FB.TK.SCREEN
	FB.TK.SCREENRES
	FB.TK.PAINT
	FB.TK.DRAW
	FB.TK.BLOAD
	FB.TK.BSAVE
end enum

'' single char tokens
const FB.TK.TWOPOINTSCHAR		= CHAR_COLON	'' :
const FB.TK.STATSEPCHAR			= CHAR_COLON	'' :
const FB.TK.COMMENTCHAR			= CHAR_APOST	'' '
const FB.TK.DIRECTIVECHAR		= CHAR_DOLAR	'' $
const FB.TK.DECLSEPCHAR			= CHAR_COMMA	'' ,
const FB.TK.ASSIGN				= FB.TK.EQ		'' special case, due the way lex processes comparators
const FB.TK.DEREFCHAR			= CHAR_CARET	'' *
const FB.TK.ADDROFCHAR			= CHAR_AT		'' @

const FB.TK.INTTYPECHAR			= CHAR_PERC
const FB.TK.LNGTYPECHAR			= CHAR_AMP
const FB.TK.SGNTYPECHAR			= CHAR_EXCL
const FB.TK.DBLTYPECHAR			= CHAR_SHARP
const FB.TK.STRTYPECHAR			= CHAR_DOLAR


'' token classes
enum FBTKCLASS_ENUM
	FB.TKCLASS.UNKNOWN
	FB.TKCLASS.KEYWORD
	FB.TKCLASS.IDENTIFIER
	FB.TKCLASS.NUMLITERAL
	FB.TKCLASS.STRLITERAL
	FB.TKCLASS.OPERATOR
	FB.TKCLASS.DELIMITER
end enum


'' argument modes
enum FBARGMODE_ENUM
	FB.ARGMODE.BYVAL 			= 1				'' must start at 1! used for mangling
	FB.ARGMODE.BYREF
	FB.ARGMODE.BYDESC
	FB.ARGMODE.VARARG
end enum

'' call conventions
enum FBFUNCMODE_ENUM
	FB.FUNCMODE.STDCALL			= 1             '' ditto
	FB.FUNCMODE.CDECL
	FB.FUNCMODE.PASCAL
end enum

const FB.DEFAULT.FUNCMODE		= FB.FUNCMODE.STDCALL


'' symbol types (same order as IR.DATATYPES!)
enum FBSYMBTYPE_ENUM
	FB.SYMBTYPE.VOID
	FB.SYMBTYPE.BYTE
	FB.SYMBTYPE.UBYTE
	FB.SYMBTYPE.CHAR
	FB.SYMBTYPE.SHORT
	FB.SYMBTYPE.USHORT
	FB.SYMBTYPE.INTEGER
	FB.SYMBTYPE.LONG			= FB.SYMBTYPE.INTEGER
	FB.SYMBTYPE.UINT
	FB.SYMBTYPE.LONGINT
	FB.SYMBTYPE.ULONGINT
	FB.SYMBTYPE.SINGLE
	FB.SYMBTYPE.DOUBLE
	FB.SYMBTYPE.STRING
	FB.SYMBTYPE.FIXSTR
	FB.SYMBTYPE.USERDEF
	FB.SYMBTYPE.FUNCTION
	FB.SYMBTYPE.FWDREF
	FB.SYMBTYPE.POINTER            				'' must be the last
end enum

const FB.SYMBOLTYPES			= 18


'' allocation types mask
enum FBALLOCTYPE_ENUM
	FB.ALLOCTYPE.SHARED			= 1
	FB.ALLOCTYPE.STATIC			= 2
	FB.ALLOCTYPE.DYNAMIC		= 4
	FB.ALLOCTYPE.COMMON			= 8
	FB.ALLOCTYPE.TEMP			= 16
	FB.ALLOCTYPE.ARGUMENTBYDESC	= 32
	FB.ALLOCTYPE.ARGUMENTBYVAL	= 64
	FB.ALLOCTYPE.ARGUMENTBYREF 	= 128
	FB.ALLOCTYPE.PUBLIC 		= 256
	FB.ALLOCTYPE.PRIVATE 		= 512
	FB.ALLOCTYPE.EXTERN			= 1024			'' extern's become public when DIM'ed
	FB.ALLOCTYPE.EXPORT			= 2048
	FB.ALLOCTYPE.IMPORT			= 4096
end enum

'$include once:'inc\hash.bi'

''
type FBARRAYDIM
	lower			as integer
	upper			as integer
end type

type FBVARDIM
	prv				as FBVARDIM ptr				'' linked-list nodes
	nxt				as FBVARDIM ptr				'' /

	lower			as integer
	upper			as integer

	r				as FBVARDIM ptr				'' right
end type

''
type FBLIBRARY
	prv				as FBLIBRARY ptr			'' linked-list nodes
	nxt				as FBLIBRARY ptr			'' /

	name			as string

	hashitem		as HASHITEM ptr
	hashindex		as uinteger
end type


''
enum SYMBCLASS_ENUM
	FB.SYMBCLASS.VAR			= 1
	FB.SYMBCLASS.CONST
	FB.SYMBCLASS.PROC
	FB.SYMBCLASS.PROCARG
	FB.SYMBCLASS.DEFINE
	FB.SYMBCLASS.KEYWORD
	FB.SYMBCLASS.LABEL
	FB.SYMBCLASS.ENUM
	FB.SYMBCLASS.UDT
	FB.SYMBCLASS.UDTELM
	FB.SYMBCLASS.TYPEDEF
	FB.SYMBCLASS.FWDREF
end enum


type FBSYMBOL_ as FBSYMBOL


''
union FBVALUE
	valuestr		as FBSYMBOL_ ptr
	value			as double
	value64			as longint
end union

''
type FBSKEYWORD
	id				as integer
	class			as integer
end type

type FBDEFARG
	prv				as FBDEFARG ptr				'' linked-list nodes
	nxt				as FBDEFARG ptr				'' /

	name			as string

	r				as FBDEFARG ptr				'' right
end type

''
type FBSDEFINE
	text			as string
	args			as integer
	arghead 		as FBDEFARG ptr
	isargless		as integer
end type

''
type FBFWDREF
	prv				as FBFWDREF ptr				'' linked-list nodes
	nxt				as FBFWDREF ptr				'' /

	ref				as FBSYMBOL_ ptr
	l				as FBFWDREF ptr				'' preview
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

type FBSCONST
	text			as string
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

	l				as FBSYMBOL_ ptr			'' left
	r				as FBSYMBOL_ ptr			'' right
end type

''
type FBSPROCARG
	mode			as integer
	suffix			as integer					'' QB quirk..

	optional		as integer					'' true or false
	optval			as FBVALUE                  '' default value

	l				as FBSYMBOL_ ptr			'' left
	r				as FBSYMBOL_ ptr			'' right
end type

type FBSPROC
	mode			as integer					'' calling convention (STDCALL, PASCAL, C)
	realtype		as integer					'' used with STRING and UDT functions
	lib				as FBLIBRARY ptr
	args			as integer
	arghead 		as FBSYMBOL_ ptr
	argtail			as FBSYMBOL_ ptr
	isdeclared		as integer					'' FALSE = just the prototype
end type

type FBSVAR
	suffix			as integer					'' QB quirk..
	initialized		as integer
	inittext		as string

	emited			as integer

	array			as FBSARRAY

	elm				as FBSUDTELM
end type

''
type FBSYMBOL
	prv				as FBSYMBOL ptr				'' linked-list nodes
	nxt				as FBSYMBOL ptr				'' /

	class			as integer					'' VAR, CONST, PROC, ..
	typ				as integer					'' integer, float, string, pointer, ..
	subtype			as FBSYMBOL ptr				'' used by UDT's
	ptrcnt 			as integer
	alloctype		as integer					'' STATIC, DYNAMIC, SHARED, ARG, ..

	alias			as string					'' alias -- original name is only at the hashtb

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
	end union

	left			as FBSYMBOL ptr
	right			as FBSYMBOL ptr
end type

type FBLOCSYMBOL
	prv				as FBLOCSYMBOL ptr			'' linked-list nodes
	nxt				as FBLOCSYMBOL ptr			'' /

    s				as FBSYMBOL ptr
end type


''
type FBCMPSTMT
	cmplabel		as FBSYMBOL ptr				'' or inilabel
    endlabel		as FBSYMBOL ptr
end type

type FBENUMCTX
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
type FBENV
	'' include paths
	incpaths		as integer

	'' source file
	inf				as integer
	infile			as zstring * 260+1

	'' destine file
	outfile			as zstring * 260+1

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
	withtext		as zstring * FB.MAXWITHLEN+1'' WITH's text

	compoundcnt		as integer					'' checked when parsing EXIT
	lastcompound	as integer					'' last compound stmt (token), def= INVALID
	isprocstatic	as integer					'' TRUE with SUB/FUNCTION (...) STATIC
	procerrorhnd	as FBSYMBOL ptr				'' var holding the old error handler inside a proc

	'' hacks
	prntcnt			as integer					'' ()'s count, to allow optional ()'s on SUB's
	prntopt			as integer					'' /
	varcheckarray	as integer					'' used by LEN() to handle expr's and ()-less arrays

	'' cmm-line options
	clopt			as FBCMMLINEOPT

	'' debug states
	dbglname 		as zstring * 32+1
	dbglnum 		as integer
	dbgpos 			as integer

	'' options
	optbase			as integer					'' default= 0
	optargmode		as integer					'' def    = byref
	optexplicit		as integer					'' def    = false
	optprocpublic	as integer					'' def    = true
	optescapestr	as integer					'' def    = false
	optdynamic		as integer					'' def    = false
end type


'$include once:'inc\symb.bi'

'$include once:'inc\hlp.bi'


''
'' super globals
''
common shared env as FBENV

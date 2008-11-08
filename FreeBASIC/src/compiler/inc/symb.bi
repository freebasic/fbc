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

''
'' symbol table protos
''

#include once "inc\list.bi"
#include once "inc\clist.bi"
#include once "inc\pool.bi"
#include once "inc\ast-op.bi"

''
enum FB_DATACLASS
	FB_DATACLASS_INTEGER                        '' must be the first
	FB_DATACLASS_FPOINT
	FB_DATACLASS_STRING
	FB_DATACLASS_UDT
	FB_DATACLASS_UNKNOWN
end enum

enum FB_DATATYPE
	FB_DATATYPE_VOID
	FB_DATATYPE_BYTE
	FB_DATATYPE_UBYTE
	FB_DATATYPE_CHAR
	FB_DATATYPE_SHORT
	FB_DATATYPE_USHORT
	FB_DATATYPE_WCHAR
	FB_DATATYPE_INTEGER
	FB_DATATYPE_UINT
	FB_DATATYPE_ENUM
	FB_DATATYPE_BITFIELD
	FB_DATATYPE_LONG
	FB_DATATYPE_ULONG
	FB_DATATYPE_LONGINT
	FB_DATATYPE_ULONGINT
	FB_DATATYPE_SINGLE
	FB_DATATYPE_DOUBLE
	FB_DATATYPE_STRING
	FB_DATATYPE_FIXSTR
	FB_DATATYPE_STRUCT
	FB_DATATYPE_NAMESPC
	FB_DATATYPE_FUNCTION
	FB_DATATYPE_FWDREF
	FB_DATATYPE_POINTER
end enum

const FB_DATATYPES = (FB_DATATYPE_POINTER - FB_DATATYPE_VOID) + 1

const FB_DT_TYPEMASK 		= &b00000000000000000000000000011111 '' max 32 built-in dts
const FB_DT_PTRMASK  		= &b00000000000000000000000111100000
const FB_DT_CONSTMASK		= &b00000000000000111111111000000000 '' PTRLEVELS + 1 bit-masks
const FB_DATATYPE_ARRAY		= &b00000000000010000000000000000000 '' used when mangling
const FB_DATATYPE_REFERENCE	= &b00000000000100000000000000000000 '' ditto
const FB_DATATYPE_INVALID	= &b10000000000000000000000000000000

const FB_DT_PTRLEVELS		= 8					'' max levels of pointer indirection

const FB_DT_PTRPOS			= 5
const FB_DT_CONSTPOS		= FB_DT_PTRPOS + 4


'' symbol classes
enum FB_SYMBCLASS
	FB_SYMBCLASS_VAR			= 1
	FB_SYMBCLASS_CONST
	FB_SYMBCLASS_PROC
	FB_SYMBCLASS_PARAM
	FB_SYMBCLASS_DEFINE
	FB_SYMBCLASS_KEYWORD
	FB_SYMBCLASS_LABEL
	FB_SYMBCLASS_NAMESPACE
	FB_SYMBCLASS_ENUM
	FB_SYMBCLASS_STRUCT
	FB_SYMBCLASS_CLASS
	FB_SYMBCLASS_FIELD
	FB_SYMBCLASS_BITFIELD
	FB_SYMBCLASS_TYPEDEF
	FB_SYMBCLASS_FWDREF							'' forward definition
	FB_SYMBCLASS_SCOPE
	FB_SYMBCLASS_NSIMPORT						'' namespace import (an USING)
end enum

'' symbol state mask
enum FB_SYMBSTATS
	FB_SYMBSTATS_VARALLOCATED = &h00000001
    FB_SYMBSTATS_ACCESSED     = &h00000002
    FB_SYMBSTATS_INITIALIZED  = &h00000004
    FB_SYMBSTATS_DECLARED     = &h00000008
    FB_SYMBSTATS_CALLED       = &h00000010
    FB_SYMBSTATS_RTL          = &h00000020
    FB_SYMBSTATS_THROWABLE    = &h00000040
    FB_SYMBSTATS_PARSED       = &h00000080
    FB_SYMBSTATS_MANGLED      = &h00000100
    FB_SYMBSTATS_HASALIAS     = &h00000200
    FB_SYMBSTATS_MOCK         = &h00000400
    FB_SYMBSTATS_DONTINIT     = &h00000800
    FB_SYMBSTATS_MAINPROC     = &H00001000
    FB_SYMBSTATS_MODLEVELPROC = &h00002000
    FB_SYMBSTATS_FUNCPTR      = &h00004000    '' needed to demangle
    FB_SYMBSTATS_JUMPTB       = &h00008000
    FB_SYMBSTATS_GLOBALCTOR   = &h00010000
    FB_SYMBSTATS_GLOBALDTOR   = &h00020000
    FB_SYMBSTATS_CANTDUP      = &h00040000
    FB_SYMBSTATS_HASCTOR      = &h00080000
    FB_SYMBSTATS_HASCOPYCTOR  = &h00100000
    FB_SYMBSTATS_HASDTOR      = &h00200000
    FB_SYMBSTATS_HASVIRTUAL   = &h00400000
    FB_SYMBSTATS_CANTUNDEF    = &h00800000
    FB_SYMBSTATS_UNIONFIELD   = &h01000000
    FB_SYMBSTATS_RTL_CONST    = &h02000000

    FB_SYMBSTATS_PROCEMITTED    = FB_SYMBSTATS_UNIONFIELD
    FB_SYMBSTATS_CTORINITED     = FB_SYMBSTATS_INITIALIZED
    FB_SYMBSTATS_EXCLPARENT     = FB_SYMBSTATS_DONTINIT
end enum

'' symbol attributes mask
enum FB_SYMBATTRIB
	FB_SYMBATTRIB_NONE			= &h00000000

	FB_SYMBATTRIB_SHARED		= &h00000001
	FB_SYMBATTRIB_STATIC		= &h00000002
	FB_SYMBATTRIB_DYNAMIC		= &h00000004
	FB_SYMBATTRIB_COMMON		= &h00000008
	FB_SYMBATTRIB_EXTERN		= &h00000010	'' extern's become public when DIM'ed
	FB_SYMBATTRIB_PUBLIC 		= &h00000020
	FB_SYMBATTRIB_PRIVATE 		= &h00000040
    FB_SYMBATTRIB_LOCAL			= &h00000080
	FB_SYMBATTRIB_EXPORT		= &h00000100
	FB_SYMBATTRIB_IMPORT		= &h00000200
	FB_SYMBATTRIB_OVERLOADED	= &h00000400
	FB_SYMBATTRIB_METHOD		= &h00000800
    FB_SYMBATTRIB_CONSTRUCTOR   = &h00001000	'' methods only
    FB_SYMBATTRIB_DESTRUCTOR    = &h00002000	'' /
    FB_SYMBATTRIB_OPERATOR    	= &h00004000
    FB_SYMBATTRIB_PROPERTY    	= &h00008000    '' /
	FB_SYMBATTRIB_PARAMBYDESC	= &h00010000
	FB_SYMBATTRIB_PARAMBYVAL	= &h00020000
	FB_SYMBATTRIB_PARAMBYREF 	= &h00040000
	FB_SYMBATTRIB_LITERAL		= &h00080000
	FB_SYMBATTRIB_CONST			= &h00100000
	FB_SYMBATTRIB_OPTIONAL		= &h00200000	'' params only
	FB_SYMBATTRIB_TEMP			= &h00400000
    FB_SYMBATTRIB_DESCRIPTOR	= &h00800000
	FB_SYMBATTRIB_FUNCRESULT	= &h01000000
	FB_SYMBATTRIB_VIS_PUBLIC	= &h02000000	'' class members only
	FB_SYMBATTRIB_VIS_PRIVATE	= &h04000000    '' /
	FB_SYMBATTRIB_VIS_PROTECTED	= &h08000000    '' /

	FB_SYMBATTRIB_LITCONST		= FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL

	'' reuse - take care
	FB_SYMBATTRIB_PARAMINSTANCE	= FB_SYMBATTRIB_METHOD
	FB_SYMBATTRIB_STATICLOCALS	= FB_SYMBATTRIB_OPTIONAL
	FB_SYMBATTRIB_SUFFIXED		= FB_SYMBATTRIB_FUNCRESULT
end enum

'' parameter modes
enum FB_PARAMMODE
	FB_PARAMMODE_BYVAL 			= 1				'' must start at 1! used for mangling
	FB_PARAMMODE_BYREF
	FB_PARAMMODE_BYDESC
	FB_PARAMMODE_VARARG
end enum

'' call conventions
enum FB_FUNCMODE
	FB_FUNCMODE_STDCALL			= 1             '' ditto
	FB_FUNCMODE_STDCALL_MS						'' ms/vb-style: don't include the @n suffix
	FB_FUNCMODE_CDECL
	FB_FUNCMODE_PASCAL
end enum

const FB_FUNCMODE_DEFAULT		= FB_FUNCMODE_STDCALL
'' C standard types
enum FB_CSTDTYPE
	FB_CSTDTYPE_SIZET			= 1
end enum

'' options when adding new symbols
enum FB_SYMBOPT
	FB_SYMBOPT_NONE				= &h00000000

	FB_SYMBOPT_PRESERVECASE		= &h00000001
	FB_SYMBOPT_UNSCOPE			= &h00000002
	FB_SYMBOPT_DECLARING		= &h00000004
	FB_SYMBOPT_MOVETOGLOB		= &h00000008
	FB_SYMBOPT_RTL				= &h00000010
	FB_SYMBOPT_DOHASH			= &h00000020
	FB_SYMBOPT_CREATEALIAS		= &h00000040
	FB_SYMBOPT_NODUPCHECK       = &h00000080
end enum

'' options when looking up symbols
enum FB_SYMBLOOKUPOPT
	FB_SYMBLOOKUPOPT_NONE    = &h00000000
	
	FB_SYMBLOOKUPOPT_PROPGET = &h00000001
	FB_SYMBLOOKUPOPT_BOP_OVL = &h00000002
end enum

''
enum FB_MANGLING
	FB_MANGLING_BASIC
	FB_MANGLING_CDECL
	FB_MANGLING_STDCALL
	FB_MANGLING_STDCALL_MS
	FB_MANGLING_CPP
	FB_MANGLING_PASCAL
end enum

type FBSYMBOL_ as FBSYMBOL

#ifndef ASTNODE_
type ASTNODE_ as ASTNODE
#endif

#ifndef EMIT_NODE_
type EMIT_NODE_ as EMIT_NODE
#endif

''
type FBSYMLIST
	head			as FBSYMBOL_ ptr
	tail			as FBSYMBOL_ ptr
end type

type FBARRAYDIM
	lower			as integer
	upper			as integer
end type

type FBVARDIM
	lower			as integer
	upper			as integer
	next			as FBVARDIM ptr
end type

''
type FBSYMCHAIN
	sym				as FBSYMBOL_ ptr			'' first symbol
	next			as FBSYMCHAIN ptr
	isimport		as integer

	'' all fields below are only set when importing (with USING) a ns
	prev			as FBSYMCHAIN ptr
	item			as HASHITEM ptr
	imp_next		as FBSYMCHAIN ptr
end type

''
type FBHASHTB
	owner			as FBSYMBOL_ ptr            '' back link
	tb				as THASH
	prev			as FBHASHTB ptr				'' prev node in the current hash tbs lookup list
	next			as FBHASHTB ptr				'' next  //
end type

type FBSYMHASH
	tb				as FBHASHTB ptr             '' parent's hash tb
	item			as HASHITEM ptr				'' hash item, for fast deletion
	index			as uinteger					'' ditto
	prev			as FBSYMBOL_ ptr			'' prev duplicated symbol
	next			as FBSYMBOL_ ptr			'' next //
end type

''
type FBSYMBOLTB
    owner			as FBSYMBOL_ ptr			'' back link
    head			as FBSYMBOL_ ptr			'' first node
    tail			as FBSYMBOL_ ptr			'' last node
end type

''
type FBNAMESPC_EXT
    implist			as FBSYMLIST  				'' all namespaces imported by this ns
    explist			as FBSYMLIST  				'' all namespaces importing this ns
    cnt				as integer					'' times this ns was imported/nested
    impsym_head		as FBSYMCHAIN ptr			'' imported symbols by the last USING
    impsym_tail		as FBSYMCHAIN ptr			'' /
end type

type FBNAMESPC
    symtb			as FBSYMBOLTB
    hashtb			as FBHASHTB
    ext				as FBNAMESPC_EXT ptr
end type

union FBVALUE
	str				as FBSYMBOL_ ptr
	int				as integer
	uint			as uinteger
	float			as double
	long			as longint
	ulong			as ulongint
end union

'' keyword
type FBS_KEYWORD
	id				as integer
	tkclass			as FB_TKCLASS
end type

'' define or macro
type FB_DEFPARAM
	name			as zstring ptr
	num				as integer
	next			as FB_DEFPARAM ptr
end type

enum FB_DEFTOK_TYPE
	FB_DEFTOK_TYPE_PARAM
	FB_DEFTOK_TYPE_PARAMSTR
	FB_DEFTOK_TYPE_TEX
	FB_DEFTOK_TYPE_TEXW
end enum

type FB_DEFTOK
	type			as FB_DEFTOK_TYPE

	union
		text		as zstring ptr
		textw		as wstring ptr
		paramnum	as integer
	end union

	prev			as FB_DEFTOK ptr
	next			as FB_DEFTOK ptr
end type

type FBS_DEFINE
	params			as integer
	paramhead 		as FB_DEFPARAM ptr

	union
		tokhead		as FB_DEFTOK ptr			'' only if args > 0
		text		as zstring ptr				'' //           = 0
		textw		as wstring ptr
	end union

	isargless		as integer
    flags           as integer          		'' flags:
                                        		'' bit    meaning
                                        		'' 0      1=numeric, 0=string
	proc			as function( ) as string
end type

'' forward definition
type FBFWDREF
	ref				as FBSYMBOL_ ptr
	prev			as FBFWDREF ptr
end type

type FBS_FWDREF
	refs			as integer
	reftail			as FBFWDREF ptr
end type

'' label
type FBS_LABEL
	parent			as FBSYMBOL_ ptr			'' parent block, not always a proc
	declared		as integer
	stmtnum			as integer					'' can't use colnum as it's unreliable
end type

'' structure
enum FB_UDTOPT
	FB_UDTOPT_ISUNION			= &h0001
	FB_UDTOPT_ISANON			= &h0002
	FB_UDTOPT_HASPTRFIELD		= &h0004
	FB_UDTOPT_HASCTORFIELD		= &h0008
	FB_UDTOPT_HASDTORFIELD		= &h0010
	FB_UDTOPT_HASRECBYVALPARAM  = &h0020
	FB_UDTOPT_HASRECBYVALRES 	= &h0040
	FB_UDTOPT_HASGETPROPERTY	= &h0080
	FB_UDTOPT_HASSETPROPERTY	= &h0100
	FB_UDTOPT_HASIDXGETPROPERTY	= &h0200
	FB_UDTOPT_HASIDXSETPROPERTY	= &h0400
	FB_UDTOPT_HASKWDFIELD		= &h0800
end enum

type FB_STRUCT_DBG
	typenum			as integer
end type

type FB_ANON_METHODS
	ctor_head		as FBSYMBOL_ ptr
	defctor			as FBSYMBOL_ ptr			'' default ctor
	copyctor		as FBSYMBOL_ ptr			'' copy ctor
	dtor			as FBSYMBOL_ ptr			'' destructor
	clone			as FBSYMBOL_ ptr
end type

type FB_STRUCTEXT
	anon			as FB_ANON_METHODS
	opovlTb ( _
				0 to AST_OP_SELFOPS-1 _
			) 		as FBSYMBOL_ ptr
end type

type FBS_STRUCT
	'' extends FBNAMESCP
	ns 				as FBNAMESPC

	anonparent		as FBSYMBOL_ ptr
	elements		as integer
	lfldlen			as integer					'' largest field len
	unpadlgt		as integer					'' unpadded len
	options			as short					'' FB_UDTOPT
	bitpos			as ubyte
	align			as ubyte
	ret_dtype		as FB_DATATYPE				'' the type this struct is returned from procs
	dbg				as FB_STRUCT_DBG
	ext				as FB_STRUCTEXT ptr
end type

type FBS_BITFLD
	bitpos			as integer
	bits			as integer
end type

'' enumeration
type FBS_ENUM
	'' extends FBNAMESPC
	ns				as FBNAMESPC

	elements		as integer
	dbg				as FB_STRUCT_DBG
end type

'' constant
type FBS_CONST
	val				as FBVALUE
end type

''
type FB_CALL_ARG								'' used by overloaded function calls
	expr			as ASTNODE_ ptr
	mode			as FB_PARAMMODE
	next			as FB_CALL_ARG ptr
end type

type FB_CALL_ARG_LIST
	args			as integer
	head			as FB_CALL_ARG ptr
	tail			as FB_CALL_ARG ptr
end type

'' function param
type FBS_PARAM
	mode			as FB_PARAMMODE
	var				as FBSYMBOL_ ptr			'' link to decl var in func bodies
	optexpr			as ASTNODE_ ptr				'' default value
end type

'' function
type FBRTLCALLBACK as function( byval sym as FBSYMBOL_ ptr ) as integer

type FB_PROCOVL
	minparams		as short
	maxparams		as short
	next			as FBSYMBOL_ ptr
end type

type FB_PROCSTK
	argofs			as integer
	localofs		as integer
	localmax		as integer
end type

type FB_PROCDBG
	iniline			as integer					'' sub|function
	endline			as integer					'' end sub|function
	incfile			as zstring ptr
end type

type FB_PROCERR
	lasthnd			as FBSYMBOL_ ptr			'' last error handler
	lastmod			as FBSYMBOL_ ptr			'' last module name
	lastfun			as FBSYMBOL_ ptr			'' last function name
end type

type FB_PROCOPOVL
	op				as AST_OP
end type

type FB_DTORWRAPPER
	proc			as FBSYMBOL_ ptr
	sym				as FBSYMBOL_ ptr			'' for symbol
end type

enum FB_PROCSTATS
	FB_PROCSTATS_RETURNUSED		= &h0001
	FB_PROCSTATS_ASSIGNUSED		= &h0002
	FB_PROCSTATS_GOSUBUSED		= &h0004
end enum

type FB_PROCGSB
	ctx				as FBSYMBOL_ ptr			'' local pointer for gosub stack
end type

type FB_PROCEXT
	res				as FBSYMBOL_ ptr			'' result, if any
	stk				as FB_PROCSTK 				'' to keep track of the stack frame
	dbg				as FB_PROCDBG 				'' debugging
	err				as FB_PROCERR
	opovl			as FB_PROCOPOVL
	statdtor		as TLIST ptr				'' list of static instances with dtors
	stats			as FB_PROCSTATS
	stmtnum			as integer
	priority		as integer
	gosub			as FB_PROCGSB
end type

type FB_PROCRTL
	callback		as FBRTLCALLBACK
end type

enum FB_PROC_RETURN_METHOD
	FB_RETURN_FPU
	FB_RETURN_SSE
	FB_RETURN_DEFAULT			'' if none specified, take from the proto
end enum


type FBS_PROC
	symtb			as FBSYMBOLTB				'' local symbols table
	params			as short
	optparams		as short					'' number of optional/default params
	paramtb			as FBSYMBOLTB				'' parameters symbol tb
	mode			as FB_FUNCMODE				'' calling convention
	real_dtype		as FB_DATATYPE				'' used with STRING and UDT functions
	lib				as FBS_LIB ptr
	lgt				as integer					'' parameters length (in bytes)
	returnMethod		as FB_PROC_RETURN_METHOD
	rtl				as FB_PROCRTL
	ovl				as FB_PROCOVL				'' overloading
	ext				as FB_PROCEXT ptr           '' extra fields, not used with prototypes
end type

'' scope
type FB_SCOPEDBG
	iniline			as integer					'' scope
	endline			as integer					'' end scope
	inilabel		as FBSYMBOL_ ptr
	endlabel		as FBSYMBOL_ ptr
end type

type FB_SCOPEEMIT
	baseofs			as integer
end type

type FBS_SCOPE
	backnode		as ASTNODE_ ptr
	symtb			as FBSYMBOLTB
	dbg				as FB_SCOPEDBG
	emit			as FB_SCOPEEMIT
end type

'' variable
type FBS_ARRAY
	dims			as integer
	dimhead 		as FBVARDIM ptr
	dimtail			as FBVARDIM ptr
	dif				as integer
	elms			as integer
	desc			as FBSYMBOL_ ptr
	has_ellipsis    as integer
end type

type FBVAR_DESC
	array			as FBSYMBOL_ ptr			'' back-link
end type

type FBS_VAR
	union
		littext		as zstring ptr
		littextw	as wstring ptr
		initree		as ASTNODE_ ptr
	end union
	array			as FBS_ARRAY
	desc			as FBVAR_DESC
	stmtnum			as integer					'' can't use colnum as it's unreliable

	align			as integer					'' 0 = use default alignment

end type

'' namespace
type FBS_NAMESPACE
	'' extends FBNAMESPC
	ns				as FBNAMESPC

	cnt				as integer					'' times this ns was re-opened
    last_tail		as FBSYMBOL_ ptr			'' point to last tail
end type

'' namespace import (USING)
type FBS_NSIMPORT
	'' imported ns (src)
	imp_ns			as FBSYMBOL_ ptr
	imp_prev		as FBSYMBOL_ ptr
	imp_next		as FBSYMBOL_ ptr
	'' exported ns (dst)
	exp_ns			as FBSYMBOL_ ptr
	exp_prev		as FBSYMBOL_ ptr
	exp_next		as FBSYMBOL_ ptr
end type

''
type FB_SYMBID
	name			as zstring ptr				'' upper-cased name, shared by hash tb
	alias			as zstring ptr              '' alias/preserved (if EXTERN was used) name
	mangled			as zstring ptr				'' mangled name
end type

''
type FBSYMBOL
	class			as FB_SYMBCLASS
	attrib			as FB_SYMBATTRIB
	stats			as FB_SYMBSTATS

	id				as FB_SYMBID

	typ				as FB_DATATYPE
	subtype			as FBSYMBOL ptr

	scope			as ushort
	mangling		as short 					'' FB_MANGLING

	lgt				as integer
	ofs				as integer					'' for local vars, args, UDT's and fields

	union
		var_		as FBS_VAR
		con			as FBS_CONST
		udt			as FBS_STRUCT
		bitfld		as FBS_BITFLD
		enum_		as FBS_ENUM
		proc		as FBS_PROC
		param		as FBS_PARAM
		lbl			as FBS_LABEL
		def			as FBS_DEFINE
		key			as FBS_KEYWORD
		fwd			as FBS_FWDREF
		scp			as FBS_SCOPE
		nspc		as FBS_NAMESPACE
		nsimp 		as FBS_NSIMPORT
	end union

	hash			as FBSYMHASH				'' hash tb (namespace) it's part of

	symtb			as FBSYMBOLTB ptr			'' symbol tb it's part of

	parent          as FBSYMBOL ptr

	prev			as FBSYMBOL ptr				'' next in symbol tb list
	next			as FBSYMBOL ptr             '' prev /
end type

type FBHASHTBLIST
	head			as FBHASHTB ptr
	tail			as FBHASHTB ptr
end type

type SYMB_DEF_PARAM
	item			as HASHITEM ptr
	index			as uinteger
end type

type SYMB_DEF_CTX
	paramlist		as TLIST					'' define parameters
	toklist			as TLIST					'' define tokens

	'' macros only..
	param			as integer					'' param count
    paramhash		as THASH
    hash(0 to FB_MAXDEFINEARGS-1) as SYMB_DEF_PARAM
end type

type SYMB_OVLOP
	head			as FBSYMBOL ptr				'' head proc
end type

type FB_GLOBCTORLIST_ITEM
	sym				as FBSYMBOL ptr
	next			as FB_GLOBCTORLIST_ITEM ptr
end type

type FB_GLOBCTORLIST
	head			as FB_GLOBCTORLIST_ITEM ptr
	tail			as FB_GLOBCTORLIST_ITEM ptr
	list			as TLIST
end type

type SYMBCTX
	inited			as integer

	symlist			as TLIST					'' (of FBSYMBOL)
	hashlist		as FBHASHTBLIST
	chainlist		as TCLIST					'' (of FBSYMHASH)

	globnspc		as FBSYMBOL					'' global namespace

	namespc			as FBSYMBOL ptr				'' current ns
	hashtb			as FBHASHTB ptr				'' current hash tb
	symtb			as FBSYMBOLTB ptr			'' current symbol tb

	neststk			as TSTACK					'' nest stack (namespace/class nesting)
	imphashtb		as THASH					'' imported symbol (USING) tb
	imphashlist		as TLIST					'' (of FBSYMHASH)

	namepool		as TPOOL

	liblist 		as TLIST					'' libraries
	libhash			as THASH
	libpathlist 	as TLIST					'' library paths
	libpathhash		as THASH

	dimlist			as TLIST					'' array dimensions

	fwdlist			as TLIST					'' forward typedef refs

	nsextlist		as TLIST					'' of FBNAMESPC_EXT

	fwdrefcnt 		as integer

	def				as SYMB_DEF_CTX				'' #define context

	lastlbl			as FBSYMBOL ptr

	globctorlist	as FB_GLOBCTORLIST			'' global ctors list
	globdtorlist	as FB_GLOBCTORLIST			'' global dtors list

	globOpOvlTb ( _
					0 to AST_OPCODES-1 _
				)	as SYMB_OVLOP				'' global operator overloading
end type

type SYMB_DATATYPE
	class			as FB_DATACLASS				'' INTEGER, FPOINT
	size			as integer					'' in bytes
	bits			as integer					'' number of bits
	signed			as integer					'' TRUE or FALSE
	remaptype		as FB_DATATYPE				'' remapped type for ENUM, POINTER, etc
	name			as zstring ptr
end type


#include once "inc\ast.bi"

declare sub symbInit _
	( _
		byval ismain as integer _
	)

declare sub symbEnd _
	( _
		_
	)

declare sub symbDataInit _
	( _
		_
	)

declare sub symbDataEnd _
	( _
		_
	)

declare function symbLookup _
	( _
		byval id as zstring ptr, _
		byref tk as FB_TOKEN, _
		byref tk_class as FB_TKCLASS, _
		byval preserve_case as integer = FALSE _
	) as FBSYMCHAIN ptr

declare function symbLookupAt _
	( _
		byval ns as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval preserve_case as integer = FALSE, _
		byval search_imports as integer = TRUE _
	) as FBSYMCHAIN ptr

declare function symbFindByClass _
	( _
		byval chain as FBSYMCHAIN ptr, _
		byval class as integer _
	) as FBSYMBOL ptr

declare function symbFindVarBySuffix _
	( _
		byval chain as FBSYMCHAIN ptr, _
		byval suffix as integer _
	) as FBSYMBOL ptr

declare function symbFindVarByDefType _
	( _
		byval chain as FBSYMCHAIN ptr, _
		byval dtype as integer _
	) as FBSYMBOL ptr

declare function symbFindVarByType _
	( _
		byval chain as FBSYMCHAIN ptr, _
		byval dtype as integer _
	) as FBSYMBOL ptr

declare function symbLookupByNameAndClass _
	( _
		byval ns as FBSYMBOL ptr, _
		byval symbol as zstring ptr, _
		byval class as integer, _
		byval preservecase as integer = FALSE, _
		byval search_imports as integer = TRUE _
	) as FBSYMBOL ptr

declare function symbLookupByNameAndSuffix _
	( _
		byval ns as FBSYMBOL ptr, _
		byval symbol as zstring ptr, _
		byval suffix as integer, _
		byval preservecase as integer = FALSE, _
		byval search_imports as integer = TRUE _
	) as FBSYMBOL ptr

declare function symbFindOverloadProc _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval options as FB_SYMBLOOKUPOPT = FB_SYMBLOOKUPOPT_NONE _
	) as FBSYMBOL ptr

declare function symbFindOpOvlProc _
	( _
		byval op as AST_OP, _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbFindClosestOvlProc _
	( _
		byval proc as FBSYMBOL ptr, _
		byval params as integer, _
		byval arg_head as FB_CALL_ARG ptr, _
		byval err_num as FB_ERRMSG ptr, _
		byval options as FB_SYMBLOOKUPOPT = FB_SYMBLOOKUPOPT_NONE _
	) as FBSYMBOL ptr

declare function symbFindBopOvlProc _
	( _
		byval op as AST_OP, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

declare function symbFindSelfBopOvlProc _
	( _
		byval op as AST_OP, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

declare function symbFindUopOvlProc _
	( _
		byval op as AST_OP, _
		byval l as ASTNODE ptr, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

declare function symbFindSelfUopOvlProc _
	( _
		byval op as AST_OP, _
		byval l as ASTNODE ptr, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

declare function symbFindCastOvlProc _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

declare function symbFindCtorOvlProc _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval arg_mode as FB_PARAMMODE, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

declare function symbFindCtorProc _
	( _
		byval head_proc as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbGetProcResult _
	( _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbGetUDTLen _
	( _
		byval udt as FBSYMBOL ptr, _
		byval unpadlen as integer = TRUE _
	) as integer

declare function symbGetConstValueAsStr _
	( _
		byval s as FBSYMBOL ptr _
	) as string

declare function symbCalcParamLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as integer _
	) as integer

declare sub symbListLibsEx _
	( _
		byval srclist as TLIST ptr, _
		byval srchash as THASH ptr, _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr, _
		byval delnodes as integer _
	)

declare function symbAddKeyword _
	( _
		byval symbol as zstring ptr, _
		byval id as integer, _
		byval class as integer, _
		byval hashtb as FBHASHTB ptr = NULL, _
		byval dtype as integer = FB_DATATYPE_INVALID, _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as FBSYMBOL ptr

declare function symbAddDefine _
	( _
		byval symbol as zstring ptr, _
		byval text as zstring ptr, _
		byval lgt as integer, _
		byval isargless as integer = FALSE, _
		byval proc as function() as string = NULL, _
		byval flags as integer = 0 _
	) as FBSYMBOL ptr

declare function symbAddDefineW _
	( _
		byval symbol as zstring ptr, _
		byval text as wstring ptr, _
		byval lgt as integer, _
		byval isargless as integer = FALSE, _
		byval proc as function() as string = NULL, _
		byval flags as integer = 0 _
	) as FBSYMBOL ptr

declare function symbAddDefineMacro _
	( _
		byval symbol as zstring ptr, _
		byval tokhead as FB_DEFTOK ptr, _
		byval params as integer, _
		byval paramhead as FB_DEFPARAM ptr _
	) as FBSYMBOL ptr

declare function symbAddDefineParam _
	( _
		byval lastparam as FB_DEFPARAM ptr, _
		byval symbol as zstring ptr _
	) as FB_DEFPARAM ptr

declare function symbAddDefineTok _
	( _
		byval lasttok as FB_DEFTOK ptr, _
		byval dtype as FB_DEFTOK_TYPE _
	) as FB_DEFTOK ptr

declare function symbDelDefineTok _
	( _
		byval tok as FB_DEFTOK ptr _
	) as FB_DEFTOK ptr

declare function symbAddFwdRef _
	( _
		byval id as zstring ptr _
	) as FBSYMBOL ptr

declare function symbAddTypedef _
	( _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as integer _
	) as FBSYMBOL ptr

declare function symbAddLabel _
	( _
		byval symbol as zstring ptr, _
		byval options as FB_SYMBOPT = FB_SYMBOPT_DECLARING _
	) as FBSYMBOL ptr

declare function symbAddVar _
	( _
		byval symbol as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval attrib as integer _
	) as FBSYMBOL ptr

declare function symbAddVarEx _
	( _
		byval symbol as zstring ptr, _
		byval aliasname as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as integer, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval attrib as integer, _
		byval options as FB_SYMBOPT = FB_SYMBOPT_NONE _
	) as FBSYMBOL ptr

declare function symbAddTempVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL, _
		byval doalloc as integer = FALSE, _
		byval checkstatic as integer = TRUE _
	) as FBSYMBOL ptr

declare function symbAddArrayDesc _
	( _
		byval array as FBSYMBOL ptr, _
		byval dimensions as integer _
	) as FBSYMBOL ptr

declare function symbAddConst _
	( _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as FBVALUE ptr, _
		byval attrib as integer = FB_SYMBATTRIB_NONE _
	) as FBSYMBOL ptr

declare function symbStructBegin _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval isunion as integer, _
		byval align as integer _
	) as FBSYMBOL ptr

declare function symbAddField _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as integer, _
		byval bits as integer _
	) as FBSYMBOL ptr

declare sub symbInsertInnerUDT _
	( _
		byval parent as FBSYMBOL ptr, _
		byval inner as FBSYMBOL ptr _
	)

declare sub symbStructEnd _
	( _
		byval t as FBSYMBOL ptr _
	)

declare function symbAddEnum _
	( _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval attrib as integer _
	) as FBSYMBOL ptr

declare function symbAddEnumElement _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval value as integer, _
		byval attrib as integer _
	) as FBSYMBOL ptr

declare function symbAddProcParam _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as integer, _
		byval mode as integer, _
		byval attrib as FB_SYMBATTRIB, _
		byval optexpr as ASTNODE ptr _
	) as FBSYMBOL ptr

declare function symbAddProcResultParam _
	( _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbAddPrototype _
	( _
		byval proc as FBSYMBOL ptr, _
		byval symbol as zstring ptr, _
		byval aliasname as zstring ptr, _
		byval libname as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer, _
		byval mode as integer, _
		byval options as FB_SYMBOPT = FB_SYMBOPT_NONE _
	) as FBSYMBOL ptr

declare function symbAddProc _
	( _
		byval proc as FBSYMBOL ptr, _
		byval symbol as zstring ptr, _
		byval aliasname as zstring ptr, _
		byval libname as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer, _
		byval mode as integer _
	) as FBSYMBOL ptr

declare function symbAddOperator _
	( _
		byval proc as FBSYMBOL ptr, _
		byval op as AST_OP, _
		byval id_alias as zstring ptr, _
		byval libname as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer, _
		byval mode as integer, _
		byval options as FB_SYMBOPT = FB_SYMBOPT_NONE _
	) as FBSYMBOL ptr

declare function symbAddCtor _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id_alias as zstring ptr, _
		byval libname as zstring ptr, _
		byval attrib as integer, _
		byval mode as integer, _
		byval options as FB_SYMBOPT = FB_SYMBOPT_NONE _
	) as FBSYMBOL ptr

declare function symbAddProcPtr _
	( _
		byval proc as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as integer _
	) as FBSYMBOL ptr

declare function symbPreAddProc _
	( _
		byval symbol as zstring ptr _
	) as FBSYMBOL ptr

declare function symbAddProcResult _
	( _
		byval f as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbAddLibEx _
	( _
		byval liblist as TLIST ptr, _
		byval libhash as THASH ptr, _
		byval libname as zstring ptr,  _
		byval isdefault as integer = FALSE _
	) as FBS_LIB ptr

declare function symbAddParam _
	( _
		byval id as zstring ptr, _
		byval param as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symAddProcInstancePtr _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbCalcProcParamLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as FB_PARAMMODE _
	) as integer

declare function symbCalcProcParamsLen _
	( _
		byval proc as FBSYMBOL ptr _
	) as integer

declare function symbAddScope _
	( _
		byval backnode as ASTNODE ptr _
	) as FBSYMBOL ptr

declare function symbAddBitField _
	( _
		byval bitpos as integer, _
		byval bits as integer, _
		byval dtype as integer, _
		byval lgt as integer _
	) as FBSYMBOL ptr

declare function symbAddNamespace _
	( _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr _
	) as FBSYMBOL ptr

declare sub symbAddToFwdRef _
	( _
		byval f as FBSYMBOL ptr, _
		byval ref as FBSYMBOL ptr _
	)

declare sub symbRecalcUDTSize _
	( _
		byval t as FBSYMBOL ptr _
	)

declare sub symbSetArrayDimTb _
	( _
		byval s as FBSYMBOL ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	)

declare sub symbSetProcIncFile _
	( _
		byval p as FBSYMBOL ptr, _
		byval incf as zstring ptr _
	)

declare sub symbDelSymbolTb _
	( _
		byval tb as FBSYMBOLTB ptr, _
		byval hashonly as integer _
	)

declare sub symbDelScopeTb _
	( _
		byval scp as FBSYMBOL ptr _
	)

declare sub symbDelSymbol _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	)

declare function symbDelKeyword _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	) as integer

declare function symbDelDefine _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	) as integer

declare sub symbDelLabel _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	)

declare sub symbDelVar _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	)

declare sub symbDelPrototype _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	)

declare sub symbDelEnum _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	)

declare sub symbDelStruct _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	)

declare sub symbDelConst _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	)

declare sub symbDelLibEx _
	( _
		byval liblist as TLIST ptr, _
		byval libhash as THASH ptr, _
		byval l as FBS_LIB ptr _
	)

declare sub symbDelScope _
	( _
		byval scp as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	)

declare sub symbDelNamespace _
	( _
		byval ns as FBSYMBOL ptr, _
		byval is_tbdel as integer = FALSE _
	)

declare function symbNewSymbol _
	( _
		byval options as FB_SYMBOPT, _
		byval s as FBSYMBOL ptr, _
		byval symtb as FBSYMBOLTB ptr, _
		byval hashtb as FBHASHTB ptr, _
		byval class as FB_SYMBCLASS, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as FBSYMBOL ptr

declare sub symbFreeSymbol _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub symbFreeSymbol_RemOnly _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub symbFreeSymbol_UnlinkOnly _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub symbDelFromHash _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub symbDelFromChainList _
	( _
		byval s as FBSYMBOL ptr _
	)

declare function symbNewArrayDim _
	( _
		byval s as FBSYMBOL ptr, _
		byval lower as integer, _
		byval upper as integer _
	) as FBVARDIM ptr

declare function symbCalcLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval unpadlen as integer = FALSE _
	) as integer

declare function symbAllocFloatConst _
	( _
		byval value as double, _
		byval dtype as integer _
	) as FBSYMBOL ptr


declare function symbAllocIntConst _
	( _
		byval value as integer, _
		byval dtype as integer _
	) as FBSYMBOL ptr

declare function symbAllocLongIntConst _
	( _
		byval value as longint, _
		byval dtype as integer _
	) as FBSYMBOL ptr


declare function symbAllocStrConst _
	( _
		byval sname as zstring ptr, _
		byval lgt as integer _
	) as FBSYMBOL ptr

declare function symbAllocWstrConst _
	( _
		byval sname as wstring ptr, _
		byval lgt as integer _
	) as FBSYMBOL ptr

declare function symbCalcArrayElements overload _
	( _
		byval s as FBSYMBOL ptr, _
		byval n as FBVARDIM ptr = NULL _
	) as integer

declare function symbCalcArrayElements _
	( _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	) as integer

declare function symbCalcArrayDiff _
	( _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval lgt as integer _
	) as integer

declare function symbCheckLabels _
	( _
		_
	) as integer

declare function symbCheckLocalLabels _
	( _
		_
	) as integer

declare function symbCheckBitField _
	( _
		byval udt as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval lgt as integer, _
		byval bits as integer _
	) as integer

declare sub symbCheckFwdRef _
	( _
		byval s as FBSYMBOL ptr, _
		byval class as integer _
	)

declare function symbIsEqual _
	( _
		byval sym1 as FBSYMBOL ptr, _
		byval sym2 as FBSYMBOL ptr _
	) as integer

declare function symbIsProcOverloadOf _
	( _
		byval proc as FBSYMBOL ptr, _
		byval parent as FBSYMBOL ptr _
	) as integer

declare function symbIsArray _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

declare function symbIsString _
	( _
		byval dtype as integer _
	) as integer

declare function symbGetVarHasCtor _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

declare function symbGetVarHasDtor _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

declare function symbMaxDataType _
	( _
		byval dtype1 as integer, _
		byval dtype2 as integer _
	) as integer

declare function symbGetSignedType _
	( _
		byval dtype as integer _
	) as integer

declare function symbGetUnsignedType _
	( _
		byval dtype as integer _
	) as integer

declare function symbRemapType _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

declare function symbProcAllocLocalVars _
	( _
		byval proc as FBSYMBOL ptr _
	) as integer

declare function symbScopeAllocLocals _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

declare sub symbHashListAdd _
	( _
		byval hashtb as FBHASHTB ptr _
	)

declare sub symbHashListAddBefore _
	( _
		byval lasttb as FBHASHTB ptr, _
		byval hashtb as FBHASHTB ptr _
	)

declare sub symbHashListDel _
	( _
		byval hashtb as FBHASHTB ptr _
	)

declare function symbNamespaceImport _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer

declare sub symbNamespaceRemove _
	( _
		byval sym as FBSYMBOL ptr, _
		byval hashonly as integer, _
		byval is_tbdel as integer = FALSE _
	)

declare sub symbNamespaceReImport _
	( _
		byval ns as FBSYMBOL ptr _
	)

declare sub symbNestBegin _
	( _
		byval sym as FBSYMBOL ptr, _
		byval insert_chain as integer = FALSE _
	)

declare sub symbNestEnd _
	( _
		byval remove_chain as integer = FALSE _
	)

declare function symbCanDuplicate _
	( _
		byval head_sym as FBSYMBOL ptr, _
		byval s as FBSYMBOL ptr _
	) as integer

declare function symbGetMangledName _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr

declare function symbGetDBGName _
	( _
		byval sym as FBSYMBOL ptr _
	) as zstring ptr

declare sub symbSetName _
	( _
		byval s as FBSYMBOL ptr, _
		byval name_ as zstring ptr _
	)

declare sub symbMangleInitAbbrev _
	( _
	)

declare sub symbMangleEndAbbrev	_
	( _
	)

declare function symbMangleType _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as string

declare function symbMangleParam _
	( _
		byval param as FBSYMBOL ptr _
	) as string

declare function symbDemangleFunctionPtr _
	( _
		byval proc as FBSYMBOL ptr _
	) as zstring ptr

declare function symbDemangleMethod _
	( _
		byval proc as FBSYMBOL ptr _
	) as zstring ptr

declare function symbTypeToStr _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as integer = 0 _
	) as zstring ptr


declare function symbGetDefType _
	( _
		byval symbol as zstring ptr _
	) as integer

declare sub symbSetDefType _
	( _
		byval ichar as integer, _
		byval echar as integer, _
		byval typ as integer _
	)

declare function symbGetCompOpOvlHead _
	( _
		byval sym as FBSYMBOL ptr, _
		byval op as AST_OP _
	) as FBSYMBOL ptr

declare sub symbSetCompOpOvlHead _
	( _
		byval syn as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

declare sub symbCheckCompClone _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

declare function symbGetCompCtorHead _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare sub symbSetCompCtorHead _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

declare sub symbCheckCompCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

declare function symbGetCompDefCtor _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbGetCompCopyCtor _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbGetCompDtor _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare sub symbSetCompDtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

declare function symbGetCompCloneProc _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare sub symbCompAddDefCtor _
	( _
		byval sym as FBSYMBOL ptr _
	) 
	
declare sub symbCompAddDefDtor _
	( _
		byval sym as FBSYMBOL ptr _
	) 
	
declare sub symbCompAddDefMembers _
	( _
		byval sym as FBSYMBOL ptr _
	)

declare function symbAddGlobalCtor _
	( _
		byval proc as FBSYMBOL ptr _
	) as FB_GLOBCTORLIST_ITEM ptr

declare function symbAddGlobalDtor _
	( _
		byval proc as FBSYMBOL ptr _
	) as FB_GLOBCTORLIST_ITEM ptr

declare function symbCloneSymbol _
	( _
		byval s as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbCloneConst _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbCloneVar _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbCloneStruct _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbCloneLabel _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbGetCStdType _
	( _
		byval ctype as FB_CSTDTYPE _
	) as integer

declare function symbIsChildOf _
	( _
		byval sym as FBSYMBOL ptr, _
		byval parent as FBSYMBOL ptr _
	) as integer

declare function symbCheckAccess _
	( _
		byval parent as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	) as integer

declare function symbGetFullProcName _
	( _
		byval proc as FBSYMBOL ptr _
	) as zstring ptr

declare function symbGetUDTFirstElm _
	( _
		byval parent as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbGetUDTNextElm _
	( _
		byval sym as FBSYMBOL ptr, _
		byval check_union as integer = FALSE, _
		byref elms as integer = 0 _
	) as FBSYMBOL ptr

declare function symbGetEnumFirstElm _
	( _
		byval parent as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare function symbGetEnumNextElm _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

declare sub symbCompDelImportList _
	( _
		byval sym as FBSYMBOL ptr _
	)

declare sub symbHashListInsertNamespace _
	( _
		byval ns as FBSYMBOL ptr, _
		byval src_head as FBSYMBOL ptr _
	)

declare sub symbHashListRemoveNamespace _
	( _
		byval ns as FBSYMBOL ptr _
	)

declare function symbGetDefaultCallConv _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

declare function symbVarCheckAccess _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

declare function symbCheckConstAssign _
	( _
		byval ldtype as FB_DATATYPE, _
		byval rdtype as FB_DATATYPE, _
		byval lsubtype as FBSYMBOL ptr, _
		byval rsubtype as FBSYMBOL ptr, _
		byval mode as FB_PARAMMODE = 0, _
		byref misses as integer = 0 _
	) as integer


''
'' macros
''

'':::::
#macro symbHashTbInit _
	( _
		_hashtb, _
		_owner, _
		_nodes _
	)

	_hashtb.owner = _owner
	_hashtb.prev = NULL
	_hashtb.next = NULL

	if( (_nodes) <> 0 ) then
		hashNew( @_hashtb.tb, _nodes )
	end if

#endmacro

'':::::
#macro symbSymbTbInit _
	( _
		_symtb, _
		_owner _
	)

	_symtb.owner = _owner
	_symtb.head = NULL
	_symtb.tail = NULL

#endmacro

'':::::
#macro symbHashListMove _
	( _
		hashtb _
	)

	symbHashListDel( hashtb )
	symbHashListAdd( hashtb )

#endmacro

'':::::
#macro symbHashListMoveBefore _
	( _
		lasttb, _
		hashtb _
	)

	symbHashListDel( hashtb )
	symbHashListAddBefore( lasttb, hashtb )

#endmacro

#define symbGetGlobalNamespc( ) symb.globnspc

#define symbIsGlobalNamespc( ) (symb.namespc = @symbGetGlobalNamespc( ))

#define symbGetGlobalTb( ) symbGetGlobalNamespc( ).nspc.ns.symtb

#define symbGetGlobalTbHead( ) symbGetGlobalTb( ).head

#define symbGetGlobalHashTb( ) symbGetGlobalNamespc( ).nspc.ns.hashtb

#define symbGetCurrentNamespc( ) symb.namespc

#define symbSetCurrentNamespc(ns) symb.namespc = ns

#define symbGetCurrentSymTb( ) symb.symtb

#define symbSetCurrentSymTb(tb) symb.symtb = tb

#define symbGetCurrentHashTb( ) symb.hashtb

#define symbSetCurrentHashTb(tb) symb.hashtb = tb

#define symbGetGlobCtorListHead( ) symb.globctorlist.head

#define symbGetGlobDtorListHead( ) symb.globdtorlist.head

#define symbGetLibListHead( ) listGetHead( @symb.liblist )

#define symbGetLibPathListHead( ) listGetHead( @symb.libpathlist )

#define symbGetIsAccessed(s) ((s->stats and FB_SYMBSTATS_ACCESSED) <> 0)

#define symbSetIsAccessed(s) s->stats or= FB_SYMBSTATS_ACCESSED

#define symbGetVarIsAllocated(s) ((s->stats and FB_SYMBSTATS_VARALLOCATED) <> 0)

#define symbSetVarIsAllocated(s) s->stats or= FB_SYMBSTATS_VARALLOCATED

#define symbGetIsInitialized(s) ((s->stats and FB_SYMBSTATS_INITIALIZED) <> 0)

#define symbSetIsInitialized(s) s->stats or= FB_SYMBSTATS_INITIALIZED

#define symbGetIsDeclared(s) ((s->stats and FB_SYMBSTATS_DECLARED) <> 0)

#define symbSetIsDeclared(s) s->stats or= FB_SYMBSTATS_DECLARED

#define symbGetIsCalled(s) ((s->stats and FB_SYMBSTATS_CALLED) <> 0)

#define symbSetIsCalled(s) s->stats or= FB_SYMBSTATS_CALLED

#define symbGetIsRTL(s) ((s->stats and FB_SYMBSTATS_RTL) <> 0)

#define symbGetIsThrowable(s) ((s->stats and FB_SYMBSTATS_THROWABLE) <> 0)

#define symbSetIsThrowable(s) s->stats or= FB_SYMBSTATS_THROWABLE

#define symbGetIsParsed(s) ((s->stats and FB_SYMBSTATS_PARSED) <> 0)

#define symbSetIsParsed(s) s->stats or= FB_SYMBSTATS_PARSED

#define symbSetIsMock(s) s->stats or= FB_SYMBSTATS_MOCK

#define symbSetDontInit(s) s->stats or= FB_SYMBSTATS_DONTINIT

#define symbGetDontInit(s) ((s->stats and FB_SYMBSTATS_DONTINIT) <> 0)

#define symbGetIsMainProc(s) ((s->stats and FB_SYMBSTATS_MAINPROC) <> 0)

#define symbSetIsMainProc(s) s->stats or= FB_SYMBSTATS_MAINPROC

#define symbGetIsModLevelProc(s) ((s->stats and FB_SYMBSTATS_MODLEVELPROC) <> 0)

#define symbSetIsModLevelProc(s) s->stats or= FB_SYMBSTATS_MODLEVELPROC

#define symbGetIsFuncPtr(s) ((s->stats and FB_SYMBSTATS_FUNCPTR) <> 0)

#define symbSetIsFuncPtr(s) s->stats or= FB_SYMBSTATS_FUNCPTR

#define symbGetIsJumpTb(s) ((s->stats and FB_SYMBSTATS_JUMPTB) <> 0)

#define symbSetIsJumpTb(s) s->stats or= FB_SYMBSTATS_JUMPTB

#define symbGetIsUnique(s) ((s->stats and FB_SYMBSTATS_CANTDUP) <> 0)

#define symbSetIsUnique(s) s->stats or= FB_SYMBSTATS_CANTDUP

#define symbGetHasCtor(s) ((s->stats and FB_SYMBSTATS_HASCTOR) <> 0)

#define symbSetHasCtor(s) s->stats or= FB_SYMBSTATS_HASCTOR

#define symbGetHasCopyCtor(s) ((s->stats and FB_SYMBSTATS_HASCOPYCTOR) <> 0)

#define symbSetHasCopyCtor(s) s->stats or= FB_SYMBSTATS_HASCOPYCTOR

#define symbGetHasDtor(s) ((s->stats and FB_SYMBSTATS_HASDTOR) <> 0)

#define symbSetHasDtor(s) s->stats or= FB_SYMBSTATS_HASDTOR

#define symbGetHasVirtual(s) ((s->stats and FB_SYMBSTATS_HASVIRTUAL) <> 0)

#define symbSetHasVirtual(s) s->stats or= FB_SYMBSTATS_HASVIRTUAL

#define symbGetIsGlobalCtor(s) ((s->stats and FB_SYMBSTATS_GLOBALCTOR) <> 0)

#define symbSetIsGlobalCtor( s ) s->stats or= FB_SYMBSTATS_GLOBALCTOR or FB_SYMBSTATS_CALLED

#define symbGetIsGlobalDtor(s) ((s->stats and FB_SYMBSTATS_GLOBALDTOR) <> 0)

#define symbSetIsGlobalDtor( s ) s->stats or= FB_SYMBSTATS_GLOBALDTOR or FB_SYMBSTATS_CALLED

#define symbGetIsCtorInited(s) ((s->stats and FB_SYMBSTATS_CTORINITED) <> 0)

#define symbSetIsCtorInited(s) s->stats or= FB_SYMBSTATS_CTORINITED

#define symbGetCantUndef(s) ((s->stats and FB_SYMBSTATS_CANTUNDEF) <> 0)

#define symbSetCantUndef(s) s->stats or= FB_SYMBSTATS_CANTUNDEF

#define symbGetIsUnionField(s) ((s->stats and FB_SYMBSTATS_UNIONFIELD) <> 0)

#define symbSetIsUnionField(s) s->stats or= FB_SYMBSTATS_UNIONFIELD

#define symbGetIsRTLConst(s) ((s->stats and FB_SYMBSTATS_RTL_CONST) <> 0)

#define symbSetIsRTLConst(s) s->stats or= FB_SYMBSTATS_RTL_CONST

#define symbGetProcIsEmitted(s) ((s->stats and FB_SYMBSTATS_PROCEMITTED) <> 0)

#define symbSetProcIsEmitted(s) s->stats or= FB_SYMBSTATS_PROCEMITTED

#define symbGetStats(s) s->stats

#define symbGetLen(s) iif( s <> NULL, s->lgt, 0 )

#define symbGetStrLen(s) symbGetLen(s)

#define symbGetWstrLen(s) (cunsg(s->lgt) \ symbGetDataSize( FB_DATATYPE_WCHAR ))

#define symbGetFullType(s) s->typ
#define symbGetType(s) typeGetDtAndPtrOnly( symbGetFullType( s ) )

#define symbGetSubType(s) s->subtype

#define symbGetPtrCnt(s) typeGetPtrCnt( symbGetType( s ) )

#define symbGetClass(s) s->class

#define symbGetSymbtb(s) s->symtb

#define symbGetHashtb(s) s->hash.tb

#define symbGetParent(s) symbGetSymbtb(s)->owner

#define symbGetNamespace(s) symbGetHashtb(s)->owner

#define symbGetMangling(s) s->mangling

#define symbGetName(s) s->id.name

#define symbGetOfs(s) s->ofs

#define symbGetAttrib(s) s->attrib

#define symbSetAttrib(s,t) s->attrib = t

#define symbGetPrev(s) s->prev

#define symbGetNext(s) s->next

#define symbChainGetNext(c) c->next

#define symbIsVar(s) (s->class = FB_SYMBCLASS_VAR)

#define symbIsConst(s) (s->class = FB_SYMBCLASS_CONST)

#define symbIsProc(s) (s->class = FB_SYMBCLASS_PROC)

#define symbIsProcArg(s) (s->class = FB_SYMBCLASS_PARAM)

#define symbIsDefine(s) (s->class = FB_SYMBCLASS_DEFINE)

#define symbIsKeyword(s) (s->class = FB_SYMBCLASS_KEYWORD)

#define symbIsLabel(s) (s->class = FB_SYMBCLASS_LABEL)

#define symbIsEnum(s) (s->class = FB_SYMBCLASS_ENUM)

#define symbIsStruct(s) (s->class = FB_SYMBCLASS_STRUCT)

#define symbIsField(s) (s->class = FB_SYMBCLASS_FIELD)

#define symbIsTypedef(s) (s->class = FB_SYMBCLASS_TYPEDEF)

#define symbIsFwdRef(s) (s->class = FB_SYMBCLASS_FWDREF)

#define symbIsScope(s) (s->class = FB_SYMBCLASS_SCOPE)

#define symbIsNameSpace(s) (s->class = FB_SYMBCLASS_NAMESPACE)

#define symbGetConstVal(s) s->con.val

#define symbGetConstValStr(s) s->con.val.str

#define symbGetConstValInt(s) s->con.val.int

#define symbGetConstValFloat(s) s->con.val.float

#define symbGetConstValLong(s) s->con.val.long

#define symbGetDefineText(d) d->def.text

#define symbGetDefineTextW(d) d->def.textw

#define symbGetDefineHeadToken(d) d->def.tokhead

#define symbGetDefTokPrev(t) t->prev

#define symbGetDefTokNext(t) t->next

#define symbGetDefTokType(t) t->type

#define symbSetDefTokType(t,_typ) t->type = _typ

#define symbGetDefTokText(t) t->text

#define symbGetDefTokTextW(t) t->textw

#define symbGetDefTokParamNum(t) t->paramnum

#define symbSetDefTokParamNum(t,n) t->paramnum = n

#define symbGetDefineParams(d) d->def.params

#define symbGetDefineHeadParam(d) d->def.paramhead

#define symbGetDefParamNext(a) a->next

#define symbGetDefParamName(a) a->name

#define symbGetDefParamNum(a) a->num

#define symbGetDefineCallback(d) d->def.proc

#define symbGetDefineIsArgless(d) d->def.isargless

#define symbGetDefineFlags(d) d->def.flags

#define symbGetVarLitText(s) s->var_.littext

#define symbGetVarLitTextW(s) s->var_.littextw

#define symbGetVarStmt(s) s->var_.stmtnum

#define symbSetTypeIniTree(s, t) s->var_.initree = t

#define symbGetTypeIniTree(s) s->var_.initree

#define symbGetArrayDiff(s) s->var_.array.dif

#define symbGetArrayDimensions(s) s->var_.array.dims

#define symbSetArrayDimensions(s,d) s->var_.array.dims = d

#define symbGetArrayDescriptor(s) s->var_.array.desc

#define symbGetArrayOffset(s) s->var_.array.dif

#define symbGetArrayFirstDim(s) s->var_.array.dimhead

#define symbGetArrayElements(s) s->var_.array.elms

#define symbGetUDTSymbTbHead(s) s->udt.ns.symtb.head

#define symbGetUDTElmBitOfs(e) ( e->ofs * 8 + _
								 iif( e->typ = FB_DATATYPE_BITFIELD, _
									  e->subtype->bitfld.bitpos, _
									  0) )

#define symbGetUDTElmBitLen(e) iif( e->typ = FB_DATATYPE_BITFIELD, _
									e->subtype->bitfld.bits, _
									e->lgt * e->var_.array.elms * 8 )

#define symbGetUDTIsUnion(s) ((s->udt.options and FB_UDTOPT_ISUNION) <> 0)

#define symbGetUDTHasPtrField(s) ((s->udt.options and (FB_UDTOPT_HASPTRFIELD or FB_UDTOPT_HASCTORFIELD)) <> 0)

#define symbSetUDTHasCtorField(s) s->udt.options or= FB_UDTOPT_HASCTORFIELD

#define symbGetUDTHasCtorField(s) ((s->udt.options and FB_UDTOPT_HASCTORFIELD) <> 0)

#define symbSetUDTHasDtorField(s) s->udt.options or= FB_UDTOPT_HASDTORFIELD

#define symbGetUDTHasDtorField(s) ((s->udt.options and FB_UDTOPT_HASDTORFIELD) <> 0)

#define symbGetUDTIsAnon(s) ((s->udt.options and FB_UDTOPT_ISANON) <> 0)

#define symbGetUDTHasRecByvalParam(s) ((s->udt.options and FB_UDTOPT_HASRECBYVALPARAM) <> 0)

#define symbSetUDTHasRecByvalParam(s) s->udt.options or= FB_UDTOPT_HASRECBYVALPARAM

#define symbGetUDTHasRecByvalRes(s) ((s->udt.options and FB_UDTOPT_HASRECBYVALRES) <> 0)

#define symbSetUDTHasRecByvalRes(s) s->udt.options or= FB_UDTOPT_HASRECBYVALRES

#define symbGetUDTHasGetProp(s) ((s->udt.options and FB_UDTOPT_HASGETPROPERTY) <> 0)

#define symbSetUDTHasGetProp(s) s->udt.options or= FB_UDTOPT_HASGETPROPERTY

#define symbGetUDTHasSetProp(s) ((s->udt.options and FB_UDTOPT_HASSETPROPERTY) <> 0)

#define symbSetUDTHasSetProp(s) s->udt.options or= FB_UDTOPT_HASSETPROPERTY

#define symbGetUDTHasIdxGetProp(s) ((s->udt.options and FB_UDTOPT_HASIDXGETPROPERTY) <> 0)

#define symbSetUDTHasIdxGetProp(s) s->udt.options or= FB_UDTOPT_HASIDXGETPROPERTY

#define symbGetUDTHasIdxSetProp(s) ((s->udt.options and FB_UDTOPT_HASIDXSETPROPERTY) <> 0)

#define symbSetUDTHasIdxSetProp(s) s->udt.options or= FB_UDTOPT_HASIDXSETPROPERTY

#define symbGetUDTHasKwdField(s) ((s->udt.options and FB_UDTOPT_HASKWDFIELD) <> 0)

#define symbSetUDTHasKwdField(s) s->udt.options or= FB_UDTOPT_HASKWDFIELD

#define symbGetUDTAlign(s) s->udt.align

#define symbGetUDTElements(s) s->udt.elements

#define symbGetUDTUnpadLen(s) s->udt.unpadlgt

#define symbGetUdtSymbTb(s) s->udt.ns.symtb

#define symbGetUDTHashTb(s) s->udt.ns.hashtb

#define symbGetUDTAnonParent(s) s->udt.anonparent

#define symbGetUDTRetType(s) s->udt.ret_dtype

#define symbGetUDTOpOvlTb(s) s->udt.ext->opovlTb

#define symbGetUDTInRegister(s) iif( symbGetType( sym ) = FB_DATATYPE_STRUCT, _
									 typeGetDtAndPtrOnly( symbGetProcRealType( sym ) ) <> typeAddrOf( FB_DATATYPE_STRUCT ), TRUE )

#define symbGetEnumSymbTbHead(s) s->enum_.ns.symtb.head

#define symbGetEnumElements(s) s->enum_.elements

#define symbGetScope(s) s->scope

#define symbGetScopeSymbTb(s) s->scp.symtb

#define symbGetScopeSymbTbHead(s) s->scp.symtb.head

#define symbGetNamespaceSymbTb(s) s->nspc.ns.symtb

#define symbGetNamespaceTbHead(s) s->nspc.ns.symtb.head

#define symbGetNamespaceTbTail(s) s->nspc.ns.symtb.tail

#define symbGetNamespaceHashTb(s) s->nspc.ns.hashtb

#define symbGetNamespaceCnt(s) s->nspc.cnt

#define symbGetNamespaceLastTail(s) s->nspc.last_tail

#define symbGetLabelIsDeclared(l) l->lbl.declared

#define symbSetLabelIsDeclared(l) l->lbl.declared = TRUE

#define symbGetLabelParent(l) l->lbl.parent

#define symbGetLabelStmt(s) s->lbl.stmtnum

#define symbGetProcParams(f) f->proc.params

#define symbGetProcParamsLen(f) f->proc.lgt

#define symbGetProcOptParams(f) f->proc.optparams

#define symbGetProcMode(f) f->proc.mode

#define symbGetProcFirstParam(f) iif( f->proc.mode = FB_FUNCMODE_PASCAL, f->proc.paramtb.head, f->proc.paramtb.tail )

#define symbGetProcLastParam(f) iif( f->proc.mode = FB_FUNCMODE_PASCAL, f->proc.paramtb.tail, f->proc.paramtb.head )

#define symbGetProcPrevParam(f,a) iif( f->proc.mode = FB_FUNCMODE_PASCAL, a->prev, a->next )

#define symbGetProcNextParam(f,a) iif( f->proc.mode = FB_FUNCMODE_PASCAL, a->next, a->prev )

#define symbGetProcHeadParam(f) f->proc.paramtb.head

#define symbGetProcTailParam(f) f->proc.paramtb.tail

#define symbGetProcCallback(f) f->proc.rtl.callback

#define symbSetProcCallback(f,cb) f->proc.rtl.callback = cb

#define symbGetProcIsOverloaded(f) ((f->attrib and FB_SYMBATTRIB_OVERLOADED) > 0)

#define symGetProcOvlMinParams(f) f->proc.ovl.minparams

#define symGetProcOvlMaxParams(f) f->proc.ovl.maxparams

#define symbGetProcIncFile(f) f->proc.ext->dbg.incfile

#define symbGetProcRealType(f) f->proc.real_dtype

#define symbGetProcSymbTb(f) f->proc.symtb

#define symbGetProcSymbTbHead(f) f->proc.symtb.head

#define symbGetProcOvlNext(f) f->proc.ovl.next

#define symbAllocProcExt() callocate( len( FB_PROCEXT ) )

#define symbFreeProcExt(f) deallocate( f->proc.ext )

#define symbGetProcStatReturnUsed(f) ((f->proc.ext->stats and FB_PROCSTATS_RETURNUSED) <> 0)

#define symbSetProcStatReturnUsed(f) f->proc.ext->stats or= FB_PROCSTATS_RETURNUSED

#define symbGetProcStatAssignUsed(f) ((f->proc.ext->stats and FB_PROCSTATS_ASSIGNUSED) <> 0)

#define symbSetProcStatAssignUsed(f) f->proc.ext->stats or= FB_PROCSTATS_ASSIGNUSED

#define symbGetProcPriority(f) f->proc.ext->priority

#macro symbSetProcPriority(f,p)
	if( f->proc.ext = NULL ) then
		f->proc.ext = symbAllocProcExt( )
	end if
	f->proc.ext->priority = p
#endmacro

#define symbGetProcStatGosub(f) ((f->proc.ext->stats and FB_PROCSTATS_GOSUBUSED) <> 0)

#define symbSetProcStatGosub(f) f->proc.ext->stats or= FB_PROCSTATS_GOSUBUSED

#define symbGetProcGosubSym(f) f->proc.ext->gosub.ctx

#define symbSetProcGosubSym(f,p) f->proc.ext->gosub.ctx = p

#define symbGetProcLocalOfs(p) p->proc.ext->stk.localofs

#define symbSetProcLocalOfs(p,ofs) p->proc.ext->stk.localofs = ofs

#define symbGetProcOpOvl(f) f->proc.ext->opovl.op

#macro symbSetProcOpOvl(f, op_)
	if( f->proc.ext = NULL ) then
		f->proc.ext = symbAllocProcExt( )
	end if
	f->proc.ext->opovl.op = op_
#endmacro

#define symbGetParamMode(a) a->param.mode

#define symbGetParamVar(a) a->param.var

#define symbGetParamOptExpr(a) a->param.optexpr

#define symbGetParamPrev(a) a->prev

#define symbGetParamNext(a) a->next

#define symbGetImportNamespc(s) s->nsimp.imp_ns

#define symbGetImportNext(s) s->nsimp.imp_next

#define symbGetExportNamespc(s) s->nsimp.exp_ns

#define symbGetExportNext(s) s->nsimp.exp_next

#define symbGetIsDynamic(s) ((s->attrib and (FB_SYMBATTRIB_DYNAMIC or FB_SYMBATTRIB_PARAMBYDESC)) <> 0 )

#define symbIsShared(s) ((s->attrib and FB_SYMBATTRIB_SHARED) <> 0)

#define symbIsStatic(s) ((s->attrib and FB_SYMBATTRIB_STATIC) <> 0)

#define symbIsDynamic(s) ((s->attrib and FB_SYMBATTRIB_DYNAMIC) <> 0)

#define symbIsCommon(s) ((s->attrib and FB_SYMBATTRIB_COMMON) <> 0)

#define symbIsTemp(s) ((s->attrib and FB_SYMBATTRIB_TEMP) <> 0)

#define symbIsParamByDesc(s) ((s->attrib and FB_SYMBATTRIB_PARAMBYDESC) <> 0)

#define symbIsParamByVal(s) ((s->attrib and FB_SYMBATTRIB_PARAMBYVAL) <> 0)

#define symbIsParamByRef(s) ((s->attrib and FB_SYMBATTRIB_PARAMBYREF) <> 0)

#define symbIsParamInstance(s) ((s->attrib and FB_SYMBATTRIB_PARAMINSTANCE) <> 0)

#define symbIsParam(s) ((s->attrib and (FB_SYMBATTRIB_PARAMBYREF or FB_SYMBATTRIB_PARAMBYVAL or FB_SYMBATTRIB_PARAMBYDESC)) <> 0)

#define symbIsLocal(s) ((s->attrib and FB_SYMBATTRIB_LOCAL) <> 0)

#define symbIsPublic(s) ((s->attrib and FB_SYMBATTRIB_PUBLIC) <> 0)

#define symbIsPrivate(s) ((s->attrib and FB_SYMBATTRIB_PRIVATE) <> 0)

#define symbIsExtern(s) ((s->attrib and FB_SYMBATTRIB_EXTERN) <> 0)

#define symbIsExport(s) ((s->attrib and FB_SYMBATTRIB_EXPORT) <> 0)

#define symbIsImport(s) ((s->attrib and FB_SYMBATTRIB_IMPORT) <> 0)

#define symbIsOverloaded(s) ((s->attrib and FB_SYMBATTRIB_OVERLOADED) <> 0)

#define symbIsConstructor(s) ((s->attrib and FB_SYMBATTRIB_CONSTRUCTOR) <> 0)

#define symbIsDestructor(s) ((s->attrib and FB_SYMBATTRIB_DESTRUCTOR) <> 0)

#define symbIsOperator(s) ((s->attrib and FB_SYMBATTRIB_OPERATOR) <> 0)

#define symbIsProperty(s) ((s->attrib and FB_SYMBATTRIB_PROPERTY) <> 0)

#define symbIsMethod(s) ((s->attrib and FB_SYMBATTRIB_METHOD) <> 0)

#define symbIsDescriptor(s) ((s->attrib and FB_SYMBATTRIB_DESCRIPTOR) <> 0)

#define symbIsConstant(s) ((s->attrib and FB_SYMBATTRIB_CONST) <> 0)

#define symbGetIsLiteral(s) ((s->attrib and FB_SYMBATTRIB_LITERAL) <> 0)

#define symbGetIsOptional(s) ((s->attrib and FB_SYMBATTRIB_OPTIONAL) <> 0)

#define symbIsLiteralConst(s) ((s->attrib and FB_SYMBATTRIB_LITCONST) <> 0)

#define symbIsVisPublic(s) ((s->attrib and FB_SYMBATTRIB_VIS_PUBLIC) <> 0)

#define symbIsVisPrivate(s) ((s->attrib and FB_SYMBATTRIB_VIS_PRIVATE) <> 0)

#define symbIsVisProtected(s) ((s->attrib and FB_SYMBATTRIB_VIS_PROTECTED) <> 0)

#define symbGetProcStaticLocals(s) ((s->attrib and FB_SYMBATTRIB_STATICLOCALS) <> 0)

#define symbIsTrivial(s) ((s->stats and (FB_SYMBSTATS_HASCOPYCTOR or _
										 FB_SYMBSTATS_HASDTOR or _
										 FB_SYMBSTATS_HASVIRTUAL)) = 0)

#define symbIsSuffixed(s) ((s->attrib and FB_SYMBATTRIB_SUFFIXED) <> 0)

#define symbGetCurrentProcName( ) symbGetName( parser.currproc )

#define symbGetLastLabel( ) symb.lastlbl

#define symbSetLastLabel( l ) symb.lastlbl = l

#define symbAddLib(libname) symbAddLibEx( @symb.liblist, @symb.libhash, libname )

#define symbDelLib(l) symbDelLibEx( @symb.liblist, @symb.libhash, l )

#define symbAddLibPath(path) symbAddLibEx( @symb.libpathlist, @symb.libpathhash, path )

#define symbDelLibPath(l) symbDelLibEx( @symb.libpathlist, @symb.libpathhash, l )

#define symbListLibs(dstlist, dsthash, delnodes) symbListLibsEx( @symb.liblist, @symb.libhash, dstlist, dsthash, delnodes )

#define symbListLibPaths(dstlist, dsthash, delnodes) symbListLibsEx( @symb.libpathlist, @symb.libpathhash, dstlist, dsthash, delnodes )

'' assuming all UDT's extend FBS_NAMESPACE
#define symbCompAllocExt( ) listNewNode( @symb.nsextlist )

#define symbCompFreeExt( n ) listDelNode( @symb.nsextlist, n )

#define symbGetCompSymbTb( s ) symbGetNamespaceSymbTb( s )

#define symbGetCompHashTb( s ) symbGetNamespaceHashTb( s )

#define symbGetCompExt( s ) s->nspc.ns.ext

#define symbGetCompImportHead( s ) s->nspc.ns.ext->implist.head

#define symbGetCompExportHead( s ) s->nspc.ns.ext->explist.head

#define symbLookupCompField( parent, id ) symbLookupAt( parent, id, FALSE, TRUE )


#define symbGetDataClass( dt ) symb_dtypeTB(typeGet( dt )).class

#define symbGetDataSize( dt ) symb_dtypeTB(typeGet( dt )).size

#define symbGetDataBits( dt ) symb_dtypeTB(typeGet( dt )).bits

#define symbIsSigned( dt ) symb_dtypeTB(typeGet( dt )).signed

'' datatype accessors

#define typeGet( dt ) iif( dt and FB_DT_PTRMASK, FB_DATATYPE_POINTER, dt and FB_DT_TYPEMASK )
#define typeGetDtOnly( dt ) (dt and FB_DT_TYPEMASK)
#define typeGetDtAndPtrOnly( dt ) (dt and (FB_DT_TYPEMASK or FB_DT_PTRMASK))
#define typeJoin( dt, ndt ) ((dt and (not (FB_DT_TYPEMASK or FB_DT_PTRMASK))) or (ndt and (FB_DT_TYPEMASK or FB_DT_PTRMASK)))



#define typeAddrOf( dt ) _
	((dt and FB_DT_TYPEMASK) or _
	 ((dt and FB_DT_PTRMASK) + (1 shl FB_DT_PTRPOS)) or _
	 ((dt and FB_DT_CONSTMASK) shl 1))

#define typeMultAddrOf( dt, cnt ) _
	((dt and FB_DT_TYPEMASK) or _
	 ((dt and FB_DT_PTRMASK) + (cnt shl FB_DT_PTRPOS)) or _
	 ((dt and FB_DT_CONSTMASK) shl cnt))

#define typeDeref( dt ) _
	((dt and FB_DT_TYPEMASK) or _
	 ((dt and FB_DT_PTRMASK) - (1 shl FB_DT_PTRPOS)) or _
	 (((dt and FB_DT_CONSTMASK) shr 1) and FB_DT_CONSTMASK))

#define typeMultDeref( dt, cnt ) _
	((dt and FB_DT_TYPEMASK) or _
	 ((dt and FB_DT_PTRMASK) - (cnt shl FB_DT_PTRPOS)) or _
	 (((dt and FB_DT_CONSTMASK) shr cnt) and FB_DT_CONSTMASK))

#define	typeIsPtr( dt ) (((dt and FB_DT_PTRMASK) <> 0))
#define typeGetPtrCnt( dt ) ((dt and FB_DT_PTRMASK) shr FB_DT_PTRPOS)

#define	typeIsConstAt( dt, at ) ((dt and (1 shl (FB_DT_CONSTPOS + at))) <> 0)
#define	typeIsConst( dt ) typeIsConstAt(dt, 0)
#define	typeIsPtrToConst( dt ) (typeIsConst(dt) and typeIsPtr(dt))
#define	typeSetIsConst( dt ) (dt or (1 shl FB_DT_CONSTPOS))
#define	typeUnsetIsConst( dt ) (dt and not (1 shl FB_DT_CONSTPOS))
#define	typeGetConstMask( dt ) (dt and FB_DT_CONSTMASK)
#define	typeGetPtrConstMask( dt ) _
	(typeGetConstMask( dt ) and not (1 shl FB_DT_CONSTPOS))

#define	typeIsRef( dt ) ((dt and FB_DATATYPE_REFERENCE) <> 0)
#define	typeSetIsRef( dt ) (dt or FB_DATATYPE_REFERENCE)
#define	typeUnsetIsRef( dt ) (dt and not FB_DATATYPE_REFERENCE)

#define	typeIsArray( dt ) ((dt and FB_DATATYPE_ARRAY) <> 0)
#define	typeSetIsArray( dt ) (dt or FB_DATATYPE_ARRAY)
#define	typeUnsetIsArray( dt ) (dt and not FB_DATATYPE_ARRAY)

#define	typeSetIsRefAndArray( dt ) (dt or (FB_DATATYPE_REFERENCE or FB_DATATYPE_ARRAY))

''
'' inter-module globals
''
extern symb as SYMBCTX

extern symb_dtypeTB( 0 to FB_DATATYPES-1 ) as SYMB_DATATYPE

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
#include once "inc\pool.bi"

'' symbol classes
enum FB_SYMBCLASS
	FB_SYMBCLASS_VAR			= 1
	FB_SYMBCLASS_CONST
	FB_SYMBCLASS_PROC
	FB_SYMBCLASS_PARAM
	FB_SYMBCLASS_DEFINE
	FB_SYMBCLASS_KEYWORD
	FB_SYMBCLASS_LABEL
	FB_SYMBCLASS_ENUM
	FB_SYMBCLASS_BITFIELD
	FB_SYMBCLASS_UDT
	FB_SYMBCLASS_UDTELM
	FB_SYMBCLASS_TYPEDEF
	FB_SYMBCLASS_FWDREF
	FB_SYMBCLASS_SCOPE
	FB_SYMBCLASS_NAMESPACE
	FB_SYMBCLASS_NSIMPORT
end enum

'' symbol status mask (max 16 bits, shared with mangling info!)
enum FB_SYMBSTATS
	FB_SYMBSTATS_ALLOCATED		= &h0001
	FB_SYMBSTATS_ACCESSED		= &h0002
	FB_SYMBSTATS_INITIALIZED	= &h0004
	FB_SYMBSTATS_DECLARED		= &h0008
	FB_SYMBSTATS_CALLED			= &h0010
	FB_SYMBSTATS_RTL			= &h0020
	FB_SYMBSTATS_THROWABLE		= &h0040
	FB_SYMBSTATS_PARSED			= &h0080
	FB_SYMBSTATS_MANGLED		= &h0100
	FB_SYMBSTATS_HASALIAS		= &h0200
	FB_SYMBSTATS_MOCK			= &h0400
end enum

'' symbol attributes mask
enum FB_SYMBATTRIB
	FB_SYMBATTRIB_SHARED		= &h00000001
	FB_SYMBATTRIB_STATIC		= &h00000002
	FB_SYMBATTRIB_DYNAMIC		= &h00000004
	FB_SYMBATTRIB_COMMON		= &h00000008
	FB_SYMBATTRIB_TEMP			= &h00000010
	FB_SYMBATTRIB_PARAMBYDESC	= &h00000020
	FB_SYMBATTRIB_PARAMBYVAL	= &h00000040
	FB_SYMBATTRIB_PARAMBYREF 	= &h00000080
	FB_SYMBATTRIB_PUBLIC 		= &h00000100
	FB_SYMBATTRIB_PRIVATE 		= &h00000200
	FB_SYMBATTRIB_EXTERN		= &h00000400	'' extern's become public when DIM'ed
	FB_SYMBATTRIB_EXPORT		= &h00000800
	FB_SYMBATTRIB_IMPORT		= &h00001000
	FB_SYMBATTRIB_OVERLOADED	= &h00002000	'' functions only
	FB_SYMBATTRIB_JUMPTB		= &h00004000
	FB_SYMBATTRIB_MAINPROC		= &H00008000
	FB_SYMBATTRIB_MODLEVELPROC	= &h00010000
    FB_SYMBATTRIB_CONSTRUCTOR   = &h00020000
    FB_SYMBATTRIB_DESTRUCTOR    = &h00040000
    FB_SYMBATTRIB_LOCAL			= &h00080000
    FB_SYMBATTRIB_DESCRIPTOR	= &h00100000
	FB_SYMBATTRIB_FUNCRESULT	= &h00200000
	FB_SYMBATTRIB_FUNCPTR		= &h00400000	'' needed to demangle
	FB_SYMBATTRIB_LITERAL		= &h00800000
	FB_SYMBATTRIB_CONST			= &h01000000
	FB_SYMBATTRIB_LITCONST		= FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL
end enum

type FBSYMBOL_ as FBSYMBOL

#ifndef ASTNODE_
type ASTNODE_ as ASTNODE
#endif

#ifndef EMIT_NODE_
type EMIT_NODE_ as EMIT_NODE
#endif

''
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
type FBLIBRARY
	name			as zstring ptr
	hashitem		as HASHITEM ptr
	hashindex		as uinteger
end type

''
type FBHASHTB
	prev			as FBHASHTB ptr
	next			as FBHASHTB ptr
	owner			as FBSYMBOL_ ptr            '' back link
	tb				as THASH
end type

type FBSYMCHAIN
	sym				as FBSYMBOL_ ptr
	index			as uinteger
	item			as HASHITEM ptr
	prev			as FBSYMCHAIN ptr			'' chain (hash) list
	next			as FBSYMCHAIN ptr			'' /
	imp_next		as FBSYMCHAIN ptr			'' import (USING) list
end type

type FBSYMHASH
	tb				as FBHASHTB ptr
	chain			as FBSYMCHAIN ptr
end type

''
type FBSYMBOLTB
    owner			as FBSYMBOL_ ptr			'' back link
    head			as FBSYMBOL_ ptr			'' first node
    tail			as FBSYMBOL_ ptr			'' last node
end type

union FBVALUE
	str				as FBSYMBOL_ ptr
	int				as integer
	float			as double
	long			as longint
end union

''
type FBS_KEYWORD
	id				as integer
	class			as integer
end type

''
type FB_DEFPARAM
	name			as zstring ptr
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

''
type FBFWDREF
	ref				as FBSYMBOL_ ptr
	prev			as FBFWDREF ptr
end type

type FBS_FWDREF
	refs			as integer
	reftail			as FBFWDREF ptr
end type

''
type FBS_LABEL
	parent			as FBSYMBOL_ ptr			'' parent block, not always a proc
	declared		as integer
	stmtnum			as integer					'' can't use colnum as it's unreliable
end type

''
type FBS_ARRAY
	dims			as integer
	dimhead 		as FBVARDIM ptr
	dimtail			as FBVARDIM ptr
	dif				as integer
	elms			as integer
	desc			as FBSYMBOL_ ptr
end type

''
type FB_TYPEDBG
	typenum			as integer
end type

type FBS_UDT
	parent			as FBSYMBOL_ ptr
	isunion			as integer
	elements		as integer
	fldtb			as FBSYMBOLTB				'' fields symbol tb
	align			as integer
	lfldlen			as integer					'' largest field len
	bitpos			as uinteger
	unpadlgt		as integer					'' unpadded len
	ptrcnt			as integer
	dyncnt			as integer
	dbg				as FB_TYPEDBG
end type

type FBS_UDTELM
	parent			as FBSYMBOL_ ptr
end type

type FBS_BITFLD
	bitpos			as integer
	bits			as integer
end type

''
type FBS_ENUM
	elements		as integer
	elmtb			as FBSYMBOLTB				'' elements symbol tb
	dbg				as FB_TYPEDBG
end type

''
type FBS_CONST
	val				as FBVALUE
end type

''
type FBS_PARAM
	mode			as FB_PARAMMODE
	suffix			as integer					'' QB quirk..
	var				as FBSYMBOL_ ptr			'' link to decl var in func bodies
	optional		as integer
	optexpr			as ASTNODE_ ptr				'' default value
end type

type FBRTLCALLBACK as function( byval sym as FBSYMBOL_ ptr ) as integer

type FB_PROCOVL
	maxparams		as integer
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

type FB_PROCEXT
	res				as FBSYMBOL_ ptr			'' result, if any
	stk				as FB_PROCSTK 				'' to keep track of the stack frame
	dbg				as FB_PROCDBG 				'' debugging
end type

type FB_PROCRTL
	callback		as FBRTLCALLBACK
end type

type FBS_PROC
	mode			as FB_FUNCMODE				'' calling convention
	realtype		as integer					'' used with STRING and UDT functions
	lib				as FBLIBRARY ptr
	params			as integer
	paramtb			as FBSYMBOLTB				'' parameters symbol tb
	lgt				as integer					'' 	   //	  lenght (in bytes)
	rtl				as FB_PROCRTL
	ovl				as FB_PROCOVL				'' overloading
	symtb			as FBSYMBOLTB				'' local symbols table
	ext				as FB_PROCEXT ptr           '' extra fields, not used with prototypes
end type

type FB_SCOPEDBG
	iniline			as integer					'' scope
	endline			as integer					'' end scope
	inilabel		as FBSYMBOL_ ptr
	endlabel		as FBSYMBOL_ ptr
end type

type FB_SCOPEEMIT
	baseofs			as integer
	bytes			as integer
	clrnode			as EMIT_NODE_ ptr			'' back track node
end type

type FBS_SCOPE
	backnode		as ASTNODE_ ptr
	symtb			as FBSYMBOLTB
	dbg				as FB_SCOPEDBG
	emit			as FB_SCOPEEMIT
end type

type FBS_VAR
	suffix			as integer					'' QB quirk..
	union
		littext		as zstring ptr
		littextw	as wstring ptr
		initree		as ASTNODE_ ptr
	end union
	array			as FBS_ARRAY
	elm				as FBS_UDTELM
	stmtnum			as integer					'' can't use colnum as it's unreliable
end type

type FBNAMESPC_IMPLIST
	head			as FBSYMBOL_ ptr
	tail			as FBSYMBOL_ ptr
end type

type FBS_NAMESPACE
    symtb			as FBSYMBOLTB
    hashtb			as FBHASHTB
    implist			as FBNAMESPC_IMPLIST		'' all USING's used inside the ns
	next			as FBSYMBOL_ ptr			'' next in implist
end type

type FBS_NSIMPORT
	ns				as FBSYMBOL_ ptr
	head			as FBSYMCHAIN ptr
	tail			as FBSYMCHAIN ptr
end type

''
type FBSYMBOL
	class			as FB_SYMBCLASS
	attrib			as FB_SYMBATTRIB
	stats			as FB_SYMBSTATS

	typ				as FB_DATATYPE
	subtype			as FBSYMBOL ptr
	ptrcnt 			as integer
	scope			as uinteger

	name			as zstring ptr				'' original name, shared by hash tb
	alias			as zstring ptr
	lgt				as integer
	ofs				as integer					'' for local vars, args, UDT's and fields

	union
		var			as FBS_VAR
		con			as FBS_CONST
		udt			as FBS_UDT
		bitfld		as FBS_BITFLD
		enum		as FBS_ENUM
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

	prev			as FBSYMBOL ptr				'' next in symbol tb list
	next			as FBSYMBOL ptr             '' prev /
end type

type FBHASHTBLIST
	head			as FBHASHTB ptr
	tail			as FBHASHTB ptr
end type

type SYMBCTX
	inited			as integer

	symlist			as TLIST
	hashlist		as FBHASHTBLIST
	chainlist		as TLIST

	globnspc		as FBSYMBOL					'' global namespace

	namespc			as FBSYMBOL ptr				'' current ns
	hashtb			as FBHASHTB ptr				'' current hash tb
	symtb			as FBSYMBOLTB ptr			'' current symbol tb

	namepool		as TPOOL

	liblist 		as TLIST					'' libraries
	libhash			as THASH

	dimlist			as TLIST					'' array dimensions
	defparamlist	as TLIST					'' define parameters
	deftoklist		as TLIST					'' define tokens
	fwdlist			as TLIST					'' forward typedef refs

	lastlbl			as FBSYMBOL ptr

	fwdrefcnt 		as integer
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

declare sub 		symbInit				( _
												byval ismain as integer _
											)

declare function 	symbHashTbInit 			( _
												byval hashtb as FBHASHTB ptr, _
												byval owner as FBSYMBOL ptr, _
												byval nodes as integer _
											) as integer

declare function 	symbSymTbInit 			( _
												byval symtb as FBSYMBOLTB ptr, _
												byval owner as FBSYMBOL ptr _
											) as integer

declare sub 		symbEnd					( _
												 _
											)

declare sub 		symbDataInit			( _
												 _
											)

declare sub 		symbDataEnd				( _
												 _
											)

declare function 	symbLookup				( _
												byval symbol as zstring ptr, _
												byref id as integer, _
												byref class as integer, _
												byval preservecase as integer = FALSE _
											) as FBSYMCHAIN ptr

declare function 	symbLookupAt			( _
												byval ns as FBSYMBOL ptr, _
					   						  	byval symbol as zstring ptr, _
					   						  	byval preservecase as integer = FALSE _
											) as FBSYMCHAIN ptr

declare function 	symbFindByClass			( _
												byval chain as FBSYMCHAIN ptr, _
												byval class as integer _
											) as FBSYMBOL ptr

declare function 	symbFindBySuffix		( _
												byval chain as FBSYMCHAIN ptr, _
												byval suffix as integer, _
						   					  	byval deftyp as integer _
											) as FBSYMBOL ptr

declare function 	symbLookupByNameAndClass( _
												byval ns as FBSYMBOL ptr, _
												byval symbol as zstring ptr, _
												byval class as integer, _
												byval preservecase as integer = FALSE _
											) as FBSYMBOL ptr

declare function 	symbLookupByNameAndSuffix( _
												byval ns as FBSYMBOL ptr, _
												byval symbol as zstring ptr, _
												byval suffix as integer, _
												byval preservecase as integer = FALSE _
											) as FBSYMBOL ptr

declare function 	symbFindOverloadProc	( _
												byval parent as FBSYMBOL ptr, _
												byval proc as FBSYMBOL ptr _
											) as FBSYMBOL ptr

declare function 	symbFindClosestOvlProc	( _
												byval proc as FBSYMBOL ptr, _
					   		    			  	byval params as integer, _
					   		    			  	exprTB() as ASTNODE ptr, _
					   		    			  	modeTB() as integer _
											) as FBSYMBOL ptr

declare function 	symbLookupUDTElm		( _
												byval parent as FBSYMBOL ptr, _
						   					  	byval id as zstring ptr _
											) as FBSYMBOL ptr

declare function 	symbGetProcResult		( _
												byval proc as FBSYMBOL ptr _
											) as FBSYMBOL ptr

declare function 	symbGetUDTLen			( _
												byval udt as FBSYMBOL ptr, _
												byval realsize as integer = TRUE _
											) as integer

declare function 	symbGetConstValueAsStr	( _
												byval s as FBSYMBOL ptr _
											) as string

declare function 	symbCalcParamLen		( _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr, _
												byval mode as integer _
											) as integer

declare function 	symbListLibs			( _
												namelist() as string, _
												byval index as integer _
											) as integer

declare function 	symbAddKeyword			( _
												byval symbol as zstring ptr, _
												byval id as integer, _
												byval class as integer _
											) as FBSYMBOL ptr

declare function 	symbAddDefine			( _
												byval symbol as zstring ptr, _
												byval text as zstring ptr, _
												byval lgt as integer, _
												byval isargless as integer = FALSE, _
												byval proc as function() as string = NULL, _
                        					  	byval flags as integer = 0 _
											) as FBSYMBOL ptr

declare function 	symbAddDefineW			( _
												byval symbol as zstring ptr, _
						 					  	byval text as wstring ptr, _
						 					  	byval lgt as integer, _
						 					  	byval isargless as integer = FALSE, _
						 					  	byval proc as function() as string = NULL, _
                         					  	byval flags as integer = 0 _
											) as FBSYMBOL ptr

declare function 	symbAddDefineMacro		( _
												byval symbol as zstring ptr, _
							 				  	byval tokhead as FB_DEFTOK ptr, _
							 				  	byval params as integer, _
						 	 				  	byval paramhead as FB_DEFPARAM ptr _
											) as FBSYMBOL ptr

declare function 	symbAddDefineParam		( _
												byval lastparam as FB_DEFPARAM ptr, _
												byval symbol as zstring ptr _
											) as FB_DEFPARAM ptr

declare function 	symbAddDefineTok		( _
												byval lasttok as FB_DEFTOK ptr, _
						     				  	byval dtype as FB_DEFTOK_TYPE _
											) as FB_DEFTOK ptr

declare function 	symbAddFwdRef			( _
												byval symbol as zstring ptr _
											) as FBSYMBOL ptr

declare function 	symbAddTypedef			( _
												byval symbol as zstring ptr, _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr, _
						 					  	byval ptrcnt as integer, _
						 					  	byval lgt as integer _
											) as FBSYMBOL ptr

declare function 	symbAddLabel			( _
												byval symbol as zstring ptr, _
												byval declaring as integer = TRUE, _
												byval createalias as integer = FALSE _
											) as FBSYMBOL ptr

declare function 	symbAddVar				( _
												byval symbol as zstring ptr, _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr, _
					  						  	byval ptrcnt as integer, _
					  						  	byval dimensions as integer, _
					  						  	dTB() as FBARRAYDIM, _
				      						  	byval attrib as integer _
											) as FBSYMBOL ptr

declare function 	symbAddVarEx			( _
												byval symbol as zstring ptr, _
												byval aliasname as zstring ptr, _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr, _
												byval ptrcnt as integer, _
												byval lgt as integer, _
												byval dimensions as integer, _
												dTB() as FBARRAYDIM, _
				       						  	byval attrib as integer, _
				       						  	byval addsuffix as integer, _
				       						  	byval preservecase as integer _
											) as FBSYMBOL ptr

declare function 	symbAddTempVar			( _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr = NULL, _
												byval doalloc as integer = FALSE, _
												byval checkstatic as integer = TRUE _
											) as FBSYMBOL ptr

declare function 	symbAddConst			( _
												byval id as zstring ptr, _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr, _
												byval value as FBVALUE ptr _
											) as FBSYMBOL ptr

declare function 	symbAddUDT				( _
												byval parent as FBSYMBOL ptr, _
												byval id as zstring ptr, _
												byval id_alias as zstring ptr, _
												byval isunion as integer, _
												byval align as integer _
											) as FBSYMBOL ptr

declare function 	symbAddUDTElement		( _
												byval t as FBSYMBOL ptr, _
												byval id as zstring ptr, _
												byval dimensions as integer, _
												dTB() as FBARRAYDIM, _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr, _
												byval ptrcnt as integer, _
												byval lgt as integer, _
												byval bits as integer _
											) as FBSYMBOL ptr

declare sub 		symbInsertInnerUDT		( _
												byval t as FBSYMBOL ptr, _
							 				  	byval inner as FBSYMBOL ptr _
											)

declare function 	symbAddEnum				( _
												byval id as zstring ptr, _
												byval id_alias as zstring ptr _
											) as FBSYMBOL ptr

declare function 	symbAddEnumElement		( _
												byval parent as FBSYMBOL ptr, _
												byval id as zstring ptr, _
					         				  	byval value as integer _
											) as FBSYMBOL ptr

declare function 	symbAddProcParam		( _
												byval proc as FBSYMBOL ptr, _
												byval id as zstring ptr, _
												byval dtype as integer, _
					 						  	byval subtype as FBSYMBOL ptr, _
					 						  	byval ptrcnt as integer, _
					 						  	byval lgt as integer, _
					 						  	byval mode as integer, _
					 						  	byval suffix as integer, _
					 						  	byval optional as integer, _
					 						  	byval optexpr as ASTNODE ptr _
											) as FBSYMBOL ptr

declare function 	symbAddProcResultParam	( _
												byval proc as FBSYMBOL ptr _
											) as FBSYMBOL ptr

declare function 	symbAddPrototype		( _
												byval proc as FBSYMBOL ptr, _
												byval symbol as zstring ptr, _
												byval aliasname as zstring ptr, _
												byval libname as zstring ptr, _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr, _
												byval ptrcnt as integer, _
												byval attrib as integer, _
												byval mode as integer, _
												byval isexternal as integer, _
												byval preservecase as integer = FALSE _
											) as FBSYMBOL ptr

declare function 	symbAddProc				( _
												byval proc as FBSYMBOL ptr, _
												byval symbol as zstring ptr, _
												byval aliasname as zstring ptr, _
												byval libname as zstring ptr, _
					  						  	byval dtype as integer, _
					  						  	byval subtype as FBSYMBOL ptr, _
					  						  	byval ptrcnt as integer, _
					  						  	byval attrib as integer, _
					  						  	byval mode as integer _
											) as FBSYMBOL ptr

declare function 	symbPreAddProc			( _
												byval symbol as zstring ptr _
											) as FBSYMBOL ptr

declare function 	symbAddProcResult		( _
												byval f as FBSYMBOL ptr _
											) as FBSYMBOL ptr

declare function 	symbAddLib				( _
												byval libname as zstring ptr _
											) as FBLIBRARY ptr

declare function 	symbAddParam			( _
												byval id as zstring ptr, _
												byval param as FBSYMBOL ptr _
											) as FBSYMBOL ptr

declare function 	symbAddScope			( _
												byval backnode as ASTNODE ptr _
											) as FBSYMBOL ptr

declare function	symbAddBitField			( _
												byval bitpos as integer, _
					      					  	byval bits as integer, _
						  					  	byval dtype as integer, _
						  					  	byval lgt as integer _
											) as FBSYMBOL ptr

declare function 	symbAddNamespace		( _
												byval id as zstring ptr, _
												byval id_alias as zstring ptr _
											) as FBSYMBOL ptr

declare sub 		symbRoundUDTSize		( _
												byval t as FBSYMBOL ptr _
											)

declare sub 		symbRecalcUDTSize		( _
												byval t as FBSYMBOL ptr _
											)

declare function 	symbGetLastLabel 		( _
												 _
											) as FBSYMBOL ptr

declare sub 		symbSetLastLabel		( _
												byval l as FBSYMBOL ptr _
											)

declare sub 		symbSetArrayDims		( _
												byval s as FBSYMBOL ptr, _
					  						  	byval dimensions as integer, _
					  						  	dTB() as FBARRAYDIM _
											)

declare sub 		symbSetProcIncFile		( _
												byval p as FBSYMBOL ptr, _
												byval incf as zstring ptr _
											)

declare sub 		symbFreeLocalDynVars	( _
												byval proc as FBSYMBOL ptr _
											)

declare sub 		symbFreeScopeDynVars 	( _
												byval scp as FBSYMBOL ptr _
											)

declare sub 		symbDelSymbolTb			( _
												byval tb as FBSYMBOLTB ptr, _
												byval hashonly as integer _
											)

declare sub 		symbDelScopeTb			( _
												byval scp as FBSYMBOL ptr _
											)

declare sub 		symbDelSymbol			( _
												byval s as FBSYMBOL ptr _
											)

declare function 	symbDelKeyword			( _
												byval s as FBSYMBOL ptr _
											) as integer

declare function 	symbDelDefine			( _
												byval s as FBSYMBOL ptr _
											) as integer

declare sub 		symbDelLabel			( _
												byval s as FBSYMBOL ptr _
											)

declare sub			symbDelVar				( _
												byval s as FBSYMBOL ptr _
											)

declare sub 		symbDelPrototype		( _
												byval s as FBSYMBOL ptr _
											)

declare sub 		symbDelEnum				( _
												byval s as FBSYMBOL ptr _
											)

declare sub 		symbDelUDT				( _
												 byval s as FBSYMBOL ptr _
											)

declare sub 		symbDelConst			( _
												byval s as FBSYMBOL ptr _
											)

declare sub 		symbDelLib				( _
												byval l as FBLIBRARY ptr _
											)

declare sub 		symbDelScope			( _
												byval scp as FBSYMBOL ptr _
											)

declare sub 		symbDelNamespace		( _
												byval ns as FBSYMBOL ptr _
											)

declare function 	symbNewSymbol			( _
												byval s as FBSYMBOL ptr, _
					 						  	byval symtb as FBSYMBOLTB ptr, _
					 						  	byval hashtb as FBHASHTB ptr, _
					 						  	byval isglobal as integer, _
					 						  	byval class as FB_SYMBCLASS, _
					 						  	byval dohash as integer = TRUE, _
					 						  	byval symbol as zstring ptr, _
					 						  	byval aliasname as zstring ptr, _
					 						  	byval dtype as integer = INVALID, _
					 						  	byval subtype as FBSYMBOL ptr = NULL, _
					 						  	byval ptrcnt as integer = 0, _
					 						  	byval preservecase as integer = FALSE, _
					 						  	byval suffix as integer = INVALID _
											) as FBSYMBOL ptr

declare sub 		symbFreeSymbol			( _
												byval s as FBSYMBOL ptr, _
									  		  	byval movetoglob as integer = FALSE _
											)

declare sub 		symbDelFromHash			( _
												byval s as FBSYMBOL ptr _
											)

declare sub 		symbDelFromChainList	( _
												byval hashtb as THASH ptr, _
												byval chain as FBSYMCHAIN ptr _
											)

declare function 	symbNewArrayDim			( _
												byval s as FBSYMBOL ptr, _
				  		  					  	byval lower as integer, _
				  		  					  	byval upper as integer _
											) as FBVARDIM ptr

declare function 	symbCalcLen				( _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr, _
												byval realsize as integer = FALSE _
											) as integer

declare function 	symbAllocFloatConst		( _
												byval value as double, _
												byval dtype as integer _
											) as FBSYMBOL ptr

declare function 	symbAllocStrConst		( _
												byval sname as zstring ptr, _
												byval lgt as integer _
											) as FBSYMBOL ptr

declare function 	symbAllocWstrConst		( _
												byval sname as wstring ptr, _
												byval lgt as integer _
											) as FBSYMBOL ptr

declare function 	symbCalcArrayElements	( _
												byval s as FBSYMBOL ptr, _
												byval n as FBVARDIM ptr = NULL _
											) as integer

declare function 	symbCalcArrayDiff		( _
												byval dimensions as integer, _
									  	  	  	dTB() as FBARRAYDIM, _
									  	  	  	byval lgt as integer _
											) as integer

declare function 	symbCheckLabels 		( _
												 _
											) as integer

declare function 	symbCheckLocalLabels 	( _
												 _
											) as integer

declare function 	symbCheckBitField		( _
												byval udt as FBSYMBOL ptr, _
												byval dtype as integer, _
												byval lgt as integer, _
												byval bits as integer _
											) as integer

declare sub 		symbCheckFwdRef			( _
												byval s as FBSYMBOL ptr, _
					 						  	byval class as integer _
											)

declare function 	symbIsEqual				( _
												byval sym1 as FBSYMBOL ptr, _
					  						  	byval sym2 as FBSYMBOL ptr _
											) as integer

declare function 	symbIsProcOverloadOf	( _
												byval proc as FBSYMBOL ptr, _
							   				  	byval parent as FBSYMBOL ptr _
											) as integer

declare function 	symbVarIsLocalDyn		( _
												byval s as FBSYMBOL ptr _
											) as integer

declare function 	symbVarIsLocalObj		( _
												byval s as FBSYMBOL ptr _
											) as integer

declare function 	symbMaxDataType			( _
												byval dtype1 as integer, _
										  	  	byval dtype2 as integer _
											) as integer

declare function 	symbGetDataClass  		( _
												byval dtype as integer _
											) as integer

declare function 	symbGetDataSize			( _
												byval dtype as integer _
											) as integer

declare function 	symbGetDataBits			( _
												byval dtype as integer _
											) as integer

declare function 	symbIsSigned			( _
												byval dtype as integer _
											) as integer

declare function 	symbGetSignedType		( _
												byval dtype as integer _
											) as integer

declare function 	symbGetUnsignedType		( _
												byval dtype as integer _
											) as integer

declare function 	symbRemapType			( _
												byval dtype as integer, _
					  					  	  	byval subtype as FBSYMBOL ptr _
											) as integer

declare function 	symbProcAllocLocals		( _
												byval proc as FBSYMBOL ptr _
											) as integer

declare function 	symbScopeAllocLocals	( _
												byval sym as FBSYMBOL ptr _
											) as integer

declare function 	symbFreeDynVar			( _
												byval s as FBSYMBOL ptr _
											) as ASTNODE ptr

declare sub 		symbHashListAdd			( _
												byval hashtb as FBHASHTB ptr, _
												byval checkdup as integer = FALSE _
											)

declare sub 		symbHashListAddBefore 	( _
												byval lasttb as FBHASHTB ptr, _
												byval hashtb as FBHASHTB ptr _
											)

declare sub 		symbHashListDel			( _
												byval hashtb as FBHASHTB ptr _
											)

declare function 	symbNamespaceImport		( _
												byval ns as FBSYMBOL ptr _
											) as integer

declare sub			symbNamespaceRemove		( _
												byval sym as FBSYMBOL ptr, _
												byval hashonly as integer _
											)

declare sub 		symbNamespaceInsertChain( _
												byval ns as FBSYMBOL ptr _
											)

declare sub 		symbNamespaceRemoveChain( _
												byval ns as FBSYMBOL ptr _
											)

declare function 	symbCanDuplicate		( _
											  	byval n as FBSYMCHAIN ptr, _
						   					  	byval s as FBSYMBOL ptr _
											) as integer

declare function 	symbGetMangledNameEx 	( _
												byval sym as FBSYMBOL ptr, _
												byval checkhash as integer _
											) as zstring ptr

declare sub 		symbSetName 			( _
												byval s as FBSYMBOL ptr, _
												byval name_ as zstring ptr _
											)

declare function 	symbMangleFunctionPtr 	( _
												byval proc as FBSYMBOL ptr, _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr, _
												byval mode as integer _
											) as zstring ptr

declare function 	symbDemangleFunctionPtr ( _
												byval proc as FBSYMBOL ptr _
											) as zstring ptr

declare function 	symbTypeToStr			( _
												byval dtype as integer, _
												byval subtype as FBSYMBOL ptr _
											) as zstring ptr

''
'' getters and setters as macros
''

#define symbGetGlobalNamespc( ) symb.globnspc

#define symbIsGlobalNamespc( ) (symb.namespc = @symbGetGlobalNamespc( ))

#define symbGetGlobalTb( ) symbGetGlobalNamespc( ).nspc.symtb

#define symbGetGlobalTbHead( ) symbGetGlobalTb( ).head

#define symbGetGlobalHashTb( ) symbGetGlobalNamespc( ).nspc.hashtb

#define symbGetCurrentNamespc( ) symb.namespc

#define symbSetCurrentNamespc(ns) symb.namespc = ns

#define symbGetCurrentSymTb( ) symb.symtb

#define symbSetCurrentSymTb(tb) symb.symtb = tb

#define symbGetCurrentHashTb( ) symb.hashtb

#define symbSetCurrentHashTb(tb) symb.hashtb = tb

#define symbGetIsAccessed(s) ((s->stats and FB_SYMBSTATS_ACCESSED) <> 0)

#define symbSetIsAccessed(s) s->stats or= FB_SYMBSTATS_ACCESSED

#define symbGetIsAllocated(s) ((s->stats and FB_SYMBSTATS_ALLOCATED) <> 0)

#define symbSetIsAllocated(s) s->stats or= FB_SYMBSTATS_ALLOCATED

#define symbGetIsInitialized(s) ((s->stats and FB_SYMBSTATS_INITIALIZED) <> 0)

#define symbSetIsInitialized(s) s->stats or= FB_SYMBSTATS_INITIALIZED

#define symbGetIsDeclared(s) ((s->stats and FB_SYMBSTATS_DECLARED) <> 0)

#define symbSetIsDeclared(s) s->stats or= FB_SYMBSTATS_DECLARED

#define symbGetIsCalled(s) ((s->stats and FB_SYMBSTATS_CALLED) <> 0)

#define symbSetIsCalled(s) s->stats or= FB_SYMBSTATS_CALLED

#define symbGetIsRTL(s) ((s->stats and FB_SYMBSTATS_RTL) <> 0)

#define symbSetIsRTL(s) s->stats or= FB_SYMBSTATS_RTL

#define symbGetIsThrowable(s) ((s->stats and FB_SYMBSTATS_THROWABLE) <> 0)

#define symbSetIsThrowable(s) s->stats or= FB_SYMBSTATS_THROWABLE

#define symbGetIsParsed(s) ((s->stats and FB_SYMBSTATS_PARSED) <> 0)

#define symbSetIsParsed(s) s->stats or= FB_SYMBSTATS_PARSED

#define symbSetIsMock(s) s->stats or= FB_SYMBSTATS_MOCK

#define symbGetStats(s) s->stats

#define symbGetLen(s) iif( s <> NULL, s->lgt, 0 )

#define symbGetStrLen(s) symbGetLen(s)

#define symbGetWstrLen(s) (cunsg(s->lgt) \ symbGetDataSize( FB_DATATYPE_WCHAR ))

#define symbGetType(s) s->typ

#define symbGetSubType(s) s->subtype

#define symbGetClass(s) s->class

#define symbGetSymtb(s) s->symtb

#define symbGetHashtb(s) s->hash.tb

#define symbGetParent(s) symbGetSymtb(s)->owner

#define symbGetNamespace(s) symbGetHashtb(s)->owner

#define symbGetMangling(s) (cuint( s->stats ) shr 16)

#define symbSetMangling(s,v) s->stats or= (cuint( v ) shl 16)

#define symbGetMangledName(s) symbGetMangledNameEx( s, FALSE )

#define symbGetName(s) s->name

#define symbGetOfs(s) s->ofs

#define symbGetAttrib(s) s->attrib

#define symbSetAttrib(s,t) s->attrib = t

#define symbChainGetNext(c) c->next

#define symbIsVar(s) (s->class = FB_SYMBCLASS_VAR)

#define symbIsConst(s) (s->class = FB_SYMBCLASS_CONST)

#define symbIsProc(s) (s->class = FB_SYMBCLASS_PROC)

#define symbIsProcArg(s) (s->class = FB_SYMBCLASS_PARAM)

#define symbIsDefine(s) (s->class = FB_SYMBCLASS_DEFINE)

#define symbIsKeyword(s) (s->class = FB_SYMBCLASS_KEYWORD)

#define symbIsLabel(s) (s->class = FB_SYMBCLASS_LABEL)

#define symbIsEnum(s) (s->class = FB_SYMBCLASS_ENUM)

#define symbIsUDT(s) (s->class = FB_SYMBCLASS_UDT)

#define symbIsUDTElm(s) (s->class = FB_SYMBCLASS_UDTELM)

#define symbIsTypedef(s) (s->class = FB_SYMBCLASS_TYPEDEF)

#define symbIsFwdRef(s) (s->class = FB_SYMBCLASS_FWDREF)

#define symbIsScope(s) (s->class = FB_SYMBCLASS_SCOPE)

#define symbIsNameSpace(s) (s->class = FB_SYMBCLASS_NAMESPACE)

#define symbGetConstValStr(s) s->con.val.str

#define symbGetConstValInt(s) s->con.val.int

#define symbGetConstValFloat(s) s->con.val.float

#define symbGetConstValLong(s) s->con.val.long

#define symbGetDefineText(d) d->def.text

#define symbGetDefineTextW(d) d->def.textw

#define symbGetDefineHeadToken(d) d->def.tokhead

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

#define symbGetDefineCallback(d) d->def.proc

#define symbGetDefineIsArgless(d) d->def.isargless

#define symbGetDefineFlags(d) d->def.flags

#define symbGetVarLitText(s) s->var.littext

#define symbGetVarLitTextW(s) s->var.littextw

#define symbGetVarStmt(s) s->var.stmtnum

#define symbSetTypeIniTree(s, t) s->var.initree = t

#define symbGetTypeIniTree(s) s->var.initree

#define symbGetArrayDiff(s) s->var.array.dif

#define symbGetArrayDimensions(s) s->var.array.dims

#define symbSetArrayDimensions(s,d) s->var.array.dims = d

#define symbGetArrayDescriptor(s) s->var.array.desc

#define symbGetArrayOffset(s) s->var.array.dif

#define symbGetArrayFirstDim(s) s->var.array.dimhead

#define symbGetArrayElements(s) s->var.array.elms

#define symbGetUDTFirstElm(s) s->udt.fldtb.head

#define symbGetUDTNextElm(e) e->next

#define symbGetUDTElmBitOfs(e) ( e->ofs * 8 + _
								 iif( e->typ = FB_DATATYPE_BITFIELD, _
									  e->subtype->bitfld.bitpos, _
									  0) )

#define symbGetUDTElmBitLen(e) iif( e->typ = FB_DATATYPE_BITFIELD, _
									e->subtype->bitfld.bits, _
									e->lgt * e->var.array.elms * 8 )

#define symbGetUDTIsUnion(s) s->udt.isunion

#define symbGetUDTAlign(s) s->udt.align

#define symbGetUDTElements(s) s->udt.elements

#define symbGetUDTPtrCnt(s) (s->udt.ptrcnt + s->udt.dyncnt)

#define symbGetUDTDynCnt(s) s->udt.dyncnt

#define symbGetENUMFirstElm(s) s->enum.elmtb.head

#define symbGetENUMNextElm(e) e->next

#define symbGetEnumElements(s) s->enum.elements

#define symbGetScope(s) s->scope

#define symbGetScopeTb(s) s->scp.symtb

#define symbGetScopeTbHead(s) s->scp.symtb.head

#define symbGetNamespaceTb(s) s->nspc.symtb

#define symbGetNamespaceHashTb(s) s->nspc.hashtb

#define symbGetLabelIsDeclared(l) l->lbl.declared

#define symbSetLabelIsDeclared(l) l->lbl.declared = TRUE

#define symbGetLabelParent(l) l->lbl.parent

#define symbGetLabelStmt(s) s->lbl.stmtnum

#define symbGetProcParams(f) f->proc.params

#define symbGetProcParamsLen(f) f->proc.lgt

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

#define symGetProcOvlMaxParams(f) f->proc.ovl.maxparams

#define symbGetProcIncFile(f) f->proc.ext->dbg.incfile

#define symbGetProcRealType(f) f->proc.realtype

#define symbGetProcLocTb(f) f->proc.symtb

#define symbGetProcLocTbHead(f) f->proc.symtb.head

#define symbGetParamMode(a) a->param.mode

#define symbGetParamVar(a) a->param.var

#define symbGetParamOptional(a) a->param.optional

#define symbGetParamOptExpr(a) a->param.optexpr

#define symbGetParamPrev(a) a->prev

#define symbGetParamNext(a) a->next

#define symbGetIsDynamic(s) iif( s->class = FB_SYMBCLASS_UDTELM, FALSE, (s->attrib and (FB_SYMBATTRIB_DYNAMIC or FB_SYMBATTRIB_PARAMBYDESC)) <> 0 )

#define symbIsArray(s) iif( (s->class = FB_SYMBCLASS_VAR) or (s->class = FB_SYMBCLASS_UDTELM), _
							iif( (s->attrib and (FB_SYMBATTRIB_DYNAMIC or FB_SYMBATTRIB_PARAMBYDESC)) > 0, _
								 TRUE, s->var.array.dims > 0 ), _
							FALSE )

#define symbIsShared(s) ((s->attrib and FB_SYMBATTRIB_SHARED) <> 0)

#define symbIsStatic(s) ((s->attrib and FB_SYMBATTRIB_STATIC) <> 0)

#define symbIsDynamic(s) ((s->attrib and FB_SYMBATTRIB_DYNAMIC) <> 0)

#define symbIsCommon(s) ((s->attrib and FB_SYMBATTRIB_COMMON) <> 0)

#define symbIsTemp(s) ((s->attrib and FB_SYMBATTRIB_TEMP) <> 0)

#define symbIsParamByDesc(s) ((s->attrib and FB_SYMBATTRIB_PARAMBYDESC) <> 0)

#define symbIsParamByVal(s) ((s->attrib and FB_SYMBATTRIB_PARAMBYVAL) <> 0)

#define symbIsParamByRef(s) ((s->attrib and FB_SYMBATTRIB_PARAMBYREF) <> 0)

#define symbIsParam(s) ((s->attrib and (FB_SYMBATTRIB_PARAMBYREF or FB_SYMBATTRIB_PARAMBYVAL or FB_SYMBATTRIB_PARAMBYDESC)) <> 0)

#define symbIsLocal(s) ((s->attrib and FB_SYMBATTRIB_LOCAL) <> 0)

#define symbIsPublic(s) ((s->attrib and FB_SYMBATTRIB_PUBLIC) <> 0)

#define symbIsPrivate(s) ((s->attrib and FB_SYMBATTRIB_PRIVATE) <> 0)

#define symbIsExtern(s) ((s->attrib and FB_SYMBATTRIB_EXTERN) <> 0)

#define symbIsExport(s) ((s->attrib and FB_SYMBATTRIB_EXPORT) <> 0)

#define symbIsImport(s) ((s->attrib and FB_SYMBATTRIB_IMPORT) <> 0)

#define symbIsOverloaded(s) ((s->attrib and FB_SYMBATTRIB_OVERLOADED) <> 0)

#define symbIsJumpTb(s) ((s->attrib and FB_SYMBATTRIB_JUMPTB) <> 0)

#define symbIsMainProc(s) ((s->attrib and FB_SYMBATTRIB_MAINPROC) <> 0)

#define symbIsModLevelProc(s) ((s->attrib and FB_SYMBATTRIB_MODLEVELPROC) <> 0)

#define symbIsConstructor(s) ((s->attrib and FB_SYMBATTRIB_CONSTRUCTOR) <> 0)

#define symbIsDestructor(s) ((s->attrib and FB_SYMBATTRIB_DESTRUCTOR) <> 0)

#define symbIsDescriptor(s) ((s->attrib and FB_SYMBATTRIB_DESCRIPTOR) <> 0)

#define symbIsFunctionPtr(s) ((s->attrib and FB_SYMBATTRIB_FUNCPTR) <> 0)

#define symbIsConstant(s) ((s->attrib and FB_SYMBATTRIB_CONST) <> 0)

#define symbGetIsLiteral(s) ((s->attrib and FB_SYMBATTRIB_LITERAL) <> 0)

#define symbGetCurrentProcName( ) symbGetName( env.currproc )

#define hIsString(t) ((t = FB_DATATYPE_STRING) or (t = FB_DATATYPE_FIXSTR) or (t = FB_DATATYPE_CHAR) or (t = FB_DATATYPE_WCHAR))

''
'' inter-module globals
''
extern symb as SYMBCTX

extern symb_dtypeTB( 0 to FB_DATATYPES-1 ) as SYMB_DATATYPE

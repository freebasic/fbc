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
'' symbol table protos
''

#include once "inc\list.bi"

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
end enum

'' symbol status mask
enum FB_SYMBSTATS
	FB_SYMBSTATS_ALLOCATED		= &h000001
	FB_SYMBSTATS_ACCESSED		= &h000002
	FB_SYMBSTATS_INITIALIZED	= &h000004
	FB_SYMBSTATS_DECLARED		= &h000008
	FB_SYMBSTATS_CALLED			= &h000010
	FB_SYMBSTATS_RTL			= &h000020
	FB_SYMBSTATS_THROWABLE		= &h000040
end enum

'' symbol attributes mask
enum FB_SYMBATTRIB
	FB_SYMBATTRIB_SHARED		= &h000001
	FB_SYMBATTRIB_STATIC		= &h000002
	FB_SYMBATTRIB_DYNAMIC		= &h000004
	FB_SYMBATTRIB_COMMON		= &h000008
	FB_SYMBATTRIB_TEMP			= &h000010
	FB_SYMBATTRIB_PARAMBYDESC	= &h000020
	FB_SYMBATTRIB_PARAMBYVAL	= &h000040
	FB_SYMBATTRIB_PARAMBYREF 	= &h000080
	FB_SYMBATTRIB_PUBLIC 		= &h000100
	FB_SYMBATTRIB_PRIVATE 		= &h000200
	FB_SYMBATTRIB_EXTERN		= &h000400		'' extern's become public when DIM'ed
	FB_SYMBATTRIB_EXPORT		= &h000800
	FB_SYMBATTRIB_IMPORT		= &h001000
	FB_SYMBATTRIB_OVERLOADED	= &h002000		'' functions only
	FB_SYMBATTRIB_JUMPTB		= &h004000
	FB_SYMBATTRIB_MAINPROC		= &H008000
	FB_SYMBATTRIB_MODLEVELPROC	= &h010000
    FB_SYMBATTRIB_CONSTRUCTOR   = &h020000      '' it can be either constructor
    FB_SYMBATTRIB_DESTRUCTOR    = &h040000      '' or destructor, but not both ...
    FB_SYMBATTRIB_LOCAL			= &h080000
    FB_SYMBATTRIB_DESCRIPTOR	= &h100000
	FB_SYMBATTRIB_LITERAL		= &h200000
	FB_SYMBATTRIB_FUNCRESULT	= &h400000
end enum

type FBSYMBOL_ as FBSYMBOL

#ifndef ASTNODE_
type ASTNODE_ as ASTNODE
#endif

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

	name			as zstring ptr

	hashitem		as HASHITEM ptr
	hashindex		as uinteger
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
	ll_prv			as FB_DEFPARAM ptr				'' linked-list nodes
	ll_nxt			as FB_DEFPARAM ptr				'' /

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
	ll_prv			as FB_DEFTOK ptr				'' linked-list nodes
	ll_nxt			as FB_DEFTOK ptr				'' /

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
	ll_prv			as FBFWDREF ptr				'' linked-list nodes
	ll_nxt			as FBFWDREF ptr				'' /

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
	ofs				as integer
	align			as integer
	lfldlen			as integer					'' largest field len
	bitpos			as uinteger
	unpadlgt		as integer					'' unpadded len
	ptrcnt			as integer
	dyncnt			as integer
	dbg				as FB_TYPEDBG
end type

type FBS_UDTELM
	ofs				as integer
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
	incfile			as integer
end type

type FB_PROCSCPTB
	head			as FBSYMBOL_ ptr
	tail			as FBSYMBOL_ ptr
end type

type FB_PROCEXT
	stk				as FB_PROCSTK 				'' to keep track of the stack frame
	dbg				as FB_PROCDBG 				'' debugging
	scptb			as FB_PROCSCPTB
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
	rtl				as FB_PROCRTL
	ovl				as FB_PROCOVL				'' overloading
	loctb			as FBSYMBOLTB				'' local symbols table
	ext				as FB_PROCEXT ptr           '' extra stuff, not used with prototypes
end type

type FB_SCOPEDBG
	iniline			as integer					'' scope
	endline			as integer					'' end scope
	inilabel		as FBSYMBOL_ ptr
	endlabel		as FBSYMBOL_ ptr
end type

type FBS_SCOPE
	backnode		as ASTNODE_ ptr
	loctb			as FBSYMBOLTB
	baseofs			as integer
	bytes			as integer
	dbg				as FB_SCOPEDBG
	next			as FBSYMBOL_ ptr			'' next in FB_PROCSCPTB's list
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

''
type FBSYMBOL
	ll_prv			as FBSYMBOL ptr				'' linked-list nodes
	ll_nxt			as FBSYMBOL ptr				'' /

	class			as FB_SYMBCLASS
	typ				as FB_DATATYPE
	subtype			as FBSYMBOL ptr
	ptrcnt 			as integer
	attrib			as FB_SYMBATTRIB

	name			as zstring ptr				'' original name, shared by hash tb
	alias			as zstring ptr
	hashitem		as HASHITEM ptr
	hashindex		as uinteger

	scope			as uinteger

	lgt				as integer
	ofs				as integer					'' used with local vars and args
	stats			as FB_SYMBSTATS

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
	end union

	left			as FBSYMBOL ptr 			'' prev in symbols with the same name
	right			as FBSYMBOL ptr				'' next /

	symtb			as FBSYMBOLTB ptr			'' symbol tb it's part of

	prev			as FBSYMBOL ptr				'' next in symbol tb list
	next			as FBSYMBOL ptr             '' prev /
end type

type SYMBCTX
	inited			as integer

	symlist			as TLIST					'' symbols (VAR, CONST, FUNCTION, UDT, etc)
	symhash			as THASH

	globtb			as FBSYMBOLTB               '' global tb (for shared vars, functions, etc)
	loctb			as FBSYMBOLTB ptr			'' local tb

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
	class		as FB_DATACLASS					'' INTEGER, FPOINT
	size		as integer						'' in bytes
	bits		as integer						'' number of bits
	signed		as integer						'' TRUE or FALSE
	remaptype	as FB_DATATYPE					'' remapped type for ENUM, POINTER, etc
end type


#include once "inc\ast.bi"


declare sub 		symbInit				( byval ismain as integer )

declare sub 		symbEnd					( )

declare sub 		symbDataInit			( )

declare sub 		symbDataEnd				( )

declare function 	symbLookup				( byval symbol as zstring ptr, _
											  byref id as integer, _
											  byref class as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbFindByClass			( byval s as FBSYMBOL ptr, _
											  byval class as integer ) as FBSYMBOL ptr

declare function 	symbFindBySuffix		( byval s as FBSYMBOL ptr, _
											  byval suffix as integer, _
						   					  byval deftyp as integer ) as FBSYMBOL ptr

declare function 	symbFindByNameAndClass	( byval symbol as zstring ptr, _
											  byval class as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbFindByNameAndSuffix	( byval symbol as zstring ptr, _
											  byval suffix as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbFindOverloadProc	( byval parent as FBSYMBOL ptr, _
											  byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbFindClosestOvlProc	( byval proc as FBSYMBOL ptr, _
					   		    			  byval params as integer, _
					   		    			  exprTB() as ASTNODE ptr, _
					   		    			  modeTB() as integer ) as FBSYMBOL ptr

declare function 	symbLookupUDTVar		( byval symbol as zstring ptr, _
											  byval dotpos as integer ) as FBSYMBOL ptr

declare function 	symbLookupUDTElm		( byval symbol as zstring ptr, _
											  byval dotpos as integer, _
											  byref typ as integer, _
											  byref subtype as FBSYMBOL ptr, _
											  byref ofs as integer, _
					       					  byref elm as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbLookupProcResult	( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare	function 	symbGetSymbolTbHead 	( ) as FBSYMBOL ptr

declare function 	symbGetUDTElmOffset		( byref elm as FBSYMBOL ptr, _
											  byref typ as integer, _
											  byref subtype as FBSYMBOL ptr, _
											  byval fields as zstring ptr ) as integer

declare function 	symbGetUDTLen			( byval udt as FBSYMBOL ptr, _
											  byval realsize as integer = TRUE ) as integer

declare function 	symbGetConstValueAsStr	( byval s as FBSYMBOL ptr ) as string

declare function 	symbCalcParamLen		( byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval mode as integer ) as integer

declare function 	symbListLibs			( namelist() as string, _
											  byval index as integer ) as integer

declare function 	symbAddKeyword			( byval symbol as zstring ptr, _
											  byval id as integer, _
											  byval class as integer ) as FBSYMBOL ptr

declare function 	symbAddDefine			( byval symbol as zstring ptr, _
											  byval text as zstring ptr, _
											  byval lgt as integer, _
											  byval isargless as integer = FALSE, _
											  byval proc as function( ) as string = NULL, _
                        					  byval flags as integer = 0 ) as FBSYMBOL ptr

declare function 	symbAddDefineW			( byval symbol as zstring ptr, _
						 					  byval text as wstring ptr, _
						 					  byval lgt as integer, _
						 					  byval isargless as integer = FALSE, _
						 					  byval proc as function( ) as string = NULL, _
                         					  byval flags as integer = 0 ) as FBSYMBOL ptr

declare function 	symbAddDefineMacro		( byval symbol as zstring ptr, _
							 				  byval tokhead as FB_DEFTOK ptr, _
							 				  byval params as integer, _
						 	 				  byval paramhead as FB_DEFPARAM ptr ) as FBSYMBOL ptr

declare function 	symbAddDefineParam		( byval lastparam as FB_DEFPARAM ptr, _
											  byval symbol as zstring ptr ) as FB_DEFPARAM ptr

declare function 	symbAddDefineTok		( byval lasttok as FB_DEFTOK ptr, _
						     				  byval typ as FB_DEFTOK_TYPE ) as FB_DEFTOK ptr

declare function 	symbAddFwdRef			( byval symbol as zstring ptr ) as FBSYMBOL ptr

declare function 	symbAddTypedef			( byval symbol as zstring ptr, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
						 					  byval ptrcnt as integer, _
						 					  byval lgt as integer ) as FBSYMBOL ptr

declare function 	symbAddLabel			( byval symbol as zstring ptr, _
											  byval declaring as integer = TRUE, _
											  byval createalias as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbAddVar				( byval symbol as zstring ptr, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
					  						  byval ptrcnt as integer, _
					  						  byval dimensions as integer, _
					  						  dTB() as FBARRAYDIM, _
				      						  byval attrib as integer ) as FBSYMBOL ptr

declare function 	symbAddVarEx			( byval symbol as zstring ptr, _
											  byval aliasname as zstring ptr, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, _
											  byval lgt as integer, _
											  byval dimensions as integer, _
											  dTB() as FBARRAYDIM, _
				       						  byval attrib as integer, _
				       						  byval addsuffix as integer, _
				       						  byval preservecase as integer, _
				       						  byval clearname as integer ) as FBSYMBOL ptr

declare function 	symbAddTempVar			( byval typ as integer, _
											  byval subtype as FBSYMBOL ptr = NULL, _
											  byval doalloc as integer = FALSE, _
											  byval checkstatic as integer = TRUE ) as FBSYMBOL ptr

declare function 	symbAddConst			( byval symbol as zstring ptr, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval value as FBVALUE ptr ) as FBSYMBOL ptr

declare function 	symbAddUDT				( byval parent as FBSYMBOL ptr, _
											  byval symbol as zstring ptr, _
											  byval isunion as integer, _
											  byval align as integer ) as FBSYMBOL ptr

declare function 	symbAddUDTElement		( byval t as FBSYMBOL ptr, _
											  byval id as zstring ptr, _
											  byval dimensions as integer, _
											  dTB() as FBARRAYDIM, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, _
											  byval lgt as integer, _
											  byval bits as integer ) as FBSYMBOL ptr

declare sub 		symbInsertInnerUDT		( byval t as FBSYMBOL ptr, _
							 				  byval inner as FBSYMBOL ptr )

declare function 	symbAddEnum				( byval symbol as zstring ptr ) as FBSYMBOL ptr

declare function 	symbAddEnumElement		( byval parent as FBSYMBOL ptr, _
											  byval symbol as zstring ptr, _
					         				  byval value as integer ) as FBSYMBOL ptr

declare function 	symbAddProcParam		( byval proc as FBSYMBOL ptr, _
											  byval symbol as zstring ptr, _
											  byval typ as integer, _
					 						  byval subtype as FBSYMBOL ptr, _
					 						  byval ptrcnt as integer, _
					 						  byval lgt as integer, _
					 						  byval mode as integer, _
					 						  byval suffix as integer, _
					 						  byval optional as integer, _
					 						  byval optexpr as ASTNODE ptr ) as FBSYMBOL ptr

declare function 	symbAddProcResultParam	( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbAddPrototype		( byval proc as FBSYMBOL ptr, _
											  byval symbol as zstring ptr, _
											  byval aliasname as zstring ptr, _
											  byval libname as zstring ptr, _
											  byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval ptrcnt as integer, _
											  byval attrib as integer, _
											  byval mode as integer, _
											  byval isexternal as integer, _
											  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare function 	symbAddProc				( byval proc as FBSYMBOL ptr, _
											  byval symbol as zstring ptr, _
											  byval aliasname as zstring ptr, _
											  byval libname as zstring ptr, _
					  						  byval typ as integer, _
					  						  byval subtype as FBSYMBOL ptr, _
					  						  byval ptrcnt as integer, _
					  						  byval attrib as integer, _
					  						  byval mode as integer ) as FBSYMBOL ptr

declare function 	symbPreAddProc			( byval symbol as zstring ptr ) as FBSYMBOL ptr

declare function 	symbAddProcResult		( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbAddLib				( byval libname as zstring ptr ) as FBLIBRARY ptr

declare function 	symbAddParam			( byval symbol as zstring ptr, _
											  byval param as FBSYMBOL ptr ) as FBSYMBOL ptr

declare function 	symbAddScope			( byval backnode as ASTNODE ptr ) as FBSYMBOL ptr

declare function	symbAddBitField			( byval bitpos as integer, _
					      					  byval bits as integer, _
						  					  byval typ as integer, _
						  					  byval lgt as integer ) as FBSYMBOL ptr

declare sub 		symbRoundUDTSize		( byval t as FBSYMBOL ptr )

declare sub 		symbRecalcUDTSize		( byval t as FBSYMBOL ptr )

declare function 	symbGetLastLabel 		( ) as FBSYMBOL ptr

declare sub 		symbSetLastLabel		( byval l as FBSYMBOL ptr )

declare sub 		symbSetArrayDims		( byval s as FBSYMBOL ptr, _
					  						  byval dimensions as integer, _
					  						  dTB() as FBARRAYDIM )

declare sub 		symbSetProcIncFile		( byval p as FBSYMBOL ptr, _
											  byval incf as integer )

declare sub 		symbFreeLocalDynVars	( byval proc as FBSYMBOL ptr )

declare sub 		symbFreeScopeDynVars 	( byval scp as FBSYMBOL ptr )

declare sub 		symbDelSymbolTb			( byval tb as FBSYMBOLTB ptr, _
											  byval hashonly as integer )

declare sub 		symbDelScopeTb			( byval scp as FBSYMBOL ptr )

declare sub 		symbDelSymbol			( byval s as FBSYMBOL ptr )

declare function 	symbDelKeyword			( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE ) as integer

declare function 	symbDelDefine			( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE ) as integer

declare sub 		symbDelLabel			( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub			symbDelVar				( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub 		symbDelPrototype		( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub 		symbDelEnum				( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub 		symbDelUDT				( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub 		symbDelConst			( byval s as FBSYMBOL ptr, _
				  							  byval dolookup as integer = TRUE )

declare sub 		symbDelLib				( byval l as FBLIBRARY ptr )

declare sub 		symbDelScope			( byval scp as FBSYMBOL ptr )

declare function 	symbNewSymbol			( byval s as FBSYMBOL ptr, _
					 						  byval symtb as FBSYMBOLTB ptr, _
					 						  byval isglobal as integer, _
					 						  byval class as FB_SYMBCLASS, _
					 						  byval dohash as integer = TRUE, _
					 						  byval symbol as zstring ptr, _
					 						  byval aliasname as zstring ptr, _
					 						  byval typ as integer = INVALID, _
					 						  byval subtype as FBSYMBOL ptr = NULL, _
					 						  byval ptrcnt as integer = 0, _
					 						  byval suffix as integer = INVALID, _
					 						  byval preservecase as integer = FALSE ) as FBSYMBOL ptr

declare sub 		symbFreeSymbol			( byval s as FBSYMBOL ptr, _
									  		  byval movetoglob as integer = FALSE )

declare sub 		symbDelFromHash			( byval s as FBSYMBOL ptr )

declare function 	symbNewArrayDim			( byval s as FBSYMBOL ptr, _
				  		  					  byval lower as integer, _
				  		  					  byval upper as integer ) as FBVARDIM ptr

declare function 	symbCalcLen				( byval typ as integer, _
											  byval subtype as FBSYMBOL ptr, _
											  byval realsize as integer = FALSE ) as integer

declare function 	symbAllocFloatConst		( byval value as double, _
											  byval typ as integer ) as FBSYMBOL ptr

declare function 	symbAllocStrConst		( byval sname as zstring ptr, _
											  byval lgt as integer ) as FBSYMBOL ptr

declare function 	symbAllocWstrConst		( byval sname as wstring ptr, _
											  byval lgt as integer ) as FBSYMBOL ptr

declare function 	symbCalcArrayElements	( byval s as FBSYMBOL ptr, _
											  byval n as FBVARDIM ptr = NULL ) as integer

declare function 	symbCalcArrayDiff		( byval dimensions as integer, _
									  	  	  dTB() as FBARRAYDIM, _
									  	  	  byval lgt as integer ) as integer

declare function 	symbCheckLabels 		( ) as integer

declare function 	symbCheckLocalLabels 	( ) as integer

declare function 	symbCheckBitField		( byval udt as FBSYMBOL ptr, _
											  byval typ as integer, _
											  byval lgt as integer, _
											  byval bits as integer ) as integer

declare sub 		symbCheckFwdRef			( byval s as FBSYMBOL ptr, _
					 						  byval class as integer )

declare function 	symbIsEqual				( byval sym1 as FBSYMBOL ptr, _
					  						  byval sym2 as FBSYMBOL ptr ) as integer

declare function 	symbIsProcOverloadOf	( byval proc as FBSYMBOL ptr, _
							   				  byval parent as FBSYMBOL ptr ) as integer

declare function 	symbVarIsLocalDyn		( byval s as FBSYMBOL ptr ) as integer

declare function 	symbVarIsLocalObj		( byval s as FBSYMBOL ptr ) as integer

declare function 	symbMaxDataType			( byval dtype1 as integer, _
										  	  byval dtype2 as integer ) as integer

declare function 	symbGetDataClass  		( byval dtype as integer ) as integer

declare function 	symbGetDataSize			( byval dtype as integer ) as integer

declare function 	symbGetDataBits			( byval dtype as integer ) as integer

declare function 	symbIsSigned			( byval dtype as integer ) as integer

declare function 	symbGetSignedType		( byval dtype as integer ) as integer

declare function 	symbGetUnsignedType		( byval dtype as integer ) as integer

declare function 	symbRemapType			( byval dtype as integer, _
					  					  	  byval subtype as FBSYMBOL ptr ) as integer

declare function 	symbProcAllocLocals		( byval proc as FBSYMBOL ptr ) as integer

declare function 	symbProcAllocScopes		( byval proc as FBSYMBOL ptr ) as integer

declare function 	symbScopeAllocLocals	( byval sym as FBSYMBOL ptr ) as integer

declare function 	symbFreeDynVar			( byval s as FBSYMBOL ptr ) as ASTNODE ptr

''
'' getters and setters as macros
''

#define symbGetGlobalTbHead( ) symb.globtb.head

#define symbGetLocalTb( ) symb.loctb

#define symbSetLocalTb(tb) symb.loctb = tb

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

#define symbGetLen(s) iif( s <> NULL, s->lgt, 0 )

#define symbGetStrLen(s) symbGetLen(s)

#define symbGetWstrLen(s) (cunsg(s->lgt) \ symbGetDataSize( FB_DATATYPE_WCHAR ))

#define symbGetType(s) s->typ

#define symbGetSubType(s) s->subtype

#define symbGetClass(s) s->class

#define symbGetSymtb(s) s->symtb

#define symbGetParent(s) symbGetSymtb(s)->owner

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

#define symbGetAttrib(s) s->attrib

#define symbSetAttrib(s,t) s->attrib = t

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

#define symbGetArrayDescName(s) symbGetName( s->var.array.desc )

#define symbGetArrayElements(s) s->var.array.elms

#define symbGetProcParams(f) f->proc.params

#define symbGetFuncMode(f) f->proc.mode

#define symbGetOrgName(s) s->name

#define symbGetName(s) s->alias

#define symbGetVarOfs(s) s->ofs

#define symbGetUDTFirstElm(s) s->udt.fldtb.head

#define symbGetUDTNextElm(e) e->next

#define symbGetUDTElmBitOfs(e) ( e->var.elm.ofs * 8 + _
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

#define symbGetScopeTb(s) s->scp.loctb

#define symbGetScopeAllocSize(s) s->scp.bytes

#define symbGetScopeTbHead(s) s->scp.loctb.head

#define symbGetLabelIsDeclared(l) l->lbl.declared

#define symbSetLabelIsDeclared(l) l->lbl.declared = TRUE

#define symbGetLabelParent(l) l->lbl.parent

#define symbGetLabelStmt(s) s->lbl.stmtnum

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

#define symbGetProcLocTb(f) f->proc.loctb

#define symbGetProcLocTbHead(f) f->proc.loctb.head

#define symbGetParamMode(a) a->param.mode

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

#define symbIsDescriptor( s ) ((s->attrib and FB_SYMBATTRIB_DESCRIPTOR) <> 0)

#define symbGetIsLiteral(s) ((s->attrib and FB_SYMBATTRIB_LITERAL) <> 0)

#define symbSetIsLiteral(s) s->attrib or= FB_SYMBATTRIB_LITERAL

#define symbGetCurrentProcName( ) symbGetOrgName( env.currproc )

#define hIsString(t) ((t = FB_DATATYPE_STRING) or (t = FB_DATATYPE_FIXSTR) or (t = FB_DATATYPE_CHAR) or (t = FB_DATATYPE_WCHAR))


''
'' inter-module globals
''
extern symb as SYMBCTX

extern symb_dtypeTB( 0 to FB_DATATYPES-1 ) as SYMB_DATATYPE

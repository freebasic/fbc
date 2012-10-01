'' symbol table module for user defined types (structures and unions)
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "ir.bi"

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbStructBegin _
	( _
		byval symtb as FBSYMBOLTB ptr, _
		byval parent as FBSYMBOL ptr, _
		byval id as const zstring ptr, _
		byval id_alias as const zstring ptr, _
		byval isunion as integer, _
		byval align as integer, _
		byval base_ as FBSYMBOL ptr, _
		byval attrib as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any

	function = NULL

    '' no explict alias given?
    if( id_alias = NULL ) then
    	'' only preserve a case-sensitive version if in BASIC mangling
    	if( parser.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    end if

	s = symbNewSymbol( FB_SYMBOPT_DOHASH, NULL, symtb, NULL, _
	                   FB_SYMBCLASS_STRUCT, id, id_alias, _
	                   FB_DATATYPE_STRUCT, NULL, attrib )
	if( s = NULL ) then
		exit function
	end if

	s->udt.options = iif( isunion, FB_UDTOPT_ISUNION, 0 )
	s->udt.elements = 0

	symbSymbTbInit( s->udt.ns.symtb, s )

    '' not anon? create a new hash tb
    if( parent = NULL ) then
    	symbHashTbInit( s->udt.ns.hashtb, s, FB_INITFIELDNODES )

    '' anonymous, use the parent's hash tb..
    else
    	s->udt.anonparent = parent
    	s->udt.options or= FB_UDTOPT_ISANON
    end if

    '' unused (while mixins aren't supported)
    s->udt.ns.ext = NULL

	''
	s->ofs = 0
	if( fbLangIsSet( FB_LANG_QB ) ) then
		if( align = 0 ) then
			align = 1
		end if
	end if
	s->udt.align = align
	s->udt.lfldlen = 0
	s->udt.bitpos = 0
	s->udt.unpadlgt	= 0

	s->udt.dbg.typenum = INVALID

	s->udt.ext = NULL

	'' extending another UDT?
	if( base_ <> NULL ) then
		static as FBARRAYDIM dTB(0 to 0)

		s->udt.base = symbAddField( s, "$fb_base", 0, dTB(), FB_DATATYPE_STRUCT, base_, symbGetLen( base_ ), 0 )

		symbSetIsUnique( s )
		symbNestBegin( s, FALSE )
		symbNamespaceImportEx( base_, s )

		if( symbGetHasRTTI( base_ ) ) then
			symbSetHasRTTI( s )
		end if
	else
		s->udt.base = NULL
	end if

	function = s
end function

'':::::
private function hGetRealLen _
	( _
		byval orglen as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	select case as const typeGet( dtype )
	'' UDT? return its largest field len
	case FB_DATATYPE_STRUCT
		function = subtype->udt.lfldlen

	'' zstring/wstring/fixlen string? use the character size
	case FB_DATATYPE_CHAR, FB_DATATYPE_FIXSTR, FB_DATATYPE_WCHAR
		function = typeGetSize( dtype )

	'' var-len string: largest field is the pointer at the front
	case FB_DATATYPE_STRING
		function = FB_POINTERSIZE

	case else
		function = orglen
	end select

end function

'':::::
private function hCalcAlign _
	( _
		byval lgt as integer, _
		byval ofs as integer, _
		byval align as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer static

	'' do align?
	if( align = 1 ) then
		return 0
	end if

	'' handle special types
	lgt = hGetRealLen( lgt, dtype, subtype )

	'' default?
	if( align = 0 ) then

	    '' qb didn't do any alignment...
	    if( fbLangIsSet( FB_LANG_QB ) ) then
	    	exit function
	    end if

		select case as const lgt
		'' align byte, short, int, float, double and long long to the natural boundary
		case 1
			exit function
		case 2
			function = (2 - (ofs and (2-1))) and (2-1)
		case 4
			function = (4 - (ofs and (4-1))) and (4-1)
		case 8
			if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
				function = (8 - (ofs and (8-1))) and (8-1)
			else
				function = (4 - (ofs and (4-1))) and (4-1)
			end if
		'' anything else (shouldn't happen), align to sizeof(int)
		case else
			function = (FB_INTEGERSIZE - (ofs and (FB_INTEGERSIZE-1))) and (FB_INTEGERSIZE-1)
		end select

	'' packed..
	else
		if( lgt < align ) then
			align = lgt
		end if

		function = (align - (ofs and (align - 1))) and (align-1)
	end if

end function

private function hCheckUDTSize _
	( _
		byval udtlen as uinteger, _
		byval fieldlen as uinteger, _
		byval fieldpad as uinteger _
	) as integer

	dim as ulongint n = any

	n = udtlen
	n += fieldlen
	n += fieldpad

	if( n > &h7FFFFFFFull ) then
		function = FALSE
		errReport( FB_ERRMSG_UDTTOOBIG )
	else
		function = TRUE
	end if
end function

'':::::
function symbCheckBitField _
	( _
		byval udt as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval lgt as integer, _
		byval bits as integer _
	) as integer

	'' <= 0 or > sizeof(type)?
	if( (bits <= 0) or (bits > lgt*8) ) then
		return FALSE
	end if

	'' not an integer type?
	select case as const typeGet( dtype )
	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE, FB_DATATYPE_SHORT, FB_DATATYPE_USHORT, _
		 FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_LONG, FB_DATATYPE_ULONG

		return TRUE

	case else
		return FALSE
	end select

end function

private function symbAddBitField _
	( _
		byval bitpos as integer, _
		byval bits as integer, _
		byval dtype as integer, _
		byval lgt as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any

	'' table must be the global one, if the UDT is been defined
	'' at main(), it will be deleted before some private function
	'' accessing the bitfield

	sym = symbNewSymbol( FB_SYMBOPT_NONE, NULL, NULL, NULL, _
	                     FB_SYMBCLASS_BITFIELD, NULL, NULL, dtype, NULL )
	if( sym = NULL ) then
		return NULL
	end if

	sym->bitfld.bitpos = bitpos
	sym->bitfld.bits = bits
	sym->lgt = lgt

	function = sym
end function

'':::::
function symbAddField _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as integer, _
		byval bits as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr sym, tail, base_parent
    dim as integer pad, updateudt, elen
    dim as FBHASHTB ptr hashtb

    function = NULL

    '' calc length if it wasn't given
	if( lgt <= 0 ) then
		lgt	= symbCalcLen( dtype, subtype )
	end if

    '' check if the parent ofs must be updated
    updateudt = TRUE
    if( bits > 0 ) then
    	'' last field was a bitfield too? try to merge..
    	if( parent->udt.bitpos > 0 ) then
    		tail = parent->udt.ns.symtb.tail
    		'' does it fit? if not, start at a new pos..
    		if( parent->udt.bitpos + bits > tail->lgt*8 ) then
    			parent->udt.bitpos = 0
    		else
    			'' if it fits but len is different, make it the same
    			if( lgt <> tail->lgt ) then
    				dtype = tail->typ
    				lgt = tail->lgt
    			end if
    		end if
    	end if

		'' don't update if there are enough bits left
		if( parent->udt.bitpos <> 0 ) then
			updateudt = FALSE
		end if

    else
    	parent->udt.bitpos = 0
    end if

	''
	if( updateudt ) then
		pad = hCalcAlign( lgt, parent->ofs, parent->udt.align, dtype, subtype )
		if( pad > 0 ) then

			'' bitfield?
			if( bits > 0 ) then
				'' not M$-way?
				if( env.clopt.msbitfields = FALSE ) then
					'' follow the GCC ABI..
					if( bits <= pad * 8 ) then
						lgt = pad
                        pad = 0

						'' remap type
						select case lgt
						case 1
							if( typeIsSigned( dtype ) ) then
								dtype = FB_DATATYPE_BYTE
							else
								dtype = FB_DATATYPE_UBYTE
							end if
						case 2
							if( typeIsSigned( dtype ) ) then
								dtype = FB_DATATYPE_SHORT
							else
								dtype = FB_DATATYPE_USHORT
							end if

						'' padding won't be >= sizeof(int) because only
						'' integers can be used as bitfields
						end select

					end if

				end if
			end if
		end if

		'' Check whether adding this field would make the UDT be too big
		if( hCheckUDTSize( parent->ofs, lgt, pad ) ) then
			parent->ofs += pad
		else
			'' error recovery: don't add this field
			updateudt = FALSE
		end if

		'' update largest field len
		elen = hGetRealLen( lgt, dtype, subtype )

		'' larger?
		if( elen > parent->udt.lfldlen ) then
			parent->udt.lfldlen = elen
		end if
	end if

	'' bitfield?
	if( bits > 0 ) then
		subtype = symbAddBitField( parent->udt.bitpos, bits, dtype, lgt )
		dtype = FB_DATATYPE_BITFIELD
	end if

    '' use the base parent hashtb if it's an anonymous type
    base_parent = parent
    do while( symbGetUDTIsAnon( base_parent ) )
    	base_parent = symbGetUDTAnonParent( base_parent )
	loop

	hashtb = @symbGetUDTHashTb( base_parent )

    ''
    sym = symbNewSymbol( FB_SYMBOPT_DOHASH, _
    				     NULL, _
    				     @symbGetUDTSymbTb( parent ), hashtb, _
    				     FB_SYMBCLASS_FIELD, _
    				     id, NULL, _
    				     dtype, subtype, _
    				     iif( symbIsLocal( parent ), _
    				     	  FB_SYMBATTRIB_LOCAL, _
    				     	  FB_SYMBATTRIB_NONE ) )
    if( sym = NULL ) then
    	exit function
    end if

	'' add to parent's linked-list
    parent->udt.elements += 1

	sym->lgt = lgt

	if( updateudt or ((parent->udt.options and FB_UDTOPT_ISUNION) <> 0) ) then
		sym->ofs = parent->ofs
	else
		sym->ofs = parent->ofs - lgt
	end if

	''
	sym->var_.initree = NULL

	'' array fields
	sym->var_.array.desc = NULL
	sym->var_.array.dif = symbCalcArrayDiff( dimensions, dTB(), lgt )
	sym->var_.array.dimhead = NULL
	sym->var_.array.dimtail = NULL
	sym->var_.array.has_ellipsis = FALSE

	symbSetArrayDimensions( sym, dimensions )
	if( dimensions > 0 ) then
		for i as integer = 0 to dimensions-1
			symbAddArrayDim( sym, dTB(i).lower, dTB(i).upper )
		next
	end if

	sym->var_.array.elms = symbCalcArrayElements( sym )

	'' multiple len by all array elements (if any)
	lgt *= sym->var_.array.elms

	select case as const typeGet( dtype )
	'' var-len string fields? must add a ctor, copyctor and dtor
	case FB_DATATYPE_STRING
		'' if it's an anon udt, it or parent is an UNION
		if( (parent->udt.options and (FB_UDTOPT_ISUNION or _
									  FB_UDTOPT_ISANON)) <> 0 ) then
			errReport( FB_ERRMSG_VARLENSTRINGINUNION )
		else
			symbSetUDTHasCtorField( parent )
			symbSetUDTHasDtorField( parent )
			symbSetUDTHasPtrField( parent )
		end if

	'' struct with a ctor or dtor? must add a ctor or dtor too
	case FB_DATATYPE_STRUCT
		'' Let the FB_UDTOPT_HASPTRFIELD flag propagate up to the
		'' parent if this field has it.
		if( symbGetUDTHasPtrField( subtype ) ) then
			symbSetUDTHasPtrField( base_parent )
		end if

		if( symbGetCompCtorHead( subtype ) ) then
			'' if it's an anon udt, it or parent is an UNION
			if( (parent->udt.options and (FB_UDTOPT_ISUNION or FB_UDTOPT_ISANON)) <> 0 ) then
				errReport( FB_ERRMSG_CTORINUNION )
			else
				symbSetUDTHasCtorField( parent )
			end if
		end if

		if( symbGetCompDtor( subtype ) ) then
			'' if it's an anon udt, it or parent is an UNION
			if( (parent->udt.options and (FB_UDTOPT_ISUNION or FB_UDTOPT_ISANON)) <> 0 ) then
				errReport( FB_ERRMSG_DTORINUNION )
			else
				symbSetUDTHasDtorField( parent )
			end if
		end if

	end select

	'' check pointers
	if( typeIsPtr( dtype ) ) then
		symbSetUDTHasPtrField( base_parent )
	end if

	'' struct?
	if( (parent->udt.options and FB_UDTOPT_ISUNION) = 0 ) then
		if( updateudt ) then
			parent->ofs += lgt
			parent->lgt = parent->ofs
		end if

		'' update the bit position, wrapping around
		if( bits > 0 ) then
			parent->udt.bitpos += bits
			parent->udt.bitpos and= (typeGetBits( dtype ) - 1)
		end if

	'' union..
	else
		symbSetIsUnionField( sym )

		'' always update, been it a bitfield or not
		parent->ofs = 0
		if( lgt > parent->lgt ) then
			parent->lgt = lgt
		end if

		'' bit position doesn't change in a union

	end if

    function = sym

    sym->parent = parent

end function

'':::::
sub symbInsertInnerUDT _
	( _
		byval parent as FBSYMBOL ptr, _
		byval inner as FBSYMBOL ptr _
	) static

    dim as FBSYMBOL ptr fld
    dim as FBSYMBOLTB ptr symtb
    dim as integer pad

	if( (parent->udt.options and FB_UDTOPT_ISUNION) = 0 ) then
		'' calc padding (should be aligned like if an UDT field was being added)
		pad = hCalcAlign( 0, parent->ofs, parent->udt.align, FB_DATATYPE_STRUCT, inner )
		if( hCheckUDTSize( parent->ofs, 0, pad ) ) then
			parent->ofs += pad
		end if
	end if

    '' move the nodes from inner to parent
    fld = inner->udt.ns.symtb.head

    '' unless it's a fake struct
    if( fld = NULL ) then
    	exit sub
    end if

    fld->prev = parent->udt.ns.symtb.tail
    if( parent->udt.ns.symtb.tail = NULL ) then
    	parent->udt.ns.symtb.head = fld
    else
    	parent->udt.ns.symtb.tail->next = fld
    end if

    symtb = @parent->udt.ns.symtb

    if( (parent->udt.options and FB_UDTOPT_ISUNION) <> 0 ) then
    	'' link to parent
    	do while( fld <> NULL )
    		fld->symtb = symtb

			''
			symbSetIsUnionField( fld )

    		'' next
    		fld = fld->next
    	loop

    else
    	'' link to parent
    	do while( fld <> NULL )
    		fld->symtb = symtb

			'' update the offset
			fld->ofs += parent->ofs

    		'' next
    		fld = fld->next
    	loop
    end if

    parent->udt.ns.symtb.tail = inner->udt.ns.symtb.tail

    '' update elements
    parent->udt.elements += inner->udt.elements

	'' struct? update ofs + len
	if( (parent->udt.options and FB_UDTOPT_ISUNION) = 0 ) then
		parent->ofs += inner->lgt
		parent->lgt = parent->ofs

	'' union.. update len, if bigger
	else
		parent->ofs = 0
		if( inner->lgt > parent->lgt ) then
			parent->lgt = inner->lgt
		end if
	end if

	'' update the largest field len
	if( inner->udt.lfldlen > parent->udt.lfldlen ) then
		parent->udt.lfldlen = inner->udt.lfldlen
	end if

    '' reset bitfield
    parent->udt.bitpos = 0

    '' remove from inner udt list
    inner->udt.ns.symtb.head = NULL
    inner->udt.ns.symtb.tail = NULL

    inner->parent = parent

end sub

'':::::
private function hGetReturnType _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	var dtype = symbGetFullType( sym )
	var res = FB_DATATYPE_VOID

	'' udt has a dtor, copy-ctor or virtual methods? it's never
	'' returned in registers
	if( symbCompIsTrivial( sym ) = FALSE ) then
		return typeAddrOf( dtype )
	end if

	'' use the un-padded UDT len
	select case as const symbGetUDTUnpadLen( sym )
	case 1
		res = FB_DATATYPE_BYTE

	case 2
		res = FB_DATATYPE_SHORT

	case 3
		'' return as int only if first is a short
		if( symbGetUDTFirstElm( sym )->lgt = 2 ) then
			'' and if the struct is not packed
			if( sym->lgt >= FB_INTEGERSIZE ) then
				res = FB_DATATYPE_INTEGER
			end if
		end if

	case FB_INTEGERSIZE

		'' return in ST(0) if there's only one element and it's a SINGLE
		if( sym->udt.elements = 1 ) then
			do
				dim as FBSYMBOL ptr s = symbGetUDTFirstElm( sym )
				if( s->typ = FB_DATATYPE_SINGLE ) then
					res = FB_DATATYPE_SINGLE
				end if

				if( typeGet( s->typ ) <> FB_DATATYPE_STRUCT ) then
					exit do
				end if

				sym = s->subtype

				if( sym->udt.elements <> 1 ) then
					exit do
				end if
			loop
		end if

		if( res = FB_DATATYPE_VOID ) then
			res = FB_DATATYPE_INTEGER
		end if

	case FB_INTEGERSIZE + 1, FB_INTEGERSIZE + 2, FB_INTEGERSIZE + 3

		'' return as longint only if first is a int
		if( symbGetUDTFirstElm( sym )->lgt = FB_INTEGERSIZE ) then
			'' and if the struct is not packed
			if( sym->lgt >= FB_INTEGERSIZE*2 ) then
				res = FB_DATATYPE_LONGINT
			end if
		end if

	case FB_INTEGERSIZE*2

		'' return in ST(0) if there's only one element and it's a DOUBLE
		if( sym->udt.elements = 1 ) then
			do
				dim as FBSYMBOL ptr s = symbGetUDTFirstElm( sym )
				if( s->typ = FB_DATATYPE_DOUBLE ) then
					res = FB_DATATYPE_DOUBLE
				end if

				if( s->typ <> FB_DATATYPE_STRUCT ) then
					exit do
				end if

				sym = s->subtype

				if( sym->udt.elements <> 1 ) then
					exit do
				end if
			loop
		end if

		if( res = FB_DATATYPE_VOID ) then
			res = FB_DATATYPE_LONGINT
		end if

	end select

	res = typeJoin( dtype, res )

	'' if nothing matched, it's the pointer that was passed as the 1st arg
	if( res = FB_DATATYPE_VOID ) then
		res = typeAddrOf( dtype )
	else
		'' C backend? don't change anything
		if( env.clopt.backend = FB_BACKEND_GCC ) then
			res = dtype
		end if
	end if

	function = res

end function

'':::::
sub symbStructEnd _
	( _
		byval sym as FBSYMBOL ptr, _
		byval isnested as integer _
	) static

    dim as integer pad

	'' end nesting?
	if( isnested ) then
		symbNestEnd( FALSE )
	end if

	'' save length without the tail padding added below
	sym->udt.unpadlgt = sym->lgt

	'' do round?
	if( sym->udt.align <> 1 ) then
		'' plus the largest scalar field size (GCC 3.x ABI)
		pad = hCalcAlign( 0, sym->lgt, sym->udt.align, FB_DATATYPE_STRUCT, sym )
		if( hCheckUDTSize( sym->lgt, 0, pad ) ) then
			sym->lgt += pad
		end if
	end if

	'' set the real data type used to return this struct from procs
	sym->udt.ret_dtype = hGetReturnType( sym )

	'' generate the default members
	symbCompAddDefMembers( sym )

	'' check for forward references
	if( symb.fwdrefcnt > 0 ) then
		symbCheckFwdRef( sym )
	end if

end sub

function symbCloneStruct( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr clone = any, fld = any

	'' assuming only simple structs will be cloned (ie: the ones
	'' created by symbAddArrayDesc())

	clone = symbStructBegin( NULL, NULL, symbUniqueId( ), NULL, _
	                         (sym->udt.options and FB_UDTOPT_ISUNION) <> 0, _
	                         sym->udt.align, NULL, 0 )

	fld = sym->udt.ns.symtb.head
	while( fld )
		symbAddField( clone, symbGetName( fld ), 0, dTB(), _
		              symbGetType( fld ), symbGetSubType( fld ), fld->lgt, 0 )
		fld = fld->next
	wend

	symbStructEnd( clone )

	function = clone
end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbDelStruct _
	( _
		byval s as FBSYMBOL ptr _
	)

    if( s = NULL ) then
    	exit sub
    end if

    ''
    symbCompDelImportList( s )

    '' del all udt elements
    do
		'' starting from last because of the USING's that could be
		'' referencing a namespace in the same scope block
		dim as FBSYMBOL ptr fld = symbGetCompSymbTb( s ).tail
		if( fld = NULL ) then
			exit do
		end if

    	'' an ordinary field?
    	if( symbGetClass( fld ) = FB_SYMBCLASS_FIELD ) then
    		'' del array dims if not a scalar type
    		dim as FBVARDIM ptr dim_ = any, dim_nxt = any
    		dim_ = fld->var_.array.dimhead
    		do while( dim_ <> NULL )
    			dim_nxt = dim_->next

    			listDelNode( @symb.dimlist, dim_ )

    			dim_ = dim_nxt
    		loop

    		symbFreeSymbol( fld )

    	'' ctor, dtor, operator or method's local symbol
    	else
    		symbDelSymbol( fld, TRUE )
    	end if
    loop

    ''
    if( s->udt.ext <> NULL ) then
    	deallocate( s->udt.ext )
    	s->udt.ext = NULL
    end if

	''
	if( s->udt.ns.ext <> NULL ) then
		symbCompFreeExt( s->udt.ns.ext )
		s->udt.ns.ext = NULL
	end if

	''
	if( (s->udt.options and FB_UDTOPT_ISANON) = 0 ) then
		hashEnd( @s->udt.ns.hashtb.tb )
	end if

	'' del the udt node
	symbFreeSymbol( s )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbGetUDTFirstElm _
	( _
		byval parent as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = symbGetUDTSymbTbHead( parent )

	'' find the first field
	do while( sym <> NULL )
		if( symbIsField( sym ) ) then
			return sym
		end if
		sym = sym->next
	loop

	function = NULL

end function


'':::::
function symbIsDeeper _
	( _
		byval sym as FBSYMBOL ptr, _
		byval next_ as FBSYMBOL ptr _
	) as integer

	function = FALSE

	if( next_ = NULL ) then
		exit function
	end if

	next_ = next_->parent

	do while( next_ )
		if( next_ = sym ) then
			return TRUE
		end if
		next_ = next_->parent
	loop

end function

'':::::
function symbGetUnionParent _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	function = FALSE

	'' if element's parent is an anonymous non-union struct...
	select case symbGetType( sym )
	case FB_DATATYPE_STRUCT', FB_DATATYPE_CLASS
		if( symbGetUDTIsUnion( sym ) = FALSE ) then
			if( symbGetUDTIsAnon( sym ) ) then

				'' then we use its parent
				if( sym->parent ) then
					if( symbGetUDTIsUnion( sym->parent ) ) then
						function = sym->parent
					end if
				end if
			end if
		else

			'' otherwise, the immediate parent
			function = sym
		end if
	end select

end function

'':::::
function symbGetUDTNextElm _
	( _
		byval sym as FBSYMBOL ptr, _
		byval check_union as integer, _
		byref elms as integer = 0 _
	) as FBSYMBOL ptr

	dim as integer skip_next = FALSE

	'' check for unions
	if( check_union ) then

		dim as FBSYMBOL ptr union_parent = symbGetUnionParent( sym->parent )
		dim as integer skip_the_rest = FALSE

		'' union initialization
		if( union_parent ) then

			'' if the next var isn't a child of this one's parent
			if( sym->next ) then
				if( symbIsDeeper( sym->parent, sym->next ) = FALSE ) then
					skip_the_rest = TRUE
				end if

				'' immediate parent is a union
				if( symbGetUDTIsUnion( sym->parent ) ) then

					'' same parent as next
					if( sym->parent = sym->next->parent ) then
						skip_the_rest = TRUE
					end if
				end if
			end if

			''
			if( skip_the_rest = TRUE ) then

				'' disable auto increment
				skip_next = TRUE

				dim as integer keep_skipping = any
				do
					keep_skipping = FALSE

					'' skip symbols until their parent is no longer the union parent
					do while( iif( sym, symbIsDeeper( union_parent, sym ), FALSE ) )
						sym = sym->next
						elms += 1
					loop

					'' if the previous var is from another struct
					if( sym ) then
						if( sym->prev ) then
							if( sym->parent ) then
								if( sym->parent <> sym->prev->parent ) then

									'' immediately in a union
									if( symbGetUDTIsUnion( sym->parent ) ) then

										'' recalibrate the parent
										union_parent = symbGetUnionParent( sym->parent )

										'' keep skipping if the previous var is in our same union
										if( symbIsDeeper( union_parent, sym->prev ) ) then
											keep_skipping = TRUE
										end if
									end if
								end if
							end if
						end if
					end if
				loop while( keep_skipping = TRUE )
			end if
		end if
	end if

	'' find the next field
	if( skip_next = FALSE ) then
		sym = sym->next
		elms += 1
	end if
	do while( sym <> NULL )
		if( symbIsField( sym ) ) then
			return sym
		end if
		sym = sym->next
		elms += 1
	loop

	function = NULL

end function

''::::::
function symbIsUDTReturnedInRegs _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

	select case typeGetDtAndPtrOnly( symbGetUDTRetType( s ) )
    case typeAddrOf( FB_DATATYPE_STRUCT ), FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    	return FALSE

    case else
    	return TRUE
    end select

end function

'':::::
function symbGetUDTBaseLevel _
	( _
		byval s as FBSYMBOL ptr, _
		byval baseSym as FBSYMBOL ptr _
	) as integer
	
	if( s = NULL or baseSym = NULL ) then
		return 0
	end if

	assert( symbIsStruct( s ) )
	assert( symbIsStruct( baseSym ) )

	var level = 1
	do until( s->udt.base = NULL )
		if( s->udt.base->subtype = baseSym ) then
			return level
		End If
		
		s = s->udt.base->subtype
		level += 1 
	Loop
	
	return 0
	
End Function

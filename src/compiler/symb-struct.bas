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

	s->udt.options = 0
	if( isunion ) then
		symbSetUDTIsUnion( s )
	end if

	symbSymbTbInit( s->udt.ns.symtb, s )

	'' not anon? create a new hash tb
	if( parent = NULL ) then
		symbHashTbInit( s->udt.ns.hashtb, s, FB_INITFIELDNODES )
	'' anonymous, use the parent's hash tb..
	else
		s->udt.anonparent = parent
		symbSetUDTIsAnon( s )
	end if

    '' unused (while mixins aren't supported)
    s->udt.ns.ext = NULL

	''
	s->ofs = 0

	'' Assume FIELD = 1 under -lang qb, because QB didn't do any alignment
	if( fbLangIsSet( FB_LANG_QB ) ) then
		if( align = 0 ) then
			align = 1
		end if
	end if

	s->udt.align = align
	s->udt.natalign = 1
	s->udt.bitpos = 0
	s->udt.unpadlgt	= 0

	s->udt.dbg.typenum = INVALID

	s->udt.ext = NULL

	'' extending another UDT?
	if( base_ <> NULL ) then
		static as FBARRAYDIM dTB(0 to 0)

		s->udt.base = symbAddField( s, "$base", 0, dTB(), FB_DATATYPE_STRUCT, base_, 0, 0 )

		symbSetIsUnique( s )
		symbNestBegin( s, FALSE )
		symbNamespaceImportEx( base_, s )

		if( symbGetHasRTTI( base_ ) ) then
			symbSetHasRTTI( s )

			'' inherit the vtable elements and abstracts counts
			assert( base_->udt.ext->vtableelements >= 2 )
			symbUdtAllocExt( s )
			s->udt.ext->vtableelements = base_->udt.ext->vtableelements
			s->udt.ext->abstractcount = base_->udt.ext->abstractcount
		end if
	else
		s->udt.base = NULL
	end if

	function = s
end function

function typeCalcNaturalAlign _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	dim as integer align = any

	select case as const( typeGet( dtype ) )
	'' UDT? its natural alignment depends on the largest field
	case FB_DATATYPE_STRUCT
		align = subtype->udt.natalign

	'' var-len string: largest field is the pointer at the front
	case FB_DATATYPE_STRING
		align = FB_POINTERSIZE

	case else
		'' Anything else (including zstring/wstring/fixlen strings)
		'' use the base type's size (e.g. character size of strings)
		align = typeGetSize( dtype )
	end select

	if( align = 8 ) then
		'' LONGINT/DOUBLE are 4-byte aligned on Unix (x86 assumption)
		if( env.clopt.target <> FB_COMPTARGET_WIN32 ) then
			align = 4
		end if
	end if

	assert( (align >= 1) and (align <= 8) )

	function = align
end function

private function hCalcPadding _
	( _
		byval ofs as integer, _
		byval align as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	dim as integer natalign = any

	natalign = typeCalcNaturalAlign( dtype, subtype )

	'' default?
	if( align = 0 ) then
		assert( fbLangIsSet( FB_LANG_QB ) = FALSE )
		align = natalign
	'' packed..
	else
		'' Field is ok with smaller alignment than what's given for FIELD=N?
		'' Then the field's alignment takes precedence, i.e. FIELD=N can
		'' only decrease the alignment but not increase it.
		if( align > natalign ) then
			align = natalign
		end if
	end if

	'' Calculate the padding bytes needed to align the current offset,
	'' so that offset mod align = 0.
	function = (align - (ofs and (align - 1))) and (align - 1)
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

	dim as FBSYMBOL ptr sym = any, tail = any, base_parent = any, prevbitfield = any
	dim as integer pad = any, updateudt = any, elen = any
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
			'' Find the last field (skipping over methods etc.)
			tail = parent->udt.ns.symtb.tail
			while( symbIsField( tail ) = FALSE )
				tail = tail->prev
			wend

			assert( symbGetType( tail ) = FB_DATATYPE_BITFIELD )
			prevbitfield = tail->subtype
			assert( symbIsBitfield( prevbitfield ) )

			'' Too many bits to fit into previous bitfield container field?
			if( parent->udt.bitpos + bits > prevbitfield->lgt*8 ) then
				'' Start new container field, this bitfield will be at bitpos 0 in it
				parent->udt.bitpos = 0
			else
				'' The previous container field still has enough
				'' room to hold this new bitfield.

				'' if it fits but len is different, make it the same
				'' TODO: is this "right"? shouldn't the different
				'' type trigger a new container field to be used?
				'' look what gcc does, with/without -mms-bitfields
				'' This for now allows merging bitfields if they
				'' have a different length, but maybe then this
				'' check shouldn't just be done for different lengths,
				'' but always if the dtypes are different?
				if( lgt <> prevbitfield->lgt ) then
					dtype = symbGetType( prevbitfield )
					lgt = prevbitfield->lgt
				end if
			end if
		end if

		'' don't update if there are enough bits left
		if( parent->udt.bitpos <> 0 ) then
			updateudt = FALSE
		end if
	else
		'' Normal fields are not merged into bitfield containers,
		'' so the bitfield merging is interrupted here.
		parent->udt.bitpos = 0
	end if

	''
	if( updateudt ) then
		pad = hCalcPadding( parent->ofs, parent->udt.align, dtype, subtype )
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
		elen = typeCalcNaturalAlign( dtype, subtype )
		'' larger?
		if( elen > parent->udt.natalign ) then
			parent->udt.natalign = elen
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

	sym->lgt = lgt

	if( updateudt or symbGetUDTIsUnion( parent ) ) then
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
		'' not allowed inside unions or anonymous nested structs/unions
		if( symbGetUDTIsUnionOrAnon( parent ) ) then
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
			'' not allowed inside unions or anonymous nested structs/unions
			if( symbGetUDTIsUnionOrAnon( parent ) ) then
				errReport( FB_ERRMSG_CTORINUNION )
			else
				symbSetUDTHasCtorField( parent )
			end if
		end if

		if( symbGetCompDtor( subtype ) ) then
			'' not allowed inside unions or anonymous nested structs/unions
			if( symbGetUDTIsUnionOrAnon( parent ) ) then
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
	if( symbGetUDTIsUnion( parent ) = FALSE ) then
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

sub symbInsertInnerUDT _
	( _
		byval parent as FBSYMBOL ptr, _
		byval inner as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr fld = any
	dim as FBSYMBOLTB ptr symtb = any
	dim as integer pad = any

	if( symbGetUDTIsUnion( parent ) = FALSE ) then
		'' calc padding (should be aligned like if an UDT field was being added)
		pad = hCalcPadding( parent->ofs, parent->udt.align, FB_DATATYPE_STRUCT, inner )
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

	if( symbGetUDTIsUnion( parent ) ) then
    	'' link to parent
    	do while( fld <> NULL )
    		fld->symtb = symtb
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

	'' struct? update ofs + len
	if( symbGetUDTIsUnion( parent ) = FALSE ) then
		parent->ofs += inner->lgt
		parent->lgt = parent->ofs
	'' union.. update len, if bigger
	else
		parent->ofs = 0
		if( inner->lgt > parent->lgt ) then
			parent->lgt = inner->lgt
		end if
	end if

	'' update the natural alignment
	if( inner->udt.natalign > parent->udt.natalign ) then
		parent->udt.natalign = inner->udt.natalign
	end if

    '' reset bitfield
    parent->udt.bitpos = 0

    '' remove from inner udt list
    inner->udt.ns.symtb.head = NULL
    inner->udt.ns.symtb.tail = NULL

    inner->parent = parent

end sub

private function hGetReturnType( byval sym as FBSYMBOL ptr ) as integer
	dim as FBSYMBOL ptr fld = any
	dim as integer res = any

	'' UDT has a dtor, copy-ctor or virtual methods?
	if( symbCompIsTrivial( sym ) = FALSE ) then
		'' It's always returned through a hidden param on stack
		return typeAddrOf( FB_DATATYPE_STRUCT )
	end if

	'' On Linux & co structures are never returned in registers
	if( (env.target.options and FB_TARGETOPT_RETURNINREGS) = 0 ) then
		return typeAddrOf( FB_DATATYPE_STRUCT )
	end if

	'' C backend? Leave the type as-is instead of lowering to the real
	'' "return-in-regs" type, this means we can generate nicer C code,
	'' since UDT vars also use the original type, they can be used with
	'' RETURN in C without needing a cast.
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		return FB_DATATYPE_STRUCT
	end if

	res = FB_DATATYPE_VOID

	'' use the un-padded UDT len
	select case as const symbGetUDTUnpadLen( sym )
	case 1
		res = FB_DATATYPE_BYTE

	case 2
		res = FB_DATATYPE_SHORT

	case 3
		'' return as int only if first is a short
		fld = symbUdtGetFirstField( sym )
		if( fld->lgt = 2 ) then
			'' and if the struct is not packed
			if( sym->lgt >= FB_INTEGERSIZE ) then
				res = FB_DATATYPE_INTEGER
			end if
		end if

	case FB_INTEGERSIZE
		'' return in ST(0) if there's only one element and it's a SINGLE
		do
			fld = symbUdtGetFirstField( sym )

			'' second field?
			if( symbUdtGetNextField( fld ) ) then
				exit do
			end if

			if( typeGetDtAndPtrOnly( fld->typ ) = FB_DATATYPE_SINGLE ) then
				res = FB_DATATYPE_SINGLE
			end if

			if( typeGetDtAndPtrOnly( fld->typ ) <> FB_DATATYPE_STRUCT ) then
				exit do
			end if

			sym = fld->subtype
		loop

		if( res = FB_DATATYPE_VOID ) then
			res = FB_DATATYPE_INTEGER
		end if

	case FB_INTEGERSIZE + 1, FB_INTEGERSIZE + 2, FB_INTEGERSIZE + 3
		'' return as longint only if first is a int
		fld = symbUdtGetFirstField( sym )
		if( fld->lgt = FB_INTEGERSIZE ) then
			'' and if the struct is not packed
			if( sym->lgt >= FB_INTEGERSIZE*2 ) then
				res = FB_DATATYPE_LONGINT
			end if
		end if

	case FB_INTEGERSIZE*2
		'' return in ST(0) if there's only one element and it's a DOUBLE
		do
			fld = symbUdtGetFirstField( sym )

			'' second field?
			if( symbUdtGetNextField( fld ) ) then
				exit do
			end if

			if( typeGetDtAndPtrOnly( fld->typ ) = FB_DATATYPE_DOUBLE ) then
				res = FB_DATATYPE_DOUBLE
			end if

			if( typeGetDtAndPtrOnly( fld->typ ) <> FB_DATATYPE_STRUCT ) then
				exit do
			end if

			sym = fld->subtype
		loop

		if( res = FB_DATATYPE_VOID ) then
			res = FB_DATATYPE_LONGINT
		end if

	end select

	'' Nothing matched?
	if( res = FB_DATATYPE_VOID ) then
		'' Then it's returned through a hidden param on stack
		res = typeAddrOf( FB_DATATYPE_STRUCT )
	end if

	function = res
end function

sub symbStructEnd _
	( _
		byval sym as FBSYMBOL ptr, _
		byval isnested as integer _
	)

	dim as integer pad = any

	'' end nesting?
	if( isnested ) then
		symbNestEnd( FALSE )
	end if

	'' save length without the tail padding added below
	sym->udt.unpadlgt = sym->lgt

	'' Add tail padding bytes, i.e. round up the structure size to match
	'' the alignment of the largest natural field.
	pad = hCalcPadding( sym->lgt, sym->udt.align, FB_DATATYPE_STRUCT, sym )
	if( hCheckUDTSize( sym->lgt, 0, pad ) ) then
		sym->lgt += pad
	end if

	'' set the real data type used to return this struct from procs
	sym->udt.retdtype = hGetReturnType( sym )

	'' Declare & add any implicit members
	symbUdtAddDefaultMembers( sym )

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
	                         symbGetUDTIsUnion( sym ), _
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

sub symbDelField( byval s as FBSYMBOL ptr )
	if( symbGetArrayDimensions( s ) > 0 ) then
		symbDelVarDims( s )
	end if
	symbFreeSymbol( s )
end sub

sub symbDelStruct( byval s as FBSYMBOL ptr )
	symbDelNamespaceMembers( s, (not symbGetUDTIsAnon( s )) )

	if( s->udt.ext ) then
		deallocate( s->udt.ext )
		s->udt.ext = NULL
	end if

	symbFreeSymbol( s )
end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private function hSkipToField( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	'' Skip over anything that isn't a field,
	'' e.g. PROCs (methods) or NSIMPORTs (in derived UDTs)
	while( sym )
		if( symbIsField( sym ) ) then
			exit while
		end if
		sym = sym->next
	wend
	function = sym
end function

function symbUdtGetFirstField( byval parent as FBSYMBOL ptr ) as FBSYMBOL ptr
	'' Get first member that is a field
	function = hSkipToField( symbGetUDTSymbTbHead( parent ) )
end function

function symbUdtGetNextField( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	function = hSkipToField( sym->next )
end function

private function hFindCommonParent _
	( _
		byval a as FBSYMBOL ptr, _
		byval b as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr originalb = any

	originalb = b

	'' For a and each parent of a,
	'' check whether it matches b or one of b's parents.
	while( a )
		b = originalb
		while( b )
			if( a = b ) then
				return a
			end if
			b = b->parent
		wend
		a = a->parent
	wend

	function = NULL
end function

function symbUdtGetNextInitableField( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	dim as FBSYMBOL ptr original = any, parent = any

	''
	'' Move to the next field that should be initialized.
	'' Unions are special cases: only their first field can be initialized,
	'' so if <sym> is from a union, the remaining fields in the union
	'' must be skipped.
	''
	'' Example:
	''
	''    type
	''        a as integer            '' reached
	''        union
	''            b as integer        '' reached
	''            c as integer        '' skipped
	''        end union
	''        union
	''            d as integer        '' reached
	''        end union
	''        e as integer            '' reached
	''        union
	''            type
	''                f as integer    '' reached
	''                g as integer    '' reached
	''            end type
	''            h as integer        '' skipped
	''            type
	''                i as integer    '' skipped
	''                j as integer    '' skipped
	''            end type
	''            k as integer        '' skipped
	''        end union
	''        l as integer            '' reached
	''    end type
	''

	original = sym

	do
		'' Move to next field, if any
		sym = symbUdtGetNextField( sym )
		if( sym = NULL ) then
			exit do
		end if

		'' If the greatest common parent of the reached field and the
		'' original field is a union (not a struct), then the reached
		'' field must be skipped.
		parent = hFindCommonParent( original, sym )
		if( parent = NULL ) then
			exit do
		end if
		if( symbGetUDTIsUnion( parent ) = FALSE ) then
			exit do
		end if
	loop

	function = sym
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

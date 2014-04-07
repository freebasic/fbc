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

		s->udt.base = symbAddField( s, "$base", 0, dTB(), FB_DATATYPE_STRUCT, base_, 0, 0, 0 )

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
		align = env.pointersize

	case else
		'' Anything else (including zstring/wstring/fixlen strings)
		'' use the base type's size (e.g. character size of strings)
		align = typeGetSize( dtype )
	end select

	if( fbIs64bit( ) = FALSE ) then
		'' LONGINT/DOUBLE are 4-byte aligned on 32bit, except on Win32
		'' (i.e. we don't have anything 8-byte aligned in this case)
		if( align = 8 ) then
			if( env.clopt.target <> FB_COMPTARGET_WIN32 ) then
				align = 4
			end if
		end if
	end if

	assert( (align >= 1) and (align <= 8) )

	function = align
end function

private function hCalcPadding _
	( _
		byval ofs as longint, _
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
		byval udtlen as ulongint, _
		byval fieldlen as ulongint, _
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
		byval lgt as longint, _
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

''
'' Add a new field, it can be one of:
''
'' a) A real field taking up memory in the structure, i.e. struct layout always
''    changes in this case. The new field is appended to the end of the
''    structure, possibly preceded by padding bytes between the previous field
''    and the new one.
''
'' b) A bitfield, which is either merged into an existing memory chunk at the
''    end of the structure (conceptually: container field, as represented by
''    by the first bitfield in the memory chunk), or causes a new "container
''    field" to be started and becomes the first bitfield in it. In the former
''    case, the struct layout doesn't change; in the latter, it changes.
''
'' c) A fake dynamic array field, which causes a corresponding real descriptor
''    field to be added recursively. The fake array field does not use up any
''    memory, only the descriptor will actually be emitted. While adding the
''    fake array field, the struct layout doesn't change. When adding the
''    descriptor, it changes, as with any other real field.
''
function symbAddField _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as longint, _
		byval bits as integer, _
		byval attrib as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any, tail = any, base_parent = any, desc = any
	dim as integer pad = any, alloc_field = any, elen = any
	dim as longint offset = any
	dim as string arrayid

	function = NULL
	desc = NULL

    '' calc length if it wasn't given
	if( lgt <= 0 ) then
		lgt	= symbCalcLen( dtype, subtype )
	end if

	'' Dynamic array field? Recursively add the corresponding descriptor field.
	if( attrib and FB_SYMBATTRIB_DYNAMIC ) then
		assert( dimensions = -1 )

		'' Because this is done here at the top:
		''  - the descriptor will be added before the fake array,
		''    allowing the fake array to be "merged" into the descriptor
		''  - we have to worry about the symbUniqueId() call
		dim as FBARRAYDIM emptydTB(0 to 0)

		'' Using symbUniqueId() below, which may overwrite the array's
		'' own id if it was generated with symbUniqueId() aswell, unless
		'' it's saved separately.
		arrayid = *id
		id = strptr( arrayid )

		desc = symbAddField( parent, symbUniqueId( ), 0, emptydTB(), _
				FB_DATATYPE_STRUCT, symb.fbarray, 0, 0, FB_SYMBATTRIB_DESCRIPTOR )

		'' Same offset for the fake array field as for the descriptor,
		'' to make astNewARG()'s job easier
		offset = desc->ofs
		alloc_field = FALSE
	else
		assert( dimensions >= 0 )

		'' All other fields default to the next available offset,
		'' except bitfields which are given special treatment below.
		offset = parent->ofs
		alloc_field = TRUE
	end if

	'' Check for bitfield
	if( bits > 0 ) then
		'' last field was a bitfield too? try to merge..
		if( parent->udt.bitpos > 0 ) then
			'' Find the last field (skipping over methods etc.)
			tail = parent->udt.ns.symtb.tail
			while( symbIsField( tail ) = FALSE )
				tail = tail->prev
			wend

			assert( symbIsBitfield( tail ) )

			'' Too many bits to fit into previous bitfield container field?
			if( parent->udt.bitpos + bits > tail->lgt*8 ) then
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
				if( lgt <> tail->lgt ) then
					dtype = symbGetType( tail )
					lgt = tail->lgt
				end if

				'' Put this bitfield into the same container as the previous bitfield,
				'' i.e. same base offset as the previous bitfield.
				offset = tail->ofs
				alloc_field = FALSE
			end if
		end if
	else
		'' Normal fields are not merged into bitfield containers,
		'' so the bitfield merging is interrupted here.
		parent->udt.bitpos = 0
	end if

	'' Add padding for normal fields (neither bitfield nor fake array)
	if( alloc_field ) then
		pad = hCalcPadding( offset, parent->udt.align, dtype, subtype )
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
		if( hCheckUDTSize( offset, lgt, pad ) ) then
			offset += pad
		else
			'' error recovery: don't add this field
			alloc_field = FALSE
		end if

		'' update largest field len
		elen = typeCalcNaturalAlign( dtype, subtype )
		'' larger?
		if( elen > parent->udt.natalign ) then
			parent->udt.natalign = elen
		end if
	end if

    '' use the base parent hashtb if it's an anonymous type
    base_parent = parent
    do while( symbGetUDTIsAnon( base_parent ) )
    	base_parent = symbGetUDTAnonParent( base_parent )
	loop

	'' Preserve LOCAL
	attrib or= (parent->attrib and FB_SYMBATTRIB_LOCAL)

	sym = symbNewSymbol( FB_SYMBOPT_DOHASH, NULL, _
			@symbGetUDTSymbTb( parent ), @symbGetUDTHashTb( base_parent ), _
			FB_SYMBCLASS_FIELD, id, NULL, dtype, subtype, _
			attrib )
	if( sym = NULL ) then
		exit function
	end if

	sym->lgt = lgt
	sym->ofs = offset
	symbVarInitFields( sym )
	symbVarInitArrayDimensions( sym, dimensions, dTB() )
	if( desc ) then
		sym->var_.array.desc = desc
		desc->var_.desc.array = sym  '' desc's backlink

		symbSetTypeIniTree( desc, astBuildArrayDescIniTree( desc, sym, NULL ) )
	end if
	sym->var_.bitpos = parent->udt.bitpos
	sym->var_.bits = bits

	'' multiple len by all array elements (if any)
	lgt *= symbGetArrayElements( sym )

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

	'' Dynamic array? Same restrictions as STRINGs
	if( dimensions = -1 ) then
		if( symbGetUDTIsUnionOrAnon( parent ) ) then
			errReport( FB_ERRMSG_DYNAMICARRAYINUNION )
		else
			symbSetUDTHasCtorField( parent )
			symbSetUDTHasDtorField( parent )
			symbSetUDTHasPtrField( parent )
		end if
	end if

	'' check pointers
	if( typeIsPtr( dtype ) ) then
		symbSetUDTHasPtrField( base_parent )
	end if

	'' Union?
	if( symbGetUDTIsUnion( parent ) ) then
		symbSetIsUnionField( sym )

		'' All fields start at offset 0 again; bitfield bitpos never increases
		assert( parent->ofs = 0 )
		assert( parent->udt.bitpos = 0 )

		if( alloc_field ) then
			'' Union's size is the max field size
			if( parent->lgt < lgt ) then
				parent->lgt = lgt
			end if
		end if
	else
		'' Update struct size, if a new (non-fake) field was started
		if( alloc_field ) then
			offset += lgt
			parent->ofs = offset
			parent->lgt = offset
		end if

		'' Update bitpos if non-zero
		parent->udt.bitpos += bits
	end if

	sym->parent = parent

	function = sym
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

	'' Link fields to the parent, so lookups will find them, but without
	'' breaking their FBSYMBOL.parent pointers which are needed for
	'' correct traversal of the tree of nested structs/unions.
	while( fld )

		fld->symtb = symtb

		if( symbGetUDTIsUnion( parent ) ) then
			symbSetIsUnionField( fld )
		else
			fld->ofs += parent->ofs
		end if

		fld = fld->next
	wend

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
	dim as integer res = any, unpadlen = any
	dim as longint unpadlen64 = any

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

	'' Check whether the structure is small enough to be returned in
	'' registers, and if so, select the proper dtype. For this, the
	'' un-padded UDT length should be checked so we can handle the cases
	'' where length=1/2/3.
	unpadlen64 = symbGetUDTUnpadLen( sym )

	'' Check for longint -> integer overflow, otherwise that could happen
	'' to the SELECT's temp var below
	unpadlen = unpadlen64
	if( unpadlen <> unpadlen64 ) then
		'' very big structure (> 2GiB), no way to return in registers
		return FB_DATATYPE_STRUCT
	end if

	select case as const( unpadlen )
	case 1
		res = FB_DATATYPE_BYTE

	case 2
		res = FB_DATATYPE_SHORT

	case 3
		'' return as int only if first is a short
		fld = symbUdtGetFirstField( sym )
		if( fld->lgt = 2 ) then
			'' and if the struct is not packed
			if( sym->lgt >= 4 ) then
				res = FB_DATATYPE_INTEGER
			end if
		end if

	case 4
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

	case 5, 6, 7
		'' return as longint only if first is a int
		fld = symbUdtGetFirstField( sym )
		if( fld->lgt = 4 ) then
			'' and if the struct is not packed
			if( sym->lgt >= 8 ) then
				res = FB_DATATYPE_LONGINT
			end if
		end if

	case 8
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
		assert( symbIsDynamic( fld ) = FALSE )
		assert( symbIsDescriptor( fld ) = FALSE )
		symbAddField( clone, symbGetName( fld ), 0, dTB(), _
		              symbGetType( fld ), symbGetSubType( fld ), fld->lgt, 0, fld->attrib )
		fld = fld->next
	wend

	symbStructEnd( clone )

	function = clone
end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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

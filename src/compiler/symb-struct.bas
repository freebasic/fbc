'' symbol table module for user defined types (structures and unions)
''
'' chng: sep/2004 written [v1ctor]
''       jan/2005 updated to use real linked-lists [v1ctor]


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
		byval hashtb as FBHASHTB ptr, _
		byval parent as FBSYMBOL ptr, _
		byval id as const zstring ptr, _
		byval id_alias as const zstring ptr, _
		byval isunion as integer, _
		byval align as integer, _
		byval is_derived as integer, _
		byval attrib as FB_SYMBATTRIB, _
		byval options as integer _
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

	s = symbNewSymbol( options or FB_SYMBOPT_DOHASH, NULL, symtb, hashtb, _
					   FB_SYMBCLASS_STRUCT, id, id_alias, _
					   FB_DATATYPE_STRUCT, NULL, attrib, FB_PROCATTRIB_NONE )
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
			'' emcripten doesn't support unaligned memory access
			if( env.clopt.target <> FB_COMPTARGET_JS ) then
				align = 1
			end if
		end if
	end if

	s->udt.align = align
	s->udt.natalign = 1
	s->udt.bitpos = 0
	s->udt.unpadlgt = 0
	s->udt.retdtype = FB_DATATYPE_INVALID
	s->udt.dbg.typenum = INVALID
	s->udt.ext = NULL
	s->udt.base = NULL

	if( is_derived ) then
		symbSetIsUnique( s )
		symbNestBegin( s, FALSE )
	end if

	function = s
end function

sub symbStructAddBase( byval s as FBSYMBOL ptr, byval base_ as FBSYMBOL ptr )
	static as FBARRAYDIM dTB(0 to 0)

	assert( s->udt.base = NULL )

	'' (using base$ instead of $base to prevent gdb/stabs confusion,
	'' where leading $ has special meaning)
	s->udt.base = symbAddField( s, "base$", 0, dTB(), FB_DATATYPE_STRUCT, base_, 0, 0, 0 )

	symbNamespaceImportEx( base_, s )

	if( symbGetHasRTTI( base_ ) ) then
		symbSetHasRTTI( s )

		'' inherit the vtable elements and abstracts counts
		assert( base_->udt.ext->vtableelements >= 2 )
		symbUdtAllocExt( s )
		s->udt.ext->vtableelements = base_->udt.ext->vtableelements
		s->udt.ext->abstractcount = base_->udt.ext->abstractcount
	end if
end sub

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

	'' LONGINT/DOUBLE are 4-byte aligned on 32bit x86 Linux/DOS/BSD,
	'' but 8-byte aligned on other systems (Win32/Win64, 64bit Linux/BSD,
	'' ARM Linux)
	if( (fbGetCpuFamily( ) = FB_CPUFAMILY_X86) and _
		(env.clopt.target <> FB_COMPTARGET_WIN32) ) then
		'' As a result, on 32bit x86 Linux/DOS/BSD, everything that is
		'' otherwise 8-byte aligned, is actually 4-byte aligned.
		if( align = 8 ) then
			align = 4
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
		 FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
		 FB_DATATYPE_BOOLEAN
		return TRUE

	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		'' Allow 64bit bitfields on 64bit
		'' TODO: 64bit bitfields on 32bit -- currently not supported
		'' because bitfield accesses are based on the default word size
		function = fbIs64bit( )
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
		byval attrib as FB_SYMBATTRIB _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any, tail = any, base_parent = any, _
		desc = any, desctype = any
	dim as integer pad = any, alloc_field = any, elen = any, options = any
	dim as longint offset = any

	function = NULL
	desc = NULL

	'' calc length if it wasn't given
	if( lgt <= 0 ) then
		lgt = symbCalcLen( dtype, subtype )
	end if

	'' Dynamic array field? Recursively add the corresponding descriptor field.
	if( attrib and FB_SYMBATTRIB_DYNAMIC ) then
		assert( dimensions > 0 )

		'' Because this is done here at the top:
		''  - the descriptor will be added before the fake array,
		''    allowing the fake array to be "merged" into the descriptor
		''  - we have to worry about the symbUniqueId() call
		dim as FBARRAYDIM emptydTB(0 to 0)

		'' Note: using the exact descriptor type corresponding to the
		'' amount of dimensions found in the field declaration.
		desctype = symbAddArrayDescriptorType( dimensions, dtype, subtype )

		desc = symbAddField( parent, id, 0, emptydTB(), _
				FB_DATATYPE_STRUCT, desctype, _
				0, 0, FB_SYMBATTRIB_DESCRIPTOR )

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
		symbSetUdtHasBitfield( parent )

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

	'' Don't add dynamic array descriptor fields to the hashtb. They use the
	'' same id as the corresponding dynamic array fields, so they would
	'' collide. And we don't need to look them up anyways. (this is also
	'' what symbAddArrayDesc() does for dynamic array variables)
	options = 0
	if( (attrib and FB_SYMBATTRIB_DESCRIPTOR) = 0 ) then
		options = FB_SYMBOPT_DOHASH
	end if

	sym = symbNewSymbol( options, NULL, _
			@symbGetUDTSymbTb( parent ), @symbGetUDTHashTb( base_parent ), _
			FB_SYMBCLASS_FIELD, id, NULL, dtype, subtype, _
			attrib, FB_PROCATTRIB_NONE )
	if( sym = NULL ) then
		exit function
	end if

	sym->lgt = lgt
	sym->ofs = offset
	symbVarInitFields( sym )
	symbVarInitArrayDimensions( sym, dimensions, dTB() )
	if( desc ) then
		sym->var_.array.desc = desc
		sym->var_.array.desctype = desc->subtype
		desc->var_.desc.array = sym  '' desc's backlink

		symbSetTypeIniTree( desc, astBuildArrayDescIniTree( desc, sym, NULL ) )
	end if
	sym->var_.bitpos = parent->udt.bitpos
	sym->var_.bits = bits

	'' Dynamic array? Same restrictions as STRINGs. No need to check the
	'' array's dtype because only the descriptor will be included in the
	'' UDT, not the array data.
	if( attrib and FB_SYMBATTRIB_DYNAMIC ) then
		if( symbGetUDTIsUnionOrAnon( parent ) ) then
			errReport( FB_ERRMSG_DYNAMICARRAYINUNION )
		else
			symbSetUDTHasCtorField( parent )
			symbSetUDTHasDtorField( parent )
			symbSetUDTHasPtrField( parent )
		end if
	else
		select case( typeGetDtAndPtrOnly( dtype ) )
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

			if( symbGetCompDtor1( subtype ) ) then
				'' not allowed inside unions or anonymous nested structs/unions
				if( symbGetUDTIsUnionOrAnon( parent ) ) then
					errReport( FB_ERRMSG_DTORINUNION )
				else
					symbSetUDTHasDtorField( parent )
				end if
			end if

		end select
	end if

	'' check pointers
	if( typeIsPtr( dtype ) ) then
		symbSetUDTHasPtrField( base_parent )
	end if

	var realsize = symbGetRealSize( sym )

	'' Union?
	if( symbGetUDTIsUnion( parent ) ) then
		symbSetIsUnionField( sym )

		'' All fields start at offset 0 again; bitfield bitpos never increases
		assert( parent->ofs = 0 )
		assert( parent->udt.bitpos = 0 )

		if( alloc_field ) then
			'' Union's size is the max field size
			if( parent->lgt < realsize ) then
				parent->lgt = realsize
			end if
		end if
	else
		'' Update struct size, if a new (non-fake) field was started
		if( alloc_field ) then
			offset += realsize
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

	'' Propagate FB_UDTOPT_HASBITFIELD flag, for the C backend
	if( symbGetUdtHasBitfield( inner ) ) then
		symbSetUdtHasBitfield( parent )
	end if

end sub

''================================================
'' for Linux structure parameters size<=16 bytes
''================================================
'' if the structure size is less or equal to 16 bytes it could be passed directly in registers according the datatype fields
'' integers and floats could even be mixed using Rxx and Xmm
'' analyzing the 8 low bytes then the 8 high bytes to know if each block contains integer or/and float
'' if at least one integer field all the range is considered as integer
'' if the size is greater than 8 and the result is only KPART1FLOAT or KPART1INTEGER then the structure is totally float or totally integer
'' (the structure contains only an array of simple datatype) and the result is forced to KSTRUCT_XX or KSTRUCT_RR
''================================================
private sub struct_analyze( byval fld as FBSYMBOL ptr, byref part1 as integer, byref part2 as integer, byref range as integer )

	dim as integer lgt=fld->lgt
	fld = symbUdtGetFirstField(fld)
	while fld
		if range=KLOW8BYTES and fld->ofs>7 then
			range = KHIGH8BYTES
			part2 = KPART2FLOAT ''default
		end if

		if typegetclass(fld->typ)=FB_DATACLASS_UDT then
			struct_analyze(fld->subtype,part1,part2,range)
		elseif typegetclass(fld->typ)=FB_DATACLASS_INTEGER then
			if range=KLOW8BYTES then
				part1=KPART1INTEGER
			else
				part2=KPART2INTEGER
			end if
		end if
		fld=symbUdtGetNextField(fld)
	wend

	if lgt>8 then
		''case array in type eg type udt / array(0 to 1) as integer /end type
		if part1+part2=KPART1INTEGER then
			part1=KSTRUCT_RR
		elseif part1+part2=KPART1FLOAT then
			part1=KSTRUCT_XX
		end if
	end if

end sub
function hGetMagicStructNumber( byval sym as FBSYMBOL ptr ) as integer
	'' by default floating point for first register
	dim as integer part1 = KPART1FLOAT
	dim as integer part2 = KPARTNOTDEF
	dim as integer range = KLOW8BYTES

	struct_analyze( sym, part1, part2, range )

	return part1 + part2
end function

private function hGetReturnTypeGas64SystemV( byval sym as FBSYMBOL ptr ) as integer

	assert( env.clopt.backend = FB_BACKEND_GAS64 )
	assert( (env.clopt.target = FB_COMPTARGET_LINUX) or  (env.clopt.target = FB_COMPTARGET_FREEBSD))

	'' Linux gas64 could use 2 registers

	if( sym->lgt <= typeGetSize( FB_DATATYPE_LONGINT ) * 2 ) then
		select case as const hGetMagicStructNumber( sym )
			case KSTRUCT_R ''only integers in RAX
				'' don't set retin2regs, it's handled by datatype only
				'' sym->udt.retin2regs = FB_STRUCT_R
				return FB_DATATYPE_LONGINT
			case KSTRUCT_X ''only floats in XMM0
				'' don't set retin2regs, it's handled by datatype only
				'' sym->udt.retin2regs = FB_STRUCT_X
				return FB_DATATYPE_DOUBLE
			case KSTRUCT_RR ''only integers in RAX/RDX
				sym->udt.retin2regs = FB_STRUCT_RR
				return FB_DATATYPE_STRUCT
			case KSTRUCT_RX ''first part in RAX then in XMMO
				 sym->udt.retin2regs = FB_STRUCT_RX
				 return FB_DATATYPE_STRUCT
			case KSTRUCT_XR ''first part in XMMO then in RAX
				sym->udt.retin2regs = FB_STRUCT_XR
				return FB_DATATYPE_STRUCT
			case KSTRUCT_XX ''only floats in XMM0/XMM1
				sym->udt.retin2regs = FB_STRUCT_XX
				return FB_DATATYPE_STRUCT
			case else
				return FB_DATATYPE_STRUCT
		end select
	end if

	''size>16 --> FB_DATATYPE_STRUCT
	return typeAddrOf( FB_DATATYPE_STRUCT )

end function

private function hGetReturnType( byval sym as FBSYMBOL ptr ) as integer
	dim as FBSYMBOL ptr fld = any
	dim as integer res = any, unpadlen = any
	dim as longint unpadlen64 = any

	'' UDT has a dtor, copy-ctor or virtual methods?
	if( symbCompIsTrivial( sym ) = FALSE ) then
		'' It's always returned through a hidden param on stack,
		'' even for the C backend, because gcc doesn't get to see
		'' ctors/dtors/virtuals and thus would think it's trivial and,
		'' if small enough, ok to be returned in registers, which would
		'' be wrong.
		return typeAddrOf( FB_DATATYPE_STRUCT )
	end if

	'' C backend: Trivial structs can just be returned as-is, no need to
	'' "lower the AST" to using registers or a hidden pointer parameter and
	'' pointer result. Instead, gcc will do that.
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		return FB_DATATYPE_STRUCT
	end if

	'' 64-bit + gas64 + linux?
	if( fbIs64Bit() ) then
		if( env.clopt.backend = FB_BACKEND_GAS64 ) then
			'' linux 64bit allows structure returned in registers
			'' !!!TODO!!! add to target options
			if( (env.clopt.target = FB_COMPTARGET_LINUX) or (env.clopt.target = FB_COMPTARGET_FREEBSD)) then
				return hGetReturnTypeGas64SystemV( sym )
			end if
		end if
	end if

	'' Otherwise, on Linux & co structures are never returned in registers
	if( (env.target.options and FB_TARGETOPT_RETURNINREGS) = 0 ) then
		return typeAddrOf( FB_DATATYPE_STRUCT )
	end if

	'' Otherwise, 32-bit gas (linux / dos) &  64-bit BSD's, etc
	'' compute a usable return type

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
				res = FB_DATATYPE_LONG
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
			res = FB_DATATYPE_LONG
		end if

	case 5, 6, 7
		'' return as longint only if first is a small int
		fld = symbUdtGetFirstField( sym )
		if( fld->lgt <= 4 ) then
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

	dim as SYMBDEFAULTMEMBERS defaultmembers = any
	dim as integer pad = any
	dim mode as FB_FUNCMODE = any

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

	'' default mode for default non-static members
	mode = FB_FUNCMODE_CDECL

	'' extern "c++" / win32 / x86 ? then
	'' default to THISCALL for default non-static members
	if( parser.mangling = FB_MANGLING_CPP ) then
		if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
			if( fbIs64bit( ) = FALSE ) then
				if( env.clopt.nothiscall = FALSE ) then
					mode = FB_FUNCMODE_THISCALL
				end if
			end if
		end if
	end if

	'' Declare implicit members (but don't implement them yet)
	symbUdtDeclareDefaultMembers( defaultmembers, sym, mode )

	'' Determine how to return this structure from procedures
	'' (must be done after declaring default members because it depends on
	'' symbCompIsTrivial() which depends on knowing all ctors/dtors)

	'' set default for 'udt.retin2regs' first
	'' side effect of calling hGetReturnType() will be setting 'sym->udt.retin2regs'
	sym->udt.retin2regs = FB_STRUCT_NONE ''for gas64

	'' compute the return type
	sym->udt.retdtype = hGetReturnType( sym )

	''
	'' Now that the UDT return type is known we can build code using it,
	'' such as the implicit methods' bodies, or the function pointers for
	'' the vtable slots.
	''
	'' Methods declared by the user using the UDT itself will be fixed up
	'' by hPatchByvalParamsToSelf/hPatchByvalResultToSelf, but that only
	'' works for declarations, not implementations.
	''
	'' Furthermore, function pointers (such as the vtable ones) can be added
	'' to a different namespace, i.e. not the UDT, so the hPatch* functions
	'' wouldn't handle them anyways.
	''
	symbUdtImplementDefaultMembers( defaultmembers, sym )

	'' check for forward references
	if( symb.fwdrefcnt > 0 ) then
		symbCheckFwdRef( sym )
	end if

end sub

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

'' Check whether s is derived from baseSym, and if so, how many levels separate
'' the two in the inheritance hierachy. For example:
''    same UDT, or not derived at all = 0 levels
''    directly derived = 1 level
''    derived from a directly derived UDT = 2 levels
''    etc.
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

function symbCloneSimpleStruct( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr

	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr s = any
	dim as FBSYMBOL ptr fld = any

	'' only will work with very simple structs, no ctor/dtor's
	'' no unions, bitfields, etc...

	'' used for __builtin_va_list mangle modifier, we only ever refer to this struct
	'' through the typedef, so it doesn't need a visible name

	s = symbStructBegin( NULL, NULL, NULL, symbUniqueLabel( ), sym->id.alias, FALSE, 0, FALSE, 0, 0 )

	fld = symbUdtGetFirstField( sym )
	while( fld )
		symbAddField( s, fld->id.name, 0, dTB(), symbGetFullType( fld ), symbGetSubtype( fld ), 0, 0, 0 )
		fld = symbUdtGetNextField( fld )
	wend

	'' end type
	symbStructEnd( s )

	function = s

end function

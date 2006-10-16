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


'' symbol table module for user defined types (structures and unions)
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ir.bi"

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbStructBegin _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval isunion as integer, _
		byval align as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s

    function = NULL

    '' no explict alias given?
    if( id_alias = NULL ) then
    	'' only preserve a case-sensitive version if in BASIC mangling
    	if( parser.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    end if

    s = symbNewSymbol( FB_SYMBOPT_DOHASH, _
    				   NULL, _
    				   NULL, NULL, _
    				   FB_SYMBCLASS_STRUCT, _
    				   id, id_alias, _
    				   FB_DATATYPE_STRUCT, NULL, 0 )
	if( s = NULL ) then
		exit function
	end if

	s->udt.options = iif( isunion, FB_UDTOPT_ISUNION, 0 )
	s->udt.elements = 0

	symbSymbTbInit( s->udt.symtb, s )

    '' not anon? create a new hash tb
    if( parent = NULL ) then
    	symbHashTbInit( s->udt.hashtb, s, FB_INITFIELDNODES )

    '' anonymous, use the parent's hash tb..
    else
    	s->udt.anonparent = parent
    	s->udt.options or= FB_UDTOPT_ISANON
    end if

	s->ofs = 0
	s->udt.align = align
	s->udt.lfldlen = 0
	s->udt.bitpos = 0
	s->udt.unpadlgt	= 0

	s->udt.dbg.typenum = INVALID

	s->udt.ext = NULL

	function = s

end function

'':::::
private function hGetRealLen _
	( _
		byval orglen as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer static

	select case as const dtype
	'' UDT? return its largest field len
	case FB_DATATYPE_STRUCT
		function = subtype->udt.lfldlen

	'' zstring or fixed-len? size is actually sizeof(byte)
	case FB_DATATYPE_CHAR, FB_DATATYPE_FIXSTR
		function = 1

	'' wstring?
	case FB_DATATYPE_WCHAR
		function = env.target.wchar.size

	'' var-len string: first field is a pointer
	case FB_DATATYPE_STRING
		function = FB_POINTERSIZE

	case else
		function = orglen
	end select

end function

'':::::
private function hCalcALign _
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
		select case as const lgt
		'' align byte, short, int, float, double and long long to the natural boundary
		case 1
			exit function
		case 2
			function = (2 - (ofs and (2-1))) and (2-1)
		case 4
			function = (4 - (ofs and (4-1))) and (4-1)
		case 8
			function = (8 - (ofs and (8-1))) and (8-1)

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

'':::::
function symbCheckBitField _
	( _
		byval udt as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval lgt as integer, _
		byval bits as integer _
	) as integer

	'' <= 0 or > sizeof(type) or not an integer type?
	if( (bits <= 0) or _
		(bits > lgt*8) or _
		(dtype >= FB_DATATYPE_ENUM) ) then
		return FALSE
	end if

    return TRUE

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
		byval ptrcnt as integer, _
		byval lgt as integer, _
		byval bits as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr sym, tail, base_parent
    dim as integer pad, updateudt, elen
    dim as FBHASHTB ptr hashtb

    function = NULL

    '' calc length if it wasn't given
	if( lgt <= 0 ) then
		lgt	= symbCalcLen( dtype, subtype, TRUE )

	'' or use the non-padded len if it's a non-array UDT field (for array
	'' of UDT's fields the padded len will be used, to follow the GCC ABI)
	elseif( dtype = FB_DATATYPE_STRUCT ) then
		if( dimensions = 0 ) then
			lgt = subtype->udt.unpadlgt
		end if
	end if

    '' check if the parent ofs must be updated
    updateudt = TRUE
    if( bits > 0 ) then
    	'' last field was a bitfield too? try to merge..
    	if( parent->udt.bitpos > 0 ) then
    		tail = parent->udt.symtb.tail
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
		pad = hCalcALign( lgt, parent->ofs, parent->udt.align, dtype, subtype )
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
							if( symbIsSigned( dtype ) ) then
								dtype = FB_DATATYPE_BYTE
							else
								dtype = FB_DATATYPE_UBYTE
							end if
						case 2
							if( symbIsSigned( dtype ) ) then
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

			parent->ofs += pad
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
    				     dtype, subtype, ptrcnt, _
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
	sym->var.initree = NULL

	'' array fields
	sym->var.array.desc = NULL
	sym->var.array.dif = symbCalcArrayDiff( dimensions, dTB(), lgt )
	sym->var.array.dimhead = NULL
	sym->var.array.dimtail = NULL

	sym->var.array.dims = dimensions
	if( dimensions > 0 ) then
		dim as integer i
		for i = 0 to dimensions-1
			if( symbNewArrayDim( sym, dTB(i).lower, dTB(i).upper ) = NULL ) then
			end if
		next
	end if

	sym->var.array.elms = symbCalcArrayElements( sym )

	'' multiple len by all array elements (if any)
	lgt *= sym->var.array.elms

	select case dtype
	'' var-len string fields? must add a ctor, copyctor and dtor
    case FB_DATATYPE_STRING
		'' if it's an anon udt, it or parent is an UNION
		if( (parent->udt.options and (FB_UDTOPT_ISUNION or _
									  FB_UDTOPT_ISANON)) <> 0 ) then
			errReport( FB_ERRMSG_VARLENSTRINGINUNION )
		else
			symbSetUDTHasCtorField( parent )
			symbSetUDTHasDtorField( parent )
		end if

    '' struct with a ctor or dtor? must add a ctor or dtor too
    case FB_DATATYPE_STRUCT
		if( symbGetCompDefCtor( subtype ) <> NULL ) then
			'' if it's an anon udt, it or parent is an UNION
			if( (parent->udt.options and (FB_UDTOPT_ISUNION or _
										  FB_UDTOPT_ISANON)) <> 0 ) then
				errReport( FB_ERRMSG_CTORINUNION )
			else
				symbSetUDTHasCtorField( parent )
			end if
    	end if

		if( symbGetHasDtor( subtype ) ) then
			'' if it's an anon udt, it or parent is an UNION
			if( (parent->udt.options and (FB_UDTOPT_ISUNION or _
										  FB_UDTOPT_ISANON)) <> 0 ) then
				errReport( FB_ERRMSG_DTORINUNION )
			else
				symbSetUDTHasDtorField( parent )
			end if
    	end if

	'' check pointers
	case is >= FB_DATATYPE_POINTER
		base_parent->udt.options or= FB_UDTOPT_HASPTRFIELD

	end select

	'' struct?
	if( (parent->udt.options and FB_UDTOPT_ISUNION) = 0 ) then
		if( updateudt ) then
			parent->ofs += lgt
			parent->lgt = parent->ofs
		end if

	'' union..
	else
		symbSetIsUnionField( sym )

		'' always update, been it a bitfield or not
		parent->ofs = 0
		if( lgt > parent->lgt ) then
			parent->lgt = lgt
		end if
	end if

	'' update the bit position, wrapping around
	if( bits > 0 ) then
		parent->udt.bitpos += bits
		parent->udt.bitpos and= (symbGetDataBits( dtype ) - 1)
	end if

    function = sym

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
		pad = hCalcALign( 0, _
						  parent->ofs, _
						  parent->udt.align, _
						  FB_DATATYPE_STRUCT, _
						  inner )
		if( pad > 0 ) then
			parent->ofs += pad
		end if
	end if

    '' move the nodes from inner to parent
    fld = inner->udt.symtb.head

    fld->prev = parent->udt.symtb.tail
    if( parent->udt.symtb.tail = NULL ) then
    	parent->udt.symtb.head = fld
    else
    	parent->udt.symtb.tail->next = fld
    end if

    symtb = @parent->udt.symtb

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

    parent->udt.symtb.tail = inner->udt.symtb.tail

    '' update elements
    parent->udt.elements += inner->udt.elements

	'' struct? update ofs + len
	if( (parent->udt.options and FB_UDTOPT_ISUNION) = 0 ) then
		parent->ofs += inner->udt.unpadlgt
		parent->lgt = parent->ofs

	'' union.. update len, if bigger
	else
		parent->ofs = 0
		if( inner->udt.unpadlgt > parent->lgt ) then
			parent->lgt = inner->udt.unpadlgt
		end if
	end if

	'' update the largest field len
	if( inner->udt.lfldlen > parent->udt.lfldlen ) then
		parent->udt.lfldlen = inner->udt.lfldlen
	end if

    '' reset bitfield
    parent->udt.bitpos = 0

    '' remove from inner udt list
    inner->udt.symtb.head = NULL
    inner->udt.symtb.tail = NULL

end sub

'':::::
private function hGetReturnType _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer static

	'' udt has a dtor, copy-ctor or virtual methods? it's never
	'' returned in registers
	if( symbIsTrivial( sym ) = FALSE ) then
		return FB_DATATYPE_POINTER + FB_DATATYPE_STRUCT
	end if

	'' use the un-padded UDT len
	select case as const symbGetUDTUnpadLen( sym )
	case 1
		return FB_DATATYPE_BYTE

	case 2
		return FB_DATATYPE_SHORT

	case 3
		'' return as int only if first is a short
		if( symbGetUDTFirstElm( sym )->lgt = 2 ) then
			'' and if the struct is not packed
			if( sym->lgt >= FB_INTEGERSIZE ) then
				return FB_DATATYPE_INTEGER
			end if
		end if

	case FB_INTEGERSIZE

		'' return in ST(0) if there's only one element and it's a SINGLE
		if( sym->udt.elements = 1 ) then
			do
				if( symbGetUDTFirstElm( sym )->typ = FB_DATATYPE_SINGLE ) then
					return FB_DATATYPE_SINGLE
				end if

				if( symbGetUDTFirstElm( sym )->typ <> FB_DATATYPE_STRUCT ) then
					exit do
				end if

				sym = symbGetUDTFirstElm( sym )->subtype

				if( sym->udt.elements <> 1 ) then
					exit do
				end if
			loop
		end if

		return FB_DATATYPE_INTEGER

	case FB_INTEGERSIZE + 1, FB_INTEGERSIZE + 2, FB_INTEGERSIZE + 3

		'' return as longint only if first is a int
		if( symbGetUDTFirstElm( sym )->lgt = FB_INTEGERSIZE ) then
			'' and if the struct is not packed
			if( sym->lgt >= FB_INTEGERSIZE*2 ) then
				return FB_DATATYPE_LONGINT
			end if
		end if

	case FB_INTEGERSIZE*2

		'' return in ST(0) if there's only one element and it's a DOUBLE
		if( sym->udt.elements = 1 ) then
			do
				if( symbGetUDTFirstElm( sym )->typ = FB_DATATYPE_DOUBLE ) then
					return FB_DATATYPE_DOUBLE
				end if

				if( symbGetUDTFirstElm( sym )->typ <> FB_DATATYPE_STRUCT ) then
					exit do
				end if

				sym = symbGetUDTFirstElm( sym )->subtype

				if( sym->udt.elements <> 1 ) then
					exit do
				end if
			loop
		end if

		return FB_DATATYPE_LONGINT

	end select

	'' if nothing matched, it's the pointer that was passed as the 1st arg
	function = FB_DATATYPE_POINTER + FB_DATATYPE_STRUCT

end function

'':::::
sub symbStructEnd _
	( _
		byval sym as FBSYMBOL ptr _
	) static

    dim as integer pad

	'' save length w/o padding
	sym->udt.unpadlgt = sym->lgt

	'' do round?
	if( sym->udt.align <> 1 ) then
		'' plus the largest scalar field size (GCC 3.x ABI)
		pad = hCalcALign( 0, sym->lgt, sym->udt.align, FB_DATATYPE_STRUCT, sym )
		if( pad > 0 ) then
			sym->lgt += pad
		end if
	end if

	'' set the real data type used to return this struct from procs
	sym->udt.ret_dtype = hGetReturnType( sym )

	'' generate the default members
	symbCompAddDefMembers( sym )

	'' check for forward references
	if( symb.fwdrefcnt > 0 ) then
		symbCheckFwdRef( sym, FB_SYMBCLASS_STRUCT )
	end if

end sub

'':::::
function symbCloneStruct _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr clone = any, fld = any

	'' assuming only simple structs will be cloned (ie: the ones
	'' created by symbAddArrayDesc())

	clone = symbStructBegin( NULL, _
						 	 NULL, _
						 	 NULL, _
						 	 (sym->udt.options and FB_UDTOPT_ISUNION) <> 0, _
							 sym->udt.align )


    fld = sym->udt.symtb.head
    do while( fld <> NULL )
    	symbAddField( clone, _
    				  NULL, _
    				  0, _
    				  dTB(), _
    				  symbGetType( fld ), _
    				  symbGetSubType( fld ), _
    				  fld->ptrcnt, _
    				  fld->lgt, _
    				  0 )


		fld = fld->next
	loop

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

    dim as FBSYMBOL ptr fld
    dim as FBVARDIM ptr dim_, dim_nxt

    if( s = NULL ) then
    	exit sub
    end if

    '' del all udt elements
    do
		fld = s->udt.symtb.head
		if( fld = NULL ) then
			exit do
		end if

    	'' an ordinary field?
    	if( symbGetClass( fld ) = FB_SYMBCLASS_FIELD ) then
    		'' del array dims if not a scalar type
    		dim_ = fld->var.array.dimhead
    		do while( dim_ <> NULL )
    			dim_nxt = dim_->next

    			listDelNode( @symb.dimlist, dim_ )

    			dim_ = dim_nxt
    		loop

    		symbFreeSymbol( fld )

    	'' ctor, dtor, operator or method's local symbol
    	else
    		symbDelSymbol( fld )
    	end if
    loop

    if( s->udt.ext <> NULL ) then
    	deallocate( s->udt.ext )
    	s->udt.ext = NULL
    end if

	'' del the udt node
	symbFreeSymbol( s )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbGetUDTLen _
	( _
		byval s as FBSYMBOL ptr, _
		byval unpadlen as integer _
	) as integer static

	if( unpadlen ) then
		function = s->udt.unpadlgt
	else
		function = s->lgt
	end if

end function


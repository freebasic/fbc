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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ir.bi"

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbAddUDT _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval isunion as integer, _
		byval align as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr t

    function = NULL

    '' no explict alias given?
    if( id_alias = NULL ) then
    	'' only preserve a case-sensitive version if in BASIC mangling
    	if( env.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    end if

    t = symbNewSymbol( NULL, _
    				   NULL, NULL, fbIsModLevel( ), _
    				   FB_SYMBCLASS_UDT, _
    				   TRUE, id, id_alias )
	if( t = NULL ) then
		exit function
	end if

	t->udt.parent = parent
	t->udt.isunion = isunion
	t->udt.elements = 0
	t->udt.fldtb.owner = t
	t->udt.fldtb.head = NULL
	t->udt.fldtb.tail = NULL
	t->ofs = 0
	t->udt.align = align
	t->udt.lfldlen = 0
	t->udt.bitpos = 0
	t->udt.unpadlgt	= 0
	t->udt.ptrcnt = 0
	t->udt.dyncnt = 0

	t->udt.dbg.typenum = INVALID

	function = t

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
	case FB_DATATYPE_USERDEF
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
function symbAddUDTElement _
	( _
		byval t as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval lgt as integer, _
		byval bits as integer _
	) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 ename
    dim as FBSYMBOL ptr p, e, tail
    dim as integer pad, i, updateudt, elen

    function = NULL

    hUcase( *id, ename )

    '' check if element already exists in the current struct and parents
    p = t
    do
    	e = p->udt.fldtb.head
    	do while( e <> NULL )
    		if( *e->name = ename ) then
    			exit function
    		end if

    		'' next
    		e = e->next
    	loop

    	p = p->udt.parent
    loop while( p <> NULL )

    '' calc length if it wasn't given
	if( lgt <= 0 ) then
		lgt	= symbCalcLen( dtype, subtype, TRUE )

	'' or use the non-padded len if it's a non-array UDT field (for array
	'' of UDT's fields the padded len will be used, to follow the GCC ABI)
	elseif( dtype = FB_DATATYPE_USERDEF ) then
		if( dimensions = 0 ) then
			lgt = subtype->udt.unpadlgt
		end if
	end if

    '' check if the parent ofs must be updated
    updateudt = TRUE
    if( bits > 0 ) then
    	'' last field was a bitfield too? try to merge..
    	if( t->udt.bitpos > 0 ) then
    		tail = t->udt.fldtb.tail
    		'' does it fit? if not, start at a new pos..
    		if( t->udt.bitpos + bits > tail->lgt*8 ) then
    			t->udt.bitpos = 0
    		else
    			'' if it fits but len is different, make it the same
    			if( lgt <> tail->lgt ) then
    				dtype = tail->typ
    				lgt = tail->lgt
    			end if
    		end if
    	end if

		'' don't update if there are enough bits left
		if( t->udt.bitpos <> 0 ) then
			updateudt = FALSE
		end if

    else
    	t->udt.bitpos = 0
    end if

	''
	if( updateudt ) then
		pad = hCalcALign( lgt, t->ofs, t->udt.align, dtype, subtype )
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

			t->ofs += pad
		end if

		'' update largest field len
		elen = hGetRealLen( lgt, dtype, subtype )

		'' larger?
		if( elen > t->udt.lfldlen ) then
			t->udt.lfldlen = elen
		end if
	end if

	'' bitfield?
	if( bits > 0 ) then
		subtype = symbAddBitField( t->udt.bitpos, bits, dtype, lgt )
		dtype = FB_DATATYPE_BITFIELD
	end if

	''
    e = symbNewSymbol( NULL, _
    				   @t->udt.fldtb, NULL, TRUE, _
    				   FB_SYMBCLASS_UDTELM, _
    				   FALSE, @ename, NULL, _
    				   dtype, subtype, ptrcnt, _
    				   TRUE )
    if( e = NULL ) then
    	exit function
    end if

	'' add to parent's linked-list
    e->var.elm.parent = t
    t->udt.elements	+= 1

	e->lgt = lgt

	if( updateudt or t->udt.isunion ) then
		e->ofs = t->ofs
	else
		e->ofs = t->ofs - lgt
	end if

	'' array fields
	e->var.array.dif = symbCalcArrayDiff( dimensions, dTB(), lgt )
	e->var.array.dimhead = NULL
	e->var.array.dimtail = NULL

	e->var.array.dims = dimensions
	if( dimensions > 0 ) then
		for i = 0 to dimensions-1
			if( symbNewArrayDim( e, dTB(i).lower, dTB(i).upper ) = NULL ) then
			end if
		next
	end if

	e->var.array.elms = symbCalcArrayElements( e )

	'' multiple len by all array elements (if any)
	lgt *= e->var.array.elms

	'' check ptr or var-len string fields
	select case dtype
	case is >= FB_DATATYPE_POINTER
		p = t
		do
			p->udt.ptrcnt += 1
    		p = p->udt.parent
    	loop while( p <> NULL )

    case FB_DATATYPE_STRING
		p = t
		do
			p->udt.dyncnt += 1
    		p = p->udt.parent
    	loop while( p <> NULL )
	end select

	'' struct?
	if( t->udt.isunion = FALSE ) then
		if( updateudt ) then
			t->ofs += lgt
			t->lgt = t->ofs
		end if

	'' union..
	else
		'' always update, been it a bitfield or not
		t->ofs = 0
		if( lgt > t->lgt ) then
			t->lgt = lgt
		end if
	end if

	'' update the bit position, wrapping around
	if( bits > 0 ) then
		t->udt.bitpos += bits
		t->udt.bitpos and= (symbGetDataBits( dtype ) - 1)
	end if

    function = e

end function

'':::::
sub symbInsertInnerUDT _
	( _
		byval t as FBSYMBOL ptr, _
		byval inner as FBSYMBOL ptr _
	) static

    dim as FBSYMBOL ptr e
    dim as FBSYMBOLTB ptr symtb
    dim as integer pad

	if( t->udt.isunion = FALSE ) then
		'' calc padding (should be aligned like if an UDT field were been added)
		pad = hCalcALign( inner->udt.lfldlen, t->ofs, t->udt.align, _
						  FB_DATATYPE_VOID, NULL )
		if( pad > 0 ) then
			t->ofs += pad
		end if
	end if

    '' move the nodes from inner to parent
    e = inner->udt.fldtb.head

    e->prev = t->udt.fldtb.tail
    if( t->udt.fldtb.tail = NULL ) then
    	t->udt.fldtb.head = e
    else
    	t->udt.fldtb.tail->next = e
    end if

    symtb = @t->udt.fldtb

    if( t->udt.isunion ) then
    	'' link to parent
    	do while( e <> NULL )
    		e->var.elm.parent = t
    		e->symtb = symtb

    		'' next
    		e = e->next
    	loop

    else
    	'' link to parent
    	do while( e <> NULL )
    		e->var.elm.parent = t
    		e->symtb = symtb

			'' update the offsets
			t->ofs += e->ofs
			e->ofs = t->ofs

    		'' next
    		e = e->next
    	loop
    end if

    t->udt.fldtb.tail = inner->udt.fldtb.tail

    '' update elements
    t->udt.elements	+= inner->udt.elements

	'' struct? update ofs + len
	if( t->udt.isunion = FALSE ) then
		t->ofs += inner->udt.unpadlgt
		t->lgt = t->ofs

	'' union.. update len, if bigger
	else
		t->ofs = 0
		if( inner->udt.unpadlgt > t->lgt ) then
			t->lgt = inner->udt.unpadlgt
		end if
	end if

	'' update the largest field len
	if( inner->udt.lfldlen > t->udt.lfldlen ) then
		t->udt.lfldlen = inner->udt.lfldlen
	end if

    '' reset bitfield
    t->udt.bitpos = 0

    '' remove from inner udt list
    inner->udt.fldtb.head = NULL
    inner->udt.fldtb.tail = NULL

end sub

'':::::
sub symbRoundUDTSize _
	( _
		byval t as FBSYMBOL ptr _
	) static

    dim as integer align, pad

	align = t->udt.align

	'' default?
	if( align = 0 ) then
		align = FB_INTEGERSIZE
	end if

	'' save length w/o padding
	t->udt.unpadlgt = t->lgt

	'' do round?
	if( align > 1 ) then
		'' first pad with the alignament given
		pad = (align - (t->lgt and (align-1))) and (align-1)
		if( pad > 0 ) then
			t->lgt += pad
		end if

		'' plus the largest scalar field size (GCC 3.x ABI)
		pad = hCalcALign( t->udt.lfldlen, t->lgt, t->udt.align, FB_DATATYPE_VOID, NULL )
		if( pad > 0 ) then
			t->lgt += pad
		end if
	end if

	'' check for forward references
	if( symb.fwdrefcnt > 0 ) then
		symbCheckFwdRef( t, FB_SYMBCLASS_UDT )
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookup
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbLookupUDTElm _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr _
	) as FBSYMBOL ptr static

	static as zstring * FB_MAXNAMELEN+1 ename
	dim as FBSYMBOL ptr fld

	if( parent = NULL ) then
		return NULL
	end if

    hUcase( id, ename )

	'' for each field
	fld = parent->udt.fldtb.head
	do while( fld <> NULL )
        '' names match?
        if( *fld->name = ename ) then
    		exit do
        end if

		fld = fld->next
    loop

    function = fld

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbDelUDT _
	( _
		byval udt as FBSYMBOL ptr _
	)

    dim as FBSYMBOL ptr fld, nxt
    dim as FBVARDIM ptr dimn, dimnxt

    if( udt = NULL ) then
    	exit sub
    end if

    '' del all udt elements
    fld = udt->udt.fldtb.head
    do while( fld <> NULL )
        nxt = fld->next

    	'' del array dims if not a scalar type
    	dimn = fld->var.array.dimhead
    	do while( dimn <> NULL )
    		dimnxt = dimn->next

    		listDelNode( @symb.dimlist, dimn )

    		dimn = dimnxt
    	loop

    	symbFreeSymbol( fld )
    	fld = nxt
    loop

	'' del the udt node
	symbFreeSymbol( udt )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbGetUDTLen _
	( _
		byval s as FBSYMBOL ptr, _
		byval unpadlen as integer = TRUE _
	) as integer static

	if( unpadlen ) then
		function = s->udt.unpadlgt
	else
		function = s->lgt
	end if

end function


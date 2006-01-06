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


'' symbol table module for variables (scalars and arrays)
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"
#include once "inc\rtl.bi"

declare function 	hCalcArrayElements	( byval dimensions as integer, _
									  	  dTB() as FBARRAYDIM ) as integer


'':::::
sub symbInitDims( ) static

	listNew( @symb.dimlist, FB_INITDIMNODES, len( FBVARDIM ), FALSE )

end sub


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function hCreateArrayDesc( byval s as FBSYMBOL ptr, _
						   byval dimensions as integer ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 sname, aname
    dim as FBSYMBOL ptr d
    dim as integer lgt, ofs
    dim as integer isshared, isstatic, isdynamic, iscommon, ispubext

	function = NULL

    '' don't add if it's a jump table
    if( symbIsJumpTb( s ) ) then
    	exit function
    end if

	isshared 	= symbIsShared( s )
	isstatic 	= symbIsStatic( s )
	isdynamic	= symbIsDynamic( s )
	iscommon 	= symbIsCommon( s )
	ispubext 	= (s->alloctype and (FB_ALLOCTYPE_PUBLIC or FB_ALLOCTYPE_EXTERN)) > 0

	'' COMMON, public or dynamic? use the array name for the descriptor,
	'' as only it will be allocated or seen by other modules
	if( (iscommon) or (ispubext and isdynamic) ) then
		sname = *symbGetName( s )

	'' otherwise, create a temporary name..
	else
		sname = *hMakeTmpStr( FALSE )
	end if

	'' module-level or static? no alias
	if( (fbIsLocal( ) = FALSE) or (isshared) or (isstatic) ) then
		aname = sname
		ofs = 0

	'' local.. let emit do it
	else
		lgt = FB_ARRAYDESCLEN + dimensions * FB_ARRAYDESC_DIMLEN
		aname = *emitAllocLocal( env.currproc, lgt, ofs )
	end if

	d = symbNewSymbol( NULL, symb.symtb, FB_SYMBCLASS_VAR, FALSE, _
					   NULL, aname, _
					   fbIsLocal( ) and (isshared = FALSE), _
					   FB_SYMBTYPE_USERDEF, cptr( FBSYMBOL ptr, FB_DESCTYPE_ARRAY ), 0 )
    if( d = NULL ) then
    	exit function
    end if

	''
	if( isshared ) then
		d->alloctype  or= FB_ALLOCTYPE_SHARED
	elseif( isstatic ) then
		d->alloctype  or= FB_ALLOCTYPE_STATIC
	end if

	d->alloctype  or= FB_ALLOCTYPE_DESCRIPTOR

	d->ofs				= ofs
	d->var.array.desc 	= NULL
	d->var.array.dif  	= 0
	d->var.array.dims 	= 0

    d->var.suffix 		= INVALID
    d->var.initialized 	= FALSE

	''
	function = d

end function

'':::::
function symbNewArrayDim( byref head as FBVARDIM ptr, _
				  		  byref tail as FBVARDIM ptr, _
				  		  byval lower as integer, _
				  		  byval upper as integer _
				  		) as FBVARDIM ptr static

    dim as FBVARDIM ptr d, n

    function = NULL

    d = listNewNode( @symb.dimlist )
    if( d = NULL ) then
    	exit function
    end if

    d->lower = lower
    d->upper = upper

	n = tail
	d->next = NULL
	tail = d
	if( n <> NULL ) then
		n->next = d
	else
		head = d
	end if

    function = d

end function

'':::::
sub symbSetArrayDims( byval s as FBSYMBOL ptr, _
					  byval dimensions as integer, _
					  dTB() as FBARRAYDIM )

    dim as integer i
    dim as FBVARDIM ptr d

	s->var.array.dims = dimensions

	if( dimensions > 0 ) then
		s->var.array.dif = symbCalcArrayDiff( dimensions, dTB(), s->lgt )

		if( s->var.array.dimhead = NULL ) then
			for i = 0 to dimensions-1
				if( symbNewArrayDim( s->var.array.dimhead, s->var.array.dimtail, _
							 		 dTB(i).lower, dTB(i).upper ) = NULL ) then
				end if
			next i
		else
			d = s->var.array.dimhead
			for i = 0 to dimensions-1
				d->lower = dTB(i).lower
				d->upper = dTB(i).upper
				d = d->next
			next i
		end if

	else
		s->var.array.dif = 0
	end if

	'' dims can be -1 with COMMON arrays..
	if( dimensions <> 0 ) then
		if( s->var.array.desc = NULL ) then
			s->var.array.desc = hCreateArrayDesc( s, dimensions )
		end if
	else
		s->var.array.desc = NULL
	end if

end sub

'':::::
private sub hSetupVar( byval s as FBSYMBOL ptr, _
			   		   byval symbol as zstring ptr, _
			   		   byval typ as integer, _
			   		   byval subtype as FBSYMBOL ptr, _
			   		   byval lgt as integer, _
			   		   byval ofs as integer, _
			   		   byval dimensions as integer, _
			   		   dTB() as FBARRAYDIM, _
			   		   byval alloctype as integer ) static

	if( typ = INVALID ) then
		typ = hGetDefType( symbol )
	end if

	''
	s->alloctype  or= alloctype
	s->acccnt		= 0

	s->lgt			= lgt
	s->ofs			= ofs

	'' array fields
	s->var.array.dimhead = NULL
	s->var.array.dimtail = NULL

	s->var.array.elms = 0						'' real value doesn't matter
	s->var.array.desc = NULL
	if( dimensions <> 0 ) then
		symbSetArrayDims( s, dimensions, dTB() )
	else
		s->var.array.dims = 0
		s->var.array.dif  = 0
	end if

	''
    s->var.initialized 	= FALSE

end sub

'':::::
function symbAddVarEx( byval symbol as zstring ptr, _
					   byval aliasname as zstring ptr, _
					   byval typ as integer, _
					   byval subtype as FBSYMBOL ptr, _
					   byval ptrcnt as integer, _
					   byval lgt as integer, _
					   byval dimensions as integer, _
					   dTB() as FBARRAYDIM, _
				       byval alloctype as integer, _
				       byval addsuffix as integer, _
				       byval preservecase as integer, _
				       byval clearname as integer ) as FBSYMBOL ptr static

    dim as zstring ptr aname
    dim as FBSYMBOL ptr s
    dim as integer isshared, isstatic, ispublic, isextern, isarg, islocal
    dim as integer suffix, locofs, loclen

    function = NULL

    ''
    isshared = (alloctype and FB_ALLOCTYPE_SHARED) > 0
    isstatic = (alloctype and FB_ALLOCTYPE_STATIC) > 0
    ispublic = (alloctype and FB_ALLOCTYPE_PUBLIC) > 0
    isextern = (alloctype and FB_ALLOCTYPE_EXTERN) > 0
    isarg    = (alloctype and (FB_ALLOCTYPE_ARGUMENTBYDESC or _
    						   FB_ALLOCTYPE_ARGUMENTBYVAL or _
    						   FB_ALLOCTYPE_ARGUMENTBYREF)) > 0
    ''
    if( lgt <= 0 ) then
		if( typ = INVALID ) then
			suffix = hGetDefType( symbol )
		else
			suffix = typ
 		end if
    	lgt	= symbCalcLen( suffix, subtype )
    end if

    ''
    if( addsuffix ) then
    	suffix = typ
    else
    	suffix = INVALID
    end if

    ''
    locofs = 0

	'' create an alias name (the real one that will be emited)
	islocal  = FALSE
	if( aliasname <> NULL ) then
		'' if alias was given, it can't be a local var
		aname = aliasname

	else
		'' static?
		if( (isshared = FALSE) and (isstatic) ) then
			aname = hMakeTmpStr( FALSE )

		else
			'' global/shared or module-level?
			if( (ispublic) or _
				(isextern) or _
				(isshared) or _
				(fbIsLocal( ) = FALSE) ) then

			    '' not inside a SCOPE block?
			    if( env.scope = 0 ) then
			    	aname = hCreateName( symbol, suffix, preservecase, _
			    					  	 TRUE, clearname )

				'' inside a SCOPE..
				else
					aname = hMakeTmpStr( FALSE )
				end if

			'' local..
			else
				islocal = TRUE
				'' an argument?
				if( isarg ) then
					loclen = iif( alloctype = FB_ALLOCTYPE_ARGUMENTBYVAL, lgt, FB_POINTERSIZE )
					aname = emitAllocArg( env.currproc, loclen, locofs )

				'' local..
				else
					loclen = lgt * hCalcArrayElements( dimensions, dTB() )
					aname = emitAllocLocal( env.currproc, loclen, locofs )
				end if
			end if
		end if
	end if

	'' if SHARED, use the global symbol tb, even if inside a proc
	s = symbNewSymbol( NULL, iif( isshared, @symb.globtb, symb.symtb ), _
					   FB_SYMBCLASS_VAR, TRUE, _
					   symbol, aname, _
					   fbIsLocal( ) and (isshared = FALSE), _
					   typ, subtype, ptrcnt, suffix, preservecase )

	if( s = NULL ) then
		'' remove a local or arg or else emit will reserve unused space for it..
		if( islocal ) then
			if( isarg ) then
				emitFreeArg( env.currproc, loclen )
			else
				emitFreeLocal( env.currproc, loclen )
			end if
		end if

		exit function
	end if

	''
	hSetupVar( s, symbol, typ, subtype, lgt, _
			   locofs, dimensions, dTB(), alloctype )

	function = s

end function

'':::::
function symbAddVar( byval symbol as zstring ptr, _
					 byval typ as integer, _
					 byval subtype as FBSYMBOL ptr, _
				     byval ptrcnt as integer, _
				     byval dimensions as integer, _
				     dTB() as FBARRAYDIM, _
				     byval alloctype as integer ) as FBSYMBOL ptr static

    function = symbAddVarEx( symbol, NULL, typ, subtype, ptrcnt, _
    		  			     0, dimensions, dTB(), _
    						 alloctype, _
    						 TRUE, FALSE, TRUE )
end function

'':::::
function symbAddTempVar( byval typ as integer, _
						 byval subtype as FBSYMBOL ptr = NULL ) as FBSYMBOL ptr static

	static as zstring * FB_MAXINTNAMELEN+1 sname
	dim as integer alloctype
    dim as FBARRAYDIM dTB(0)

	sname = *hMakeTmpStr( FALSE )

	alloctype = FB_ALLOCTYPE_TEMP
	if( fbIsLocal( ) ) then
		if( env.isprocstatic ) then
			alloctype or= FB_ALLOCTYPE_STATIC
		end if
	end if

	function = symbAddVarEx( sname, NULL, typ, subtype, 0, _
							 0, 0, dTB(), _
							 alloctype, _
							 FALSE, FALSE, FALSE )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbCalcArrayDiff( byval dimensions as integer, _
							dTB() as FBARRAYDIM, _
							byval lgt as integer ) as integer

    dim d as integer, diff as integer, elms as integer, mult as integer

	if( dimensions <= 0 ) then
		return 0
	end if

	diff = 0
	for d = 0 to (dimensions-1)-1
		elms = (dTB(d+1).upper - dTB(d+1).lower) + 1
		diff = (diff+dTB(d).lower) * elms
	next

	diff += dTB(dimensions-1).lower

	diff *= lgt

	function = -diff

end function

'':::::
function symbCalcArrayElements( byval s as FBSYMBOL ptr, _
								byval n as FBVARDIM ptr = NULL ) as integer static
    dim e as integer, d as integer

	if( n = NULL ) then
		n = s->var.array.dimhead
	end if

	e = 1
	do while( n <> NULL )
		d = (n->upper - n->lower) + 1
		e = e * d
		n = n->next
	loop

	function = e

end function

'':::::
private function hCalcArrayElements( byval dimensions as integer, _
						 		 	 dTB() as FBARRAYDIM ) as integer static
    dim e as integer, i as integer, d as integer

	e = 1
	for i = 0 to dimensions-1
		d = (dTB(i).upper - dTB(i).lower) + 1
		e = e * d
	next i

	function = e

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hDelVarDims( byval s as FBSYMBOL ptr ) static
    dim as FBVARDIM ptr n, nxt

    n = s->var.array.dimhead
    do while( n <> NULL )
    	nxt = n->next

    	listDelNode( @symb.dimlist, cptr( TLISTNODE ptr, n ) )

    	n = nxt
    loop

    s->var.array.dimhead = NULL
    s->var.array.dimtail = NULL
    s->var.array.dims	  = 0

end sub

'':::::
sub symbDelVar( byval s as FBSYMBOL ptr, _
				byval dolookup as integer )

    dim movetoglob as integer

    if( s = NULL ) then
    	exit sub
    end if

	movetoglob = FALSE

	'' local?
	if( (s->alloctype and FB_ALLOCTYPE_LOCAL ) > 0 ) then
    	'' static?
    	if( symbIsStatic( s ) ) then
    		'' move it to global list if not already
    		if( s->symtb <> @symb.globtb ) then
    			movetoglob = TRUE
    		end if
    	end if
	end if

	if( movetoglob = FALSE ) then
    	if( s->var.array.dims > 0 ) then
    		hDelVarDims( s )
    		'' del the array descriptor, recursively
    		symbDelVar( s->var.array.desc )
    	end if
    end if

    if( s->var.initialized ) then
    	s->var.initialized = FALSE
    	'' not a wchar literal?
    	if( s->typ <> IR_DATATYPE_WCHAR ) then
    		if( s->var.inittext <> NULL ) then
    			ZstrFree( s->var.inittext )
    		end if
    	else
    		if( s->var.inittextw <> NULL ) then
    			WstrFree( s->var.inittextw )
    		end if
    	end if
    end if

    symbFreeSymbol( s, movetoglob )

end sub

'':::::
sub symbFreeLocalDynVars( byval proc as FBSYMBOL ptr, _
						  byval issub as integer ) static

    dim as FBSYMBOL ptr s, fres
    dim as ASTNODE ptr strg

    '' can't free function's result, that's will be done by the rtlib
    if( issub ) then
    	fres = NULL
    else
    	fres = symbLookupProcResult( proc )
	end if

	s = symb.symtb->head
    do while( s <> NULL )
    	'' variable?
    	if( s->class = FB_SYMBCLASS_VAR ) then
    		'' not shared or static?
    		if( (s->alloctype and (FB_ALLOCTYPE_SHARED or FB_ALLOCTYPE_STATIC)) = 0 ) then

				'' not an argument?
    			if( (s->alloctype and (FB_ALLOCTYPE_ARGUMENTBYDESC or _
    				  				   FB_ALLOCTYPE_ARGUMENTBYVAL or _
    				  				   FB_ALLOCTYPE_ARGUMENTBYREF or _
    				  				   FB_ALLOCTYPE_TEMP)) = 0 ) then

					'' array?
					if( s->var.array.dims > 0 ) then
						'' dynamic?
						if( symbIsDynamic( s ) ) then
							rtlArrayErase( astNewVAR( s, 0, s->typ ) )
						'' array of dyn strings?
						elseif( s->typ = FB_SYMBTYPE_STRING ) then
							rtlArrayStrErase( s )
						end if

					'' dyn string?
					elseif( s->typ = FB_SYMBTYPE_STRING ) then
						'' not funct's result?
						if( s <> fres ) then
							strg = astNewVAR( s, 0, IR_DATATYPE_STRING )
							astAdd( rtlStrDelete( strg ) )
						end if
					end if

				end if

    		end if
    	end if

    	s = s->next
    loop

end sub


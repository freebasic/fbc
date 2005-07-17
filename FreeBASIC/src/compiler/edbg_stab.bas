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


'' debug emiter (stabs format) for GNU assembler (GAS)
''
'' chng: nov/2004 written [v1ctor]

defint a-z
option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"
#include once "inc\emit.bi"
#include once "inc\emitdbg.bi"
#include once "inc\stabs.bi"

type EDBGCTX
	typecnt			as uinteger

	label 			as FBSYMBOL ptr
	lnum 			as integer
	pos 			as integer
	isnewline		as integer

	firstline		as integer					'' first non-decl line
	lastline		as integer					'' last  /

	incfile			as integer
end type

declare sub 	 hDeclUDT				( byval sym as FBSYMBOL ptr )
declare sub 	 hDeclENUM				( byval sym as FBSYMBOL ptr )

declare function hGetDataType			( byval sym as FBSYMBOL ptr ) as string

'' globals
	dim shared ctx as EDBGCTX

	dim shared remapTB(0 to FB_SYMBOLTYPES-1) = { 7, 2, 3, 4, 5, 6, 1, 8, 1, 9, 10, 11, 12, 13, 14 }


stabstdef:
data "integer:t1=-1"
data "void:t7=-11"
data "byte:t2=-6"
data "ubyte:t3=-5"
data "char:t4=-2"
data "short:t5=-3"
data "ushort:t6=-7"
data "uinteger:t8=-8"
data "longint:t9=-31"
data "ulongint:t10=-32"
data "single:t11=-12"
data "double:t12=-13"
data "string:t13=s12data:15,0,32;len:1,32,32;size:1,64,32;;"
data "fixstr:t14=-2"
data "pchar:t15=*4;"
data ""

'':::::
private sub hEmitSTABS( byval _type as integer, _
						byval _string as string, _
						byval _other as integer = 0, _
						byval _desc as integer = 0, _
						byval _value as string = "0" ) static

	dim as string ostr

	ostr = ".stabs \""
	ostr += _string
	ostr += "\","
	ostr += str( _type )
	ostr += ","
	ostr += str( _other )
	ostr += ","
	ostr += str( _desc )
	ostr += ","
	ostr += _value

	hWriteStr( TRUE, ostr )

end sub

'':::::
private function hMakeSTABN( byval _type as integer, _
							 byval _other as integer = 0, _
							 byval _desc as integer = 0, _
							 byval _value as string ) as zstring ptr static

	static as string ostr

	ostr = ".stabn "
	ostr += str( _type )
	ostr += ","
	ostr += str( _other )
	ostr += ","
	ostr += str( _desc )
	ostr += ","
	ostr += _value

	function = strptr( ostr )

end function

'':::::
private sub hEmitSTABN( byval _type as integer, _
						byval _other as integer = 0, _
						byval _desc as integer = 0, _
						byval _value as string = "0" ) static


	hWriteStr( TRUE, byval hMakeSTABN( _type, _other, _desc, _value ) )

end sub

'':::::
private sub hEmitSTABD( byval _type as integer, _
						byval _other as integer = 0, _
						byval _desc as integer = 0 ) static

	dim as string ostr

	ostr = ".stabd "
	ostr += str( _type )
	ostr += ","
	ostr += str( _other )
	ostr += ","
	ostr += str( _desc )

	hWriteStr( TRUE, ostr )

end sub

'':::::
private sub hLABEL( byval label as string ) static
    dim ostr as string

	ostr = label + ":"
	hWriteStr( FALSE, ostr )

end sub


'':::::
sub edbgEmitHeader( byval filename as string ) static
    dim as integer i
    dim as string fname, stab, lname

	if( not env.clopt.debug ) then
		exit sub
	end if

	''
	ctx.typecnt 	= 1

	ctx.label 		= NULL
	ctx.lnum 		= 0
	ctx.isnewline 	= TRUE

	ctx.incfile 	= INVALID

	'' emit source file
    lname = *hMakeTmpStr( )
    fname = hRevertSlash( filename )
    hWriteStr( TRUE, ".file \"" + fname + "\"" )
    if( instr( fname, "/" ) = 0 ) then
    	hEmitSTABS( STAB_TYPE_SO, hRevertSlash( curdir$ + "/" ), 0, 0, lname )
    end if

    hEmitSTABS( STAB_TYPE_SO, fname, 0, 0, lname )

	''
	emitSECTION( EMIT_SECTYPE_CODE )
	hLABEL( lname )

	'' (known) type definitions
	restore stabstdef
	do
		read stab
		if( len( stab ) = 0 ) then
			exit do
		end if
		hEmitSTABS( STAB_TYPE_LSYM, stab, 0, 0, "0" )
		ctx.typecnt += 1
	loop

	hWriteStr( FALSE, "" )

	hEmitSTABS( STAB_TYPE_BINCL, fname, 0, 0 )

end sub

'':::::
sub edbgEmitFooter( ) static
	dim as string lname

	if( not env.clopt.debug ) then
		exit sub
	end if

	emitSECTION( EMIT_SECTYPE_CODE )

	'' no checkings after this
	lname = *hMakeTmpStr( )
	hEmitSTABS( STAB_TYPE_SO, "", 0, 0, lname )

	hLABEL( lname )

end sub

'':::::
sub edbgLineBegin( byval proc as FBSYMBOL ptr, _
				   byval lnum as integer )

    if( not env.clopt.debug ) then
    	exit sub
    end if

    if( ctx.lnum > 0 ) then
    	ctx.pos = emitGetPos( ) - ctx.pos
    	if( ctx.pos > 0 ) then
    		edbgEmitLine( proc, ctx.lnum, ctx.label )
    		ctx.isnewline = TRUE
    	end if
    end if

    ctx.pos	 = emitGetPos( )
    ctx.lnum = lnum
    if( ctx.isnewline ) then
    	ctx.label = symbAddLabel( "" )
    	emitLABEL( ctx.label )
    	ctx.isnewline = FALSE
    end if

end sub

'':::::
sub edbgLineEnd( byval proc as FBSYMBOL ptr )

    if( not env.clopt.debug ) then
    	exit sub
    end if

    if( ctx.lnum > 0 ) then
    	ctx.pos = emitGetPos( ) - ctx.pos
    	if( ctx.pos > 0 ) then
   			edbgEmitLine( proc, ctx.lnum, ctx.label )
   			ctx.isnewline = TRUE
   		end if
    	ctx.lnum = 0
    end if

end sub

'':::::
sub edbgEmitLine( byval proc as FBSYMBOL ptr, _
				  byval lnum as integer, _
			  	  byval label as FBSYMBOL ptr ) static
    dim as zstring ptr s

	if( not env.clopt.debug ) then
		exit sub
	end if

	if( ctx.firstline = -1 ) then
		ctx.firstline = lnum
	end if

	ctx.lastline = lnum

	'' emit current line
	s = hMakeSTABN( STAB_TYPE_SLINE, 0, lnum, symbGetName( label ) + "-" + symbGetName( proc ) )

	emitLIT( byval s )

end sub

'':::::
sub edbgEmitLineFlush( byval proc as FBSYMBOL ptr, _
				  	   byval lnum as integer, _
			  	  	   byval label as FBSYMBOL ptr ) static

	if( not env.clopt.debug ) then
		exit sub
	end if

	hEmitSTABN( STAB_TYPE_SLINE, 0, lnum, symbGetName( label ) + "-" + symbGetName( proc ) )

end sub

'':::::
sub edbgProcBegin( byval proc as FBSYMBOL ptr ) static

	'' called by ir->ast

	proc->proc.dbg.iniline = lexLineNum( )

end sub

'':::::
sub edbgProcEnd( byval proc as FBSYMBOL ptr ) static

	'' called by ir->ast

	proc->proc.dbg.endline = lexLineNum( )

end sub

'':::::
sub edbgProcEmitBegin( byval proc as FBSYMBOL ptr ) static

	'' called by emit->ir

	ctx.firstline = -1
	ctx.lastline  = -1

end sub

'':::::
private sub hDeclArgs( byval proc as FBSYMBOL ptr ) static
	dim as FBSYMBOL ptr s

	s = symbGetLocalHead( )
	do while( s <> NULL )

    	if( symbIsVar( s ) ) then
			'' an argument?
    		if( (s->alloctype and (FB_ALLOCTYPE_ARGUMENTBYDESC or _
    			  				   FB_ALLOCTYPE_ARGUMENTBYVAL or _
    			  				   FB_ALLOCTYPE_ARGUMENTBYREF)) <> 0 ) then

				edbgEmitProcArg( s )
			end if
		end if

		s = s->next
	loop

end sub

'':::::
sub edbgEmitProcHeader( byval proc as FBSYMBOL ptr ) static
    dim as string desc, procname
    dim as integer incfile

	if( not env.clopt.debug ) then
		exit sub
	end if

	'' procs defined in include files must be declared inside the proper blocks
	incfile = symbGetProcIncFile( proc )
	if( incfile <> ctx.incfile ) then

        edbgIncludeEnd( )

		if( incfile <> INVALID ) then
			edbgIncludeBegin( fbGetIncFile( incfile ), incfile )
		end if

		ctx.incfile = incfile

	end if

	'' main?
	if( symbIsMainProc( proc ) ) then
		'' main proc (the entry point)
		hEmitSTABS( STAB_TYPE_MAIN, fbGetEntryPoint( ), 0, ctx.firstline, symbGetName( proc ) )

    	'' set the entry line
    	hEmitSTABD( STAB_TYPE_SLINE, 0, ctx.firstline )

    	'' also correct the end and start lines
    	proc->proc.dbg.iniline = ctx.firstline
    	proc->proc.dbg.endline = ctx.lastline

    	desc = fbGetEntryPoint( )
    else
    	desc = symbGetOrgName( proc )
    end if

	''
	procname = symbGetName( proc )

	if( symbIsPublic( proc ) ) then
		desc += ":F"
	else
		desc += ":f"
	end if

	desc += hGetDataType( proc )

	hEmitSTABS( STAB_TYPE_FUN, desc, 0, proc->proc.dbg.iniline, procname )

	hDeclArgs( proc )

	''
	ctx.isnewline = TRUE
	ctx.lnum	  = 0
	ctx.label	  = NULL

end sub

'':::::
private sub hDeclLocalVars( byval proc as FBSYMBOL ptr ) static
	dim as FBSYMBOL ptr s, funcres

	if( proc->typ <> FB_SYMBTYPE_VOID ) then
		funcres = symbLookupProcResult( proc )
	else
		funcres = NULL
	end if

	s = symbGetLocalHead( )
	do while( s <> NULL )

    	if( symbIsVar( s ) ) then
			'' not an argument?
    		if( (s->alloctype and (FB_ALLOCTYPE_ARGUMENTBYDESC or _
    			  				   FB_ALLOCTYPE_ARGUMENTBYVAL or _
    			  				   FB_ALLOCTYPE_ARGUMENTBYREF or _
    			  				   FB_ALLOCTYPE_TEMP)) = 0 ) then

				if( s <> funcres ) then
					edbgEmitLocalVar( s )
				end if
			end if
		end if

		s = s->next
	loop

end sub

'':::::
sub edbgEmitProcFooter( byval proc as FBSYMBOL ptr, _
			     	  	byval initlabel as FBSYMBOL ptr, _
			      		byval exitlabel as FBSYMBOL ptr ) static

    dim as string procname, lname

	if( not env.clopt.debug ) then
		exit sub
	end if

	''
	procname = symbGetName( proc )

    ''
    hDeclLocalVars( proc )

	'' main?
	if( not symbIsMainProc( proc ) ) then
		'' emit block (change the scope)
		hEmitSTABN( STAB_TYPE_LBRAC, 0, 0, symbGetName( initlabel ) + "-" + procname )
		hEmitSTABN( STAB_TYPE_RBRAC, 0, 0, symbGetName( exitlabel ) + "-" + procname )
	end if

	lname = *hMakeTmpStr( )
	hLABEL( lname )

	'' emit end proc (FUN with a null string)
	hEmitSTABS( STAB_TYPE_FUN, "", 0, 0, lname + "-" + procname )

	''
	ctx.isnewline = TRUE
	ctx.lnum	  = 0
	ctx.label	  = NULL

end sub

'':::::
private function hGetDataType( byval sym as FBSYMBOL ptr ) as string
	dim as integer dtype
	dim as FBVARDIM ptr d
	dim as FBSYMBOL ptr subtype
	dim as string desc

    if( sym = NULL ) then
    	return str( remapTB(FB_SYMBTYPE_VOID) )
    end if

    '' array?
    if( symbGetArrayDimensions( sym ) > 0 ) then
    	desc = str( ctx.typecnt ) + "="
    	ctx.typecnt += 1

    	if( symbIsDynamic( sym ) ) then
    		desc += str( ctx.typecnt ) + "=*"
    		ctx.typecnt += 1
    	end if

    	d = symbGetArrayFirstDim( sym )
    	do while( d <> NULL )
    		desc += "ar1;"
    		desc += str( d->lower ) + ";"
    		desc += str( d->upper ) + ";"
    		d = d->next
    	loop
    else
    	desc = ""
    end if

    dtype = symbGetType( sym )

    '' pointer?
    do while( dtype >= FB_SYMBTYPE_POINTER )
    	dtype -= FB_SYMBTYPE_POINTER
    	desc += str( ctx.typecnt ) + "=*"
    	ctx.typecnt += 1
    loop

    select case dtype
    '' UDT?
    case FB_SYMBTYPE_USERDEF
    	subtype = sym->subtype
    	if( subtype <> FB_DESCTYPE_ARRAY ) then
    		if( subtype->dbg.typenum = INVALID ) then
    			hDeclUDT( subtype )
    		end if

    		desc += str( subtype->dbg.typenum )
    	end if

    '' ENUM?
    case FB_SYMBTYPE_ENUM
    	subtype = sym->subtype
    	if( subtype->dbg.typenum = INVALID ) then
    		hDeclENUM( subtype )
    	end if

    	desc += str( subtype->dbg.typenum )

    '' function pointer?
    case FB_SYMBTYPE_FUNCTION
    	desc += str( ctx.typecnt ) + "=f"
    	ctx.typecnt += 1
    	desc += hGetDataType( sym->subtype )

    '' forward reference?
    case FB_SYMBTYPE_FWDREF
    	desc += str( remapTB(FB_SYMBTYPE_VOID) )

    '' ordinary type..
    case else
    	desc += str( remapTB(dtype) )

    end select

    function = desc

end function

'':::::
private sub hDeclUDT( byval sym as FBSYMBOL ptr )
    dim as FBSYMBOL ptr e
    dim as string desc

	sym->dbg.typenum = ctx.typecnt
	ctx.typecnt += 1

	desc = symbGetOrgName( sym )

	desc += ":T" + str( sym->dbg.typenum ) + "=s" + str( symbGetUDTLen( sym ) )

	e = symbGetUDTFirstElm( sym )
	do while( e <> NULL )
        desc += symbGetName( e ) + ":" + hGetDataType( e )
        desc += "," + str( symbGetUDTElmBitOfs( e ) ) + "," + str( symbGetUDTElmBitLen( e ) ) + ";"

		e = symbGetUDTNextElm( e )
	loop

	desc += ";"

	hEmitSTABS( STAB_TYPE_LSYM, desc, 0, 0, "0" )

end sub

'':::::
private sub hDeclENUM( byval sym as FBSYMBOL ptr )
    dim as FBSYMBOL ptr e
    dim as string desc

	sym->dbg.typenum = ctx.typecnt
	ctx.typecnt += 1

	desc = symbGetOrgName( sym )

	desc += ":T" + str$( sym->dbg.typenum ) + "=e"

	e = symbGetENUMFirstElm( sym )
	do while( e <> NULL )
        desc += symbGetName( e ) + ":" + symbGetConstText( e ) + ","

		e = symbGetENUMNextElm( e )
	loop

	desc += ";"

	hEmitSTABS( STAB_TYPE_LSYM, desc, 0, 0, "0" )

end sub

'':::::
sub edbgEmitGlobalVar( byval sym as FBSYMBOL ptr, _
				   	   byval section as integer ) static

	dim as integer t, alloctype
	dim as string desc, sname

	if( not env.clopt.debug ) then
		exit sub
	end if

	'' local declared as static..
	if( sym->scope > 0 ) then
		exit sub
	end if

	'' external static arrays..
	if( symbIsExtern( sym ) ) then
		exit sub
	end if

	'' temporary?
	if( symbIsTemp( sym ) ) then
		exit sub
	end if

	'' depends on section
	select case section
	case EMIT_SECTYPE_CONST
		t = STAB_TYPE_FUN
	case EMIT_SECTYPE_DATA
		t = STAB_TYPE_STSYM
	case EMIT_SECTYPE_BSS
		t = STAB_TYPE_LCSYM
	end select

    '' allocation type (static, global, etc)
    desc = symbGetOrgName( sym )

    alloctype = symbGetAllocType( sym )
    if( (alloctype and (FB_ALLOCTYPE_PUBLIC or FB_ALLOCTYPE_COMMON)) > 0 ) then
    	desc += ":G"
    elseif( (sym->scope = 0) or (alloctype and FB_ALLOCTYPE_STATIC) > 0 ) then
        desc += ":S"
    else
    	desc += ":"
    end if

    '' data type
    desc += hGetDataType( sym )

    ''
    if( symbIsDynamic( sym ) ) then
    	sname = symbGetVarDescName( sym )
    else
    	sname = symbGetName( sym )
    end if

    ''
    hEmitSTABS( t, desc, 0, 0, sname )

end sub

'':::::
sub edbgEmitLocalVar( byval sym as FBSYMBOL ptr ) static
	dim as integer t
	dim as string desc, value

	if( not env.clopt.debug ) then
		exit sub
	end if

    desc = symbGetOrgName( sym )

    ''
    if( symbIsStatic( sym ) ) then
		if( symbGetVarEmited( sym ) ) then
			t = STAB_TYPE_STSYM
		else
			t = STAB_TYPE_LCSYM
		end if
		desc += ":V"
		value = symbGetName( sym )
    else
    	t = STAB_TYPE_LSYM
    	desc += ":"
    	value = str( symbGetVarOfs( sym ) )
    end if

    '' data type
    desc += hGetDataType( sym )

    ''
    hEmitSTABS( t, desc, 0, 0, value )

end sub

'':::::
sub edbgEmitProcArg( byval sym as FBSYMBOL ptr ) static

	dim as string desc

	if( not env.clopt.debug ) then
		exit sub
	end if

    desc = symbGetOrgName( sym ) + ":"

    if( symbIsArgByVal( sym ) ) then
	    desc += "p"

	elseif( symbIsArgByRef( sym ) ) then
		desc += "v"

	elseif( symbIsArgByDesc( sym ) ) then
    	desc += "v"
	end if

    '' data type
    desc += hGetDataType( sym )

    ''
    hEmitSTABS( STAB_TYPE_PSYM, desc, 0, 0, str( symbGetVarOfs( sym ) ) )

end sub

'':::::
sub edbgIncludeBegin ( byval incname as string, _
					   byval incfile as integer ) static
	dim as string fname, lname

	if( not env.clopt.debug ) then
		exit sub
	end if

	ctx.incfile = incfile

	fname = hRevertSlash( incname )

	hEmitSTABS( STAB_TYPE_BINCL, fname, 0, 0 )

	emitSECTION( EMIT_SECTYPE_CODE )

	lname = *hMakeTmpStr( )

	hEmitSTABS( STAB_TYPE_SOL, fname, 0, 0, lname )

	hLABEL( lname )

end sub

'':::::
sub edbgIncludeEnd ( ) static

	if( not env.clopt.debug ) then
		exit sub
	end if

	if( ctx.incfile = INVALID ) then
		exit sub
	end if

	hEmitSTABS( STAB_TYPE_EINCL, "", 0, 0 )

	ctx.incfile = INVALID

end sub



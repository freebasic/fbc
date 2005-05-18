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

'$include once:'inc\fb.bi'
'$include once:'inc\fbint.bi'
'$include once:'inc\lex.bi'
'$include once:'inc\emit.bi'
'$include once:'inc\emitdbg.bi'
'$include once:'inc\stabs.bi'

type EDBGCTX
	asmf			as integer
	modulename		as zstring * FB.MAXNAMELEN+1
	entryname		as zstring * FB.MAXNAMELEN+1

	mainopened		as integer
	mainclosed		as integer
	mainininame		as zstring * FB.MAXNAMELEN+1

	procinitline 	as integer

	typecnt			as uinteger

	lname 			as zstring * 32+1
	lnum 			as integer
	pos 			as integer
	isnewline		as integer
end type

declare sub 	 hDeclUDT				( byval sym as FBSYMBOL ptr )

declare function hGetDataType			( byval sym as FBSYMBOL ptr ) as string

'' globals
	dim shared ctx as EDBGCTX

	dim shared remapTB(0 to FB.SYMBOLTYPES-1) = { 7, 2, 3, 4, 5, 6, 1, 8, 9, 10, 11, 12, 13, 14 }


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
	ostr += str$( _type )
	ostr += ","
	ostr += str$( _other )
	ostr += ","
	ostr += str$( _desc )
	ostr += ","
	ostr += _value

	hWriteStr( ctx.asmf, TRUE, ostr )

end sub

'':::::
private sub hEmitSTABN( byval _type as integer, _
						byval _other as integer = 0, _
						byval _desc as integer = 0, _
						byval _value as string = "0" ) static

	dim as string ostr

	ostr = ".stabn "
	ostr += str$( _type )
	ostr += ","
	ostr += str$( _other )
	ostr += ","
	ostr += str$( _desc )
	ostr += ","
	ostr += _value

	hWriteStr( ctx.asmf, TRUE, ostr )

end sub

'':::::
private sub hEmitSTABD( byval _type as integer, _
						byval _other as integer = 0, _
						byval _desc as integer = 0 ) static

	dim as string ostr

	ostr = ".stabd "
	ostr += str$( _type )
	ostr += ","
	ostr += str$( _other )
	ostr += ","
	ostr += str$( _desc )

	hWriteStr( ctx.asmf, TRUE, ostr )

end sub


'':::::
sub edbgHeader( byval asmf as integer, _
				byval filename as string, _
				byval modulename as string, _
				byval entryname as string ) static
    dim as integer i
    dim as string fname, stab

	if( not env.clopt.debug ) then
		exit sub
	end if

	''
	ctx.asmf 		= asmf
	ctx.entryname 	= entryname
	ctx.modulename 	= modulename
	ctx.mainopened	= FALSE
	ctx.mainclosed	= FALSE
	ctx.typecnt 	= 1

	ctx.lname 		= ""
	ctx.lnum 		= 0
	ctx.isnewline 	= TRUE

	'' emit source file
    fname = hRevertSlash( filename )
    hWriteStr( asmf, TRUE, ".file \"" + fname + "\"" )
    if( instr( fname, "/" ) = 0 ) then
    	hEmitSTABS( STAB_TYPE_SO, hRevertSlash( curdir$ + "/" ), 0, 0, "__stabini" )
    end if

    hEmitSTABS( STAB_TYPE_SO, fname, 0, 0, "__stabini" )

	''
	emitSECTION( EMIT.SECTYPE.CODE )
	emitLABEL( "__stabini" )

	'' (known) type defs
	restore stabstdef
	do
		read stab
		if( len( stab ) = 0 ) then
			exit do
		end if
		hEmitSTABS( STAB_TYPE_LSYM, stab, 0, 0, "0" )
		ctx.typecnt += 1
	loop

	hWriteStr( asmf, FALSE, "" )

	hEmitSTABS( STAB_TYPE_BINCL, fname, 0, 0 )

	'' main proc (the entry point)
	hEmitSTABS( STAB_TYPE_MAIN, ctx.modulename, 0, 1, ctx.entryname )

end sub

'':::::
sub edbgFooter( )

	if( not env.clopt.debug ) then
		exit sub
	end if

	emitSECTION( EMIT.SECTYPE.CODE )

	edgbMainEnd( )

	'' no checkings after this
	hEmitSTABS( STAB_TYPE_SO, "", 0, 0, "__stabend" )

	emitLABEL( "__stabend" )

end sub

'':::::
sub edbgMainBegin( byval lnum as integer, _
			       byval lname as string ) static

	ctx.mainopened = TRUE
	ctx.mainclosed = FALSE
	ctx.mainininame = lname

	edbgProcBegin( NULL, FALSE, lnum )

end sub

'':::::
sub edgbMainEnd( )
    dim as integer currpos
    dim as string lname

	if( not env.clopt.debug ) then
		exit sub
	end if

	if( not ctx.mainopened or ctx.mainclosed ) then
		exit sub
	end if

    '' set entry line
    hEmitSTABD( STAB_TYPE_SLINE, 0, ctx.procinitline )

    ''
    lname = *hMakeTmpStr( )
    emitLABEL( lname )

    '' close main()
    edbgProcEnd( NULL, ctx.mainininame, lname )

	ctx.mainclosed = TRUE

end sub

'':::::
sub edbgLineBegin( )

    if( not env.clopt.debug ) then
    	exit sub
    end if

    if( ctx.lnum > 0 ) then
    	''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
    	irFlush( )
    	ctx.pos = emitGetPos( ) - ctx.pos
    	if( ctx.pos > 0 ) then
    		edbgLine( ctx.lnum, ctx.lname )
    		ctx.isnewline = TRUE
    	end if
    end if

    ''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
    irFlush( )
    ctx.pos	 = emitGetPos( )
    ctx.lnum  = lexLineNum( )
    if( ctx.isnewline ) then
    	ctx.lname = *hMakeTmpStr( )
    	emitLABEL( ctx.lname )
    	ctx.isnewline = FALSE
    end if

end sub

'':::::
sub edbgLineEnd( )

    if( not env.clopt.debug ) then
    	exit sub
    end if

    if( ctx.lnum > 0 ) then
    	''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
    	irFlush( )
    	ctx.pos = emitGetPos( ) - ctx.pos
    	if( ctx.pos > 0 ) then
   			edbgLine( ctx.lnum, ctx.lname )
   			ctx.isnewline = TRUE
   		end if
    	ctx.lnum = 0
    end if

end sub

'':::::
sub edbgLine( byval lnum as integer, _
			  byval lname as string ) static

    dim as string procname

	if( not env.clopt.debug ) then
		exit sub
	end if

	if( not ctx.mainopened ) then
		edbgMainBegin( lnum, lname )
	end if

	'' not at module level?
	if( env.currproc <> NULL ) then
		procname = symbGetName( env.currproc )

	'' module level..
	else
		procname = ctx.entryname
	end if

	'' emit current line
	hEmitSTABN( STAB_TYPE_SLINE, 0, lnum, lname + "-" + procname )

end sub

'':::::
sub edbgProcBegin ( byval proc as FBSYMBOL ptr, _
					byval ispublic as integer, _
					byval lnum as integer ) static

    dim as string desc, procname

	if( not env.clopt.debug ) then
		exit sub
	end if

	'' not at module level?
	if( proc <> NULL ) then
		'' main() not closed yet?
		if( ctx.mainopened and not ctx.mainclosed ) then
			edgbMainEnd( )
		end if

		desc = symbGetOrgName( proc )
		procname = symbGetName( proc )

	'' module-level..
	else
		desc = ctx.modulename
		procname = ctx.entryname
	end if

	if( ispublic ) then
		desc += ":F"
	else
		desc += ":f"
	end if

	if( lnum = -1 ) then
		ctx.procinitline = lexLineNum( )
	else
		ctx.procinitline = lnum
	end if

	desc += hGetDataType( proc )

	hEmitSTABS( STAB_TYPE_FUN, desc, 0, ctx.procinitline, procname )

	ctx.isnewline = TRUE

end sub

'':::::
private sub edbgLocalVars( byval proc as FBSYMBOL ptr ) static
	dim as FBLOCSYMBOL ptr l
	dim as FBSYMBOL ptr s, funcres

	if( proc->typ <> FB.SYMBTYPE.VOID ) then
		funcres = symbLookupProcResult( proc )
	else
		funcres = NULL
	end if

	l = symbGetFirstLocalNode( )
	do while( l <> NULL )

    	s = l->s
    	if( symbIsVar( s ) ) then
			'' not an argument?
    		if( (s->alloctype and (FB.ALLOCTYPE.ARGUMENTBYDESC or _
    			  				   FB.ALLOCTYPE.ARGUMENTBYVAL or _
    			  				   FB.ALLOCTYPE.ARGUMENTBYREF or _
    			  				   FB.ALLOCTYPE.TEMP)) = 0 ) then

				if( s <> funcres ) then
					edbgLocalVar( s )
				end if
			end if
		end if

		l = symbGetNextLocalNode( l )
	loop

end sub

'':::::
sub edbgProcEnd ( byval proc as FBSYMBOL ptr, _
				  byval ininame as string, _
				  byval endname as string ) static

    dim as string procname, lname
    dim as integer iniline, endline

	if( not env.clopt.debug ) then
		exit sub
	end if

	iniline = ctx.procinitline
	endline = lexLineNum( )

	'' not at module level?
	if( proc <> NULL ) then
		procname = symbGetName( proc )

		edbgLocalVars( proc )

	'' module level..
	else
		procname = ctx.entryname
		endline -= 1
	end if

	'' emit block (change the scope)
	hEmitSTABN( STAB_TYPE_LBRAC, 0, iniline, ininame + "-" + procname )
	hEmitSTABN( STAB_TYPE_RBRAC, 0, endline, endname + "-" + procname )

	lname = *hMakeTmpStr( )
	emitLABEL( lname )

	'' emit end proc (FUN with a null string)
	hEmitSTABS( STAB_TYPE_FUN, "", 0, 0, lname + "-" + procname )

	ctx.isnewline = TRUE

end sub

'':::::
private function hGetDataType( byval sym as FBSYMBOL ptr ) as string
	dim as integer dtype
	dim as FBVARDIM ptr d
	dim as FBSYMBOL ptr udt
	dim as string desc

    if( sym = NULL ) then
    	return str$( remapTB(FB.SYMBTYPE.VOID) )
    end if

    '' array?
    if( symbGetArrayDimensions( sym ) > 0 ) then
    	desc = str$( ctx.typecnt ) + "="
    	ctx.typecnt += 1

    	if( symbIsDynamic( sym ) ) then
    		desc += str$( ctx.typecnt ) + "=*"
    		ctx.typecnt += 1
    	end if

    	d = symbGetArrayFirstDim( sym )
    	do while( d <> NULL )
    		desc += "ar1;"
    		desc += str$( d->lower ) + ";"
    		desc += str$( d->upper ) + ";"
    		d = d->r
    	loop
    else
    	desc = ""
    end if

    dtype = symbGetType( sym )

    '' pointer?
    do while( dtype >= FB.SYMBTYPE.POINTER )
    	dtype -= FB.SYMBTYPE.POINTER
    	desc += str$( ctx.typecnt ) + "=*"
    	ctx.typecnt += 1
    loop

    select case dtype
    '' UDT?
    case FB.SYMBTYPE.USERDEF
    	udt = sym->subtype
    	if( udt <> FB.DESCTYPE.ARRAY ) then
    		if( udt->dbg.typenum = INVALID ) then
    			hDeclUDT( udt )
    		end if

    		desc += str$( udt->dbg.typenum )
    	end if

    '' function pointer?
    case FB.SYMBTYPE.FUNCTION
    	desc += str$( ctx.typecnt ) + "=f"
    	ctx.typecnt += 1
    	desc += hGetDataType( sym->subtype )

    '' forward reference?
    case FB.SYMBTYPE.FWDREF
    	desc += str$( remapTB(FB.SYMBTYPE.VOID) )

    '' ordinary type..
    case else
    	desc += str$( remapTB(dtype) )

    end select

    function = desc

end function

'':::::
private sub hDeclUDT( byval sym as FBSYMBOL ptr )
    dim as FBSYMBOL ptr e
    dim as string desc

	sym->dbg.typenum = ctx.typecnt
	ctx.typecnt += 1

    if( sym->hashitem = NULL ) then
    	desc = symbGetName( sym )
    else
		desc = symbGetOrgName( sym )
	end if

	desc += ":T" + str$( sym->dbg.typenum ) + "=s" + str$( symbGetUDTLen( sym ) )

	e = symbGetUDTFirstElm( sym )
	do while( e <> NULL )
        desc += symbGetName( e ) + ":" + hGetDataType( e )
        desc += "," + str$( symbGetUDTElmBitOfs( e ) ) + "," + str$( symbGetUDTElmBitLen( e ) ) + ";"

		e = symbGetUDTNextElm( e )
	loop

	desc += ";"

	hEmitSTABS( STAB_TYPE_LSYM, desc, 0, 0, "0" )

end sub

'':::::
sub edbgGlobalVar( byval sym as FBSYMBOL ptr, _
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

	'' depends on section
	select case section
	case EMIT.SECTYPE.CONST
		t = STAB_TYPE_FUN
	case EMIT.SECTYPE.DATA
		t = STAB_TYPE_STSYM
	case EMIT.SECTYPE.BSS
		t = STAB_TYPE_LCSYM
	end select

    '' alloc type
    alloctype = symbGetAllocType( sym )

    if( sym->hashitem = NULL ) then
    	desc = symbGetName( sym )
    else
    	desc = symbGetOrgName( sym )
    end if

    if( (alloctype and (FB.ALLOCTYPE.PUBLIC or FB.ALLOCTYPE.COMMON)) > 0 ) then
    	desc += ":G"
    elseif( (sym->scope = 0) or (alloctype and FB.ALLOCTYPE.STATIC) > 0 ) then
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
sub edbgLocalVar( byval sym as FBSYMBOL ptr ) static
	dim as integer t
	dim as string desc, value

	if( not env.clopt.debug ) then
		exit sub
	end if

    if( sym->hashitem = NULL ) then
    	desc = symbGetName( sym )
    else
    	desc = symbGetOrgName( sym )
    end if

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
    	value = str$( symbGetVarOfs( sym ) )
    end if

    '' data type
    desc += hGetDataType( sym )

    ''
    hEmitSTABS( t, desc, 0, 0, value )

end sub

'':::::
sub edbgProcArg( byval sym as FBSYMBOL ptr, _
				 byval typ as integer, _
				 byval mode as integer ) static

	dim as string desc

	if( not env.clopt.debug ) then
		exit sub
	end if

    desc = symbGetOrgName( sym ) + ":"

    select case mode
    case FB.ARGMODE.BYVAL
	    desc += "p"

	case FB.ARGMODE.BYREF
		desc += "v"

	case FB.ARGMODE.BYDESC
    	desc += "v"
	end select

    '' data type
    if( typ <> sym->typ ) then
    	desc += str$( remapTB(typ) )
    else
    	desc += hGetDataType( sym )
    end if

    ''
    hEmitSTABS( STAB_TYPE_PSYM, desc, 0, 0, str$( symbGetVarOfs( sym ) ) )

end sub

'':::::
sub edbgIncludeBegin ( byval incfile as string ) static
	dim as string fname, lname

	if( not env.clopt.debug ) then
		exit sub
	end if

	fname = hRevertSlash( incfile )

	hEmitSTABS( STAB_TYPE_BINCL, fname, 0, 0 )

	emitSECTION( EMIT.SECTYPE.CODE )

	lname = *hMakeTmpStr( )

	hEmitSTABS( STAB_TYPE_SOL, fname, 0, 0, lname )

	emitLABEL( lname )

	ctx.isnewline = TRUE

end sub

'':::::
sub edbgIncludeEnd ( ) static

	if( not env.clopt.debug ) then
		exit sub
	end if

	hEmitSTABS( STAB_TYPE_EINCL, "", 0, 0 )

	ctx.isnewline = TRUE

end sub



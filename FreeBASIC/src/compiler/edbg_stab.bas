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
	modulename		as string
	entryname		as string

	mainopened		as integer
	mainclosed		as integer
	maininitlabel	as FBSYMBOL ptr

	procinitline 	as integer

	typecnt			as integer
end type

declare sub hDeclUDT			( byval sym as FBSYMBOL ptr )

'' globals
	dim shared ctx as EDBGCTX

	dim shared remapTB(0 to FB.SYMBOLTYPES-1) = { 7, 2, 3, 4, 5, 6, 1, 8, 9, 10, 11, 12, 13, 14, 15 }


stabstdef:
data "int:t1=r1;-2147483648;2147483647;"
data "void:t7=r2"
data "byte:t2=r1;-128;127;"
data "ubyte:t3=r1;0;255;"
data "char:t4=r1;-128;127;"
data "short:t5=r1;-32768;32767;"
data "ushort:t6=r1;0;65535;"
data "uinteger:t8=r1;0;-1;"
data "longint:t9=r1;0;-1;"
data "ulongint:t10=r1;0;-1;"
data "single:t11=r1;4;0"
data "double:t12=r1;8;0"
data "ubyte:t13=r1;0;255;"
data "ubyte:t14=r1;0;255;"
data "ubyte:t15=r1;0;255;"
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
				byval entryname as string )
    dim as integer i
    dim as string s

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

	'' emit source file
    s = hRevertSlash( filename )
    hWriteStr asmf, TRUE, ".file \"" + s + "\""
    if( instr( s, "/" ) = 0 ) then
    	hEmitSTABS( STAB_TYPE_SO, hRevertSlash( curdir$ + "/" ), 0, 0, "__stabini" )
    end if

    hEmitSTABS( STAB_TYPE_SO, s, 0, 0, "__stabini" )

	'' (known) type defs
	emitSECTION( EMIT.SECTYPE.CODE )
	hWriteStr( asmf, FALSE, "__stabini:" )

	restore stabstdef
	do
		read s
		if( len( s ) = 0 ) then
			exit do
		end if
		hEmitSTABS( STAB_TYPE_LSYM, s, 0, 0, "0" )
		ctx.typecnt += 1
	loop

	hWriteStr( asmf, FALSE, "" )

	'' main proc (the entry point)
	hEmitSTABS( STAB_TYPE_MAIN, modulename, 0, 1, entryname )

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

	hWriteStr( ctx.asmf, FALSE, "__stabend:" )

end sub

'':::::
sub edbgMainBegin( byval initlabel as FBSYMBOL ptr )

	if( not env.clopt.debug ) then
		exit sub
	end if

	ctx.mainclosed = FALSE
	ctx.maininitlabel = initlabel

end sub

'':::::
sub edgbMainEnd( )
    dim as FBSYMBOL ptr exitlabel
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
    exitlabel = symbAddLabel( "" )

    lname = symbGetName( exitlabel )
    emitLABEL( lname )

    '' close main()
    edbgProcEnd( NULL, ctx.maininitlabel, exitlabel )

	'''''symbDelLabel exitlabel

	ctx.mainclosed = TRUE

end sub

'':::::
sub edbgLine( byval lnum as integer, _
			  byval lname as string ) static

    dim as string procname

	if( not env.clopt.debug ) then
		exit sub
	end if

	'' module level and main() header not emited yet?
	if( not ctx.mainopened ) then
		edbgProcBegin( NULL, FALSE, lnum )
		ctx.mainopened = TRUE
		ctx.mainclosed = FALSE
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

    dim as string realname, procname, prochar

	if( not env.clopt.debug ) then
		exit sub
	end if

	'' not at module level?
	if( proc <> NULL ) then
		'' main() not closed yet?
		if( ctx.mainopened and not ctx.mainclosed ) then
			edgbMainEnd( )
		end if

		realname = symbGetOrgName( proc )
		procname = symbGetName( proc )

	'' module-level..
	else
		realname = ctx.modulename
		procname = ctx.entryname
	end if

	if( ispublic ) then
		prochar = "F"
	else
		prochar = "f"
	end if

	if( lnum = -1 ) then
		ctx.procinitline = lexLineNum
	else
		ctx.procinitline = lnum
	end if

	hEmitSTABS( STAB_TYPE_FUN, realname + ":" + prochar + "4", 0, ctx.procinitline, procname )

end sub

'':::::
sub edbgProcEnd ( byval proc as FBSYMBOL ptr, _
				  byval initlabel as FBSYMBOL ptr, _
				  byval exitlabel as FBSYMBOL ptr ) static

    dim as string procname, ininame, endname, lname
    dim as integer iniline, endline

	if( not env.clopt.debug ) then
		exit sub
	end if

	iniline = ctx.procinitline
	endline = lexLineNum

	'' not at module level?
	if( proc <> NULL ) then
		procname = symbGetName( proc )

	'' module level..
	else
		procname = ctx.entryname
		endline -= 1
	end if

	ininame	 = symbGetName( initlabel )
	endname	 = symbGetName( exitlabel )

	'' emit block (change the scope)
	hEmitSTABN( STAB_TYPE_LBRAC, 0, iniline, ininame + "-" + procname )
	hEmitSTABN( STAB_TYPE_RBRAC, 0, endline, endname + "-" + procname )

	lname = *hMakeTmpStr( )
	emitLABEL( lname )

	'' emit end proc (FUN with a null string)
	hEmitSTABS( STAB_TYPE_FUN, "", 0, 0, lname + "-" + procname )

end sub

'':::::
private function hGetDataType( byval sym as FBSYMBOL ptr ) as string
	dim as integer dtype
	dim as FBVARDIM ptr d
	dim as FBSYMBOL ptr udt
	dim as string desc

    '' array?
    if( symbGetArrayDimensions( sym ) > 0 ) then
    	desc = str$( ctx.typecnt )
    	ctx.typecnt += 1
    	desc += "=ar1;"
    	d = symbGetArrayFirstDim( sym )
    	do while( d <> NULL )
    		desc += str$( d->lower )
    		desc += ";"
    		desc += str$( d->upper )
    		d = d->r
    	loop
    else
    	desc = ""
    end if

    dtype = symbGetType( sym )
    select case dtype
    case FB.SYMBTYPE.USERDEF
    	udt = sym->subtype
    	if( udt->dbg.typenum = INVALID ) then
    		hDeclUDT( udt )
    	end if

    	desc += str$( udt->dbg.typenum )

    case else
    	if( dtype >= FB.SYMBTYPE.POINTER ) then
    		dtype = FB.SYMBTYPE.UINT
    	end if

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

	desc = symbGetOrgName( sym ) + ":T" + str$( sym->dbg.typenum ) + "=s" + str$( symbGetUDTLen( sym ) )

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

	dim as integer t, alloctype, dtype
	dim as string desc

	if( not env.clopt.debug ) then
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

    if( (alloctype and (FB.ALLOCTYPE.PUBLIC or FB.ALLOCTYPE.COMMON)) > 0 ) then
    	desc = ":G"
    elseif( (sym->scope = 0) or (alloctype and FB.ALLOCTYPE.STATIC) > 0 ) then
        desc = ":S"
    else
    	desc = ":"
    end if

    '' data type
    desc += hGetDataType( sym )

    ''
    hEmitSTABS( t, symbGetOrgName( sym ) + desc, 0, 0, symbGetName( sym ) )

end sub


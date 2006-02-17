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


'' misc helpers
''
''

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\lex.bi"
#include once "inc\dstr.bi"

type FBHLPCTX
	tmpcnt		as uinteger
end type


''globals
	dim shared ctx as FBHLPCTX

	dim shared deftypeTB( 0 to (asc("_")-asc("A")+1)-1 ) as integer

	dim shared suffixTB( 0 to FB_DATATYPES-1 ) as zstring * 1+1 => _
	{ _
				"v", _							'' void
				"b", "a", _                     '' byte, ubyte
				"c", _                          '' char
				"s", "r", _                     '' short, ushort
				"w", _                          '' wchar
				"i", "j", _                     '' integer, uinteger
				"e", _                          '' enum
				"~", _                          '' bitfield
				"l", "m", _                     '' longint, ulongint
				"f", "d", _                     '' single, double
				"t", "x", _                     '' var-len string, fix-len string
				"u", _                     		'' udt
				"n", _							'' function
				"z", _                          '' fwd-ref
				"p" _                           '' pointer
	}


'':::::
sub hlpInit
    dim i as integer

	''
	for i = 0 to (asc("_")-asc("A")+1)-1
		deftypeTB(i) = FB_DATATYPE_INTEGER
	next

	''
	for i = 0 to FB_DATATYPES-1
		if( len( suffixTB(i) ) = 0 ) then
			suffixTB(i) = chr( CHAR_ALOW + i )
		end if
	next

	''
	ctx.tmpcnt	= 0

end sub

'':::::
sub hlpEnd

end sub

'':::::
function hMatch( byval token as integer ) as integer

	function = FALSE
	if( lexGetToken( ) = token ) then
		function = TRUE
		lexSkipToken( )
	end if

end function

'':::::
function hHexUInt( byval value as uinteger ) as zstring ptr static
    static as zstring * 8 + 1 res
    dim as zstring ptr p
    dim as integer lgt, maxlen

	static hexTB(0 to 15) as integer = { asc( "0" ), asc( "1" ), asc( "2" ), asc( "3" ), _
									  	 asc( "4" ), asc( "5" ), asc( "6" ), asc( "7" ), _
										 asc( "8" ), asc( "9" ), asc( "A" ), asc( "B" ), _
										 asc( "C" ), asc( "D" ), asc( "E" ), asc( "F" ) }

	maxlen = 4
	if( value > 65535 ) then
		maxlen = 8
	end if

	p = @res + 8-1
	lgt = 0

	do
		*p = hexTB( value and &h0000000F )

		lgt +=1
		if( lgt = maxlen ) then
			exit do
		end if

		p -= 1
		value shr= 4
	loop

	function = p

end function

'':::::
function hMakeTmpStr( byval islabel as integer ) as zstring ptr static
	static as zstring * 8 + 3 + 1 res

	if( islabel ) then
		res = ".Lt_" + *hHexUInt( ctx.tmpcnt )
	else
		res = "Lt_" + *hHexUInt( ctx.tmpcnt )
	end if

	ctx.tmpcnt += 1

	function = @res

end function

'':::::
function hFloatToStr( byval value as double, _
					  byref typ as integer ) as string static

    dim as integer expval

	'' x86 little-endian assumption
	expval = cptr( integer ptr, @value )[1]

	select case expval
	'' -|+ infinite?
	case &h7FF00000UL, &hFFF00000UL
		if( typ = FB_DATATYPE_DOUBLE ) then
			typ = FB_DATATYPE_LONGINT
			if( expval >= 0 ) then
				function = "0x7FF0000000000000"
			else
				function = "0xFFF0000000000000"
			end if
		else
			typ = FB_DATATYPE_INTEGER
			if( expval >= 0 ) then
				function = "0x7F800000"
			else
				function = "0xFF800000"
			end if
		end if

	'' -|+ NaN? Quiet-NaN's only
	case &h7FF80000UL, &hFFF80000UL
		if( typ = FB_DATATYPE_DOUBLE ) then
			typ = FB_DATATYPE_LONGINT
			function = "0x7FF8000000000000"
		else
			typ = FB_DATATYPE_INTEGER
			function = "0x7FF00000"
		end if

	case else
		function = str( value )
	end select

end function

'':::::
function hGetDefType( byval symbol as zstring ptr ) as integer static
    dim c as integer

	c = symbol[0][0]

	'' to upper
	if( (c >= asc("a")) and (c <= asc("z")) ) then
		c -= (asc("a") - asc("A"))
	end if

	function = deftypeTB(c - asc("A"))

end function

'':::::
sub hSetDefType( byval ichar as integer, _
				 byval echar as integer, _
				 byval typ as integer ) static
    dim i as integer

	if( ichar < asc("A") ) then
		ichar = asc("A")
	elseif( ichar > asc("_") ) then
		ichar = asc("_")
	end if

	if( echar < asc("A") ) then
		echar = asc("A")
	elseif( echar > asc("_") ) then
		echar = asc("_")
	end if

	if( ichar > echar ) then
		swap ichar, echar
	end if

	for i = ichar to echar
		deftypeTB(i - asc("A")) = typ
	next i

end sub

'':::::
function hFBrelop2IRrelop( byval op as integer ) as integer static

    select case as const op
    case FB_TK_EQ
    	op = IR_OP_EQ
    case FB_TK_GT
    	op = IR_OP_GT
    case FB_TK_LT
    	op = IR_OP_LT
    case FB_TK_NE
    	op = IR_OP_NE
    case FB_TK_LE
    	op = IR_OP_LE
    case FB_TK_GE
    	op = IR_OP_GE
    end select

    function = op

end function

'':::::
function hFileExists( byval filename as zstring ptr ) as integer static
    dim f as integer

    f = freefile

	if( open( *filename, for input, as #f ) = 0 ) then
		function = TRUE
		close #f
	else
		function = FALSE
	end if

end function

'':::::
sub hUcase( byval src as zstring ptr, _
		    byval dst as zstring ptr ) static

    dim as integer i, c
    dim as zstring ptr s, d

	s = src
	d = dst
	for i = 1 to len( *src )
		c = *s

		if( c >= 97 ) then
			if( c <= 122 ) then
				c -= (97 - 65)
			end if
		end if

		*d = c

		s += 1
		d += 1
	next

	'' null-term
	*d = 0

end sub


'':::::
sub hClearName( byval src as zstring ptr ) static
    dim i as integer
    dim p as zstring ptr

	p = src

	for i = 1 to len( *src )

		select case as const *p
		case CHAR_AUPP to CHAR_ZUPP, CHAR_ALOW to CHAR_ZLOW, CHAR_0 to CHAR_9, CHAR_UNDER

		case else
			*p = CHAR_ZLOW
		end select

		p += 1
	next

end sub

'':::::
function hCreateName( byval symbol as zstring ptr, _
					  byval typ as integer = INVALID, _
					  byval preservecase as integer = FALSE, _
					  byval addunderscore as integer = TRUE, _
					  byval clearname as integer = TRUE ) as zstring ptr static

    static sname as zstring * FB_MAXINTNAMELEN+1

	if( addunderscore ) then
		sname = "_"
		sname += *symbol
	else
		sname = *symbol
	end if

	if( preservecase = FALSE ) then
		hUcase( sname, sname )
	end if

    if( clearname ) then
    	hClearName( sname )
    end if

    if( typ <> INVALID ) then
    	if( typ > FB_DATATYPE_POINTER ) then
    		typ = FB_DATATYPE_POINTER
    	end if
    	sname += suffixTB( typ )
    end if

	function = @sname

end function

'':::::
function hCreateProcAlias( byval symbol as zstring ptr, _
						   byval argslen as integer, _
						   byval mode as integer ) as zstring ptr static

    static sname as zstring * FB_MAXINTNAMELEN+1


	select case as const env.clopt.target
    case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
        dim addat as integer

        if( env.clopt.nounderprefix ) then
            sname = *symbol
        else
            sname = "_"
            sname += *symbol
        end if

        if( env.clopt.nostdcall ) then
            addat = FALSE
        else
            addat = (mode = FB_FUNCMODE_STDCALL)
        end if

        if( addat ) then
            if( instr( *symbol, "@" ) = 0 ) then
            	sname += "@"
            	sname += str( argslen )
            end if
        end if

	case FB_COMPTARGET_LINUX
		sname = *symbol

	case FB_COMPTARGET_DOS, FB_COMPTARGET_XBOX
        sname = "_"
        sname += *symbol

    end select

	function = @sname

end function

'':::::
function hCreateOvlProcAlias( byval symbol as zstring ptr, _
					    	  byval argc as integer, _
					    	  byval arg as FBSYMBOL ptr ) as zstring ptr static
    dim as integer i, typ
    static as zstring * FB_MAXINTNAMELEN+1 aname

    aname = *symbol
    aname += "__ovl_"

    for i = 0 to argc-1
    	aname += "_"

		'' by descriptor?
		if( symbGetArgMode( arg ) = FB_ARGMODE_BYDESC ) then
			aname += "d"
		end if

    	typ = symbGetType( arg )
    	do while( typ >= FB_DATATYPE_POINTER )
    		aname += "p"
    		typ -= FB_DATATYPE_POINTER
    	loop

    	aname += suffixTB( typ )
    	if( (typ = FB_DATATYPE_USERDEF) or _
    		(typ = FB_DATATYPE_ENUM) ) then
    		aname += *symbGetOrgName( symbGetSubType( arg ) )
    	end if

    	'' next
    	arg = symbGetArgNext( arg )
    next

	function = @aname

end function


'':::::
function hCreateDataAlias( byval symbol as zstring ptr, _
						   byval isimport as integer ) as string static

	select case as const env.clopt.target
    case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
        if( isimport ) then
            function = "__imp__" + *symbol
        else
            function = "_" + *symbol
        end if

    case FB_COMPTARGET_DOS, FB_COMPTARGET_XBOX
		function = "_" + *symbol

    case FB_COMPTARGET_LINUX
		function = *symbol

    end select

end function

'':::::
function hStripUnderscore( byval symbol as zstring ptr ) as string static

	select case as const env.clopt.target
    case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
	    if( env.clopt.nostdcall = FALSE ) then
			function = *(symbol + 1)
		else
			function = *symbol
		end if

    case FB_COMPTARGET_DOS, FB_COMPTARGET_XBOX
    	function = *(symbol + 1)

    case FB_COMPTARGET_LINUX
    	function = *symbol

    end select

end function

'':::::
function hStripExt( byval filename as zstring ptr ) as string static
    dim p as integer, lp as integer

	lp = 0
	do
		p = instr( lp+1, *filename, "." )
	    if( p = 0 ) then
	    	exit do
	    end if
	    lp = p
	loop

	if( lp > 0 ) then
		function = left( *filename, lp-1 )
	else
		function = *filename
	end if

end function

'':::::
function hStripPath( byval filename as zstring ptr ) as string static
    dim as integer lp, p_found, p(1 to 2)

	lp = 0
	do
		p(1) = instr( lp+1, *filename, "\\" )
		p(2) = instr( lp+1, *filename, "/" )
        if p(1)=0 or (p(2)>0 and p(2)<p(1)) then
            p_found = p(2)
        else
            p_found = p(1)
        end if
	    if( p_found = 0 ) then
	    	exit do
	    end if
	    lp = p_found
	loop

	if( lp > 0 ) then
		function = mid( *filename, lp+1 )
	else
		function = *filename
	end if

end function

'':::::
function hStripFilename ( byval filename as zstring ptr ) as string static
    dim as integer lp, p_found, p(1 to 2)

	lp = 0
	do
		p(1) = instr( lp+1, *filename, "\\" )
		p(2) = instr( lp+1, *filename, "/" )
        if p(1)=0 or (p(2)>0 and p(2)<p(1)) then
            p_found = p(2)
        else
            p_found = p(1)
        end if
	    if( p_found = 0 ) then
	    	exit do
	    end if
	    lp = p_found
	loop

	if( lp > 0 ) then
		function = left( *filename, lp )
	else
		function = ""
	end if

end function

'':::::
function hGetFileExt( byval fname as zstring ptr ) as string static
    dim as integer p, lp
    dim as string res

	lp = 0
	do
		p = instr( lp+1, *fname, "." )
		if( p = 0 ) then
			exit do
		end if
		lp = p
	loop

    if( lp = 0 ) then
    	function = ""
    else
    	res = lcase( mid( *fname, lp+1 ) )
        if instr( res, "\\" ) > 0 or instr( res, "/" ) > 0 then
            '' We had a folder with a "." inside ...
            function = ""
        elseif( len(res) > 0 ) then
	    	'' . or .. dirs?
	    	if( res[0] = asc( "\\" ) or res[0] = asc( "/" ) ) then
	    		function = ""
	    	else
	    		function = res
	    	end if
        end if
    end if

end function

'':::::
function hRevertSlash( byval src as zstring ptr, _
					   byval allocnew as integer _
					 ) as zstring ptr static

    dim as zstring ptr res
    dim as integer i, c

	if( allocnew ) then
		res = allocate( len( *src ) + 1 )

		for i = 0 to len( *src )-1
			c = src[i]
			if( c = CHAR_RSLASH ) then
				c = CHAR_SLASH
			end if
			res[i] = c
		next

		res[i] = 0

		function = res

	else
		for i = 0 to len( *src )-1
			if( src[i] = CHAR_RSLASH ) then
				src[i] = CHAR_SLASH
			end if
		next

		function = src

	end if

end function

'':::::
function hToPow2( byval value as uinteger ) as uinteger static
    dim n as uinteger

	static pow2tb(0 to 63) as uinteger = {  0,  0,  0, 15,  0,  1, 28,  0, _
										   16,  0,  0,  0,  2, 21, 29,  0, _
    									    0,  0, 19, 17, 10,  0, 12,  0, _
    									    0,  3,  0,  6,  0, 22, 30,  0, _
    									   14,  0, 27,  0,  0,  0, 20,  0, _
    									   18,  9, 11,  0,  5,  0,  0, 13, _
    									   26,  0,  0,  8,  0,  4,  0, 25, _
    									   0,   7, 24,  0, 23,  0, 31,  0 }

	'' don't check if it's zero
	if( value = 0 ) then
		return 0
	end if

	'' (n^(n-1)) * Harley's magic number
	n = ((value-1) xor value) * (7*255*255*255)

    '' extract bits <31:26>
    n = pow2tb(n shr 26)				'' translate into bit count - 1

    '' is this really a power of 2?
    if( value - (1 shl n) = 0 ) then
    	function = n
    else
    	function = 0
    end if

end function

'':::::
sub hConvertValue( byval src as FBVALUE ptr, _
				   byval sdtype as integer, _
				   byval dst as FBVALUE ptr, _
				   byval ddtype as integer ) static

	select case as const sdtype
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		select case as const ddtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			dst->long = src->long
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			dst->float= src->long
		case else
			dst->int  = src->long
		end select

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		select case as const ddtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			dst->long = src->float
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			dst->float= src->float
		case else
			dst->int  = src->float
		end select

	case else
		select case as const ddtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			dst->long = src->int
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			dst->float= src->int
		case else
			dst->int  = src->int
		end select
	end select

end sub

'':::::
function hJumpTbAllocSym( ) as any ptr static
	static as zstring * FB_MAXNAMELEN+1 sname
	dim as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr s

	sname = *hMakeTmpStr( )

	s = symbAddVarEx( @sname, NULL, FB_DATATYPE_UINT, NULL, 0, _
					  FB_INTEGERSIZE, 1, dTB(), FB_ALLOCTYPE_SHARED+FB_ALLOCTYPE_JUMPTB, _
					  FALSE, FALSE, FALSE )

	symbSetVarEmited( s, TRUE )

	function = s

end function

'':::::
function hCheckFileFormat( byval f as integer ) as integer
    dim as integer BOM
    dim as FBFILE_FORMAT fmt

	'' little-endian assumptions
	fmt = FBFILE_FORMAT_ASCII

	if( get( #f, 0, BOM ) = 0 ) then
		if( BOM = &hFFFE0000 ) then
			fmt = FBFILE_FORMAT_UTF32BE

		elseif( BOM = &h0000FEFF ) then
		    fmt = FBFILE_FORMAT_UTF32LE

		else
			BOM and= &h00FFFFFF
			if( BOM = &h00BFBBEF ) then
				fmt = FBFILE_FORMAT_UTF8

			else
				BOM and= &h0000FFFF
		        if( BOM = &h0000FEFF ) then
		        	fmt = FBFILE_FORMAT_UTF16LE

		        elseif( BOM = &h0000FFFE ) then
		        	fmt = FBFILE_FORMAT_UTF16BE
		        end if
			end if
		end if

		select case fmt
		case FBFILE_FORMAT_ASCII
			seek #f, 1

		case FBFILE_FORMAT_UTF8
			seek #f, 1+3

		case FBFILE_FORMAT_UTF16LE, _
			 FBFILE_FORMAT_UTF16BE
			seek #f, 1+2
		end select
	end if

	function = fmt

end function


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

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\lex.bi'

type FBERRCTX
	lasterror 	as integer
	lastline	as integer
end type


declare sub 		hUcase		( src as string )


''globals
	dim shared errctx as FBERRCTX
	redim shared deftypeTB( 0 ) as integer

''warning msgs (level, msg)
warningdata:
data 0, "Passing scalar as pointer"
data -1

'' error msgs
errordata:
data "Argument count mismatch"
data "Expected End-of-File"
data "Expected End-of-Line"
data "Duplicated definition"
data "Expected 'AS'"
data "Expected '('"
data "Expected ')'"
data "Undefined symbol"
data "Expected expression"
data "Expected '='"
data "Expected constant"
data "Expected 'TO'"
data "Expected 'NEXT'"
data "Expected identifier"
data "Internal: Tables Full!"
data "Expected '-'"
data "Expected ','"
data "Syntax error"
data "Element not defined"
data "Expected 'END TYPE' or 'END UNION'"
data "Type mismatch"
data "Internal!"
data "Parameter type mismatch"
data "File not found"
data "Illegal outside of FOR, DO, SUB or FUNCTION"
data "Invalid data types"
data "Invalid character"
data "File access error"
data "Recursion level too depth"
data "Expected pointer"
data "Expected 'LOOP'"
data "Expected 'WEND'"
data "Expected 'THEN'"
data "Expected 'END IF'"
data "'END' without IF, SELECT, SUB or FUNCTION"
data "Expected 'CASE'"
data "Expected 'END SELECT'"
data "Wrong number of dimensions"
data "'SUB' or 'FUNCTION' without 'END SUB' or 'END FUNCTION'"
data "Expected 'END SUB' or 'END FUNCTION'"
data "Illegal parameter specification"
data "Variable not declared"
data "Variable required"
data "Illegal outside a compound statement"
data "Expected 'END ASM'"
data "SUB or FUNCTION not declared"
data "Expected ';'"
data "Undefined label"
data "Too many array dimensions"
data "Expected scalar counter"
data "Illegal outside a SUB or FUNCTION"
data "Expected dynamic array"
data "Cannot return TYPE's or UNION's from functions"
data "Cannot return fixed-len strings from functions"
data "Array already dimensioned"
data "Literal string too big, split it"
data "Identifier's name too big"
data "Illegal without the -ex option"
data "Type mismatch"
data "Illegal specification"
data "Expected 'END WITH'"
data "Illegal inside a SUB or FUNCTION"
data "Expected array"
data "Too many expressions"

const FB.ERRMSGS = 64


'':::::
function hMatch( byval token as integer ) as integer

	hMatch = FALSE
	if( lexCurrentToken = token ) then
		hMatch = TRUE
		lexSkipToken
	end if

end function

'':::::
sub hReportErrorEx( byval errnum as integer, msgex as string, byval linenum as integer = 0 )
    dim i as integer, msg as string

	if( linenum = 0 ) then
		linenum = lexLineNum

		if( linenum = errctx.lastline ) then
			exit sub
		end if

		errctx.lasterror = errnum
		errctx.lastline  = linenum
	end if

	restore errordata
	for i = 0 to FB.ERRMSGS-1
		read msg
		if( (i+1) = errnum ) then
			exit for
		end if
	next i

	print rtrim$( env.infile ); "(";
	if( linenum > 0 ) then
		print str$( linenum );
	end if
	print ") : error ";
	print str$( errnum ); ": "; msg;
	if( len( msgex ) > 0 ) then
		print ", "; msgex
	else
		print
	end if

end sub

'':::::
sub hReportError( byval errnum as integer, byval isbefore as integer = FALSE )
    dim token as string, msgex as string

	token = lexTokenText
	if( len( token ) > 0 ) then
		if( isbefore ) then
			msgex = "before: '"
		else
			msgex = "found: '"
		end if
		msgex = msgex + token + "'"
	else
		msgex = ""
	end if

    ''
	hReportErrorEx errnum, msgex

end sub

'':::::
function hGetLastError as integer

	hGetLastError = errctx.lasterror

end function


'':::::
sub hReportWarning( byval msgnum as integer, msgex as string )
    dim i as integer
    dim level as integer, msg as string

	restore warningdata
	i = 1
	do
		read level
		if( level = -1 ) then
			exit do
		end if
		read msg

		if( i = msgnum ) then
			exit do
		end if
		i = i + 1
	loop

	if( level < env.clopt.warninglevel ) then
		exit sub
	end if

	print rtrim$( env.infile ); "(";
	if( lexLineNum > 0 ) then
		print str$( lexLineNum );
	end if
	print ") : warning level"; level;
	print ": "; msg;
	if( len( msgex ) > 0 ) then
		print ", "; msgex
	else
		print
	end if

end sub


'':::::
function hMakeTmpStr as string static
	static c as integer
	dim v as string

	v = hex$( c )

	hMakeTmpStr$ = "_t" + string$( 4-len(v), 48 ) + v

	c = c + 1

end function

'':::::
function hGetDefType( symbol as string ) as integer
    dim c as integer

	c = asc( ucase$( mid$( symbol, 1, 1 ) ) )

	hGetDefType = deftypeTB(c-65)

end function

'':::::
sub hSetDefType( byval ichar as integer, byval echar as integer, byval typ as integer )
    dim i as integer

	if( ichar < 65 ) then
		ichar = 65
	elseif( ichar > 90 ) then
		ichar = 90
	end if

	if( echar < 65 ) then
		echar = 65
	elseif( echar > 90 ) then
		echar = 90
	end if

	if( ichar > echar ) then
		swap ichar, echar
	end if

	for i = ichar to echar
		deftypeTB(i-65) = typ
	next i

end sub

'':::::
sub hlpInit
    dim i as integer

	''
	redim deftypeTB( 0 to (90-65+1)-1 ) as integer

	for i = 0 to (90-65+1)-1
		deftypeTB(i) = FB.SYMBTYPE.INTEGER
	next i

end sub

'':::::
sub hlpEnd

	erase deftypeTB

end sub

'':::::
function hFBrelop2IRrelop( byval op as integer ) as integer static

    select case op
    case FB.TK.EQ
    	op = IR.OP.EQ
    case FB.TK.GT
    	op = IR.OP.GT
    case FB.TK.LT
    	op = IR.OP.LT
    case FB.TK.NE
    	op = IR.OP.NE
    case FB.TK.LE
    	op = IR.OP.LE
    case FB.TK.GE
    	op = IR.OP.GE
    end select

    hFBrelop2IRrelop = op

end function

'':::::
function hFileExists( filename as string ) as integer static
    dim f as integer

	hFileExists = FALSE

	on local error goto exitfunction

	f = freefile
	open filename for input as #f
	close #f

	hFileExists = TRUE

exitfunction:
    exit function
end function

'':::::
function hScapeStr( text as string ) as string static
    dim c as integer, l as byte ptr
    dim s as byte ptr, d as byte ptr
    dim res as string

	s = sadd( text )
	l = len( text )

	res = space$( l * 2 )
	d = sadd( res )

	l = l + s

	do while( s < l )
		c = *s
		s = s + 1

		select case c
		case CHAR_RSLASH, CHAR_QUOTE
			*d = CHAR_RSLASH
			d = d + 1

		case FB.INTSCAPECHAR
			if( env.optescapestr ) then
				*d = CHAR_RSLASH
				d = d + 1
				if( s >= l ) then exit do
				c = *s
				s = s + 1
			end if
		end select

		*d = c
		d = d + 1
	loop

	hScapeStr = left$( res, d - sadd( res ) )

end function

'':::::
function hUnescapeStr( text as string ) as string static
    dim c as integer, l as byte ptr, p as byte ptr
    dim res as string

	if( not env.optescapestr ) then
    	hUnescapeStr = text
    	exit function
    end if

	res = ""

	p = sadd( text )
	l = p + len( text )
	do while( p < l )

		c = *p
		p = p + 1

		if( c = FB.INTSCAPECHAR ) then
			c = CHAR_RSLASH
		end if

		res = res + chr$( c )
	loop

	hUnescapeStr = res

end function

'':::::
sub hUcase( src as string ) static
    dim i as integer, c as integer
    dim p as byte ptr

	p = sadd( src )

	for i = 1 to len( src )
		c = *p

		if( (c >= 97) and (c <= 122) ) then
			*p = c - (97 - 65)
		end if

		p = p + 1
	next i

end sub

'':::::
sub hClearName( src as string ) static
    dim i as integer, c as integer
    dim p as byte ptr

	p = sadd( src )

	for i = 1 to len( src )
		c = *p

		select case c
		case CHAR_DOT, CHAR_MINUS, CHAR_SPACE
			*p = CHAR_ZLOW
		end select

		p = p + 1
	next i

end sub

'':::::
function hCreateName( symbol as string, byval typ as integer = INVALID, _
					  byval preservecase as integer = FALSE, _
					  byval addunderscore as integer = TRUE, byval clearname as integer = TRUE ) as string static
    dim nm as string

	if( addunderscore ) then
		nm = "_"
	else
		nm = ""
	end if

	nm = nm + symbol

	if( not preservecase ) then
		hUcase nm
	end if

    if( clearname ) then
    	hClearName nm
    end if

    if( (typ <> INVALID) and (typ < 128) ) then
    	nm = nm + "_" + chr$( CHAR_ALOW + typ )
    end if

	hCreateName = nm

end function

'':::::
function hCreateProcAlias( symbol as string, byval argslen as integer, _
						   byval toupper as integer, byval mode as integer ) as string static
    dim nm as string
    dim addat as integer

#ifdef TARGET_WIN32
    if( not env.clopt.nostdcall ) then
		nm = "_" + symbol
	else
		nm = symbol
	end if

    if( env.clopt.nostdcall ) then
    	addat = FALSE
    else
    	addat = (mode = FB.FUNCMODE.STDCALL)
    end if

	if( addat ) then
		nm = nm + "@" + str$( argslen )
	end if

#elseif defined(TARGET_DOS)
    nm = "_" + symbol

#else
	nm = symbol
#endif

	if( toupper ) then
		hUcase nm
	end if

	hCreateProcAlias = nm

end function

'':::::
function hCreateDataAlias( symbol as string, byval isimport as integer ) as string static

#if defined(TARGET_WIN32)
	if( isimport ) then
		hCreateDataAlias = "__imp__" + symbol
	else
		hCreateDataAlias = "_" + symbol
	end if

#elseif defined(TARGET_DOS)
	hCreateDataAlias = "_" + symbol

#else
	hCreateDataAlias = symbol

#endif

end function

'':::::
function hStripUnderscore( symbol as string ) as string static

#ifdef TARGET_WIN32
    if( not env.clopt.nostdcall ) then
		hStripUnderscore = mid$( symbol, 2 )
	else
		hStripUnderscore = symbol
	end if

#elseif defined(TARGET_DOS)
    hStripUnderscore = mid$( symbol, 2 )

#else
	hStripUnderscore = symbol

#endif

end function

'':::::
function hStripExt( filename as string ) as string 'static
    dim p as integer, lp as integer

	lp = 0
	do
		p = instr( lp+1, filename, "." )
	    if( p = 0 ) then
	    	exit do
	    end if
	    lp = p
	loop

	if( lp > 0 ) then
		hStripExt = left$( filename, lp-1 )
	else
		hStripExt = filename
	end if

end function

'':::::
function hStripPath( filename as string ) as string 'static
    dim p as integer, lp as integer

	lp = 0
	do
		p = instr( lp+1, filename, "\\" )
	    if( p = 0 ) then
	    	p = instr( lp+1, filename, "/" )
	    	if( p = 0 ) then
	    		exit do
	    	end if
	    end if
	    lp = p
	loop

	if( lp > 0 ) then
		hStripPath = mid$( filename, lp+1 )
	else
		hStripPath = filename
	end if

end function

'':::::
function hStripFilename ( filename as string ) as string 'static
    dim p as integer, lp as integer

	lp = 0
	do
		p = instr( lp+1, filename, "\\" )
	    if( p = 0 ) then
	    	p = instr( lp+1, filename, "/" )
	    	if( p = 0 ) then
	    		exit do
	    	end if
	    end if
	    lp = p
	loop

	if( lp > 0 ) then
		hStripFilename = left$( filename, lp )
	else
		hStripFilename = ""
	end if

end function

	dim shared pow2tb(0 to 63) as uinteger

'':::::
private sub hInitPow2
	static hasinit as integer

	if( hasinit ) then
		exit sub
	end if

	pow2tb(0)  =  0: pow2tb(1)  =  0: pow2tb(2)  =  0: pow2tb(3)  = 15
	pow2tb(4)  =  0: pow2tb(5)  =  1: pow2tb(6)  = 28: pow2tb(7)  =  0
	pow2tb(8)  = 16: pow2tb(9)  =  0: pow2tb(10) =  0: pow2tb(11) =  0
	pow2tb(12) =  2: pow2tb(13) = 21: pow2tb(14) = 29: pow2tb(15) =  0
    pow2tb(16) =  0: pow2tb(17) =  0: pow2tb(18) = 19: pow2tb(19) = 17
    pow2tb(20) = 10: pow2tb(21) =  0: pow2tb(22) = 12: pow2tb(23) =  0
    pow2tb(24) =  0: pow2tb(25) =  3: pow2tb(26) =  0: pow2tb(27) =  6
    pow2tb(28) =  0: pow2tb(29) = 22: pow2tb(30) = 30: pow2tb(31) =  0
    pow2tb(32) = 14: pow2tb(33) =  0: pow2tb(34) = 27: pow2tb(35) =  0
    pow2tb(36) =  0: pow2tb(37) =  0: pow2tb(38) = 20: pow2tb(39) =  0
    pow2tb(40) = 18: pow2tb(41) =  9: pow2tb(42) = 11: pow2tb(43) =  0
    pow2tb(44) =  5: pow2tb(45) =  0: pow2tb(46) =  0: pow2tb(47) = 13
    pow2tb(48) = 26: pow2tb(49) =  0: pow2tb(50) =  0: pow2tb(51) =  8
    pow2tb(52) =  0: pow2tb(53) =  4: pow2tb(54) =  0: pow2tb(55) = 25
    pow2tb(56) =  0: pow2tb(57) =  7: pow2tb(58) = 24: pow2tb(59) =  0
    pow2tb(60) = 23: pow2tb(61) =  0: pow2tb(62) = 31: pow2tb(63) =  0

    hasinit = TRUE

end sub

'':::::
function hToPow2( byval value as uinteger ) as uinteger static
    dim n as uinteger

	'' init table
	hInitPow2

	hToPow2 = 0

	'' don't check if it's zero
	if( value = 0 ) then
		exit function
	end if

	'' (n^(n-1)) * Harley's magic number
	n = ((value-1) xor value) * (7*255*255*255)

    '' extract bits <31:26>
    n = pow2tb(n shr 26)				'' translate into bit count - 1

    '' is this really a power of 2?
    if( value - (1 shl n) = 0 ) then
    	hToPow2 = n
    end if

end function

'':::::
'function hToPow2( byval value as integer ) as integer static
'	dim c as integer, remainder as integer
'
'  	c = 0
'  	remainder = value and 1
'  	do while( (value > 1) and (remainder = 0) )
'    	remainder = value and 1
'    	value = value shr 1
'    	c = c + 1
'  	loop
'
'	if( remainder = 0 ) then
'		hToPow2 = c
'	else
'		hToPow2 = 0
'	end if
'
'end function

'':::::
function hMakeEntryPointName( entrypoint as string ) as string

	hMakeEntryPointName = "fb_" + entrypoint + "_entry"

end function

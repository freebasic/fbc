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
'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\ir.bi'
'$include once: 'inc\lex.bi'

type FBERRCTX
	lasterror 	as integer
	lastline	as integer

	tmpcnt		as uinteger
end type

''globals
	dim shared ctx as FBERRCTX

	dim shared deftypeTB( 0 to (90-65+1)-1 ) as integer

	dim shared suffixTB( 0 to FB.SYMBOLTYPES-1 ) as zstring * 1+1


''warning msgs (level, msg)
warningdata:
data 0, "Passing scalar as pointer"
data 0, "Suspicious pointer assignament"
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
data "Cannot return TYPE's or UNION's from FB functions"
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
data "Expected '{'"
data "Expected '}'"
data "Too many expressions"
data "Expected explicit result type"
data "Range too large"
data "Forward references not allowed"
data "Incomplete type"
data "Array not dimensioned"
data "Array access, index expected"
data "Expected 'END ENUM'"
data "Cannot initialize dynamic arrays"
data "Invalid bitfield"
data "Literal number too big"
data "Too many parameters"
data "Macro text too long"
data "Invalid command-line option"
data "Cannot initialize dynamic strings"


const FB.ERRMSGS = 80


'':::::
sub hlpInit
    dim i as integer

	''
	for i = 0 to (90-65+1)-1
		deftypeTB(i) = FB.SYMBTYPE.INTEGER
	next i

	''
	for i = 0 to FB.SYMBOLTYPES-1
		suffixTB(i) = chr$( CHAR_ALOW + i )
	next i

	''
	ctx.tmpcnt	= 0

end sub

'':::::
sub hlpEnd

end sub

'':::::
function hMatch( byval token as integer ) as integer

	function = FALSE
	if( lexCurrentToken = token ) then
		function = TRUE
		lexSkipToken
	end if

end function

'':::::
sub hReportErrorEx( byval errnum as integer, _
					byval msgex as string, _
					byval linenum as integer = 0 )
    dim i as integer, msg as string
    dim token_pos as string

	if( linenum = 0 ) then
		linenum = lexLineNum

		if( linenum = ctx.lastline ) then
			exit sub
		end if

		ctx.lasterror = errnum
		ctx.lastline  = linenum
	end if

	if( errnum >= 0 ) then
		restore errordata
		for i = 0 to FB.ERRMSGS-1
			read msg
			if( (i+1) = errnum ) then
				exit for
			end if
		next i
	end if

	if( len( env.infile ) > 0 ) then
		print env.infile; "(";
		if( linenum > 0 ) then
			print str$( linenum );
		end if
		print ") : ";
	end if

	print "error";

	if( errnum >= 0 ) then
		print " "; str$( errnum ); ": "; msg;
		if( len( msgex ) > 0 ) then
			print ", "; msgex
		else
			print
		end if

		if( ( linenum > 0 ) and ( env.clopt.showerror ) ) then
			print
			print lexPeekCurrentLine( token_pos )
			print token_pos
		end if
	else
		print ": "; msgex
	end if

end sub

'':::::
sub hReportError( byval errnum as integer, _
				  byval isbefore as integer = FALSE )
    dim token as string, msgex as string

	token = *lexTokenText( )
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
	hReportErrorEx( errnum, msgex )

end sub

'':::::
function hGetLastError as integer

	function = ctx.lasterror

end function


'':::::
sub hReportWarning( byval msgnum as integer, _
				 	byval msgex as string = "" )
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

	print env.infile; "(";
	if( lexLineNum( ) > 0 ) then
		print str$( lexLineNum( ) );
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
function hMakeTmpStr( ) as zstring ptr static
	static as zstring * 8 + 3 + 1 res

	res = "Lt_" + *hHexUInt( ctx.tmpcnt )

	ctx.tmpcnt += 1

	function = @res

end function

'':::::
function hGetDefType( byval symbol as string ) as integer static
    dim c as integer
    dim p as byte ptr

    p = strptr( symbol )

	c = *p

	'' to upper
	if( (c >= 97) and (c <= 122) ) then
		c = c - (97 - 65)
	end if

	function = deftypeTB(c-65)

end function

'':::::
sub hSetDefType( byval ichar as integer, _
				 byval echar as integer, _
				 byval typ as integer ) static
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
function hFBrelop2IRrelop( byval op as integer ) as integer static

    select case as const op
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

    function = op

end function

'':::::
function hFileExists( byval filename as string ) as integer static
    dim f as integer

    f = freefile

	if( open( filename, for input, as #f ) = 0 ) then
		function = TRUE
		close #f
	else
		function = FALSE
	end if

end function

'':::::
sub hReplace( text as string, _
			  byval oldtext as string, _
			  byval newtext as string ) static
    dim remtext as string
    dim oldlen as integer, newlen as integer
    dim p as integer

	oldlen = len( oldtext )
	newlen = len( newtext )

	p = 0
	do
		p = instr( p+1, text, oldtext )
	    if( p = 0 ) then
	    	exit do
	    end if

		remtext = mid$( text, p + oldlen )
		text = left$( text, p-1 )
		text += newtext
		text += remtext
		p += newlen
	loop

end sub

'':::::
function hEscapeStr( byval text as string ) as string static
    dim as integer c, l
    dim as byte ptr s, d
    dim as string res
    dim as integer octlen

	s = strptr( text )
	l = len( text )

	res = space$( l * 2 )
	d = strptr( res )

	l += s
	octlen = 0

	do while( s < l )
		c = *s
		s += 1

		select case c
		case CHAR_RSLASH, CHAR_QUOTE
			*d = CHAR_RSLASH
			d += 1

		case FB.INTSCAPECHAR
			*d = CHAR_RSLASH
			d += 1
			if( s >= l ) then exit do

			c = *s
			s += 1

			'' octagonal?
			if( c >= 1 and c <= 3 ) then
				octlen = c
				c = *s
				s += 1
			end if

		end select

		*d = c
		d += 1

		'' add quote's when the octagonal escape ends
		if( octlen > 0 ) then
			octlen -= 1
			if( octlen = 0 ) then
				d[0] = CHAR_QUOTE
				d[1] = CHAR_QUOTE
				d += 2
			end if
		end if
	loop

	function = left$( res, d - strptr( res ) )

end function

'':::::
function hUnescapeStr( byval text as string ) as string static
    dim c as integer, l as byte ptr, s as byte ptr
    dim res as string, d as byte ptr

	if( not env.optescapestr ) then
    	function = text
    	exit function
    end if

	res = text

	s = strptr( text )
	d = strptr( res )

	l = s + len( text )
	do while( s < l )

		c = *s
		s += 1

		if( c = FB.INTSCAPECHAR ) then
			*d = CHAR_RSLASH
		end if

		d += 1
	loop

	function = res

end function

'':::::
sub hUcase( byval src as string, _
		    byval dst as string ) static

    dim as integer i, c
    dim as ubyte ptr s, d

	s = strptr( src )
	d = strptr( dst )

	for i = 1 to len( src )
		c = *s

		if( c >= 97 ) then
			if( c <= 122 ) then
				c -= (97 - 65)
			end if
		end if

		*d = c

		s += 1
		d += 1
	next i

	*d = 0

end sub


'':::::
sub hClearName( byval src as string ) static
    dim i as integer
    dim p as byte ptr

	p = strptr( src )

	for i = 1 to len( src )

		select case as const *p
		case CHAR_AUPP to CHAR_ZUPP, CHAR_ALOW to CHAR_ZLOW, CHAR_0 to CHAR_9, CHAR_UNDER

		case else
			*p = CHAR_ZLOW
		end select

		p += 1
	next i

end sub

'':::::
function hCreateName( byval symbol as string, _
					  byval typ as integer = INVALID, _
					  byval preservecase as integer = FALSE, _
					  byval addunderscore as integer = TRUE, _
					  byval clearname as integer = TRUE ) as zstring ptr static

    static sname as zstring * FB.MAXINTNAMELEN+1

	if( addunderscore ) then
		sname = "_"
		sname += symbol
	else
		sname = symbol
	end if

	if( not preservecase ) then
		hUcase( sname, sname )
	end if

    if( clearname ) then
    	hClearName( sname )
    end if

    if( cunsg(typ) < FB.SYMBOLTYPES ) then
    	sname += suffixTB( typ )
    end if

	function = @sname

end function

'':::::
function hCreateProcAlias( byval symbol as string, _
						   byval argslen as integer, _
						   byval mode as integer ) as zstring ptr static

    static sname as zstring * FB.MAXINTNAMELEN+1

#ifdef TARGET_WIN32
    dim addat as integer

	if( env.clopt.nounderprefix ) then
		sname = symbol
	else
		sname = "_"
		sname += symbol
	end if

    if( env.clopt.nostdcall ) then
    	addat = FALSE
    else
    	addat = (mode = FB.FUNCMODE.STDCALL)
    end if

	if( addat ) then
		sname += "@"
		sname += str$( argslen )
	end if

#elseif defined(TARGET_DOS)

	sname = "_"
	sname += symbol

#else

	sname = symbol

#endif

	function = @sname

end function

'':::::
function hCreateOvlProcAlias( byval symbol as string, _
					    	  byval argc as integer, _
					    	  byval argtail as FBSYMBOL ptr ) as zstring ptr static
    dim as integer i
    static as zstring * FB.MAXINTNAMELEN+1 aname

    aname = symbol
    aname += "__ovl_"

    for i = 0 to argc-1
    	aname += "_"

    	if( cunsg(argtail->typ) < FB.SYMBOLTYPES ) then
    		aname += suffixTB( argtail->typ )
    	end if

    	argtail = argtail->arg.l
    next i

	function = @aname

end function


'':::::
function hCreateDataAlias( byval symbol as string, _
						   byval isimport as integer ) as string static

#if defined(TARGET_WIN32)
	if( isimport ) then
		function = "__imp__" + symbol
	else
		function = "_" + symbol
	end if

#elseif defined(TARGET_DOS)
	function = "_" + symbol

#else
	function = symbol

#endif

end function

'':::::
function hStripUnderscore( byval symbol as string ) as string static

#ifdef TARGET_WIN32
    if( not env.clopt.nostdcall ) then
		function = mid$( symbol, 2 )
	else
		function = symbol
	end if

#elseif defined(TARGET_DOS)
    function = mid$( symbol, 2 )

#else
	function = symbol

#endif

end function

'':::::
function hStripExt( byval filename as string ) as string static
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
		function = left$( filename, lp-1 )
	else
		function = filename
	end if

end function

'':::::
function hStripPath( byval filename as string ) as string static
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
		function = mid$( filename, lp+1 )
	else
		function = filename
	end if

end function

'':::::
function hStripFilename ( byval filename as string ) as string static
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
		function = left$( filename, lp )
	else
		function = ""
	end if

end function

'':::::
function hGetFileExt( fname as string ) as string static
    dim p as integer, lp as integer

	lp = 0
	do
		p = instr( lp+1, fname, "." )
		if( p = 0 ) then
			exit do
		end if
		lp = p
	loop

    if( lp = 0 ) then
    	function = ""
    else
    	function = lcase$( mid$( fname, lp+1 ) )
    end if

end function

'':::::
function hRevertSlash( byval s as string ) as string static
    dim as integer i
    dim as string res

	res = s

	for i = 0 to len( s )-1
		if( res[i] = CHAR_RSLASH ) then
			res[i] = CHAR_SLASH
		end if
	next i

	function = res

end function

'':::::
function hToPow2( byval value as uinteger ) as uinteger static
    dim n as uinteger

	static pow2tb(0 to 63) as uinteger = { 0, 0,  0, 15,  0,  1, 28, 0, _
										  16, 0,  0,  0,  2, 21, 29, 0, _
    									   0, 0, 19, 17, 10,  0, 12, 0, _
    									   0, 3,  0,  6,  0, 22, 30, 0, _
    									  14, 0, 27,  0,  0, 0, 20,  0, _
    									  18, 9, 11,  0,  5, 0,  0, 13, _
    									  26, 0,  0,  8,  0, 4,  0, 25, _
    									  0,  7, 24,  0, 23, 0, 31,  0 }

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
function hMakeEntryPointName( byval entrypoint as string ) as string

	function = "fb_" + entrypoint + "_entry"

end function

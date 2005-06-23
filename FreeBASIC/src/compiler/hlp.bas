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
#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\lex.bi"

type FBERRCTX
	lasterror 	as integer
	lastline	as integer

	tmpcnt		as uinteger
end type

type FBWARNING
	level		as integer
	text		as zstring * 64
end type


''globals
	dim shared ctx as FBERRCTX

	dim shared deftypeTB( 0 to (90-65+1)-1 ) as integer

	dim shared suffixTB( 0 to FB_SYMBOLTYPES-1 ) as zstring * 1+1 => { _
				"v", _							'' void
				"b", "a", _                     '' byte, ubyte
				"c", _                          '' char
				"s", "S", _                     '' short, ushort
				"i", "j", _                     '' integer, uinteger
				"e", _                          '' enum
				"l", "m", _                     '' longint, ulongint
				"f", "d", _                     '' single, double
				"t", "x", _                     '' var-len string, fix-len string
				"u", _                     		'' udt
				"n", _							'' function
				"z", _                          '' fwd-ref
				"p" }                           '' pointer


	dim shared warningMsgs( 1 to FB_WARNINGMSGS-1 ) as FBWARNING = { _
		( 0, "Passing scalar as pointer" ), _
		( 0, "Suspicious pointer assignment" ), _
		( 0, "Implicit convertion" ) _
	}

	dim shared errorMsgs( 1 to FB_ERRMSGS-1 ) as zstring * 128 => { _
		"Argument count mismatch", _
		"Expected End-of-File", _
		"Expected End-of-Line", _
		"Duplicated definition", _
		"Expected 'AS'", _
		"Expected '('", _
		"Expected ')'", _
		"Undefined symbol", _
		"Expected expression", _
		"Expected '='", _
		"Expected constant", _
		"Expected 'TO'", _
		"Expected 'NEXT'", _
		"Expected identifier", _
		"Internal: Tables Full!", _
		"Expected '-'", _
		"Expected ','", _
		"Syntax error", _
		"Element not defined", _
		"Expected 'END TYPE' or 'END UNION'", _
		"Type mismatch", _
		"Internal!", _
		"Parameter type mismatch", _
		"File not found", _
		"Illegal outside of FOR, DO, SUB or FUNCTION", _
		"Invalid data types", _
		"Invalid character", _
		"File access error", _
		"Recursion level too depth", _
		"Expected pointer", _
		"Expected 'LOOP'", _
		"Expected 'WEND'", _
		"Expected 'THEN'", _
		"Expected 'END IF'", _
		"'END' without IF, SELECT, SUB or FUNCTION", _
		"Expected 'CASE'", _
		"Expected 'END SELECT'", _
		"Wrong number of dimensions", _
		"'SUB' or 'FUNCTION' without 'END SUB' or 'END FUNCTION'", _
		"Expected 'END SUB' or 'END FUNCTION'", _
		"Illegal parameter specification", _
		"Variable not declared", _
		"Variable required", _
		"Illegal outside a compound statement", _
		"Expected 'END ASM'", _
		"SUB or FUNCTION not declared", _
		"Expected ';'", _
		"Undefined label", _
		"Too many array dimensions", _
		"Expected scalar counter", _
		"Illegal outside a SUB or FUNCTION", _
		"Expected dynamic array", _
		"Cannot return TYPE's or UNION's from FB functions", _
		"Cannot return fixed-len strings from functions", _
		"Array already dimensioned", _
		"Literal string too big, split it", _
		"Identifier's name too big", _
		"Illegal without the -ex option", _
		"Type mismatch", _
		"Illegal specification", _
		"Expected 'END WITH'", _
		"Illegal inside a SUB or FUNCTION", _
		"Expected array", _
		"Expected '{'", _
		"Expected '}'", _
		"Too many expressions", _
		"Expected explicit result type", _
		"Range too large", _
		"Forward references not allowed", _
		"Incomplete type", _
		"Array not dimensioned", _
		"Array access, index expected", _
		"Expected 'END ENUM'", _
		"Cannot initialize dynamic arrays", _
		"Invalid bitfield", _
		"Literal number too big", _
		"Too many parameters", _
		"Macro text too long", _
		"Invalid command-line option", _
		"Cannot initialize dynamic strings", _
		"Recursive TYPE or UNION not allowed", _
		"Array fields cannot be redimensioned" _
	}


'':::::
sub hlpInit
    dim i as integer

	''
	for i = 0 to (90-65+1)-1
		deftypeTB(i) = FB_SYMBTYPE_INTEGER
	next i

	''
	for i = 0 to FB_SYMBOLTYPES-1
		if( len( suffixTB(i) ) = 0 ) then
			suffixTB(i) = chr$( CHAR_ALOW + i )
		end if
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
    dim msg as string
    dim token_pos as string

	if( linenum = 0 ) then
		linenum = lexLineNum

		if( linenum = ctx.lastline ) then
			exit sub
		end if

		ctx.lasterror = errnum
		ctx.lastline  = linenum
	end if

	if( (errnum < 1) or (errnum >= FB_ERRMSGS) ) then
		msg = ""
	else
		msg = errorMsgs(errnum)
	end if

	if( len( env.inf.name ) > 0 ) then
		print env.inf.name; "(";
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

	if( (msgnum < 1) or (msgnum >= FB_WARNINGMSGS) ) then
		exit sub
	end if

	if( warningMsgs(msgnum).level < env.clopt.warninglevel ) then
		exit sub
	end if

	print env.inf.name; "(";
	if( lexLineNum( ) > 0 ) then
		print str$( lexLineNum( ) );
	end if
	print ") : warning level"; warningMsgs(msgnum).level;
	print ": "; warningMsgs(msgnum).text;
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

	res = ".Lt_" + *hHexUInt( ctx.tmpcnt )

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
    dim as integer c, octlen, lgt
    dim as string res
    dim as byte ptr s, d, l

	s = strptr( text )
	lgt = len( text )

	res = space( lgt * 2 )
	d = strptr( res )

	l = s + lgt
	octlen = 0

	do while( s < l )
		c = *s
		s += 1

		select case c
		case CHAR_RSLASH, CHAR_QUOTE
			*d = CHAR_RSLASH
			d += 1

		case FB_INTSCAPECHAR
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

	function = left( res, d - strptr( res ) )

end function

'':::::
function hUnescapeStr( byval text as string ) as string static
    dim as integer c
    dim as string res
    dim as byte ptr s, d, l

	if( not env.opt.escapestr ) then
    	return text
    end if

	res = text

	s = strptr( text )
	d = strptr( res )

	l = s + len( text )
	do while( s < l )

		c = *s
		s += 1

		if( c = FB_INTSCAPECHAR ) then
			*d = CHAR_RSLASH
		end if

		d += 1
	loop

	function = res

end function

'':::::
function hEscapeToChar( byval text as string ) as string static
    dim as integer c
    dim as string res, octval
    dim as byte ptr s, d, l

	if( not env.opt.escapestr ) then
    	return text
    end if

	res = text

	s = strptr( text )
	d = strptr( res )

	l = s + len( text )
	do while( s < l )
		c = *s
		s += 1

		if( c = FB_INTSCAPECHAR ) then

			if( s >= l ) then exit do
			c = *s
			s += 1

			'' octagonal?
			if( c >= 1 and c <= 3 ) then

				octval = "&o"
				do while( c > 0 )
					octval += chr$( *s )
					s += 1
					c -= 1
				loop

				c = valint( octval )

			else
			    '' remap char
			    select case as const c
			    case asc( "r" )
			    	c = CHAR_CR
			    case asc( "l" ), asc( "n" )
			    	c = CHAR_LF
			    case asc( "t" )
			    	c = CHAR_TAB
			    case asc( "b" )
			    	c = CHAR_BKSPC
			    case asc( "a" )
			    	c = CHAR_BELL
			    case asc( "f" )
			    	c = CHAR_FORMFEED
			    case asc( "v" )
			    	c = CHAR_VTAB
			    end select

			end if

		end if

		*d = c
		d += 1

	loop

	function = left( res, d - strptr( res ) )

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

    static sname as zstring * FB_MAXINTNAMELEN+1

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

    if( typ <> INVALID ) then
    	if( typ > FB_SYMBTYPE_POINTER ) then
    		typ = FB_SYMBTYPE_POINTER
    	end if
    	sname += suffixTB( typ )
    end if

	function = @sname

end function

'':::::
function hCreateProcAlias( byval symbol as string, _
						   byval argslen as integer, _
						   byval mode as integer ) as zstring ptr static

    static sname as zstring * FB_MAXINTNAMELEN+1

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
    	addat = (mode = FB_FUNCMODE_STDCALL)
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
    dim as integer i, typ
    static as zstring * FB_MAXINTNAMELEN+1 aname

    aname = symbol
    aname += "__ovl_"

    for i = 0 to argc-1
    	aname += "_"

    	typ = argtail->typ
    	do while( typ >= FB_SYMBTYPE_POINTER )
    		aname += "p"
    		typ -= FB_SYMBTYPE_POINTER
    	loop

    	aname += suffixTB( typ )
    	if( (typ = FB_SYMBTYPE_USERDEF) or (typ = FB_SYMBTYPE_ENUM) ) then
    		aname += symbGetName( argtail->subtype )
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
function hMakeEntryPointName( byval entrypoint as string ) as string

	function = "fb_" + entrypoint + "_entry"

end function

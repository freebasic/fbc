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

defint a-z
'$include: 'inc\ir.bi'
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\lex.bi'


''globals
	redim shared deftypeTB( 0 ) as integer
	dim shared lasterror as integer


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

const FB.ERRMSGS = 49


'':::::
function hMatch( byval token as integer ) as integer

	hMatch = FALSE
	if( lexCurrentToken = token ) then
		hMatch = TRUE
		lexSkipToken
	end if

end function

'':::::
sub hReportErrorEx( byval errnum as integer, byval linenum as integer, msgex as string )
    dim i as integer, msg as string

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
    static lastline as integer
    dim token as string, msgex as string
    dim l as integer, c as integer

	l = lexLineNum
	c = lexColNum

	if( l = lastline ) then
		exit sub
	end if

	lasterror = errnum

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
	hReportErrorEx errnum, l, msgex

	lastline = l

end sub

'':::::
function hGetLastError as integer

	hGetLastError = lasterror

end function

'':::::
sub hReportSimpleError( byval errnum as integer )
    dim i as integer, msg as string

	restore errordata
	for i = 0 to FB.ERRMSGS-1
		read msg
		if( (i+1) = errnum ) then
			exit for
		end if
	next i

	print rtrim$( env.infile ); " : error ";
	print str$( errnum ); ": "; msg

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
function hScapeStr( s as string ) as string 'static
    dim c as string, i as integer
    dim res as string

	res = ""

	for i = 1 to len( s )

		c = mid$( s, i, 1 )
		res = res + c

		if( asc( c ) = CHAR_RSLASH ) then
			res = res + chr$( CHAR_RSLASH )
		end if

	next i

	hScapeStr = res

end function

'':::::
sub hClearName( src as string ) static
    dim i as integer, c as integer
    dim ofs as integer

	ofs = sadd( src )

	for i = 1 to len( src )
		c = peek( ofs )
		select case c
		case CHAR_DOT, CHAR_MINUS
			poke ofs, CHAR_ZLOW
		end select
		ofs = ofs + 1
	next i

end sub

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
		p = instr( lp+1, filename, "\" )
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
function hToPow2( byval value as integer ) as integer static
	dim c as integer, remainder as integer

  	c = 0
  	remainder = value and 1
  	do while( (value > 1) and (remainder = 0) )
    	remainder = value and 1
    	value = value shr 1
    	c = c + 1
  	loop

	if( remainder = 0 ) then
		hToPow2 = c
	else
		hToPow2 = 0
	end if

end function


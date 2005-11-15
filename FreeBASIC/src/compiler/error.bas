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


'' error reporting module
''
''

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\lex.bi"

type FB_ERRCTX
	lasterror 	as integer
	lastline	as integer
	errcnt		as integer
end type

type FBWARNING
	level		as integer
	text		as zstring * 64
end type


''globals
	dim shared ctx as FB_ERRCTX

	dim shared warningMsgs( 1 to FB_WARNINGMSGS-1 ) as FBWARNING = _
	{ _
		( 0, "Passing scalar as pointer" ), _
		( 0, "Passing pointer to scalar" ), _
		( 0, "Passing different pointer types" ), _
		( 0, "Suspicious pointer assignment" ), _
		( 0, "Implicit conversion" ), _
		( 0, "Cannot export symbol without -export option" ), _
		( 0, "Identifier's name too big, truncated" ), _
		( 0, "Literal number too big, truncated" ), _
		( 0, "Literal string too big, truncated" ) _
	}

	dim shared errorMsgs( 1 to FB_ERRMSGS-1 ) as zstring * 128 => _
	{ _
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
		"Cannot return fixed-len strings from functions", _
		"Array already dimensioned", _
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
		"Too many parameters", _
		"Macro text too long", _
		"Invalid command-line option", _
		"Cannot initialize dynamic strings", _
		"Recursive TYPE or UNION not allowed", _
		"Array fields cannot be redimensioned", _
		"Identifier cannot include periods", _
		"Executable not found", _
		"Array out-of-bounds", _
		"Missing command-line option for", _
		"Math overflow", _
		"Expected 'ANY'", _
		"Expected 'END SCOPE'", _
		"Illegal inside a SCOPE block", _
		"Cannot pass an UDT result by reference", _
		"Ambiguous call to overloaded function", _
		"Division by zero", _
		"Cannot pop stack, underflow" _
	}


'':::::
sub errInit

	ctx.lastline= -1
	ctx.errcnt	= 0

end sub

'':::::
sub errEnd

end sub

'':::::
sub hReportErrorEx( byval errnum as integer, _
					byval msgex as string, _
					byval linenum as integer = 0 )
    dim msg as string
    dim token_pos as string

	if( linenum = 0 ) then
		linenum = lexLineNum( )

		if( linenum = ctx.lastline ) then
			exit sub
		end if

		ctx.lasterror = errnum
		ctx.lastline  = linenum
	end if

	ctx.errcnt += 1

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

	token = *lexGetText( )
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
function hGetErrorCnt as integer

	function = ctx.errcnt

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


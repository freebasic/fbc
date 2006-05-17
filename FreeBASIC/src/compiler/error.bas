''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
	text		as zstring ptr
end type


''globals
	dim shared ctx as FB_ERRCTX

	dim shared warningMsgs( 1 to FB_WARNINGMSGS-1 ) as FBWARNING = _
	{ _
		( 0, @"Passing scalar as pointer" ), _
		( 0, @"Passing pointer to scalar" ), _
		( 0, @"Passing different pointer types" ), _
		( 0, @"Suspicious pointer assignment" ), _
		( 0, @"Implicit conversion" ), _
		( 0, @"Cannot export symbol without -export option" ), _
		( 0, @"Identifier's name too big, truncated" ), _
		( 0, @"Literal number too big, truncated" ), _
		( 0, @"Literal string too big, truncated" ), _
		( 0, @"UDT with pointer or dynamic string fields" ), _
		( 0, @"UDT with dynamic string fields" ), _
		( 0, @"Implicit variable allocation" ) _
	}

	dim shared errorMsgs( 1 to FB_ERRMSGS-1 ) as zstring ptr => _
	{ _
		@"Argument count mismatch", _
		@"Expected End-of-File", _
		@"Expected End-of-Line", _
		@"Duplicated definition", _
		@"Expected 'AS'", _
		@"Expected '('", _
		@"Expected ')'", _
		@"Undefined symbol", _
		@"Expected expression", _
		@"Expected '='", _
		@"Expected constant", _
		@"Expected 'TO'", _
		@"Expected 'NEXT'", _
		@"Expected identifier", _
		@"Internal: Tables Full!", _
		@"Expected '-'", _
		@"Expected ','", _
		@"Syntax error", _
		@"Element not defined", _
		@"Expected 'END TYPE' or 'END UNION'", _
		@"Type mismatch", _
		@"Internal!", _
		@"Parameter type mismatch", _
		@"File not found", _
		@"Illegal outside of FOR, DO, SUB or FUNCTION", _
		@"Invalid data types", _
		@"Invalid character", _
		@"File access error", _
		@"Recursion level too deep", _
		@"Expected pointer", _
		@"Expected 'LOOP'", _
		@"Expected 'WEND'", _
		@"Expected 'THEN'", _
		@"Expected 'END IF'", _
		@"'END' without IF, SELECT, SUB or FUNCTION", _
		@"Expected 'CASE'", _
		@"Expected 'END SELECT'", _
		@"Wrong number of dimensions", _
		@"'SUB' or 'FUNCTION' without 'END SUB' or 'END FUNCTION'", _
		@"Expected 'END SUB' or 'END FUNCTION'", _
		@"Illegal parameter specification", _
		@"Variable not declared", _
		@"Variable required", _
		@"Illegal outside a compound statement", _
		@"Expected 'END ASM'", _
		@"SUB or FUNCTION not declared", _
		@"Expected ';'", _
		@"Undefined label", _
		@"Too many array dimensions", _
		@"Expected scalar counter", _
		@"Illegal outside a SUB or FUNCTION", _
		@"Expected dynamic array", _
		@"Cannot return fixed-len strings from functions", _
		@"Array already dimensioned", _
		@"Illegal without the -ex option", _
		@"Type mismatch", _
		@"Illegal specification", _
		@"Expected 'END WITH'", _
		@"Illegal inside a SUB or FUNCTION", _
		@"Expected array", _
		@"Expected '{'", _
		@"Expected '}'", _
		@"Too many expressions", _
		@"Expected explicit result type", _
		@"Range too large", _
		@"Forward references not allowed", _
		@"Incomplete type", _
		@"Array not dimensioned", _
		@"Array access, index expected", _
		@"Expected 'END ENUM'", _
		@"Cannot initialize dynamic arrays", _
		@"Invalid bitfield", _
		@"Too many parameters", _
		@"Macro text too long", _
		@"Invalid command-line option", _
		@"Cannot initialize dynamic strings", _
		@"Recursive TYPE or UNION not allowed", _
		@"Recursive DEFINE not allowed", _
		@"Array fields cannot be redimensioned", _
		@"Identifier cannot include periods", _
		@"Executable not found", _
		@"Array out-of-bounds", _
		@"Missing command-line option for", _
		@"Math overflow", _
		@"Expected 'ANY'", _
		@"Expected 'END SCOPE'", _
		@"Illegal inside a SCOPE block", _
		@"Cannot pass an UDT result by reference", _
		@"Ambiguous call to overloaded function", _
		@"No matching overloaded function", _
		@"Division by zero", _
		@"Cannot pop stack, underflow", _
		@"Cannot initialize UDT's containing dynamic string fields", _
		@"Branching to scope blocks containing local variables", _
		@"Branching to other SUB's/FUNCTION's or to module-level", _
		@"Branch crossing local array or object definition", _
		@"LOOP without DO", _
		@"NEXT without FOR", _
		@"WEND without WHILE", _
		@"END WITH without WITH", _
		@"END IF without IF", _
		@"END SELECT without SELECT", _
		@"END SUB or FUNCTION without SUB or FUNCTION",_
		@"END SCOPE without SCOPE", _
		@"END MAMESPACE without NAMESPACE", _
		@"END EXTERN without EXTERN", _
		@"ELSEIF without IF", _
		@"ELSE without IF", _
		@"CASE without SELECT", _
		@"Cannot modify a constant", _
		@"Expected period ('.')", _
		@"Expected END NAMESPACE", _
		@"Illegal inside a NAMESPACE block", _
		@"Cannot remove symbols defined in other namespaces", _
		@"Expected END EXTERN", _
		@"Expected 'END SUB'", _
		@"Expected 'END FUNCTION'", _
		@"Declaration outside the original namespace" _
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
					byval msgex as zstring ptr, _
					byval linenum as integer = 0 )

    dim as zstring ptr msg
    dim as string token_pos

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
		msg = NULL
	else
		msg = errorMsgs(errnum)
	end if

	if( len( env.inf.name ) > 0 ) then
		print env.inf.name; "(";
		if( linenum > 0 ) then
			print str( linenum );
		end if
		print ") : ";
	end if

	print "error";

	if( errnum >= 0 ) then
		print " "; str( errnum ); ": "; *msg;
		if( len( *msgex ) > 0 ) then
			print ", "; *msgex
		else
			print
		end if

		if( ( linenum > 0 ) and ( env.clopt.showerror ) ) then
			print
			print lexPeekCurrentLine( token_pos )
			print token_pos
		end if
	else
		print ": "; *msgex
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
				 	byval msgex as zstring ptr )

	if( (msgnum < 1) or (msgnum >= FB_WARNINGMSGS) ) then
		exit sub
	end if

	if( warningMsgs(msgnum).level < env.clopt.warninglevel ) then
		exit sub
	end if

	print env.inf.name; "(";
	if( lexLineNum( ) > 0 ) then
		print str( lexLineNum( ) );
	end if
	print ") : warning level"; warningMsgs(msgnum).level;
	print ": "; *warningMsgs(msgnum).text;

	if( msgex <> NULL ) then
		print ", "; *msgex
	else
		print
	end if

end sub


'':::::
private function hReportMakeDesc( byval proc as FBSYMBOL ptr, _
								  byval pnum as integer, _
								  byval pid as zstring ptr _
								) as zstring ptr

    static as zstring * FB_MAXNAMELEN*2+32+1 desc
    dim as zstring ptr pname

	if( pnum > 0 ) then
		desc = "at parameter " + str( pnum )
		if( pid = NULL ) then
			if( proc <> NULL ) then
				dim as FBSYMBOL ptr param = symbGetProcHeadParam( proc )
				dim as integer cnt = 1

				do while( param <> NULL )
					if( cnt = pnum ) then
						exit do
					end if
					cnt += 1
					param = param->next
				loop

				if( param <> NULL ) then
					pid = symbGetName( param )
				end if
			end if
		end if

    	if( pid <> NULL ) then
			desc += " ("
			desc += *pid
			desc += ")"
		end if

	else
		desc = ""
	end if

	if( proc <> NULL ) then
		dim as integer showname = TRUE

		'' part of the rtlib?
		if( symbGetIsRTL( proc ) ) then
			'' any name set?
			if( symbGetName( proc ) <> NULL ) then
				'' starts with "FB_"?
				if( left( *symbGetName( proc ), 3 ) = "FB_" ) then
					showname = FALSE
				end if
			else
				showname = FALSE
			end if
		end if

		if( showname ) then
			pname = symbGetName( proc )
			if( pname <> NULL ) then
				if( len( *pname ) = 0 ) then
					pname = symbGetMangledName( proc )
				end if
			end if

			if( pname <> NULL ) then
				if( pnum > 0 ) then
					desc += " of "
				end if
				if( len( *symbGetName( proc ) ) > 0 ) then
					desc += *symbGetName( proc )
				else
					desc += *symbGetMangledName( proc )
				end if
				desc += "()"
			end if
		end if
	end if

	function = @desc

end function

'':::::
sub hReportParamError( byval proc as any ptr, _
					   byval pnum as integer, _
					   byval pid as zstring ptr, _
					   byval msgnum as integer )

	hReportErrorEx( msgnum, *hReportMakeDesc( proc, pnum, pid ) )

end sub

'':::::
sub hReportParamWarning( byval proc as any ptr, _
					   	 byval pnum as integer, _
					   	 byval pid as zstring ptr, _
						 byval msgnum as integer )

	hReportWarning( msgnum, *hReportMakeDesc( proc, pnum, pid ) )

end sub


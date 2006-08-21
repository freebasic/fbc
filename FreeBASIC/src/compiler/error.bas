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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\lex.bi"

type FBWARNING
	level		as integer
	text		as zstring ptr
end type


''globals
	dim shared errctx as FB_ERRCTX

	dim shared warningMsgs( 1 to FB_WARNINGMSGS-1 ) as FBWARNING = _
	{ _
		( 1, @"Passing scalar as pointer" ), _
		( 1, @"Passing pointer to scalar" ), _
		( 1, @"Passing different pointer types" ), _
		( 1, @"Suspicious pointer assignment" ), _
		( 0, @"Implicit conversion" ), _
		( 1, @"Cannot export symbol without -export option" ), _
		( 1, @"Identifier's name too big, truncated" ), _
		( 1, @"Literal number too big, truncated" ), _
		( 1, @"Literal string too big, truncated" ), _
		( 0, @"UDT with pointer or dynamic string fields" ), _
		( 0, @"UDT with dynamic string fields" ), _
		( 0, @"Implicit variable allocation" ), _
		( 0, @"Missing closing quote in literal string" ), _
		( 0, @"Function result was not explicitly set" ), _
		( 1, @"Branch crossing local variable definition" ), _
		( 0, @"No explicit BYREF or BYVAL" ), _
		( 0, @"Possible escape sequence found in" ), _
		( 0, @"The type length is too large, consider passing BYREF" ), _
		( 1, @"The length of the parameters list is too large, consider passing UDT's BYREF" ) _
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
		@"Illegal 'END'", _
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
		@"Fixed-len strings cannot be returned from functions", _
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
		@"Dynamic arrays cannot be initialized", _
		@"Invalid bitfield", _
		@"Too many parameters", _
		@"Macro text too long", _
		@"Invalid command-line option", _
		@"Dynamic strings cannot be initialized", _
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
		@"UDT function results cannot be passed by reference", _
		@"Ambiguous call to overloaded function", _
		@"No matching overloaded function", _
		@"Division by zero", _
		@"Cannot pop stack, underflow", _
		@"UDT's containing dynamic string fields cannot be initialized", _
		@"Branching to scope block containing local variables", _
		@"Branching to other SUB's/FUNCTION's or to module-level", _
		@"Branch crossing local array, var-len string or object definition", _
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
		@"Symbols defined inside namespaces cannot be removed", _
		@"Expected END EXTERN", _
		@"Expected 'END SUB'", _
		@"Expected 'END FUNCTION'", _
		@"Expected 'END CONSTRUCTOR'", _
		@"Expected 'END DESTRUCTOR'", _
		@"Expected 'END OPERATOR'", _
		@"Declaration outside the original namespace", _
		@("No end of multi-line comment, expected " + QUOTE + "'/" + QUOTE), _
		@"Too many errors, exiting", _
		@"Expected 'ENDMACRO'", _
		@"EXTERN or COMMON variables cannot be initialized", _
		@"At least one parameter must be an user-defined type", _
		@"Parameter or result must be an user-defined type", _
		@"Both parameters can't be of the same type", _
		@"Parameter and result can't be of the same type", _
		@"Invalid result type for this operator", _
		@"Vararg parameters are not allowed in overloaded functions", _
		@"Illegal outside an OPERATOR function", _
		@"Parameter cannot be optional", _
		@"Only valid in -lang", _
		@"Default types or suffixes are only valid in -lang", _
		@"Suffixes are only valid in -lang", _
		@"Implicit variables are only valid in -lang" _
	}


'':::::
sub errInit

	errctx.cnt = 0
	errctx.lastmsg = FB_ERRMSG_OK
	errctx.lastline = -1
	errctx.laststmt = -1

	'' alloc the undefined symbols tb, used to not report them more than once
	hashInit( )
	hashNew( @errctx.undefhash, 64, TRUE )

end sub

'':::::
sub errEnd

	hashFree( @errctx.undefhash )
	hashEnd( )

end sub

'':::::
function errFatal( ) as integer

	'' infinite? never fatal..
	if( env.clopt.maxerrors = FB_ERR_INFINITE ) then
		function = TRUE

	'' else, make the parser stop
	else
		errctx.cnt = env.clopt.maxerrors
		function = FALSE
	end if

end function

'':::::
private sub hPrintErrMsg _
	( _
		byval errnum as integer, _
		byval msgex as zstring ptr, _
		byval options as FB_ERRMSGOPT, _
		byval linenum as integer, _
		byval showerror as integer = TRUE _
	) static

    dim as zstring ptr msg
    dim as string token_pos

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

		if( showerror ) then
			showerror = (linenum > 0)
		end if

		if( len( *msgex ) > 0 ) then
			if( (options and FB_ERRMSGOPT_ADDCOMMA) <> 0 ) then
				print ", ";
			elseif( (options and FB_ERRMSGOPT_ADDCOLON) <> 0 ) then
				print ": ";
			else
				print " ";
			end if

			if( (options and FB_ERRMSGOPT_ADDQUOTES) <> 0 ) then
				print QUOTE;
			end if

			print *msgex;

			if( (options and FB_ERRMSGOPT_ADDQUOTES) <> 0 ) then
				print QUOTE;
			end if
		end if

		if( showerror ) then
			if( fbLangOptIsSet( FB_LANG_OPT_SINGERRLINE ) ) then
				print ": "; lexPeekCurrentLine( token_pos )
			else
				print
				print lexPeekCurrentLine( token_pos )
				print token_pos
			end if
		else
			print
		end if

	else
		print ": "; *msgex
	end if

end sub

'':::::
function errReportEx _
	( _
		byval errnum as integer, _
		byval msgex as zstring ptr, _
		byval linenum as integer, _
		byval options as FB_ERRMSGOPT _
	) as integer

    '' too many errors?
    if( errctx.cnt >= env.clopt.maxerrors ) then
    	return FALSE
    end if

	if( linenum = 0 ) then
		if( env.clopt.showsusperrors = FALSE ) then
			'' only one error per stmt
			if( env.stmtcnt = errctx.laststmt ) then
				return TRUE
			end if
		end if

		linenum = lexLineNum( )

		errctx.lastmsg = errnum
		errctx.lastline = linenum
    	errctx.laststmt = env.stmtcnt
	end if

    hPrintErrMsg( errnum, msgex, options, linenum, env.clopt.showerror )

	errctx.cnt += 1

    if( errctx.cnt >= env.clopt.maxerrors ) then
		hPrintErrMsg( FB_ERRMSG_TOOMANYERRORS, NULL, 0, linenum, FALSE )
		function = FALSE
	else
		function = TRUE
	end if

end function

'':::::
private function hAddToken _
	( _
		byval isbefore as integer, _
		byval addcomma as integer, _
		byval msgex as zstring ptr = NULL _
	) as string static

	dim as string res, token

	res = ""

	if( msgex = NULL ) then
		token = *lexGetText( )
	else
		token = *msgex
	end if

	if( len( token ) > 0 ) then
		'' don't print control chars
		select case lexGetToken( )
		case is <= CHAR_SPACE, FB_TK_EOL, FB_TK_EOF

		case else
			if( addcomma ) then
				res += ", "
			end if

			if( isbefore ) then
				res += "before: '"
			else
				res += "found: '"
			end if

			res += token + "'"
		end select
	end if

	function = res

end function

'':::::
function errReport _
	( _
		byval errnum as integer, _
		byval isbefore as integer = FALSE _
	) as integer

	function = errReportEx( errnum, hAddToken( isbefore, FALSE ) )

end function

'':::::
sub errReportWarnEx _
	( _
		byval msgnum as integer, _
		byval msgex as zstring ptr, _
		byval linenum as integer, _
		byval options as FB_ERRMSGOPT _
	)

	if( (msgnum < 1) or (msgnum >= FB_WARNINGMSGS) ) then
		exit sub
	end if

	if( warningMsgs(msgnum).level < env.clopt.warninglevel ) then
		exit sub
	end if

	print env.inf.name;

	if( linenum > 0 ) then
		print "("; str( linenum ); ")";
	end if

	print " : warning: "; *warningMsgs(msgnum).text;

	if( msgex <> NULL ) then
		if( (options and FB_ERRMSGOPT_ADDCOMMA) <> 0 ) then
			print ", ";
		elseif( (options and FB_ERRMSGOPT_ADDCOLON) <> 0 ) then
			print ": ";
		else
			print " ";
		end if

		if( (options and FB_ERRMSGOPT_ADDQUOTES) <> 0 ) then
			print QUOTE;
		end if

		print *msgex;

		if( (options and FB_ERRMSGOPT_ADDQUOTES) <> 0 ) then
			print QUOTE;
		end if
	end if

	print

end sub

'':::::
sub errReportWarn _
	( _
		byval msgnum as integer, _
		byval msgex as zstring ptr, _
		byval options as FB_ERRMSGOPT _
	)

	errReportWarnEx( msgnum, msgex, lexLineNum( ), options )

end sub

'':::::
function errReportNotAllowed _
	( _
		byval opt as FB_LANG_OPT, _
		byval errnum as integer, _
		byval msgex as zstring ptr _
	) as integer

	dim as string msg = ""
	dim as integer i, langs

	langs = 0
	for i = 0 to FB_LANGS-1
		if( (fbGetLangOptions( i ) and opt) <> 0 ) then
			if( langs > 0 ) then
				msg += " or "
			end if
			msg += fbGetLangName( i )
			langs += 1
		end if
	next

	msg += hAddToken( FALSE, langs > 0, msgex )

	function = errReportEx( errnum, msg, , FB_ERRMSGOPT_NONE )

end function

'':::::
private function hReportMakeDesc _
	( _
		byval proc as FBSYMBOL ptr, _
		byval pnum as integer, _
		byval pid as zstring ptr _
	) as zstring ptr

    static as zstring * FB_MAXNAMELEN*2+32+1 desc
    dim as zstring ptr pname
    dim as integer addprnts

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
		pname = NULL
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

		else
			'' function pointer?
			if( symbIsFunctionPtr( proc ) ) then
				pname = symbDemangleFunctionPtr( proc )
			end if
		end if

		if( showname ) then
			if( pname = NULL ) then
				addprnts = TRUE
				pname = symbGetName( proc )
				if( pname <> NULL ) then
					if( len( *pname ) = 0 ) then
						pname = symbGetMangledName( proc )
					end if
				end if
			else
				addprnts = FALSE
			end if

			if( pname <> NULL ) then
				if( pnum > 0 ) then
					desc += " of "
				end if
				desc += *pname
				if( addprnts ) then
					desc += "()"
				end if
			end if
		end if
	end if

	function = @desc

end function

'':::::
function errReportParam _
	( _
		byval proc as any ptr, _
		byval pnum as integer, _
		byval pid as zstring ptr, _
		byval msgnum as integer _
	) as integer

	static as any ptr lastproc = NULL
	static as integer lastpnum = -1
	dim as integer cnt

	'' don't report more than one error in a single param
	if( proc = lastproc ) then
		if( pnum = lastpnum ) then
			return TRUE
		end if

		cnt = errctx.cnt
	end if

	'' new param, take as a new statement
	errctx.laststmt = -1

	function = errReportEx( msgnum, *hReportMakeDesc( proc, pnum, pid ) )

	'' if it's the same proc, n-param errors will count as just one
	if( proc = lastproc ) then
		errctx.cnt = cnt
	end if

	lastproc = proc
	lastpnum = pnum

end function

'':::::
sub errReportParamWarn _
	( _
		byval proc as any ptr, _
		byval pnum as integer, _
		byval pid as zstring ptr, _
		byval msgnum as integer _
	)

	errReportWarn( msgnum, *hReportMakeDesc( proc, pnum, pid ) )

end sub

'':::::
function errReportUndef _
	( _
		byval errnum as integer, _
		byval id as zstring ptr _
	) as integer

	dim as uinteger hash
	dim as zstring ptr id_cpy

	'' already reported?
	hash = hashHash( id )
	if( hashLookupEx( @errctx.undefhash, id, hash ) <> NULL ) then
		return errctx.cnt < env.clopt.maxerrors
	end if

	'' add to hash and report the error
	id_cpy = NULL
	ZStrAssign( @id_cpy, id )

	hashAdd( @errctx.undefhash, id_cpy, id_cpy, hash )

	function = errReportEx( errnum, id )

end function

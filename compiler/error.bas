'' error reporting module
''
''

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "lex.bi"
#include once "parser.bi"

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
		( 0, @"UDT with pointer or var-len string fields" ), _
		( 0, @"UDT with var-len string fields" ), _
		( 0, @"Implicit variable allocation" ), _
		( 0, @"Missing closing quote in literal string" ), _
		( 0, @"Function result was not explicitly set" ), _
		( 1, @"Branch crossing local variable definition" ), _
		( 0, @"No explicit BYREF or BYVAL" ), _
		( 0, @"Possible escape sequence found in" ), _
		( 0, @"The type length is too large, consider passing BYREF" ), _
		( 1, @"The length of the parameters list is too large, consider passing UDT's BYREF" ), _
		( 1, @"The ANY initializer has no effect on UDT's with default constructors" ), _
		( 2, @"Object files or libraries with mixed multithreading (-mt) options" ), _
		( 2, @"Object files or libraries with mixed language (-lang) options" ), _
		( 0, @"Deleting ANY pointers is undefined" ), _
		( 2, @"Array too large for stack, consider making it var-len or SHARED" ), _
		( 0, @"Overflow in constant conversion" ), _
		( 0, @"Variable following NEXT is meaningless" ), _
		( 0, @"Cast to non-pointer" ), _
		( 0, @"Return method mismatch" ), _
		( 0, @"Passing Pointer" ), _
		( 0, @"Command line option overrides directive" ), _
		( 0, @"Directive ignored after first pass" ), _
		( 0, @"'IF' statement found directly after multi-line 'ELSE'" ), _
		( 0, @"Shift value greater than or equal to number of bits in data type" ), _
		( 0, @"'BYVAL AS STRING' actually behaves like 'BYREF AS ZSTRING' (this is hoped to change in future releases)" ), _
		( 0, @"No newline at end of file" ) _
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
		@"Function not declared", _
		@"Expected ';'", _
		@"Undefined label", _
		@"Too many array dimensions", _
		@"Expected scalar counter", _
		@"Illegal outside a CONSTRUCTOR, DESTRUCTOR, FUNCTION, OPERATOR, PROPERTY or SUB block", _
		@"Expected var-len array", _
		@"Fixed-len strings cannot be returned from functions", _
		@"Array already dimensioned", _
		@"Illegal without the -ex option", _
		@"Type mismatch", _
		@"Illegal specification", _
		@"Expected 'END WITH'", _
		@"Illegal inside functions", _
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
		@"Var-len arrays cannot be initialized", _
		@"Invalid bitfield", _
		@"Too many parameters", _
		@"Macro text too long", _
		@"Invalid command-line option", _
		@"Var-len strings cannot be initialized", _
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
		@"Illegal inside a compound statement or scoped block", _
		@"UDT function results cannot be passed by reference", _
		@"Ambiguous call to overloaded function", _
		@"No matching overloaded function", _
		@"Division by zero", _
		@"Cannot pop stack, underflow", _
		@"UDT's containing var-len string fields cannot be initialized", _
		@"Branching to scope block containing local variables", _
		@"Branching to other functions or to module-level", _
		@"Branch crossing local array, var-len string or object definition", _
		@"LOOP without DO", _
		@"NEXT without FOR", _
		@"WEND without WHILE", _
		@"END WITH without WITH", _
		@"END IF without IF", _
		@"END SELECT without SELECT", _
		@"END SUB or FUNCTION without SUB or FUNCTION",_
		@"END SCOPE without SCOPE", _
		@"END NAMESPACE without NAMESPACE", _
		@"END EXTERN without EXTERN", _
		@"ELSEIF without IF", _
		@"ELSE without IF", _
		@"CASE without SELECT", _
		@"Cannot modify a constant", _
		@"Expected period ('.')", _
		@"Expected 'END NAMESPACE'", _
		@"Illegal inside a NAMESPACE block", _
		@"Symbols defined inside namespaces cannot be removed", _
		@"Expected 'END EXTERN'", _
		@"Expected 'END SUB'", _
		@"Expected 'END FUNCTION'", _
		@"Expected 'END CONSTRUCTOR'", _
		@"Expected 'END DESTRUCTOR'", _
		@"Expected 'END OPERATOR'", _
		@"Expected 'END PROPERTY'", _
		@"Declaration outside the original namespace", _
		@"No end of multi-line comment, expected ""'/""", _
		@"Too many errors, exiting", _
		@"Expected 'ENDMACRO'", _
		@"EXTERN or COMMON variables cannot be initialized", _
		@"At least one parameter must be a user-defined type", _
		@"Parameter or result must be a user-defined type", _
		@"Both parameters can't be of the same type", _
		@"Parameter and result can't be of the same type", _
		@"Invalid result type for this operator", _
		@"Invalid parameter type, it must be the same as the parent TYPE/CLASS", _
		@"Vararg parameters are not allowed in overloaded functions", _
		@"Illegal outside an OPERATOR block", _
		@"Parameter cannot be optional", _
		@"Only valid in -lang", _
		@"Default types or suffixes are only valid in -lang", _
		@"Suffixes are only valid in -lang", _
		@"Implicit variables are only valid in -lang", _
		@"Auto variables are only valid in -lang", _
		@"Invalid array index", _
		@"Operator must be a member function", _
		@"Operator cannot be a member function", _
		@"Member function not allowed in anonymous UDT's", _
		@"Expected operator", _
		@"Declaration outside the original namespace or class", _
		@"A destructor should not have any parameters", _
		@"Expected class or UDT identifier", _
		@"Var-len strings cannot be part of UNION's or nested TYPE's", _
		@"Fields with constructors cannot be part of UNION's or nested TYPE's", _
		@"Fields with destructors cannot be part of UNION's or nested TYPE's", _
		@"Illegal outside a CONSTRUCTOR block", _
		@"Illegal outside a DESTRUCTOR block", _
		@"UDT's with methods must have unique names", _
		@"Parent is not a class or UDT", _
		@"Call to another constructor must be the first statement", _
		@"The constructor or destructor calling convention must be CDECL", _
		@"This symbol cannot be undefined", _
		@"Either 'RETURN' or 'FUNCTION =' should be used when returning objects with default constructors", _
		@"Invalid assignment/conversion", _
		@"Invalid array subscript", _
		@"TYPE or CLASS has no default constructor", _
		@"Invalid priority attribute", _
		@"PROPERTY GET should have no parameter, or just one if indexed", _
		@"PROPERTY SET should have one parameter, or just two if indexed", _
		@"Expected 'PROPERTY'", _
		@"Illegal outside a PROPERTY block", _
		@"PROPERTY has no GET method/accessor", _
		@"PROPERTY has no SET method/accessor", _
		@"PROPERTY has no indexed GET method/accessor", _
		@"PROPERTY has no indexed SET method/accessor", _
		@"Missing overloaded operator: ", _
		@"The NEW[] operator does not allow explicit calls to constructors", _
		@"The NEW[] operator only supports the { ANY } initialization", _
		@"The NEW operator cannot be used with strings", _
		@"Illegal member access", _
		@"Expected ':'", _
		@"The default constructor has no public access", _
		@"Constructor has no public access", _
		@"Destructor has no public access", _
		@"Illegal non-static member access", _
		@"Member cannot be static", _
		@"Member isn't static", _
		@"Only static members can be accessed from static functions", _
		@"The PRIVATE and PUBLIC attributes are not allowed with REDIM, COMMON or EXTERN", _
		@"The function prototype wasn't declared as STATIC", _
		@"This operator cannot be STATIC", _
		@"Parameter must be an integer", _
		@"Parameter must be a pointer", _
		@"Expected initializer", _
		@"Fields cannot be named as keywords in TYPE's that contain member functions or in CLASS'es", _
		@"Illegal outside a FOR compound statement", _
		@"Illegal outside a DO compound statement", _
		@"Illegal outside a WHILE compound statement", _
		@"Illegal outside a SELECT compound statement", _
		@"Expected 'FOR'", _
		@"Expected 'DO'", _
		@"Expected 'WHILE'", _
		@"Expected 'SELECT'", _
		@"No outer FOR compound statement found", _
		@"No outer DO compound statement found", _
		@"No outer WHILE compound statement found", _
		@"No outer SELECT compound statement found", _
		@"Expected 'CONSTRUCTOR', 'DESTRUCTOR', 'DO', 'FOR', 'FUNCTION', 'OPERATOR', 'PROPERTY', 'SELECT', 'SUB' or 'WHILE'", _
		@"Expected 'DO', 'FOR' or 'WHILE'", _
		@"Illegal outside a SUB block", _
		@"Illegal outside a FUNCTION block", _
		@"Ambiguous symbol access, explicit scope resolution required", _
		@"An ENUM, TYPE or UNION cannot be empty", _
		@"ENUM's declared inside EXTERN .. END EXTERN blocks don't open new scopes", _
		@"Only member functions can be static", _
		@"Invalid initializer", _
		@"Objects with default [con|de]structors or methods are only allowed in the module level", _
		@"Symbol not a CLASS, ENUM, TYPE or UNION type", _
		@"Too many elements", _
		@"Only data members supported", _
		@"UNIONs are not allowed", _
		@"Arrays are not allowed", _
		@"COMMON variables cannot be object instances of CLASS/TYPE's with cons/destructors", _
		@"Cloning operators (LET, Copy constructors) can't take a byval arg of the parent's type", _
		@"Local symbols can't be referenced", _
		@"Expected 'PTR' or 'POINTER'", _
		@"Too many levels of pointer indirection", _
		@"Dynamic arrays can't be const", _
		@"Non-const UDT cannot invoke const method", _
		@"Elements must be empty for strings and arrays", _
		@"GOSUB disabled, use 'OPTION GOSUB' to enable", _
		@"Invalid -lang", _
		@"Can't use ANY as initializer in array with ellipsis bound", _
		@"Must have initializer with array with ellipsis bound", _
		@"Can't use ... as lower bound", _
		@"FOR/NEXT variable name mismatch", _
		@"Selected option requires an SSE FPU mode", _
		@"Expected relational operator ( =, >, <, <>, <=, >= )", _
		@"Unsupported statement in -gen gcc mode", _
		@"Too many labels", _
		@"Expected '#ENDIF'", _
		@"Resource file given for target system that does not support them", _
		@"-o <file> option without corresponding input file" _
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
		byval showerror as integer = TRUE, _
		byval customText as zstring ptr = 0 _
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
		print ") ";
	end if

	print "error";

	if( errnum >= 0 ) then
		print " " & errnum & ": " & *msg;
		if( customText ) then
			print *customText;
		end if

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
			dim as string ln
			ln = lexPeekCurrentLine( token_pos, fbLangOptIsSet( FB_LANG_OPT_SINGERRLINE ) )

			if( len( ln ) > 0 ) then
				if( fbLangOptIsSet( FB_LANG_OPT_SINGERRLINE ) ) then
					print " in '" & ln & "'"
				else
					print
					print lexPeekCurrentLine( token_pos, FALSE )
					print token_pos
				end if
			else
				print
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
		byval options as FB_ERRMSGOPT, _
		byval customText as zstring ptr _
	) as integer

    '' too many errors?
    if( errctx.cnt >= env.clopt.maxerrors ) then
    	return FALSE
    end if

	if( linenum = 0 ) then
		'' only one error per stmt
		if( parser.stmt.cnt = errctx.laststmt ) then
			return TRUE
		end if

		if( lex.ctx <> NULL ) then
			linenum = lexLineNum( )
		end if

		errctx.lastmsg = errnum
		errctx.lastline = linenum
    	errctx.laststmt = parser.stmt.cnt
	end if

    hPrintErrMsg( errnum, msgex, options, linenum, env.clopt.showerror, customText )

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
				res += "before '"
			else
				res += "found '"
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
		byval isbefore as integer = FALSE, _
		byval customText as zstring ptr _
	) as integer

	function = errReportEx( errnum, hAddToken( isbefore, FALSE ), , , customText )

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

	if( len( env.inf.name ) > 0 ) then
		print env.inf.name;
	else
		if( msgex <> NULL ) then
			print *msgex;
			msgex = NULL
		end if
	end if

	if( linenum > 0 ) then
		print "(" & linenum & ")";
	else
		print "()";
	end if

	print " warning " & msgnum & "(" & warningMsgs(msgnum).level & "): ";
	print *warningMsgs(msgnum).text;

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
				dim as integer cnt = iif( symbIsMethod( proc ), 0, 1 )

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
			if( len(*pid) > 0 ) then
				desc += " ("
				desc += *pid
				desc += ")"
			end if
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
			if( symbGetIsFuncPtr( proc ) ) then
				pname = symbDemangleFunctionPtr( proc )

			'' method?
			elseif( (symbGetAttrib( proc ) and (FB_SYMBATTRIB_CONSTRUCTOR or _
											    FB_SYMBATTRIB_DESTRUCTOR or _
											    FB_SYMBATTRIB_OPERATOR)) <> 0 ) then

				pname = symbDemangleMethod( proc )
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
		byval proc as FBSYMBOL ptr, _
		byval pnum as integer, _
		byval pid as zstring ptr, _
		byval msgnum as integer _
	) as integer

	static as any ptr lastproc = NULL
	static as integer lastpnum = -1
	dim as integer cnt

	'' don't count the instance pointer
	if( symbIsMethod( proc ) ) then
		if( pnum > 1 ) then
			pnum -= 1
		end if
	end if

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
		byval proc as FBSYMBOL ptr, _
		byval pnum as integer, _
		byval pid as zstring ptr, _
		byval msgnum as integer _
	)

	'' don't count the instance pointer
	if( symbIsMethod( proc ) ) then
		if( pnum > 1 ) then
			pnum -= 1
		end if
	end if

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

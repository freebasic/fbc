'' WITH..END WITH compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'' WithStmtBegin  =  WITH Variable .
sub cWithStmtBegin( )
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr sym = any, subtype = any
	dim as ASTNODE ptr expr = any
	dim as integer dtype = any, is_ptr = any
	dim as FB_CMPSTMTSTK ptr stk = any

	'' WITH
	lexSkipToken( )

	'' Variable
	expr = cVarOrDeref( FB_VAREXPROPT_ISEXPR )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake a var
		expr = astNewVAR( symbAddTempVar( FB_DATATYPE_INTEGER ) )
		dtype = FB_DATATYPE_INTEGER
	else
		'' not an UDT?
		dtype = astGetFullType( expr )
		if( typeGetDtAndPtrOnly( dtype ) <> FB_DATATYPE_STRUCT ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
		end if
	end if

	if( astIsVAR( expr ) ) then
		'' If it's a simple VAR access, we can just access the
		'' corresponding variable from inside the WITH.
		sym = astGetSymbol( expr )
		is_ptr = FALSE
	else
		'' Otherwise, take a reference (a pointer that will be deref'ed
		'' for accesses from inside the WITH block)
		sym = symbAddTempVar( typeAddrOf( dtype ), astGetSubType( expr ) )
		is_ptr = TRUE

		'' temp = @expr
		astAdd( astNewASSIGN( astNewVAR( sym ), astNewADDROF( expr ) ) )
	end if

	'' Save current WITH context to the statement stack
	stk = cCompStmtPush( FB_TK_WITH )
	stk->with = parser.stmt.with

	'' And set the new WITH context
	parser.stmt.with.sym    = sym
	parser.stmt.with.is_ptr = is_ptr
end sub

'' WithStmtEnd  =  END WITH .
function cWithStmtEnd( ) as integer
	dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_WITH )
	if( stk = NULL ) then
		exit function
	end if

	'' END WITH
	lexSkipToken( )
	lexSkipToken( )

	'' Restore the previous WITH context
	parser.stmt.with = stk->with
	cCompStmtPop( stk )

	function = TRUE
end function

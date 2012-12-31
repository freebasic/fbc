'' WITH..END WITH compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

private function hAllocWithVar( ) as FBSYMBOL ptr
    static as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr sym = any, subtype = any
    dim as ASTNODE ptr expr = any
    dim as integer dtype = any
    
    dtype = FB_DATATYPE_VOID
    
    '' Variable
	expr = cVarOrDeref( FB_VAREXPROPT_ISEXPR )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake a var
		expr = astNewVAR( symbAddTempVar( FB_DATATYPE_INTEGER ) )
	else
		'' not an UDT?
		dtype = astGetFullType( expr )
		if( typeGet( dtype ) <> FB_DATATYPE_STRUCT ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
		end if
    end if

    '' create a temporary pointer
    dtype = typeAddrOf( dtype )
    subtype = astGetSubType( expr )

    sym = symbAddTempVar( dtype, subtype )

	'' load with the address of expr (sym = @expr)
	astAdd( astNewASSIGN( astNewVAR( sym ), astNewADDROF( expr ) ) )

	function = sym
end function

'':::::
''WithStmtBegin   =   WITH Variable .
''
sub cWithStmtBegin()
    dim as FBSYMBOL ptr sym = any
    dim as FB_CMPSTMTSTK ptr stk = any

	'' WITH
	lexSkipToken( )

	'' Variable
	sym = hAllocWithVar( )

	'' push to stmt stack
	stk = cCompStmtPush( FB_TK_WITH )

	stk->with.last = parser.stmt.with.sym
	parser.stmt.with.sym = sym
end sub

'':::::
''WithStmtEnd	  =   END WITH .
''
function cWithStmtEnd as integer
	dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_WITH )
	if( stk = NULL ) then
		exit function
	end if

	'' END WITH
	lexSkipToken( )
	lexSkipToken( )

	'' pop from stmt stack
	parser.stmt.with.sym = stk->with.last
	cCompStmtPop( stk )

	function = TRUE

end function


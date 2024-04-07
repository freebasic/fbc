'' quick threadcall implementation
''
'' chng: oct/2011 written [jofers]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

#include once "ast.bi"
#include once "rtl.bi"

'':::::
'' ThreadCallFunc =   THREADCALL proc_call
''
function cThreadCallFunc() as ASTNODE ptr
	dim as FBSYMBOL ptr sym
	dim as FBSYMCHAIN ptr chain_
	dim as integer check_paren
	dim as FB_CALL_ARG_LIST arg_list = ( 0, NULL, NULL )
	dim as ASTNODE ptr childcall

	function = NULL

	'' THREADCALL
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' proc
	chain_ = cIdentifier( NULL, FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT )
	if( chain_ = NULL ) then
		exit function
	end if

	'' get symbol
	sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
	if sym = NULL then
		errReport( FB_ERRMSG_EXPECTEDSUB )
		exit function
	end if

	'' must be a sub
	if( symbGetType( sym ) <> FB_DATATYPE_VOID ) then
		errReport( FB_ERRMSG_EXPECTEDSUB )
		exit function
	end if

	'' ID
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' '('?
	if( hMatch( CHAR_LPRNT ) = FALSE ) then
		dim params as integer
		params = symbGetProcParams( sym )
		if( params > 0 ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if
	else
		check_paren = TRUE
	end if

	'' arg_list
	childcall = cProcArgList( NULL, sym, NULL, @arg_list, 0 )

	'' ')'?
	if( check_paren = TRUE ) then
		if( lexGetToken( ) <> CHAR_RPRNT ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if
		lexSkipToken( )
	end if

	'' transform the call into a threadcall
	function = rtlThreadCall( childcall )
end function

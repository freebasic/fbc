'' statements top-level parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

'':::::
''Statement       =   STT_SEPARATOR? ( Declaration
''									 | ProcCallOrAssign
''								     | CompoundStmt
''									 | QuirkStmt
''									 | AsmBlock
''									 | AssignmentOrPtrCall )?
''                    (STT_SEPARATOR Statement)* .
''
function cStatement as integer

	'' ':'?
	if( lexGetToken( ) = FB_TK_STMTSEP ) then
		lexSkipToken( )
	end if

	do
		if( cDeclaration( ) = FALSE ) then
			if( cCompoundStmt( ) = FALSE ) then
				if( cProcCallOrAssign( ) = FALSE ) then
					if( cQuirkStmt( ) = FALSE ) then
						if( cAsmBlock( ) = FALSE ) then
							cAssignmentOrPtrCall( )
						end if
					end if
				end if
			end if
		end if

		'' ':'?
		if( lexGetToken( ) <> FB_TK_STMTSEP ) then
			exit do
		end if
		lexSkipToken( )
	loop

	function = (errGetLast( ) = FB_ERRMSG_OK)

end function

'':::
''SttSeparator    =   (STT_SEPARATOR | EOL)+ .
''
function cStmtSeparator( byval lexflags as LEXCHECK ) as integer

	function = FALSE

	do
		select case lexGetToken( lexflags )
		case FB_TK_STMTSEP, FB_TK_EOL
        	lexSkipToken( lexflags )
		case else
			exit do
		end select

		function = TRUE
	loop

end function


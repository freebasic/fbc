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
sub cStatement()
	'' ':'?
	if( lexGetToken( ) = FB_TK_STMTSEP ) then
		parser.stmt.cnt += 1
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

		parser.stmt.cnt += 1

		'' ':'?
		if( lexGetToken( ) <> FB_TK_STMTSEP ) then
			exit do
		end if
		lexSkipToken( )
	loop
end sub

'':::
''SttSeparator    =   (STT_SEPARATOR | EOL)+ .
''
function cStmtSeparator( byval lexflags as LEXCHECK ) as integer

	function = FALSE

	do
		select case lexGetToken( lexflags )
		case FB_TK_STMTSEP, FB_TK_EOL
			parser.stmt.cnt += 1
			lexSkipToken( lexflags )
		case else
			exit do
		end select

		function = TRUE
	loop

end function


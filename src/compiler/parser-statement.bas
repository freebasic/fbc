'' statements top-level parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

'':::::
''Statement       =   STT_SEPARATOR? ( Declaration
''                                   | ProcCallOrAssign
''                                   | CompoundStmt
''                                   | QuirkStmt
''                                   | AsmBlock
''                                   | AssignmentOrPtrCall )?
''                    (STT_SEPARATOR Statement)* .
''
sub cStatement()
	'' ':'?
	if( lexGetToken( ) = FB_TK_STMTSEP ) then
		parser.stmt.cnt += 1  '' end-of-statement seen
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
		parser.stmt.cnt += 1  '' end-of-statement seen
		lexSkipToken( )
	loop
end sub

'' StmtSeparator  =  (':' | EOL | EOF)+ .
function cStmtSeparator( byval lexflags as LEXCHECK ) as integer
	function = FALSE

	do
		select case lexGetToken( lexflags )
		case FB_TK_STMTSEP, FB_TK_EOL
			parser.stmt.cnt += 1
			lexSkipToken( lexflags )
			function = TRUE

		case FB_TK_EOF
			function = TRUE
			exit do

		case else
			exit do
		end select
	loop
end function

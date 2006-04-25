''
'' CRegex test
''
'' to build: fbc test.bas
'' 			 (note: build the CRegex static library first)
''

option explicit 

#include once "CRegex.bi"

const TEST_PATTERN = "[a-zA-Z_][a-zA-Z0-9_]*|" + _
					 "[0-9]+([\.][0-9]*)?([Ee][-+][0-9]+)?|" + _
					 "\=|\+|\-|\*|\\|\/|\^|\@|\(|\)|\{|\}"

declare function 	load_textfile			( filename as string ) as string


'' main

	'' create a regex object
	dim as CRegex ptr reg 
	
	reg = CRegex_New( TEST_PATTERN, REGEX_OPT_MULTILINE or REGEX_OPT_DOTALL )
	if( reg = NULL ) then
		print "Error: CRegex_New failed"
		end 1
	end if

	'' load the test file
	dim as string text
	
	text = load_textfile( "test.txt" )
	
	if( len( text ) = 0 ) then
		print "Error: load_textfile failed"
		end 1
	end if
	
	'' parse it
	if( CRegex_Search( reg, text ) ) then
		'' match found..
		dim as string match
		do 
			match = *CRegex_GetStr( reg, 0 )
			
			print "Found a ";
			
			'' naive check..
			select case match[0]
			case asc( "0" ) to asc( "9" )
				print "number  : ";
			
			case asc( "a" ) to asc( "z" ), asc( "A" ) to asc( "Z" ), asc( "_" )
				print "symbol  : ";
			
			case else
				print "operator: ";
			end select
			
			print """"; match; """"
		
		'' find next match..
		loop while( CRegex_SearchNext( reg ) )	
	end if	
	
	'' free the object
	CRegex_Delete( reg )


'':::::
function load_textfile( filename as string ) as string
	dim as string text, ln

	dim as integer f = freefile
	if( open( filename, for input, access read, as #f ) <> 0 ) then
		exit function
	end if
	
	do until eof( f )
		line input #f, ln
		text += ln + chr( 13, 10 )
	loop	
	
	close #f
	
	function = text
	
end function


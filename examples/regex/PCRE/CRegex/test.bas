''
'' CRegex test
''
'' to build: fbc test.bas
'' 			 (note: build the CRegex static library first)
''

#include once "CRegex.bi"

const TEST_PATTERN = "[a-zA-Z_][a-zA-Z0-9_]*|" + _
					 "[0-9]+([\.][0-9]*)?([Ee][-+][0-9]+)?|" + _
					 "\=|\+|\-|\*|\\|\/|\^|\@|\(|\)|\{|\}"

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

	'' create a regex object
	var reg = new CRegex( TEST_PATTERN, CRegex.MULTILINE or CRegex.DOTALL )
	if( reg = NULL ) then
		print "Error: CRegex_New failed"
		end 1
	end if

	'' load the test file
	dim as string text = load_textfile( "test.txt" )
	if( len( text ) = 0 ) then
		print "Error: load_textfile failed"
		end 1
	end if

	'' parse it
	if( reg->search( text ) ) then
		'' match found..
		dim as string match
		do 
			match = *reg->getStr( 0 )

			'' naive check..
			select case match[0]
			case asc( "0" ) to asc( "9" )
				print "Number";

			case asc( "a" ) to asc( "z" ), asc( "A" ) to asc( "Z" ), asc( "_" )
				print "Symbol";

			case else
				print "Operator";
			end select

			print " found: """; match; """"

		'' find next match..
		loop while( reg->searchNext( ) )
	end if

	'' free the object
	delete reg

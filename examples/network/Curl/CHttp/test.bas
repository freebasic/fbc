''
'' CHttp example
''
'' to build: fbc test.bas
''			 (build the CHttp static library first)
''

#include once "CHttp.bi"

	scope
		'' create object
		dim as CHttpStream stream
	
		'' get the page
		if( stream.receive( "http://freebasic.net/" ) ) then
			print stream.read( )
		end if
	
		'' the stream will be closed when the object is destroyed
	end scope
	

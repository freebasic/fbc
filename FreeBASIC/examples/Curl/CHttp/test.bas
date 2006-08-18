''
'' CHttp example
''
'' to build: fbc test.bas
''			 (build the CHttp static library first)
''



#include once "CHttp.bi"

	'' create object
	dim as CHttpStream ptr stream

	stream = CHttpStream_New( )
	
	'' get page
	if( CHttpStream_Receive( stream, "http://freebasic.net/" ) ) then
		print CHttpStream_Read( stream )
	end if
	
	'' delete object
	CHttpStream_Delete( stream )


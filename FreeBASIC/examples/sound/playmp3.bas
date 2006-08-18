''
'' play all mp3 files at the path given in command-line (current dir if none)
''
'' uses the fmod library to do the hard work
''


#include once "fmod.bi"

declare function 	listmp3			( byref path as string, mp3table() as string ) as integer
declare function 	getmp3name		( byval stream as FSOUND_STREAM ptr ) as string
declare function 	getmp3artist	( byval stream as FSOUND_STREAM ptr ) as string
declare function 	getmp3album		( byval stream as FSOUND_STREAM ptr ) as string
declare sub 		printmp3tags	( byval stream as FSOUND_STREAM ptr )

	dim stream as FSOUND_STREAM ptr
	dim mp3table() as string
	dim songs as integer, currsong as integer
	dim doexit as integer
	dim shared streamended as integer
	
	''
	songs = listmp3( command, mp3table() )
   
	if( songs = 0 ) then
		print "No mp3 files found, usage: playmp3.exe path"
		sleep
		end 1
	end if
   
   	''
   	if( FSOUND_GetVersion < FMOD_VERSION ) then 
      	print "FMOD version " + str(FMOD_VERSION) + " or greater required" 
      	end 1
   	end If 

   	''
   	if( FSOUND_Init( 44100, 4, 0 ) = 0 ) then 
      	print "Can't initialize FMOD" 
      	end 1
   	end if 

   	''
   	FSOUND_Stream_SetBufferSize( 50 )
      	
   	''   	
   	currsong = 0
   	doexit = 0
   	do
   		''
   		stream = FSOUND_Stream_Open( mp3table(currsong), FSOUND_MPEGACCURATE, 0, 0 ) 
   		if( stream = 0 ) then 
    	  	print !"Can't load music file \"" + mp3table(currsong) + !"\""
    		exit do
    	end if
   		
   		''
   		print "Title:", getmp3name( stream )
   		print "Album:", getmp3album( stream )
   		print "Artist:", getmp3artist( stream )
	   
   		'printmp3tags stream

   		''
   		streamended = 0
   		
   		FSOUND_Stream_Play( FSOUND_FREE, stream )
   
   		''
   		print "(press P for previous, N for next or any other key to exit)"
   		print
        
		dim key as string		
   		do 
      		
      		key = inkey 
      		if( len( key ) > 0 ) then
      			select case ucase( key )
      			case "P"
      				currsong = currsong - 1
      				if( currsong < 0 ) then currsong = songs - 1
      			case "N"
      				currsong = currsong + 1
      				if( currsong >= songs ) then currsong = 0
      			case else
      				doexit = -1
      			end select
      			exit do	
      		
      		else
      			
      			if( FSOUND_Stream_GetPosition( stream ) >= FSOUND_Stream_GetLength( stream ) ) then
      				currsong = currsong + 1
      				if( currsong >= songs ) then currsong = 0
      				exit do	
      			end if      				

      		end if
      		
      		sleep 50
   		loop
   
   		FSOUND_Stream_Stop stream
   		FSOUND_Stream_Close stream
	loop until( doexit )

	FSOUND_Close 
	end
	
'':::::
sub printmp3tags( byval stream as FSOUND_STREAM ptr )
	dim numtags as integer
   	dim tagtype as integer, tagname as zstring ptr, tagvalue as zstring ptr, taglen as integer
   	dim tag as integer

   	FSOUND_Stream_GetNumTagFields( stream, @numtags )
   
   	for tag = 0 to numtags-1
		FSOUND_Stream_GetTagField( stream, tag, @tagtype, @tagname, @tagvalue, @taglen )
		print left( *tagname, taglen )
	next tag

end sub

'':::::
function getmp3name( byval stream as FSOUND_STREAM ptr ) as string
	dim tagname as zstring ptr, taglen as integer
   
	FSOUND_Stream_FindTagField( stream, FSOUND_TAGFIELD_ID3V1, "TITLE", @tagname, @taglen ) 
	if( taglen = 0 ) then 
		FSOUND_Stream_FindTagField( stream, FSOUND_TAGFIELD_ID3V2, "TIT2", @tagname, @taglen ) 
	end if
   
	getmp3name = left( *tagname, taglen )
	
end function

'':::::
function getmp3artist( byval stream as FSOUND_STREAM ptr ) as string
	dim tagname as zstring ptr, taglen as integer
   
	FSOUND_Stream_FindTagField( stream, FSOUND_TAGFIELD_ID3V1, "ARTIST", @tagname, @taglen ) 
	if( taglen = 0 ) then 
		FSOUND_Stream_FindTagField( stream, FSOUND_TAGFIELD_ID3V2, "TPE1", @tagname, @taglen ) 
	end if
   
	getmp3artist = left( *tagname, taglen )
	
end function

'':::::
function getmp3album( byval stream as FSOUND_STREAM ptr ) as string
	dim tagname as zstring ptr, taglen as integer
   
	FSOUND_Stream_FindTagField( stream, FSOUND_TAGFIELD_ID3V1, "ALBUM", @tagname, @taglen ) 
	if( taglen = 0 ) then 
		FSOUND_Stream_FindTagField( stream, FSOUND_TAGFIELD_ID3V2, "TALB", @tagname, @taglen ) 
	end if
   
	getmp3album = left( *tagname, taglen )
	
end function

'':::::
function listmp3( byref path as string, mp3table() as string ) as integer
	dim fname as string   
	dim maxsongs as integer, song as integer
	
   	''
   	maxsongs = 20
   	redim mp3table(0 to maxsongs-1) as string

	''
#ifdef __FB_WIN32__
const pathdiv = !"\\"	
#else
const pathdiv = "/"
#endif
	
	if( len( path ) > 0 ) then
		if( left( path, 1 ) = !"\"" ) then
			path = mid( path, 2 )
		end if

		if( right( path, 1 ) = !"\"" ) then
			path = left( path, len( path ) - 1 )
		end if
		
		if( right( path, 1 ) <> pathdiv ) then
			path = path + pathdiv
		end if
	end if

	''
	song = 0
	
	fname = dir( path + "*.mp3" )
	do while( len( fname ) > 0 )
   		
   		if( song >= maxsongs ) then
   			maxsongs = maxsongs + (maxsongs \ 2)
   			redim preserve mp3table(0 to maxsongs-1) as string
   		end if
   		
   		mp3table(song) = path + fname
   		song = song + 1
   		
   		fname = dir( "" )
   	loop

	listmp3 = song
	
end function

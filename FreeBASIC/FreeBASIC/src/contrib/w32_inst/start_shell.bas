'
' Small tool to start a shell with the path set to the FreeBASIC compiler
'

	dim as string cmd, path
	
	cmd = environ( "COMSPEC" )	
	if( len( cmd ) = 0 ) then
		cmd = "command.com"
	end if
	
	path = environ( "PATH" )
	if( len( cmd ) > 0 ) then
		path = ";" + path
	end if
	
	setenviron( "PATH=" + exepath() + path  )
	
	shell cmd

	end

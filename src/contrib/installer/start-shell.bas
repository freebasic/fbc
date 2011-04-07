'' Small tool to start a shell with the PATH set to the FreeBASIC compiler
'' win32 only

'' Try to cd to the first thing passed on command line
if( __FB_ARGC__ > 1 ) then
    chdir( *__FB_ARGV__[1] )
end if

'' Set the PATH
dim as string path = environ( "PATH" )
if( len( path ) > 0 ) then
    path = ";" + path
end if
setenviron( "PATH=" + exepath() + path  )

'' Start shell
dim as string cmd = environ( "COMSPEC" )	
if( len( cmd ) = 0 ) then
    cmd = "command.com"
end if
shell( cmd )

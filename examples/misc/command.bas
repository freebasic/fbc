''
'' command-line arguments example
''

 	print "exe name= "; command( 0 )
 	
 	dim argc as integer, argv as string
 	 	
 	argc = 1
 	do
 		argv = command( argc )
 		
 		if( len( argv ) = 0 ) then
 			exit do
 		end if
 		
 		print "arg"; argc; " = """; argv; """"
 		
 		argc += 1
 	loop
 	
 	if( argc = 1 ) then
 		print "(no arguments)"
 	end if
 	

	sleep

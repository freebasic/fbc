print "full command line: "; command( 0 ) & " " & command( )

''
'' Access to command-line arguments through the command() function:
'' (works from anywhere, except for global constructors)
''

	print "executable name from command line: "; command( 0 )

	dim position as integer, arg as string

	position = 1
	do
		arg = command( position )
		if( len( arg ) = 0 ) then
			exit do
		end if

		print "argument " & position & ": """ & arg & """"
		position += 1
	loop

	if( position = 1 ) then
		print "(no arguments)"
	end if

''
'' Accessing argc/argv directly (as in C)
'' (works only from main part of FB program)
''
	print "executable name from command line: " & *__FB_ARGV__[0]

	for i as integer = 1 to __FB_ARGC__ - 1
		print "argument " & i & ": """ & *__FB_ARGV__[i] & """"
	next

	if( __FB_ARGC__ = 1 ) then
		print "(no arguments)"
	end if

sleep

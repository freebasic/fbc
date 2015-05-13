'' inkey() demo

print "press ESC to exit, and other keys to see the characters"

dim as string k
do
	k = inkey( )

	if( len( k ) > 0 ) then
		print asc( k ), k;
		if( len( k ) > 1 ) then
			print asc( right( k, 1 ) )
		else
			print
		end if
	end if

	sleep 25
loop until k = chr( 27 )

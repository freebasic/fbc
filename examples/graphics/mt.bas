'' An example program mixing FB graphics and multi-threading

const TRUE = -1
const FALSE = 0

const SCREEN_W = 800
const SCREEN_H = 600

dim shared as integer active
dim shared as any ptr activelock, locatelock

sub randomBoxes( byval userdata as any ptr )
	var my_active = TRUE

	do
		mutexlock( activelock )
		my_active = active
		mutexunlock( activelock )

		if( my_active = FALSE ) then
			exit do
		end if

		var x = rnd( ) * SCREEN_W
		var y = rnd( ) * SCREEN_H

		var r = rnd( ) * 255
		var g = rnd( ) * 255
		var b = rnd( ) * 255

		screenlock( )
		line (x, y) - (x+50, y+50), rgb(r, g, b), bf
		screenunlock( )

		sleep 50, 1
	loop
end sub

sub mouseMonitor( byval userdata as any ptr )
	var my_active = TRUE

	do
		mutexlock( activelock )
		my_active = active
		mutexunlock( activelock )

		if( my_active = FALSE ) then
			exit do
		end if

		dim as integer x, y, buttons
		getmouse x, y, , buttons

		mutexlock( locatelock )
		locate 2 : print "mouse: ";x;",";y;space( 20 )
		mutexunlock( locatelock )

		'' Any buttons pressed, and mouse inside the window?
		if( (buttons <> 0) and (x <> -1) ) then
			circle (x, y), 20, rgb(255, 255, 255), , , , f
		end if

		sleep 25, 1
	loop
end sub

sub hPrintInfo( )
	windowtitle "FB graphics + multi threading"
	mutexlock( locatelock )
	locate 1 : print "press ESC to exit, SPACE to clear screen, mouse buttons to draw some white circles."
	mutexunlock( locatelock )
end sub

screenres SCREEN_W, SCREEN_H, 32
randomize( timer( ) )

active = TRUE
activelock = mutexcreate( )
locatelock = mutexcreate( )

var thread1 = threadcreate( @randomBoxes )
var thread2 = threadcreate( @randomBoxes )
var thread3 = threadcreate( @mouseMonitor )

hPrintInfo( )
do
	var k = inkey( )
	if( len( k ) > 0 ) then
		mutexlock( locatelock )
		locate 3
		print "last key: " + hex( k[0], 2 );
		if( len( k ) > 1 ) then
			print " ";hex( k[1], 2 );
		end if
		print space( 40 )
		mutexunlock( locatelock )

		select case( k )
		case chr( 27 )
			exit do
		case " "
			cls
			hPrintInfo( )
		end select
	end if

	sleep 50, 1
loop

mutexlock( activelock )
active = FALSE
mutexunlock( activelock )

threadwait( thread1 )
threadwait( thread2 )
threadwait( thread3 )

mutexdestroy( activelock )
mutexdestroy( locatelock )

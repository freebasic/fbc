''
'' test for the timer library
''
'' to compile: fbc test.bas -mt 
'' (compile timer.bas first, of course)
''



#include once "timer.bi"

declare sub timer_handler ( byval id as integer )

	dim t1, t2, t3
	
	print "starting.."
	
	t1 = timercreate( 500, @timer_handler, 1 )
	t2 = timercreate( 5000, @timer_handler, 2 )
	t3 = timercreate( 10000, @timer_handler, 3 )
	
	timeron t1
	timeron t2
	timeron t3
	
	do
		print "(main loop)"
		sleep 1000
    loop until len( inkey ) > 0

	print "exiting.."
	
	timeroff t3
	timeroff t2
	timeroff t1
	timerdestroy t3
	timerdestroy t2
	timerdestroy t1
	
	end

'':::::
sub timer_handler ( byval id as integer )
	
	print "(timer:" & id & " handler)" 
	
end sub		


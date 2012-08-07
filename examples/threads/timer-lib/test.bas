'' Timer library test
'' To compile: fbc test.bas -mt 
'' (compile timer.bas first, of course)

#include once "timer.bi"

sub timer_handler( byval id as integer )
	print "(timer:" & id & " handler)" 
end sub

	dim as CTimer ptr t1, t2, t3

	print "starting.."

	t1 = new CTimer( 500, @timer_handler, 1 )
	t2 = new CTimer( 5000, @timer_handler, 2 )
	t3 = new CTimer( 10000, @timer_handler, 3 )

	t1->on()
	t2->on()
	t3->on()

	do
		''print "(main loop)"
		sleep 1000
	loop until len( inkey ) > 0

	print "exiting.."

	t3->off()
	t2->off()
	t1->off()

	delete t3
	delete t2
	delete t1

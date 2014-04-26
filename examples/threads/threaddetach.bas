#include once "fbthread.bi"

sub mythread( byval p as any ptr )
	print "hey!"
end sub

threaddetach( threadcreate( @mythread ) )
sleep 100

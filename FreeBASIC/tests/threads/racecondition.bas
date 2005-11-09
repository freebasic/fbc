option explicit

const THREADS = 100

declare sub cb(byval i as integer) 

	dim htb(0 to THREADS-1) as integer 
	dim i as integer
	
	randomize timer
	
	for i = 0 to THREADS-1
	    htb(i) = threadcreate( @cb, i ) 
	    if( htb(i) = 0 ) then 
	       print "error:" & i
	       end 
	   end if 
	next i 

	for i = 0 to THREADS-1
   		print "waiting:" & i 
    	threadwait( htb(i) ) 
	next

	print "Exiting.." 
	sleep 1000

sub cb(byval i as integer) 
    sleep rnd * 100
    print "ending:" & i 
end sub 
# include "fbcu.bi"


#ifndef __FB_DOS__

namespace fbc_tests.threads.racecondition

const NUM_THREADS = 100

declare sub cb(byval i as any ptr) 

sub test_1 cdecl ()

	dim htb(0 to NUM_THREADS-1) as any ptr
	dim i as integer
	
	randomize timer
	
	for i = 0 to NUM_THREADS-1
	    htb(i) = threadcreate( @cb, cast(any ptr, i) ) 
	    if( htb(i) = 0 ) then 
	       print "error:" & i
	       end 
	   end if 
	next i 

	for i = 0 to NUM_THREADS-1
   		print "waiting:" & i 
    	threadwait( htb(i) ) 
	next

	print "Exiting.." 
	sleep 1000

end sub

sub cb(byval i as any ptr) 
    sleep rnd * 100
    print "ending:" & i 
end sub

sub ctor () constructor

'// fbcu should handle this internally ...
# if defined(FBCU_CONFIG_TEST_OUTPUT)
	fbcu.add_suite("fbc_tests.threads:race condition")
	fbcu.add_test("test_1", @test_1)
# endif

end sub

end namespace

#endif '' !defined(__FB_DOS__)

#ifdef __FB_LINUX__
#define CHAIN2	"chain2"
#else
#define CHAIN2	"chain2.exe"
#endif

	print "chain1 begins"
	
	chain CHAIN2
	
	print "chain1 ends"

	sleep

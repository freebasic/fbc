''
'' escape sequences test
''

option escape

#define CRLF "\r\n"	
	
	message$= "\45 this is the \"first\" line\r\nthis is the \"second\" line \45" 
	
	print message$
	
	print CRLF + "^-- CRLF --V" + CRLF;
	
	sleep
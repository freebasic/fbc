'' examples/manual/libraries/fastcgi.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FastCGI'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibFastCGI
'' --------

#include "fastcgi/fcgi_stdio.bi"

Dim As Integer count = 0
While (FCGI_Accept() >= 0)
	count += 1
	Print !"Content-type: text/html\r\n"
	Print !"\r\n"
	Print "<title>FastCGI Hello!</title>"
	Print "<h1>FastCGI Hello!</h1>"
	Print Using "Request number ### running on host <i>&</i>"; count; *getenv("SERVER_NAME");
Wend

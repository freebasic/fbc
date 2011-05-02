#include "fastcgi/fcgi_stdio.bi"

dim as integer count = 0
while (FCGI_Accept() >= 0)
    count += 1
    print !"Content-type: text/html\r\n"
    print !"\r\n"
    print "<title>FastCGI Hello!</title>"
    print "<h1>FastCGI Hello!</h1>"
    print using "Request number ### running on host <i>&</i>"; count, *getenv("SERVER_NAME");
wend

' Making a CGI script in FreeBASIC is simple, first print any headers,
' most of the time you just need Content-type, then an empty line, then
' the actual page data.

print "Content-type: text/html; charset=ISO-8859-1"
print ""
print "<html>"
print "  <head>"
print "    <title>CGI Test</title>"
print "  </head>"
print "  <body>"
print "    It works!"
print "  </body>"
print "</html>"

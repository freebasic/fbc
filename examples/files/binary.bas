open "binary.bas" for binary as #1

dim b as byte

print "Reading each byte separately, press a key to continue to the next"

do until( eof(1) )
	get #1, , b

	'' Display corresponding ASCII character
	print chr( b );

	sleep
	if inkey() = chr(27) then exit do
	while inkey() <> "" : wend
loop

close #1

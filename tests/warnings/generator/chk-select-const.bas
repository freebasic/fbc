/'

Checks to see if our expectation for warnings matches the results
from the compiler.  This help with the first time we add the test
result because we can't diff new results with any previous results.

For this to work, run independantly of warnings ./test.sh
This needs to search the unmodified output from the compiler.

Usage:

Generate the test source
	$ fbc gen-select-const.bas
	$ ./gen-select-const > const-overflow-select-const.bas

Generate the results of compiling the test source
	$ fbc -c const-overflow-select-const.bas > const-overflow-select-const.log

Generate the results of the check
	$ fbc chk-select-const.bas
	$ ./chk-select-const > chk-select-const.log

Line numbers in the result refer to line numbers in const-overflow-select-const.log

'/

open "const-overflow-select-const.log" for input as #1

dim x as string
dim mode as integer = 0
dim lineno as integer = 0

while eof(1) = 0
	lineno += 1
	line input #1, x
	if( left(x,4) = "----" ) then
		exit while
	end if
wend

while eof(1) = 0
	lineno += 1
	line input #1, x
	if( mode = 0 ) then
		if left( x, 8 ) = "warning " then
			mode = 1
		else
			if instr( 2, x, "warning" ) > 0 then
				print "line " & lineno & " - unexpected warning"
			end if
		end if
	else
		if instr( 2, x, "warning" ) = 0 then
			print "line " & lineno & " - expected warning"
		end if
		mode = 0
	end if

 wend
 
 close #1
 
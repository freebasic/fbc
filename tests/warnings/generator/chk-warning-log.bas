/'

chk-warning-log.bas
-------------------

Checks to see if our expectation for warnings matches the results
from the compiler.  This source helps with the first time we add the test
result because we can't diff new results with any previous results.

For this to work, run independantly of warnings ./test.sh script
This tool needs unmodified output from the compiler.


Compiling:
	$ fbc chk-warning-log.bas


Usage:
	$ ./chk-warning-log input.log > output.log


Input File:
	
	A log file of the following format, generated from fbc compiler 
	output:

		<BOF>
		----
		warning expected
		filename.bas(###) warning ##(#): message text
		...
		etc
		<EOF>

	The input file is scanned for first "----".  File is then examined 
	line by line.  If the log file sees "warning expected" then the next 
	line is expected to be a compiler generated warning.


Output: 

	A log file containing any mismatches between "warning expected" and 
	compiler generated warning found, or not found, on the following line.

	If no mismatches detected, output is empty.


Example #1 usage:

	$ fbc -w constness ../const-discard.bas -c > const-discard.log 
	$ ./chk-warning-log const-discard.log > chk-const-discard.log


Example #2 usage:

	$ fbc gen-select-const.bas
	$ ./gen-select-const > const-overflow-select-const.bas

	$ fbc -c const-overflow-select-const.bas > const-overflow-select-const.log

	$ ./chk-warning-log const-overflow-select-const.log > chk-select-const.log

'/

if command(1) = "" then
	print "no file name"
	end 1
end if

if( open( command(1) for input access read as #1 ) <> 0 ) then
	print "Error reading input file '" & command(1) & "'"
	end 1
end if

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
retry:
	if( mode = 0 ) then
		if left( x, 8 ) = "warning " then
			mode = 1
		elseif mid( x, 2, 10 ) = " warnings " then
			mode = cuint(left(x,1))
		else
			if instr( 2, x, "warning" ) > 0 then
				print "line " & lineno & " - unexpected warning"
			end if
		end if
	else
		if instr( 2, x, "warning" ) = 0 then
			print "line " & lineno & " - expected warning"
			mode = 0
			goto retry
		else
			mode -= 1
		end if
	end if

 wend
 
 close #1
 
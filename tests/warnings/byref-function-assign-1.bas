function f0byval( ) as integer
	function = 0
end function

function f0byref( ) byref as integer
	static j as integer
	function = j
end function

function f1byval( byval i as integer ) as integer
	function = 0
end function

function f1byref( byval i as integer ) byref as integer
	static j as integer
	function = j
end function

function f1xbyval( byval i as integer = 0 ) as integer
	function = 0
end function

function f1xbyref( byval i as integer = 0 ) byref as integer
	static j as integer
	function = j
end function

function f2byval( byval i as integer, byval j as integer ) as integer
	function = 0
end function

function f2byref( byval i as integer, byval j as integer ) byref as integer
	static k as integer
	function = k
end function

function f2xbyval( byval i as integer, byval j as integer = 0 ) as integer
	function = 0
end function

function f2xbyref( byval i as integer, byval j as integer = 0 ) byref as integer
	static k as integer
	function = k
end function

function f2xxbyval( byval i as integer = 0, byval j as integer = 0 ) as integer
	function = 0
end function

function f2xxbyref( byval i as integer = 0, byval j as integer = 0 ) byref as integer
	static k as integer
	function = k
end function

#print "no warnings:"
f0byval( )
f0byref( )
f1byval( 1 )
f1byref( 1 )
f1xbyval( )
f1xbyref( )
f1xbyval( 1 )
f1xbyref( 1 )
f2byval( 1, 1 )
f2byref( 1, 1 )
f2xbyval( 1 )
f2xbyref( 1 )
f2xbyval( 1, 1 )
f2xbyref( 1, 1 )
f2xxbyval( )
f2xxbyref( )
f2xxbyval( 1 )
f2xxbyref( 1 )
f2xxbyval( 1, 1 )
f2xxbyref( 1, 1 )

f0byval
f0byref
f1byval 1
f1byref 1
f1xbyval
f1xbyref
f1xbyval 1
f1xbyref 1
f2byval 1, 1
f2byref 1, 1
f2xbyval 1
f2xbyref 1
f2xbyval 1, 1
f2xbyref 1, 1
f2xxbyval
f2xxbyref
f2xxbyval 1
f2xxbyref 1
f2xxbyval 1, 1
f2xxbyref 1, 1

'f0byval( ) = 0
#print "no warning:"
f0byref( ) = 0
#print "no warning:"
f1byval( 1 ) = 0
#print "1 warning:"
f1byref( 1 ) = 0
'f1xbyval( ) = 0
#print "no warning:"
f1xbyref( ) = 0
#print "no warning:"
f1xbyval( 1 ) = 0
#print "1 warning:"
f1xbyref( 1 ) = 0
'f2byval( 1, 1 ) = 0
#print "no warning:"
f2byref( 1, 1 ) = 0
#print "no warning:"
f2xbyval( 1 ) = 0
#print "1 warning:"
f2xbyref( 1 ) = 0
'f2xbyval( 1, 1 ) = 0
#print "no warning:"
f2xbyref( 1, 1 ) = 0
'f2xxbyval( ) = 0
#print "no warning:"
f2xxbyref( ) = 0
#print "no warning:"
f2xxbyval( 1 ) = 0
#print "1 warning:"
f2xxbyref( 1 ) = 0
'f2xxbyval( 1, 1 ) = 0
#print "no warning:"
f2xxbyref( 1, 1 ) = 0

'f0byval = 0
'f0byref = 0
#print "no warning:"
f1byval 1 = 0
#print "1 warning:"
f1byref 1 = 0
'f1xbyval = 0
'f1xbyref = 0
#print "no warning:"
f1xbyval 1 = 0
#print "1 warning:"
f1xbyref 1 = 0
#print "no warning:"
f2byval 1, 1 = 0
#print "no warning:"
f2byref 1, 1 = 0
#print "no warning:"
f2byval 1 = 0, 1
#print "no warning:"
f2byref 1 = 0, 1
#print "no warning:"
f2xbyval 1 = 0
#print "1 warning:"
f2xbyref 1 = 0
#print "no warning:"
f2xbyval 1, 1 = 0
#print "no warning:"
f2xbyref 1, 1 = 0
#print "no warning:"
f2xbyval 1 = 0, 1
#print "no warning:"
f2xbyref 1 = 0, 1
'f2xxbyval = 0
'f2xxbyref = 0
#print "no warning:"
f2xxbyval 1 = 0
#print "1 warning:"
f2xxbyref 1 = 0
#print "no warning:"
f2xxbyval 1, 1 = 0
#print "no warning:"
f2xxbyref 1, 1 = 0
#print "no warning:"
f2xxbyval 1 = 0, 1
#print "no warning:"
f2xxbyref 1 = 0, 1

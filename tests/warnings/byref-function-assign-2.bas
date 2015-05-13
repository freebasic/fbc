function f1 overload( ) byref as integer
	static j as integer = 123
	function = j
end function

function f1 overload( i as integer ) as integer
	function = 123
end function

#print "--- 1 ---"
#print "no warning:"
f1(     ) = 123  '' no args, not really ambigious
#print "1 warning:"
f1( 123 ) = 123  '' byval

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function f2 overload( ) as integer
	function = 123
end function

function f2 overload( i as integer ) byref as integer
	static j as integer = 123
	function = j
end function

#print "--- 2 ---"
'f2(     ) = 123  '' assign to byval, not allowed
#print "1 warning:"
f2( 123 ) = 123

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function f3 overload( ) byref as integer
	static j as integer = 123
	function = j
end function

function f3 overload( i as integer ) byref as integer
	static j as integer = 123
	function = j
end function

#print "--- 3 ---"
#print "no warning:"
f3(     ) = 123  '' no args, not really ambigious
#print "1 warning:"
f3( 123 ) = 123

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function f4 overload( i as integer ) byref as integer
	static j as integer = 123
	function = j
end function

function f4 overload( ) as integer
	function = 123
end function

#print "--- 4 ---"
#print "1 warning:"
f4( 123 ) = 123
'f4(     ) = 123  '' assign to byval, not allowed

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function f5 overload( i as integer ) as integer
	function = 123
end function

function f5 overload( ) byref as integer
	static j as integer = 123
	function = j
end function

#print "--- 5 ---"
#print "1 warning:"
f5( 123 ) = 123  '' byval, f5( (123) = 123 )
#print "no warning:"
f5(     ) = 123  '' no args, not really ambigious

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function f6 overload( i as integer ) byref as integer
	static j as integer = 123
	function = j
end function

function f6 overload( ) byref as integer
	static j as integer = 123
	function = j
end function

#print "--- 6 ---"
#print "1 warning:"
f6( 123 ) = 123
#print "no warning:"
f6(     ) = 123  '' no args, not really ambigious

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function f7 overload( i as integer ) as integer
	function = 123
end function

function f7 overload( d as double ) byref as integer
	static j as integer = 123
	function = j
end function

#print "--- 7 ---"
#print "2 warnings:"
f7( 123   ) = 123
f7( 123.0 ) = 123

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function f8 overload( i as integer ) byref as integer
	static j as integer = 123
	function = j
end function

function f8 overload( d as double ) as integer
	function = 123
end function

#print "--- 8 ---"
#print "2 warnings:"
f8( 123   ) = 123
f8( 123.0 ) = 123

function f1 overload( ) byref as integer
	static j as integer = 123
	function = j
end function

function f1 overload( i as integer ) as integer
	function = 123
end function

#print "no warning:"
f1(     ) = 123  '' no args/params, not ambigious

#print "no warning:"
f1( 123 ) = 123  '' byval

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function f2 overload( ) as integer
	function = 123
end function

function f2 overload( i as integer ) byref as integer
	static j as integer = 123
	function = j
end function

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

#print "no warning:"
f3(     ) = 123  '' no args/params, not ambigious

#print "1 warning:"
f3( 123 ) = 123


function f4 overload( i as integer ) byref as integer
	static j as integer = 123
	function = j
end function

function f4 overload( ) as integer
	function = 123
end function

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

#print "no warning:"
f5( 123 ) = 123  '' byval, f5( (123) = 123 )
#print "no warning:"
f5(     ) = 123  '' no args/params, not ambigious

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function f6 overload( i as integer ) byref as integer
	static j as integer = 123
	function = j
end function

function f6 overload( ) byref as integer
	static j as integer = 123
	function = j
end function

#print "1 warning:"
f6( 123 ) = 123
#print "no warning:"
f6(     ) = 123  '' no args/params, not ambigious

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function f7 overload( i as integer ) byref as integer
	static j as integer = 123
	function = j
end function

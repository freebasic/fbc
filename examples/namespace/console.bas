

namespace net.fb.sys.console
	''
	function getStdIn() as integer
		static as integer h = -1
		
		if( h = -1 ) then
			h = freefile
			open cons for input as #h
		end if
		
		function = h
		
	end function

	''
	function getStdOut() as integer
		static as integer h = -1
		
		if( h = -1 ) then
			h = freefile
			open cons for output as #h
		end if
		
		function = h
		
	end function
	
	''
	sub print overload ( byval v as string )
		.print #getStdOut(), v;
	end sub

	''
	sub printnl overload ( byval v as string )
		.print #getStdOut(), v
	end sub

	''
	sub printnl overload ( byval v as integer )
		.print #getStdOut(), str( v )
	end sub

	''
	sub printnl overload ( byval v as uinteger )
		.print #getStdOut(), str( v )
	end sub
	
	''
	sub printnl overload ( byval v as longint )
		.print #getStdOut(), str( v )
	end sub

	''
	sub printnl overload ( byval v as ulongint )
		.print #getStdOut(), str( v )
	end sub

	''
	sub printnl overload ( byval v as double )
		.print #getStdOut(), str( v )
	end sub
	
end namespace

	using net.fb.sys
	
	console.print "string: "
	console.printnl "hello!"
	console.print "integer: "
	console.printnl &h7fffffff
	console.print "uinteger: "
	console.printnl &hfffffffful
	console.print "longint: "
	console.printnl &h7fffffffffffffff
	console.print "ulongint: "
	console.printnl &hffffffffffffffffull
	console.print "double: "
	console.printnl 1.23456789012345
		    
	
option explicit

namespace net.fb.sys.console
	''
	function getStdIn()
		static as integer h = -1
		
		if( h = -1 ) then
			h = freefile
			open cons for input as #h
		end if
		
		function = h
		
	end function

	''
	function getStdOut()
		static as integer h = -1
		
		if( h = -1 ) then
			h = freefile
			open cons for output as #h
		end if
		
		function = h
		
	end function
	
	''
	sub print_ overload ( byval v as string )
		print #getStdOut(), v;
	end sub

	''
	sub printnl overload ( byval v as string )
		print #getStdOut(), v
	end sub

	''
	sub printnl overload ( byval v as integer )
		print #getStdOut(), str( v )
	end sub

	''
	sub printnl overload ( byval v as uinteger )
		print #getStdOut(), str( v )
	end sub
	
	''
	sub printnl overload ( byval v as longint )
		print #getStdOut(), str( v )
	end sub

	''
	sub printnl overload ( byval v as ulongint )
		print #getStdOut(), str( v )
	end sub

	''
	sub printnl overload ( byval v as double )
		print #getStdOut(), str( v )
	end sub
	
end namespace

	using net.fb.sys.console
	
	print_ "string: "
	printnl "hello!"
	print_ "integer: "
	printnl &h7fffffff
	print_ "uinteger: "
	printnl &hfffffffful
	print_ "longint: "
	printnl &h7fffffffffffffff
	print_ "ulongint: "
	printnl &hffffffffffffffffull
	print_ "double: "
	printnl 1.23456789012345
		    
	
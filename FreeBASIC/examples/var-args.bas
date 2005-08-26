''
'' variable-arguments example
''

option explicit

declare sub myprintf cdecl (fmtstr as string, ...)

	dim s as string
	
	s = "bar"
	
	myprintf( "integer=%i, longint=%l single=%f, double=%d, string=%s, string=%s", _
			  1, 1LL shl 32, 2.2!, 3.3#, "foo", s )
	
	print
	sleep
	
'':::::	
sub myprintf cdecl (fmtstr as string, ...)
	dim as any ptr arg
	dim as zstring ptr p
	dim as integer i, char
	
	'' get the pointer to the first var-arg
	arg = va_first()
	
	'' for each char on format string..
	p = strptr( fmtstr )
	i = len( fmtstr )
	do while( i > 0 ) 
		char = *p
		p += 1
		i -= 1
		
		'' is it a format char?
		if( char = asc( "%" ) ) then
			'' get type
			char = *p
			p += 1
			i -= 1
			
			'' print var-arg, depending on the type
			select case char
			case asc( "i" )
				print str( va_arg( arg, integer ) );
				'' different from C, va_next() must be used as va_arg() won't update the pointer
				arg = va_next( arg, integer )

			case asc( "l" )
				print str( va_arg( arg, longint ) );
				arg = va_next( arg, longint )			'' /
			
			case asc( "f" )
				print str( va_arg( arg, single ) );
				arg = va_next( arg, single )			'' /
			
			case asc( "d" )
				print str( va_arg( arg, double ) );
				arg = va_next( arg, double )			'' /
			
			case asc( "s" )
				'' strings are passed byval, so the len is unknown
				print *va_arg( arg, zstring ptr );
				arg = va_next( arg, zstring ptr )		'' /
			end select
			
		'' ordinary char, just print as-is
		else
			print chr( char );
		end if
		
	loop

end sub

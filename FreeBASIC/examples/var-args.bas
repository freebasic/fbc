''
'' variable-arguments example
''

option explicit

#include "crt.bi" 		'' just for strlen()

declare sub myprintf cdecl (fmtstr as string, ...)

	dim s as string
	
	s = "bar"
	
	myprintf "integer=%i, longint=%l single=%f, double=%d, string=%s, string=%s", 1, 1LL shl 32, 2.2!, 3.3#, "foo", s
	
	print
	sleep
	
'':::::	
sub myprintf cdecl (fmtstr as string, ...)
	dim arg as any ptr
	dim p as byte ptr
	dim s as byte ptr
	dim i as integer, char as integer
	
	'' get the pointer to the first var-arg
	arg = va_first()
	
	'' for each char on format string..
	p = strptr( fmtstr )
	for i = 0 to len( fmtstr )-1
		char = *p
		p += 1
		
		'' is it a format char?
		if( char = asc( "%" ) ) then
			'' get type
			char = *p
			p += 1
			
			'' print var-arg, depending on the type
			select case char
			case asc( "i" )
				print str$( va_arg( arg, integer ) );
				'' different from C, va_next() must be used as va_arg() won't update the pointer
				arg = va_next( arg, integer )

			case asc( "l" )
				print str$( va_arg( arg, longint ) );
				arg = va_next( arg, longint )			'' /
			
			case asc( "f" )
				print str$( va_arg( arg, single ) );
				arg = va_next( arg, single )			'' /
			
			case asc( "d" )
				print str$( va_arg( arg, double ) );
				arg = va_next( arg, double )			'' /
			
			case asc( "s" )
				'' strings are passed byval, so the len is unknown
				s = va_arg( arg, byte ptr )
				print left$( *s, strlen( s ) );
				arg = va_next( arg, byte ptr )			'' /
			end select
			
		'' ordinary char, just print as-is
		else
			print chr$( char );
		end if
		
	next

end sub

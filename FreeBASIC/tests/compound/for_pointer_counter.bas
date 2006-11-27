# include "fbcu.bi"




namespace fbc_tests.compound.for_pointer_counter

	sub testPtrIterators cdecl( )
	
		#macro buildTest( __TYPE__ )
		    
		    scope
		        
		        dim as __TYPE__ buff( 9 )
			    dim as __TYPE__ ptr iBuffer = @buff( 0 )
		
				dim as integer c, stp
				for i as integer = 0 to 9
					iBuffer[i] = i
				next
				c = 0
				for i as __TYPE__ ptr = iBuffer to iBuffer + 9
					CU_ASSERT( *i = c )
					CU_ASSERT( i = ( c + iBuffer ) )
					c += 1
				next
				c = 9
				for i as __TYPE__ ptr = iBuffer + 9 to iBuffer step -1
					CU_ASSERT( *i = c )
					CU_ASSERT( i = ( c + iBuffer ) )
					c -= 1
				next
				c = 0
				stp = 2
				for i as __TYPE__ ptr = iBuffer + 9 to iBuffer step stp
					CU_ASSERT( *i = c )
					CU_ASSERT( i = ( c + iBuffer ) )
					c += 2
				next
			end scope
		
		#endmacro
		
		buildTest( byte )
		buildTest( short )
		buildTest( single )
		buildTest( double )
		buildTest( longint )
		
		
		type foo
			as any ptr x, y
		end type
		
		dim as foo buff( 9 )
		dim as foo ptr fBuffer  = @buff( 0 )
		dim as integer c
		for i as foo ptr = fBuffer to fBuffer + 9
			i->x = i
			i->y = i->x + 4
			CU_ASSERT( i = ( fBuffer +  c) )
			c += 1
		next
		
		dim as integer stp = 2
		for i as foo ptr = fBuffer to fBuffer + 9 step stp
			CU_ASSERT( i->x = @i->x )
			CU_ASSERT( i->y = @i->y )
		next
	
	end sub


sub ctor () constructor

	fbcu.add_suite("fbc_tests.compound.for_pointer_counter")
	fbcu.add_test("test pointer as counter", @testPtrIterators)

end sub

end namespace

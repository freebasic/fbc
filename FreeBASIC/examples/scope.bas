''
'' scope blocks test
''

option explicit

declare sub foo	
	
	dim shared c
	c = 3
	dim shared d
	d = 4
	
	scope
		dim a
		a = 1
		scope 
			dim b
			b = 2
			print "1=" & a
			assert( a = 1 )
			scope
				print "2=" & b
				assert( b = 2 )
			end scope
		end scope

	end scope
	
	scope
		dim a
		print "0=" & a
		assert( a = 0 )
		scope
			print "3=" & c
			assert( c = 3 )
			scope
				dim d
				print "0=" & d
				assert( d = 0 )
			end scope
		end scope
	end scope
	
	foo
	
	sleep
	
''::::
sub foo

	scope
		dim a
		a = 1
		scope 
			dim b
			b = 2
			print "1=" & a
			assert( a = 1 )
			scope
				print "2=" & b
				assert( b = 2 )
			end scope
		end scope
	end scope
	
	scope
		dim a
		print "0=" & a
		assert( a = 0 )
		scope
			print "3=" & c
			assert( c = 3 )
			scope
				dim d
				print "0=" & d
				assert( d = 0 )
			end scope
		end scope
	end scope

end sub	
''
'' scope blocks test
''

option explicit

declare sub foo	
	
	dim shared c = 3
	dim shared d = 4
	
	scope
		dim a = 1
		scope 
			dim b = 2
			print "1=" & a
			scope
				print "2=" & b
			end scope
		end scope

	end scope
	
	scope
		dim a = 0
		print "0=" & a
		scope
			print "3=" & c
			scope
				dim d
				print "0=" & d
			end scope
		end scope
	end scope
	
	foo
	
	sleep
	
''::::
sub foo

	scope
		dim a = 1
		scope 
			dim b = 2
			print "1=" & a
			scope
				print "2=" & b
			end scope
		end scope
	end scope
	
	scope
		dim a = 0
		print "0=" & a
		scope
			print "3=" & c
			scope
				dim d = 0
				print "0=" & d
			end scope
		end scope
	end scope

end sub	
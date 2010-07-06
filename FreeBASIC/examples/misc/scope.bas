''
'' scope blocks test
''

declare sub foo	
	
	dim shared as integer c = 3
	dim shared as integer d = 4
	
	scope
		dim as integer a = 1
		scope 
			dim as integer b = 2
			print "1=" & a
			scope
				print "2=" & b
			end scope
		end scope

	end scope
	
	scope
		dim as integer a = 0
		print "0=" & a
		scope
			print "3=" & c
			scope
				dim as integer d
				print "0=" & d
			end scope
		end scope
	end scope
	
	foo
	
	sleep
	
''::::
sub foo

	scope
		dim as integer a = 1
		scope 
			dim as integer b = 2
			print "1=" & a
			scope
				print "2=" & b
			end scope
		end scope
	end scope
	
	scope
		dim as integer a = 0
		print "0=" & a
		scope
			print "3=" & c
			scope
				dim as integer d = 0
				print "0=" & d
			end scope
		end scope
	end scope

end sub 

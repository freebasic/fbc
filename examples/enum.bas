''
'' Enumerations are an easy way to declare integer constants:
'' (unless explicitly assigned, the first will be zero, and following ones
'' are just incremented)
''
	enum
		A
		B
		C
		D = 123
		E
	end enum

	print A, B, C, D, E

''
'' It's common to use them to represent options:
''
	enum
		SAY_HELLO
		SAY_HI
		SAY_BYE
		SAY_SEEYOU
	end enum

	sub saySomething( byval what as integer )
		select case what
		case SAY_HELLO, SAY_HI
			print "hello"
		case SAY_BYE, SAY_SEEYOU
			print "bye"
		end select
	end sub

	saySomething( SAY_HELLO )
	saySomething( SAY_BYE )

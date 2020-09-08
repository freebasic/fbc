#include once "trycatch.bi"

''to compile: fbc test.bas trycatch.bas

type MyException extends Exception
	declare constructor()
	something as integer = 1234
	declare operator cast() as string
end type

constructor MyException
	base("myexception")
end constructor

operator MyException.cast() as string
	operator = base.toString()
end operator

sub fun3()
	print "begin fun3"
	try
		print "Begin try3.1"
		try
			print "Begin try3.2"
			throw "bleh"
			print "End try3.2"
		catch ex as Exception
			print "fun3.2:" & *ex
			dim as integer ptr p = 0
			*p = 2
			throw "never executed"
		end_try
		print "End try3.1"
	catch ex as Exception
		print "fun3.1:" & *ex
	end_try
	
	print "end fun3"
end sub

sub fun2()
	print "begin fun2"
	try
		print "Begin try2"
		fun3()
		dim as integer ptr p = 0
		*p = 2
		print "End try2"
	catch ex as Exception
		print "fun2:" & *ex
		return
	end_try
	
	print "end fun2"
end sub


sub fun1()	
	print "begin fun1"

	try
		print "Begin try1"
		fun2()
		throw new MyException 
		throw "never executed"
		print "End try1"
	catch ex as MyException
		print "fun1:" & *ex
	catch ex as Exception
		print "fun1:" & *ex
	end_try

	print "end fun1"
end sub

fun1()

type foo
	declare destructor
	bar as byte
end type

destructor foo
	print "foo:desctructor"
end destructor

	try
		dim f as foo
		dim as integer ptr p = 0
		*p = 2
		'' NOTE: without proper stack unwinding the foo's destructor will never be called :/
	catch ex as exception
		print *ex
	end_try

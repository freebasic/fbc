''
'' All methods (except constructors) can be VIRTUAL,
'' allowing them to be overridden by a subclass at runtime
''

'' base class
type ClassA extends object
	declare virtual sub hello( )
end type

sub ClassA.hello( )
	print "hello from A"
end sub

'' subclass
type ClassB extends ClassA
	declare sub hello( )
end type

sub ClassB.hello( )
	print "hi from B"
end sub

'' tester, can be given any class object that subclasses ClassA
sub test( byval p as ClassA ptr )
	p->hello( )
end sub

	var a = new ClassA
	var b = new ClassB

	test( a )
	test( b )

	delete b
	delete a

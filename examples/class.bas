''
'' User defined types with constructor/destructor:
''

type MyClass
	as integer i
	declare constructor( )
	declare destructor( )
end type

constructor MyClass( )
	i = 123
end constructor

destructor MyClass( )
end destructor


dim as MyClass x
print "accessing stack object (DIM)... ", x.i

'' New/delete:
dim as MyClass ptr p = new MyClass( )
print "accessing heap object (NEW)... ", p->i
delete p

''
'' Inheritance
''

type MyChildClass extends MyClass
	declare constructor()
end type

constructor MyChildClass()
	this.i = 456
end constructor

dim as MyChildClass c
print "accessing base class... ", c.i

sleep

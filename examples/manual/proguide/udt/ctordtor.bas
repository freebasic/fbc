'' examples/manual/proguide/udt/ctordtor.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors and Destructors (basics)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsDtors
'' --------

Type foo
	'' Declare a default ctor, copy ctor and normal ctor
	Declare Constructor
	Declare Constructor (ByRef As foo)
	Declare Constructor (As Integer)

	'' Declare a destructor
	Declare Destructor

	ints As Integer Ptr
	numints As Integer
End Type

'' Define a constructor that creates 100 integers
Constructor foo
	ints = New Integer(100)
	numints = 100
End Constructor

'' Define a constructor that copies the integers from another object
Constructor foo (ByRef x As foo)
	ints = New Integer(x.numints)
	numints = x.numints
End Constructor

'' Define a constructor that creates some integers based on a parameter
Constructor foo (n As Integer)
	ints = New Integer(n)
	numints = n
End Constructor

'' Define a destructor that destroys those integers
Destructor foo
	Delete[] ints
End Destructor

Scope
	'' calls foo's default ctor
	Dim a As foo
	Dim x As foo Ptr = New foo

	'' calls foo's copy ctor
	Dim b As foo = a
	Dim y As foo Ptr = New foo(*x)

	'' calls foo's normal ctor
	Dim c As foo = foo(20)
	Dim z As foo Ptr = New foo(20)

	'' calls foo's dtor
	Delete x
	Delete y
	Delete z
End Scope '' <- a, b and c are destroyed here as well

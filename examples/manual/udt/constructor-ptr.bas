'' examples/manual/udt/constructor-ptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONSTRUCTOR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgConstructor
'' --------

Type MyObj
  Foo As Integer Ptr
  
	'' Constructor to create our integer, and set its value.
  Declare Constructor( ByVal DefVal As Integer = 0 )
	'' Destroy our integer on object deletion.
  Declare Destructor()
End Type

Constructor MyObj( ByVal DefVal As Integer = 0 )
  Print "Creating a new integer in MyObj!"
  Print "The Integer will have the value of: " & DefVal
  Print ""
  
	'' Create a pointer, and set its value to the one passed to the
	'' Constructor.
  This.Foo = New Integer
  *This.Foo = DefVal
End Constructor

Destructor MyObj()
  Print "Deleting our Integer in MyObj!"
  Print ""
  
	'' Delete the pointer we created in MyObj.
  Delete This.Foo
  This.Foo = 0
End Destructor


Scope
	'' Create a MyObj type object
	'' Send the value of '10' to the constructor
  Dim As MyObj Bar = 10
  
	'' See if the integer's been created.  Print its value.
  Print "The Value of our integer is: " & *Bar.Foo
  Print ""
  
  Sleep
End Scope
  '' We've just gone out of a scope.  The Destructor should be called now
  '' Because our objects are being deleted.
Sleep

'' examples/manual/udt/extends1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'EXTENDS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExtends
'' --------

Type SchoolMember 'Represents any school member'
	Declare Constructor ()
	Declare Sub Init (ByRef _name As String, ByVal _age As Integer)
	As String Name
	As Integer age
End Type

Constructor SchoolMember ()
	Print "Initialized SchoolMember"
End Constructor

Sub SchoolMember.Init (ByRef _name As String, ByVal _age As Integer)
	This.name = _name
	This.age = _age
	Print "Name: "; This.name; "   Age:"; This.age
End Sub


Type Teacher Extends SchoolMember 'Represents a teacher derived from SchoolMember'
	Declare Constructor (ByRef _name As String, ByVal _age As Integer, ByVal _salary As Integer)
	As Integer salary
	Declare Sub Tell ()
End Type

Constructor Teacher (ByRef _name As String, ByVal _age As Integer, ByVal _salary As Integer)
	Print "Initialized Teacher"
	This.Init(_name, _age) 'implicit access to base member procedure'
	This.salary = _salary
End Constructor

Sub Teacher.Tell ()
	Print "Salary:"; This.salary
End Sub


Type Student Extends SchoolMember 'Represents a student derived from SchoolMember'
	Declare Constructor (ByRef _name As String, ByVal _age As Integer, ByVal _marks As Integer)
	As Integer marks
	Declare Sub Tell ()
End Type

Constructor Student (ByRef _name As String, ByVal _age As Integer, ByVal _marks As Integer)
	Print "Initialized Student"
	This.Init(_name, _age) 'implicit access to base member procedure'
	This.marks = _marks
End Constructor
	
Sub Student.Tell ()
	Print "Marks:"; This.marks
End Sub


Dim As Teacher t = Teacher("Mrs. Shrividya", 40, 30000)
t.Tell()
Print
Dim As Student s = Student("Swaroop", 22, 75)
s.Tell()

'' examples/manual/proguide/opovld/smart-pointer-macro.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Overloading'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgOperatorOverloading
'' --------

#macro Define_SmartPointer (_UDTname_)

	Type SmartPointer_##_UDTname_
		Public:
			Declare Constructor (ByVal rhs As _UDTname_ Ptr)              '' to construct smart pointer
			'                                                                '' from _UDTname_ pointer,
			'                                                                '' with reference counter increment
			Declare Static Function returnCount () As Integer             '' to return reference counter value
			Declare Operator Cast () As _UDTname_ Ptr                     '' to cast private _UDTname_ pointer
			'                                                                '' to _UDTname_ pointer (read only)
			Declare Operator Cast () As String                            '' to cast private _UDTname_ pointer
			'                                                                '' to string (read only)
			Declare Destructor ()                                         '' to destroy smart pointer
			'                                                                '' and _UDTname_ object
			'                                                                '' with reference counter decrement
		Private:
			Dim As _UDTname_ Ptr p                                        '' private _UDTname_ pointer
			Static As Integer Count                                       '' private reference counter
			Declare Constructor ()                                        '' to disallow default-construction
			Declare Constructor (ByRef rhs As SmartPointer_##_UDTname_)   '' to disallow copy-construction
			Declare Operator Let (ByRef rhs As SmartPointer_##_UDTname_)  '' to disallow copy-assignment
	End Type
	Dim As Integer SmartPointer_##_UDTname_.Count = 0

	Constructor SmartPointer_##_UDTname_ (ByVal rhs As _UDTname_ Ptr)
		If rhs <> 0 Then
			This.p = rhs
			SmartPointer_##_UDTname_.count += 1
		End If
	End Constructor

	Static Function SmartPointer_##_UDTname_.returnCount () As Integer
		Return SmartPointer_##_UDTname_.count
	End Function

	Operator SmartPointer_##_UDTname_.Cast () As _UDTname_ Ptr
		Return This.p
	End Operator

	Operator SmartPointer_##_UDTname_.Cast () As String
		Return Str(This.p)
	End Operator

	Destructor SmartPointer_##_UDTname_ ()
		If This.p <> 0 Then
			Delete This.p
			SmartPointer_##_UDTname_.count -= 1
			This.p = 0
		End If
	End Destructor

	Operator * (ByRef sp As SmartPointer_##_UDTname_) ByRef As _UDTname_  '' operator '*' (return byref)
		'                                                                    '' to behave as pointer
		Return ByVal sp                                                   '' 'Return *sp' would induce an infinite loop
	End Operator

	Operator -> (ByRef sp As SmartPointer_##_UDTname_) ByRef As _UDTname_  '' operator '->' (return byref)
		'                                                                     '' to behave as pointer
		Return ByVal sp
	End Operator

#endmacro

'--------------------------------------------------------------------------------------------------------

' Example using all eight keywords of inheritance:
'   'Extends', 'Base.', 'Base()', 'Object', 'Is' operator, 'Virtual', 'Abstract', 'Override'

Type root Extends Object ' 'Extends' to activate RTTI by inheritance of predefined Object type
	Public:
		Declare Function ObjectHierarchy () As String
		Declare Function ObjectName () As String
		Declare Abstract Function ObjectRealType () As String  '' 'Abstract' declares function without local body
		'                                                         '' which must be overridden
		Declare Virtual Destructor ()                          '' 'Virtual' declares destructor
	Protected:
		Declare Constructor ()                                 '' to avoid default-construction from outside Types
		Declare Constructor (ByRef _name As String = "")       '' to avoid construction from outside Types
		Declare Constructor (ByRef rhs As root)                '' to avoid copy-construction from outside Types
		Declare Operator Let (ByRef rhs As root)               '' to avoid copy-assignment from outside Types
	Private:
		Dim Name As String
End Type                                                   '' derived type may be member data empty

Constructor root ()  '' only to avoid compile error (due to inheritance)
End Constructor

Constructor root (ByRef _name As String = "")              '' only to avoid compile error (due to inheritance)
	This.name = _name
	Print "root constructor:", This.name
End Constructor

Function root.ObjectHierarchy () As String
	Return "Object(forRTTI) <- root"
End Function

Function root.ObjectName () As String
	Return This.name
End Function

Virtual Destructor root ()
	Print "root destructor:", This.name
End Destructor

Operator root.Let (ByRef rhs As root)                      '' only to avoid compile error (due to onheritance)
End Operator


Type animal Extends root                                           '' 'Extends' to inherit of root
	Declare Constructor (ByRef _name As String = "")
	Declare Function ObjectHierarchy () As String
	Declare Virtual Function ObjectRealType () As String Override  '' 'Virtual' declares function with local
	'                                                              ''    body which can be overridden
	'                                                              '' 'Override' to check if the function is
	'                                                              ''    well an override
	Declare Virtual Destructor () Override                         '' 'Virtual' declares destructor with local body
	'                                                              '' 'Override' to check if the destructor is well an override
End Type

Constructor animal (ByRef _name As String = "")
	Base(_name)                                                    '' 'Base()' allows to call parent constructor
	Print "  animal constructor:", This.ObjectName()
End Constructor

Function animal.ObjectHierarchy () As String
	Return Base.ObjectHierarchy & " <- animal"                     '' 'Base.' allows to access to parent member function
End Function

Virtual Function animal.ObjectRealType () As String
	Return "animal"
End Function

Virtual Destructor animal ()
	Print "  animal destructor:", This.ObjectName()
End Destructor


Type dog Extends animal                                    '' 'Extends' to inherit of animal
	Declare Constructor (ByRef _name As String = "")
	Declare Function ObjectHierarchy () As String
	Declare Function ObjectRealType () As String Override  '' 'Override' to check if the function is well an
	'                                                      ''    override
	Declare Destructor () Override                         '' 'Override' to check if the destructor is well an override
End Type                                                   '' derived type may be member data empty

Constructor dog (ByRef _name As String = "")
	Base(_name)                                            '' 'Base()' allows to call parent constructor
	Print "    dog constructor:", This.ObjectName()
End Constructor

Function dog.ObjectHierarchy () As String
	Return Base.ObjectHierarchy & " <- dog"                '' 'Base.' allows to access to parent member function
End Function

Function dog.ObjectRealType () As String
	Return "dog"
End Function

Destructor dog ()
	Print "    dog destructor:", This.ObjectName()
End Destructor


Type cat Extends animal                                  '' 'Extends' to inherit of animal
	Declare Constructor (ByRef _name As String = "")
	Declare Function ObjectHierarchy () As String
	Declare Function ObjectRealType () As String Override  '' 'Override' to check if the function is well an
	'                                                      ''    override
	Declare Destructor () Override                         '' 'Override' to check if the destructor is well an override
End Type                                                   '' derived type may be member data empty

Constructor cat (ByRef _name As String = "")
	Base(_name)                                            '' 'Base()' allows to call parent constructor
	Print "    cat constructor:", This.ObjectName()
End Constructor

Function cat.ObjectHierarchy () As String
	Return Base.ObjectHierarchy & " <- cat"                '' 'Base.' allows to access to parent member function
End Function

Function cat.ObjectRealType () As String
	Return "cat"
End Function

Destructor cat ()
	Print "    cat destructor:", This.ObjectName()
End Destructor


Sub PrintInfo (ByVal p As root Ptr)                                       '' parameter is a 'root Ptr' or compatible (smart pointer)
	Print "  " & p->ObjectName, "  " & p->ObjectRealType, "           ";
	If *p Is dog Then                                                     '' 'Is' allows to check compatibility with type symbol
		Print  Cast(dog Ptr, p)->ObjectHierarchy
	ElseIf *p Is cat Then                                                 '' 'Is' allows to check compatibility with type symbol
		Print Cast(cat Ptr, p)->ObjectHierarchy
	ElseIf *p Is animal Then                                              '' 'Is' allows to check compatibility with type symbol
		Print Cast(animal Ptr, p)->ObjectHierarchy
	End If
End Sub


Define_SmartPointer(root)  '' smart pointer definition

Scope
	Print "reference counter value:"; SmartPointer_root.returnCount()
	Print
	Dim As SmartPointer_root sp(2) = {New animal("Mouse"), New dog("Buddy"), New cat("Tiger")}
	Print
	Print "reference counter value:"; SmartPointer_root.returnCount()
	For I As Integer = 0 To 2
		Print "  " & sp(I), sp(I)->ObjectName()
	Next I
	Print
	Print "Name:", "Object (real):         Hierarchy:"
	For I As Integer = 0 To 2
		PrintInfo(sp(I))
	Next I
	Print
End Scope
Print
Print "reference counter value:"; SmartPointer_root.returnCount()
Print

Sleep
			

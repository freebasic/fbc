'' examples/manual/proguide/init/udt.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Variable Initializers'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgInitialization
'' --------

Type UDT1
	Dim As Integer I
	Dim As Integer J
End Type

Dim As UDT1 u11 = (1, 2)                  '' default-construction + initialization
'Dim As UDT1 u12 = UDT1(1, 2)             '' not valid: no Constructor(As Integer, As Integer)
Dim As UDT1 u13 = Type<UDT1>(1, 2)        '' default-construction + initialization
Dim As UDT1 Ptr pu14 = New UDT1(1, 2)     '' default-construction + initialization
	Delete pu14
Dim ByRef As UDT1 ru15 = *New UDT1(1, 2)  '' default-construction + initialization
	Delete @ru15
   
Dim As UDT1 u16 = u13                     '' default copy-construction
'Dim As UDT1 u17 = UDT1(u13)              '' not valid: no implicit Constructor(As UDT1)
Dim As UDT1 u18 = Type<UDT1>(u13)         '' default-construction + initialization
Dim As UDT1 Ptr pu19 = New UDT1(u13)      '' default-construction + initialization
	Delete pu19
Dim ByRef As UDT1 ru110 = *New UDT1(u13)  '' default-construction + initialization
	Delete @ru110
Print



Type UDT2
	Dim As Integer I = Any
	Dim As Integer J
	Declare Constructor ()
	Declare Constructor (ByVal _I As Integer, ByVal _J As Integer)
End Type
Constructor UDT2 ()
	Print "UDT2.Constructor()"
End Constructor
Constructor UDT2 (ByVal _I As Integer, ByVal _J As Integer)
	Print "UDT2.Constructor(Byval As Integer, Byval As Integer)"
	This.I = _I
	This.J = _J
End Constructor

'Dim As UDT2 u21 = (1, 2)                  '' not valid: exist constructor (due at least to '= Any' initialiser)
Dim As UDT2 u22 = UDT2(1, 2)               '' call Constructor(As Integer, As Integer)
Dim As UDT2 u23 = Type<UDT2>(1, 2)         '' call Constructor(As Integer, As Integer)
Dim As UDT2 Ptr pu24 = New UDT2(1, 2)      '' call Constructor(As Integer, As Integer)
	Delete pu24
Dim ByRef As UDT2 ru25 = *New UDT2(1, 2)   '' call Constructor(As Integer, As Integer)
	Delete @ru25
   
Dim As UDT2 u26 = u23                      '' default copy-construction
'Dim As UDT2 u27 = UDT2(u23)               '' not valid: no implicit Constructor(As UDT2)
'Dim As UDT2 u28 = Type<UDT2>(u23)         '' not valid: no implicit Constructor(As UDT2)
'Dim As UDT2 Ptr pu29 = New UDT2(u23)      '' not valid: no implicit Constructor(As UDT2)
'Dim Byref As UDT2 ru210 = *New UDT2(u23)  '' not valid: no implicit Constructor(As UDT2)
Print



Type UDT3
	Dim As Integer I
	Dim As String S
	Declare Constructor ()
	Declare Constructor (ByVal _I As Integer, ByRef _S As Const String)
End Type
Constructor UDT3 ()
	Print "UDT3.Constructor()"
End Constructor
Constructor UDT3 (ByVal _I As Integer, ByRef _S As Const String)
	Print "UDT3.Constructor(Byval As Integer, Byref As Const String)"
	This.I = _I
	This.S = _S
End Constructor

'Dim As UDT3 u31 = (1, "2")                 '' not valid: exist constructor (due at least to string member)
Dim As UDT3 u32 = UDT3(1, "2")              '' call Constructor(As Integer, As String)
Dim As UDT3 u33 = Type<UDT3>(1, "2")        '' call Constructor(As Integer, As String)
Dim As UDT3 Ptr pu34 = New UDT3(1, "2")     '' call Constructor(As Integer, As String)
	Delete pu34
Dim ByRef As UDT3 ru35 = *New UDT3(1, "2")  '' call Constructor(As Integer, As String)
	Delete @ru35
   
Dim As UDT3 u36 = u33                       '' default copy-construction
Dim As UDT3 u37 = UDT3(u33)                 '' call implicit Constructor(As UDT3)
Dim As UDT3 u38 = Type<UDT3>(u33)           '' call implicit Constructor(As UDT3)
Dim As UDT3 Ptr pu39 = New UDT3(u33)        '' call implicit Constructor(As UDT3)
	Delete pu39
Dim ByRef As UDT3 ru310 = *New UDT3(u33)    '' call implicit Constructor(As UDT3)
	Delete @ru310
Print



Type UDT4 Extends Object
	Dim As Integer I
	Dim As Integer J
	Declare Constructor ()
	Declare Constructor (ByVal _I As Integer, ByVal _J As Integer)
End Type
Constructor UDT4 ()
	Print "UDT4.Constructor()"
End Constructor
Constructor UDT4 (ByVal _I As Integer, ByVal _J As Integer)
	Print "UDT4.Constructor(Byval As Integer, Byval As Integer)"
	This.I = _I
	This.J = _J
End Constructor

'Dim As UDT4 u41 = (1, 2)                 '' not valid: exist constructor (due at least to Object as base)
Dim As UDT4 u42 = UDT4(1, 2)              '' call Constructor(As Integer, As Integer)
Dim As UDT4 u43 = Type<UDT4>(1, 2)        '' call Constructor(As Integer, As Integer)
Dim As UDT4 Ptr pu44 = New UDT4(1, 2)     '' call Constructor(As Integer, As Integer)
	Delete pu44
Dim ByRef As UDT4 ru45 = *New UDT4(1, 2)  '' call Constructor(As Integer, As Integer)
	Delete @ru45
   
Dim As UDT4 u46 = u43                     '' default copy-construction
Dim As UDT4 u47 = UDT4(u43)               '' call implicit Constructor(As UDT4)
Dim As UDT4 u48 = Type<UDT4>(u43)         '' call implicit Constructor(As UDT4)
Dim As UDT4 Ptr pu49 = New UDT4(u43)      '' call implicit Constructor(As UDT4)
	Delete pu49
Dim ByRef As UDT4 ru410 = *New UDT4(u43)  '' call implicit Constructor(As UDT4)
	Delete @ru410
Print



' Note for static UDT declaration + initializer:
'    When the initializer expression calling the constructor has only one parameter 'x', example:
'    'Dim As UDT u = UDT(x)', in this case, 'UDT(x)' can be shortened into '(x)' or even 'x', like:
'    'Dim As UDT u = (x)' or even 'Dim As UDT u = x', but all these statements call the constructor.
'    (a constructor with one parameter is called a conversion-constructor)

' The six below declarations + initialisers all call only the conversion-constructor

Type UDT5
	Dim As Integer I
	Declare Constructor ()
	Declare Constructor (ByVal _I As Integer)
End Type
Constructor UDT5 ()
	Print "UDT5.Constructor()"
End Constructor
Constructor UDT5 (ByVal _I As Integer)
	Print "UDT5.Constructor(Byval As Integer)"
	This.I = _I
End Constructor

Dim As UDT5 u51 = UDT5(1)                  '' call Constructor(As Integer)
Dim As UDT5 u52 = Type<UDT5>(1)            '' call Constructor(As Integer)
Dim As UDT5 u53 = (1)                      '' call Constructor(As Integer)
Dim As UDT5 u54 = 1                        '' call Constructor(As Integer)
Dim As UDT5 Ptr pu55 = New UDT5(1)         '' call Constructor(As Integer)
	Delete pu55
Dim ByRef As UDT5 ru56 = *New UDT5(1)      '' call Constructor(As Integer)
	Delete @ru56
   
Dim As UDT5 u57 = u54                      '' default copy-construction
'Dim As UDT5 u58 = UDT5(u54)               '' not valid: no implicit Constructor(As UDT5)
'Dim As UDT5 u59 = Type<UDT5>(u54)         '' not valid: no implicit Constructor(As UDT5)
'Dim As UDT5 Ptr pu510 = New UDT5(u54)     '' not valid: no implicit Constructor(As UDT5)
'Dim Byref As UDT5 ru511 = *New UDT5(u54)  '' not valid: no implicit Constructor(As UDT5)
Print

Sleep
		

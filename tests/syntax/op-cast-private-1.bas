print "---"

Type TV
	Public:
		Dim As Integer I
		Declare Constructor()
	Private:
		Declare Operator Cast() As String
End Type

Constructor TV()
	Print "Constructor TV()"
End Constructor

Operator TV.Cast() As String
	Print "Operator TV.Cast() As String"
	Return " "
End operator

Type TU
	Public:
		Dim As Integer I
		Declare Constructor()
		'Declare Constructor(Byref v As TV)
		Declare Constructor(Byref s As String)
		Declare Constructor(Byref s As String, Byval i As Integer)
		'Declare Operator Let(Byref v As TV)
		Declare Operator Let(Byref s As String)
End Type

Constructor TU()
	Print "Constructor TU()"
End Constructor

'Constructor TU(Byref v As TV)
	'Print "Constructor TU(Byref As TV)"
'End constructor

Constructor TU(Byref s As String)
	Print "Constructor TU(Byref s As String)"
End Constructor

Constructor TU(Byref s As String, Byval i As Integer)
	Print "Constructor TU(Byref As String, Byval As Integer)"
End constructor

'Operator TU.Let(Byref v As TV)
	'Print "Operator TU.Let(Byref As TV)"
'End Operator

Operator TU.Let(Byref s As String)
	Print "Operator TU.Let(Byref As String)"
End Operator

Sub s(Byval u As TU)
End Sub

Function f1() As TU
	Dim As TV v
	#print "1 error for invalid return"
	Return v
End function

Function f2() As TU
	Dim As TV v
	#print "1 error for invalid return"
	Function = v
End function

Dim As TV v

#print "1 error for invalid data type"
Dim As TU u = v

#print "1 error for invalid assignment"
u = v

#print "1 error for type mismatch"
s(v)

f1()

f2()

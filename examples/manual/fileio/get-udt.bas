'' examples/manual/fileio/get-udt.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'GET (File I/O)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetfileio
'' --------

' 'THIS' can be used as argument for writing/filling all non-static data of an UDT instance to/from a file

Type UDT
	Dim As String * 32 s
	Dim As Double d
	Declare Sub Save(ByRef filename As String)
	Declare Sub Load(ByRef filename As String)
End Type

Sub UDT.Save(ByRef filename As String)
	Dim As Integer f
	f = FreeFile()
	Open filename For Binary As #f
	Put #f, , This  '' writes all non-static data of the UDT instance to the file
	Close #f
End Sub

Sub UDT.Load(ByRef filename As String)
	Dim As Integer f
	f = FreeFile()
	Open filename For Binary As #f
	Get #f, , This  '' fills all non-static data of the UDT instance from the file
	Close #f
End Sub

Dim As UDT u1
u1.s = "PI number"
u1.d = 3.14159
u1.Save("file.ext")

Dim As UDT u2
u2.Load("file.ext")
Print u2.s
Print u2.d

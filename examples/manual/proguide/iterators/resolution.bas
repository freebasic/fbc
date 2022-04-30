'' examples/manual/proguide/iterators/resolution.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Iterators'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeIterators
'' --------

Type screenResolution
	' user interface
		Declare Constructor (ByVal colorBit As Long)
		Declare Property colorDepth () As Long
		Declare Property screenWidth () As Long
		Declare Property screenHeigth () As Long
	' overload iteration operators when Step is not defined in For...Next statement
		Declare Operator For ()
		Declare Operator Next (ByRef iterateCondition As screenResolution) As Integer
		Declare Operator Step ()
	' internal variables
		Dim As Long colorBit, resolutionWH
End Type

Constructor screenResolution (ByVal colorBit As Long)
	This.colorBit = colorBit
End Constructor

Property screenResolution.colorDepth () As Long
	Return This.colorBit
End Property

Property screenResolution.screenWidth () As Long
	Return HiWord(This.resolutionWH)
End Property

Property screenResolution.screenHeigth () As Long
	Return LoWord(This.resolutionWH)
End Property

Operator screenResolution.For ()
	This.resolutionWH = ScreenList(This.colorBit)
End Operator

Operator screenResolution.Next (ByRef iterateCondition As screenResolution) As Integer
	While This.resolutionWH = 0
		If This.colorBit < iterateCondition.colorBit Then
			This.colorBit += 1
			This.resolutionWH = ScreenList(This.colorBit)
		Else
			Exit While
		End If
	Wend
	Return (This.resolutionWH <> iterateCondition.resolutionWH)
End Operator

Operator screenResolution.Step ()
	This.resolutionWH = ScreenList()
End Operator


Print "Screen resolutions supported within [1 bpp , 64 bpp]:"
For iterator As screenResolution = screenResolution(1) To screenResolution(64)
	Print "    " & iterator.colorDepth & " bpp ",
	Print ":" & iterator.screenWidth & "x" & iterator.screenHeigth
Next iterator
Print "End of supported screen resolutions"

Sleep
		

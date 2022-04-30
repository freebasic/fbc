'' examples/manual/hardware/out.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OUT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOut
'' --------

'speakersound.bas 
Sub Sound(ByVal freq As UInteger, dur As UInteger)
  Dim t As Double,f1 As Unsigned Short
	f1 = 1193181 \ freq
	Out &h61,Inp(&h61) Or 3
	Out &h43,&hb6
	Out &h42,LoByte(f1)
	Out &h42,HiByte(f1)
	t=Timer 
	While ((Timer - t) * 1000) < dur
	  Sleep 0,1
	Wend
	Out &h61,Inp(&h61) And &hfc
End Sub

Sound(523, 60)  'C5
Sound(587, 60)  'D5
Sound(659, 60)  'E5
Sound(698, 60)  'F5
Sound(784, 60)  'G5
Sound(880, 60)  'A5
Sound(988, 60)  'B5
Sound(1046, 60) 'C6 

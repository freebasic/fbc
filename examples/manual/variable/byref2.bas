'' examples/manual/variable/byref2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BYREF (variables)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefVariables
'' --------

'' Use reference allows to simplify expressions compared to pointer
'' (avoid to use operator '@' and especially '*')


Function fp () As ZString Ptr
	Static As ZString * 256 z
	Return @z
End Function

Dim As ZString Ptr pz = fp()
*pz = "FreeBASIC Zstring Ptr"
Print *pz
*pz &= " 1.3.0"
Print *pz


Print


Function fr () ByRef As ZString
	Static As ZString * 256 z
	Return z
End Function

Dim ByRef As ZString rz = fr()  '' or Var Byref rz = fr()
rz = "FreeBASIC Zstring Ref"
Print rz
rz &= " 1.4.0"
Print rz

Sleep
	

'' examples/manual/variable/var.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'VAR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVar
'' --------

Var a  = Cast(Byte, 0)
Var b  = Cast(Short, 0)
Var c  = Cast(Integer, 0)
Var d  = Cast(LongInt, 0)
Var au = Cast(UByte, 0)   
Var bu = Cast(UShort, 0)  
Var cu = Cast(UInteger, 0)
Var du = Cast(ULongInt, 0)
Var e  = Cast(Single, 0.0)
Var f  = Cast(Double, 0.0)
Var g  = @c      '' integer ptr
Var h  = @a      '' byte ptr
Var s2 = "hello" '' var-len string

Var ii = 6728   '' implicit integer
Var id = 6728.0 '' implicit double

Print "Byte: ";Len(a)
Print "Short: ";Len(b)
Print "Integer: ";Len(c)
Print "Longint: ";Len(d)
Print "UByte: ";Len(au)
Print "UShort: ";Len(bu)
Print "UInteger: ";Len(cu)
Print "ULongint: ";Len(du)
Print "Single: ";Len(e)
Print "Double: ";Len(f)
Print "Integer Pointer: ";Len(g)
Print "Byte Pointer: ";Len(h)
Print "Variable String: ";Len(s2)
Print
Print "Integer: ";Len(ii)
Print "Double: ";Len(id)

Sleep

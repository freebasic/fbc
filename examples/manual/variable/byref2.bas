'' examples/manual/variable/byref2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefVariables
'' --------

'' Use reference allows to simplify expressions compared to pointer
'' (avoid to use operator '@' and especially '*')


Dim As ZString Ptr pz = @"FreeBASIC Zstring Ptr"
Print *pz
*pz &= " 1.3.0"
Print *pz

Print

Dim ByRef As ZString rz = "FreeBASIC Zstring Ref"  '' or Var Byref rz = "FreeBASIC Zstring Ref"
Print rz
rz &= " 1.4.0"
Print rz

Sleep

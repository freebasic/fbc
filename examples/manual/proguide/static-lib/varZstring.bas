'' examples/manual/proguide/static-lib/varZstring.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgStaticLibraries
'' --------

'' library module: 'varZstring.bas'

#include "varZstring.bi"

Constructor varZstring (ByRef z As Const ZString)
	If This._p <> 0 Then
		Deallocate(This._p)
	End If
	This._allocated = Len(z) + 1
	This._p = CAllocate(This._allocated, SizeOf(ZString))
	*This._p = z
End Constructor

Operator varZstring.Cast () ByRef As ZString
	Return *This._p
End Operator

Operator varZstring.Let (ByRef z As Const ZString)
	If This._allocated < Len(z) + 1 Then
	Deallocate(This._p)
	This._allocated = Len(z) + 1
	This._p = CAllocate(This._allocated, SizeOf(ZString))
  End If
  *This._p = z
End Operator

Property varZstring.allocated () As Integer
	Return This._allocated
End Property

Destructor varZstring ()
	Deallocate(This._p)
	This._p = 0
End Destructor

Operator Len (ByRef v As varZstring) As Integer
	Return Len(Type<String>(v))  '' found nothing better than this
End Operator                     ''     (or: 'Return Len(Str(v))')
		

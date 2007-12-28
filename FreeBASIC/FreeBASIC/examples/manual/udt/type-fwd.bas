'' examples/manual/udt/type-fwd.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTypeAlias
'' --------

Type ParentFwd As Parent
Type Child
	Name As ZString * 32
	ParentRef As ParentFwd Ptr
	''...
End Type

Type Parent
	Name As ZString * 32
	ChildList(0 To 9) As Child
	''...
End Type

Dim p As Parent
p.Name = "Foo"
With p.ChildList(0)
	.Name = "Jr."
	.ParentRef = @p
	'' ...
End With	

With p.ChildList(0)
	Print .Name; " is child of "; .parentRef->Name
End With

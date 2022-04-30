'' examples/manual/udt/enum2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ENUM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgEnum
'' --------

Enum MyEnum
	option1 = 1
	option2
	option3
	__
	MAX_VALUE = __ -1
End Enum

Print "Option #1:", MyEnum.option1
Print "Option #2:", MyEnum.option2
Print "Option #3:", MyEnum.option3
Print "Max Value:", MyEnum.MAX_VALUE

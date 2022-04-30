'' examples/manual/proguide/numeric_types.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Numeric Types'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgNumericTypes
'' --------

Print Using "A  BYTE     is ##"; SizeOf(Byte)     * 8; : Print "-bit"
Print Using "A  SHORT    is ##"; SizeOf(Short)    * 8; : Print "-bit"
Print Using "A  LONG     is ##"; SizeOf(Long)     * 8; : Print "-bit"
Print Using "An INTEGER  is ##"; SizeOf(Integer)  * 8; : Print "-bit"
Print Using "A  LONGINT  is ##"; SizeOf(LongInt)  * 8; : Print "-bit"
Print Using "An UBYTE    is ##"; SizeOf(UByte)    * 8; : Print "-bit"
Print Using "An USHORT   is ##"; SizeOf(UShort)   * 8; : Print "-bit"
Print Using "An ULONG    is ##"; SizeOf(ULong)    * 8; : Print "-bit"
Print Using "An UINTEGER is ##"; SizeOf(UInteger) * 8; : Print "-bit"
Print Using "An ULONGINT is ##"; SizeOf(ULongInt) * 8; : Print "-bit"
Print
Print Using "A  SINGLE   is ##"; SizeOf(Single)   * 8; : Print "-bit"
Print Using "A  DOUBLE   is ##"; SizeOf(Double)   * 8; : Print "-bit"
Print
Enum myENUM : option1 = 1 : option2 : End Enum
Print Using "An ENUM     is ##"; SizeOf(myENUM)   * 8; : Print "-bit"
Print
Print Using "A  BOOLEAN  is ##"; SizeOf(Boolean)  * 8; : Print "-bit"
Print
Print Using "A  POINTER  is ##"; SizeOf(Any Ptr)  * 8; : Print "-bit"

Sleep
		

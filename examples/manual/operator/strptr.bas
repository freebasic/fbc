'' examples/manual/operator/strptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator STRPTR (String pointer)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpStrptr
'' --------

'' This example uses Strptr to demonstrate using pointers with strings
Dim myString As String
Dim toMyStringDesc As Any Ptr
Dim toMyString As ZString Ptr

'' Note that using standard VARPTR notation will return a pointer to the
'' descriptor, not the string data itself
myString = "Improper method for Strings"
toMyStringDesc = @myString
Print myString
Print Hex( toMyStringDesc )
Print

'' However, using Strptr returns the proper pointer
myString = "Hello World Examples Are Silly"
toMyString = StrPtr(myString)
Print myString
Print *toMyString
Print

'' And the pointer acts like pointers to other types
myString = "MyString has now changed"
Print myString
Print *toMyString
Print

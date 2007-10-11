'' examples/manual/operator/strptr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpStrptr
'' --------

'' This example uses Strptr to demonstrate using pointers with strings
Dim myString As String
Dim toMyStringDesc as any ptr
Dim toMyString As ZString Ptr

'' Note that using standard VARPTR notation will return a pointer to the
'' descriptor, not the string data itself
myString = "Improper method for Strings"
toMyStringDesc = @myString
Print myString
Print hex( toMyStringDesc )
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

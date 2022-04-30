'' examples/manual/udt/union1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'UNION'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUnion
'' --------

' Example 1: Only one union member can be relevantly accessed at a time
Union member
  username As String * 32
  posts As ULong
End Union

Dim As member userX
userX.username = "Samantha"
userX.posts = 1234

Print userX.username  ' value of username corrupted because final value assigned to posts occupies same memory location
'                     ' (and this is reason that value of posts is displayed well)
Print userX.posts
Print

Dim As member userY
userY.posts = 4321
userY.username = "Alexander"

Print userY.username
Print userY.posts  ' value of posts corrupted because final value assigned to username occupies same memory location
'                  ' (and this is reason that value of username is displayed well)
Print

Sleep

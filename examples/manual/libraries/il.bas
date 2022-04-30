'' examples/manual/libraries/il.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DevIL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibIL
'' --------

'' DevIL example

#include Once "IL/il.bi"

'' Version check
If (ilGetInteger(IL_VERSION_NUM) < IL_VERSION) Then
	Print "DevIL version is different"
	End 1
End If

'' Good practice to explicitely initialize it
ilInit()

'' Load a bitmap
Dim As ILuint fblogo
ilGenImages(1, @fblogo)
ilBindImage(fblogo)

Print "Loading fblogo.bmp..."
ilLoadImage("fblogo.bmp")

'' Save a copy
Print "Saving a copy, fblogo-copy.bmp..."
ilEnable(IL_FILE_OVERWRITE)
ilSaveImage("fblogo-copy.bmp")

'' Clean up
ilDeleteImages(1, @fblogo)

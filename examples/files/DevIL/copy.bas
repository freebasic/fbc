'' DevIL example

#include once "IL/il.bi"

'' Version check
If (ilGetInteger(IL_VERSION_NUM) < IL_VERSION) Then
    Print "DevIL version is different" : Sleep : End 1
End If

'' Good practice to explicitely initialize it
ilInit()

dim as string filename = exepath() & "/../../fblogo.bmp"

'' Load a bitmap
Print "Loading '" & filename & "'..."
Dim As ILuint fblogo
ilGenImages(1, @fblogo)
ilBindImage(fblogo)
ilLoadImage(filename)

'' Save a copy
Print "Saving a copy, fblogo-copy.bmp..."
ilEnable(IL_FILE_OVERWRITE)
ilSaveImage("fblogo-copy.bmp")

'' Clean up
ilDeleteImages(1, @fblogo)

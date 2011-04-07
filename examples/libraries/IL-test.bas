'' DevIL/ILU/ILUT test

#include once "IL/il.bi"
#include once "IL/ilu.bi"

'' FB has no ILUT headers, but this one function is enough to test the ILUT.dll
#inclib "ILUT"
#define ILUT_VERSION        167
#define ILUT_VERSION_NUM    IL_VERSION_NUM
extern "c"
declare function ilutGetInteger(byval Mode as ILenum) as ILint
end extern

'' Version check
if ((  ilGetInteger(  IL_VERSION_NUM) <   IL_VERSION) orelse _
    ( iluGetInteger( ILU_VERSION_NUM) <  ILU_VERSION) orelse _
    (ilutGetInteger(ILUT_VERSION_NUM) < ILUT_VERSION)) then
    print "DevIL version is different"
    end 1
end if

'' Good practice to explicitely initialize it
ilInit()

'' Load a bitmap
dim as ILuint fblogo
ilGenImages(1, @fblogo)
ilBindImage(fblogo)
ilLoadImage("fblogo.bmp")

'' Save a copy
ilEnable(IL_FILE_OVERWRITE)
ilSaveImage("fblogo-copy.bmp")

'' Clean up
ilDeleteImages(1, @fblogo)


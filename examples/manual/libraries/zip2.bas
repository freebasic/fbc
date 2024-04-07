'' examples/manual/libraries/zip2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'libzip'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibZip
'' --------

'' .zip packing using libzip
#include "zip.bi"

Sub zipAddFileFromString(ByVal fname As ZString Ptr, ByVal id_d As ZString Ptr, ByVal myData As ZString Ptr)
	Dim As Any Ptr pzo
	Dim As Any Ptr pzsb
   
	pzo = zip_open(fname, ZIP_CREATE, 0)
	If pzo = 0 Then End
   
	pzsb = zip_source_buffer(pzo, myData, Len(*myData), 0)
	If pzsb = 0 Then End
   
	zip_file_add(pzo, id_d, pzsb, ZIP_FL_OVERWRITE)
	zip_close(pzo)
   
	Print "OK"
End Sub

Dim As String mytext, myzipfile, myfile

myText    = "<My text           >......6...3..2"
myZipFile = "26.zip"
myFile    = "file3.txt"

zipAddFileFromString(myZipFile, myFile, myText)

myFile    = "BIMBO/file3.txt"
zipAddFileFromString(myZipFile, myFile, myText)

Sleep

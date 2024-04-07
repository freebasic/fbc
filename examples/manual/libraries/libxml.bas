'' examples/manual/libraries/libxml.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'libxml2'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLiblibxml
'' --------

#include Once "libxml/xmlreader.bi"
#define NULL 0

Dim As String filename = Command(1)
If( Len( filename ) = 0 ) Then
	Print "Usage: libxml filename"
	End 1
End If

Dim As xmlTextReaderPtr reader = xmlReaderForFile( filename, NULL, 0 )
If (reader = NULL) Then
	Print "Unable to open "; filename
	End 1
End If

Dim As Integer ret = xmlTextReaderRead( reader )
Do While( ret = 1 )
	Dim As Const ZString Ptr constname = xmlTextReaderConstName( reader )
	Dim As Const ZString Ptr value = xmlTextReaderConstValue( reader )

	Print xmlTextReaderDepth( reader ); _
		xmlTextReaderNodeType( reader ); _
		" "; *constname; _
		xmlTextReaderIsEmptyElement(reader); _
		xmlTextReaderHasValue( reader ); _
		*value

	ret = xmlTextReaderRead( reader )
Loop

xmlFreeTextReader( reader )

If( ret <> 0 ) Then
	Print "failed to parse: "; filename
End If

xmlCleanupParser( )
xmlMemoryDump()

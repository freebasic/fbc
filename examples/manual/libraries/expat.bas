'' examples/manual/libraries/expat.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Expat'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibexpat
'' --------

'' XML file parser command line tool based on libexpat

'' Can use zstring or wstring (libexpat or libexpatw):
'#define XML_UNICODE

#include Once "expat.bi"
#include Once "crt/mem.bi"

#ifndef False
#define False 0
#endif
#define NULL 0

Const BUFFER_SIZE = 1024

Type Context
	As Integer nesting
	As XML_char * (BUFFER_SIZE+1) text
	As Integer textlength
End Type

Dim Shared As Context ctx

'' Callback called by libexpat when begin of XML tag is found
Sub elementBegin cdecl _
	( _
		ByVal userdata As Any Ptr, _
		ByVal element As Const XML_char Ptr, _
		ByVal attributes As Const XML_char Ptr Ptr _
	)

	'' Show its name
	Print Space(ctx.nesting);*element;

	'' and its attributes (attributes are given as an array of XML_char pointers
	'' much like argv, for each attribute there will apparently be the one
	'' element representing the name and a second element representing the
	'' specified value)
	While (*attributes)
		Print " ";**attributes;
		attributes += 1
		Print "='";**attributes;"'";
		attributes += 1
	Wend
	Print

	ctx.nesting += 1
	ctx.text[0] = 0
	ctx.textlength = 0
End Sub

'' Callback called by libexpat when end of XML tag is found
Sub elementEnd cdecl(ByVal userdata As Any Ptr, ByVal element As Const XML_char Ptr)
	'' Show text collected in charData() callback below
	Print Space(ctx.nesting);ctx.text
	ctx.text[0] = 0
	ctx.textlength = 0
	ctx.nesting -= 1
End Sub

Sub charData cdecl _
	( _
		ByVal userdata As Any Ptr, _
		ByVal chars As Const XML_char Ptr, _  '' Note: not null-terminated
		ByVal length As Integer _
	)

	'' This callback will apparently recieve every data between xml tags
	'' (really?), including newlines and space.

	'' Append to our buffer, if there still is free room, so we can print it out later
	If (length <= (BUFFER_SIZE - ctx.textlength)) Then
		memcpy(@ctx.text[ctx.textlength], @chars[0], length * SizeOf(XML_char))
		ctx.textlength += length
		ctx.text[ctx.textlength] = 0
	End If
End Sub

''
'' Main
''

	Dim As String filename = Command(1)
	If (Len(filename) = 0) Then
		Print "Usage: expat <xmlfilename>"
		End 1
	End If

	Dim As XML_Parser parser = XML_ParserCreate(NULL)
	If (parser = NULL) Then
		Print "XML_ParserCreate failed"
		End 1
	End If

	''XML_SetUserData(parser, userdata_pointer)
	XML_SetElementHandler(parser, @elementBegin, @elementEnd)
	XML_SetCharacterDataHandler(parser, @charData)


	If (Open(filename, For Input, As #1)) Then
		Print "Could not open file: '";filename;"'"
		End 1
	End If

	Static As UByte buffer(0 To (BUFFER_SIZE-1))

	Dim As Integer reached_eof = False
	Do
		Dim As Integer size = BUFFER_SIZE
		Dim As Integer result = Get(#1, , buffer(0), size, size)
		If (result Or (size <= 0)) Then
			Print "File input error"
			End 1
		End If

		reached_eof = (EOF(1) <> False)

		If (XML_Parse(parser, @buffer(0), size, reached_eof) = False) Then
			Print filename & "(" & XML_GetCurrentLineNumber(parser) & "): Error from XML parser: "
			Print *XML_ErrorString(XML_GetErrorCode(parser))
			End 1
		End If
	Loop While (reached_eof = False)

	XML_ParserFree(parser)

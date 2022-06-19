'' examples/manual/defines/fbiif.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_IIF__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbiif
'' --------

' From the example of the '#ELSE' documentation page:
	'#DEFINE MODULE_VERSION 1
	'Dim a As String
	'#IF (MODULE_VERSION > 0)
	'    a = "Release"
	'#ELSE
	'    a = "Beta"
	'#ENDIF
	'Print "Program is "; a

' Simpler code using '__FB_IIF__':
	#define MODULE_VERSION 1
	Dim a As String
	a = __FB_IIF__( MODULE_VERSION > 0, "Release", "Beta" )
	Print "Program is "; a

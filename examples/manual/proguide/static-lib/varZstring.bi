'' examples/manual/proguide/static-lib/varZstring.bi
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Static Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgStaticLibraries
'' --------

'' header file: 'varZstring.bi'

Type varZstring Extends ZString
	Public:
		Declare Constructor (ByRef z As Const ZString)
		Declare Operator Cast () ByRef As ZString
		Declare Operator Let (ByRef z As Const ZString)
		Declare Property allocated () As Integer
		Declare Destructor ()
	Private:
		Dim As ZString Ptr _p
		Dim As UInteger _allocated
End Type

Declare Operator Len (ByRef v As varZstring) As Integer  '' mandatory for the user code to call
														 ''    the overload Len operator and
														 ''    not the prebuilt-in Len operator
		

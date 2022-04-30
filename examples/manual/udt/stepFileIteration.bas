'' examples/manual/udt/stepFileIteration.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Step (Iteration)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpStep
'' --------

'' a class which iterates through files
Type FileIter
	As String pathName, fileName
	Declare Constructor( ByRef pathName As String )

	Declare Operator For()
	Declare Operator Step()
	Declare Operator Next( ByRef endCond As FileIter) As Integer
End Type

Constructor FileIter( ByRef pathName As String )   
	this.pathName = pathName
End Constructor

Operator FileIter.for( )   
	fileName = Dir(pathName & "/*.*")   
End Operator

Operator FileIter.step( )   
	fileName = Dir("")
End Operator

Operator FileIter.next( ByRef endCond As FileIter ) As Integer
	Return(fileName <> endCond.pathName)   
	'' the c'tor sets the path name and so we check against that
End Operator

'' example code
'' change it to any directory
For i As FileIter = "./" To ""
	Print i.fileName
Next
	

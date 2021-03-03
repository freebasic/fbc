Namespace One
    Namespace Two
        Type IntegerHolder
        Dim num As Integer
	Declare Constructor
	Declare Constructor(ByVal val As Long)
	Declare Operator Let(ByVal val As Long)
        End Type
	Private Constructor IntegerHolder
		num = 0
	End Constructor
	Private Constructor IntegerHolder(ByVal val As Long)
		num = val
	End Constructor
        Private Operator =(ByRef cv1 As IntegerHolder, ByRef cv2 As IntegerHolder) As Boolean
		'' Equality operator required for most containers
		Return (cv1.num = cv2.num)
        End Operator
	Private Operator IntegerHolder.Let(ByVal val As Long)
		num = val
	End Operator
    End Namespace
End Namespace

FBCont_DefineIIteratorOf(Long)

Type SequentialLongGenerator extends FB_IIterator(Long)
	Private:
		Dim numToGenerate As Long
		Dim soFar As Long
		Dim firstVal As Long

	Public:
		Declare Constructor(ByVal howMany as Long, ByVal startPoint As Long)
		Declare Function Advance() As Boolean Override
		Declare Function Item() ByRef As Long Override
		Declare Sub Reset() Override
		Declare Sub Skip(byVal howMany As Long)
End Type

Private Constructor SequentialLongGenerator(ByVal howMany As Long, ByVal startPoint As Long)
	numToGenerate = howMany
	firstVal = startPoint
	Reset()
End Constructor

Private Function SequentialLongGenerator.Advance() As Boolean
	soFar += 1
	Return soFar < (firstVal + numToGenerate)
End Function

Private Function SequentialLongGenerator.Item() ByRef As Long
	Return soFar
End Function

Private Sub SequentialLongGenerator.Reset()
	soFar = firstVal - 1
End Sub

Private Sub SequentialLongGenerator.Skip(byVal howMany As Long)
	soFar += howMany
End Sub

FBCont_DefineIIteratorOf(One, Two, IntegerHolder)

Type SequentialIntegerHolderGenerator extends FB_IIterator(One, Two, IntegerHolder)
	Private:
		Dim numToGenerate As Long
		Dim soFar As Long
		Dim firstVal As Integer
		dim tempObj As One.Two.IntegerHolder

	Public:
		Declare Constructor(ByVal howMany as Long, ByVal startPoint As Integer)
		Declare Function Advance() As Boolean Override
		Declare Function Item() ByRef As One.Two.IntegerHolder Override
		Declare Sub Reset() Override
		Declare Sub Skip(byVal howMany As Long)
End Type

Private Constructor SequentialIntegerHolderGenerator(ByVal howMany As Long, ByVal startPoint As Integer)
	numToGenerate = howMany
	firstVal = startPoint
	Reset()
End Constructor

Private Function SequentialIntegerHolderGenerator.Advance() As Boolean
	soFar += 1
	Return soFar < (firstVal + numToGenerate)
End Function

Private Function SequentialIntegerHolderGenerator.Item() ByRef As One.Two.IntegerHolder
	tempObj.num = soFar
	Return tempObj
End Function

Private Sub SequentialIntegerHolderGenerator.Reset()
	soFar = firstVal - 1
End Sub

Private Sub SequentialIntegerHolderGenerator.Skip(byVal howMany As Long)
	soFar += howMany
End Sub

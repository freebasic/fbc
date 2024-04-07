'' examples/manual/proguide/recursion_iteration/DynamicUserStackTypeCreateMacro.bi
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

'' save as file: "DynamicUserStackTypeCreateMacro.bi"

#macro DynamicUserStackTypeCreate(typename, datatype)

	Type typename
		Public:
			Declare Constructor ()                       '' pre-allocating user stack memory
			Declare Property push (ByRef i As datatype)  '' pushing on the user stack
			Declare Property pop () ByRef As datatype    '' popping from the user stack
			Declare Property used () As Integer          '' outputting number of used elements in the user stack
			Declare Property allocated () As Integer     '' outputting number of allocated elements in the user stack
			Declare Destructor ()                        '' deallocating user stack memory
		Private:
			Dim As datatype ae (Any)  '' array of elements
			Dim As Integer nue        '' number of used elements
			Dim As Integer nae        '' number of allocated elements
			Dim As Integer nae0       '' minimum number of allocated elements
	End Type

	Constructor typename ()
		This.nae0 = 2^Int(Log(1024 * 1024 / SizeOf(datatype)) / Log(2) + 1) '' only a power of 2 (1 MB < stack memory < 2 MB here)
		This.nue = 0
		This.nae = This.nae0
		ReDim This.ae(This.nae - 1)                                         '' pre-allocating user stack memory
	End Constructor

	Property typename.push (ByRef i As datatype)  '' pushing on the user stack
		This.nue += 1
		If This.nue > This.nae0 And This.nae < This.nue * 2 Then
			This.nae *= 2
			ReDim Preserve This.ae(This.nae - 1)  '' allocating user stack memory for double used elements at least
		End If
		This.ae(This.nue - 1) = i
	End Property

	Property typename.pop () ByRef As datatype  '' popping from the user stack
		If This.nue > 0 Then
			Property = This.ae(This.nue - 1)
			This.nue -= 1
			If This.nue > This.nae0 And This.nae > This.nue * 2 Then
				This.nae \= 2
				ReDim Preserve This.ae(This.nae - 1)  '' allocating user stack memory for double used elements at more
			End If
		Else
			Static As datatype d
			Dim As datatype d0
			d = d0
			Property = d
			AssertWarn(This.nue > 0)  '' warning if popping while empty user stack and debug mode (-g compiler option)
		End If
	End Property

	Property typename.used () As Integer  '' outputting number of used elements in the user stack
		Property = This.nue
	End Property

	Property typename.allocated () As Integer  '' outputting number of allocated elements in the user stack
		Property = This.nae
	End Property

	Destructor typename  '' deallocating user stack memory
		This.nue = 0
		This.nae = 0
		Erase This.ae  '' deallocating user stack memory
	End Destructor

#endmacro
		

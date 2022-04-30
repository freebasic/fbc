'' examples/manual/proguide/compare_all_rtti_info.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OBJECT built-in and RTTI info'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgObjectRtti
'' --------

Namespace oop
	Type parent Extends Object
	End Type

	Type child Extends parent
	End Type

	Type grandchild Extends child
	End Type
End Namespace

Function mangledTypeNameFromRTTI (ByVal po As Object Ptr, ByVal baseIndex As Integer = 0) As String
	' Function to get any mangled-typename in the inheritance up hierarchy
	' of the type of an instance (address: 'po') compatible with the built-in 'Object'
	'
	' ('baseIndex =  0' to get the mangled-typename of the instance)
	' ('baseIndex = -1' to get the base mangled-typename of the instance, or "" if not existing)
	' ('baseIndex = -2' to get the base.base mangled-typename of the instance, or "" if not existing)
	' (.....)
	'
		Dim As String s
		Dim As ZString Ptr pz
		Dim As Any Ptr p = CPtr(Any Ptr Ptr Ptr, po)[0][-1]  ' Ptr to RTTI info
		For I As Integer = baseIndex To -1
			p = CPtr(Any Ptr Ptr, p)[2]                      ' Ptr to Base RTTI info of previous RTTI info
			If p = 0 Then Return s
		Next I
		pz = CPtr(Any Ptr Ptr, p)[1]                         ' Ptr to mangled-typename
		s = *pz
		Return s
End Function

Function typeNameFromRTTI (ByVal po As Object Ptr, ByVal baseIndex As Integer = 0) As String
	' Function to get any typename in the inheritance up hierarchy
	' of the type of an instance (address: 'po') compatible with the built-in 'Object'
	'
	' ('baseIndex =  0' to get the typename of the instance)
	' ('baseIndex = -1' to get the base.typename of the instance, or "" if not existing)
	' ('baseIndex = -2' to get the base.base.typename of the instance, or "" if not existing)
	' (.....)
	'
		Dim As String s
		Dim As ZString Ptr pz
		Dim As Any Ptr p = CPtr(Any Ptr Ptr Ptr, po)[0][-1]          ' Ptr to RTTI info
		For I As Integer = baseIndex To -1
			p = CPtr(Any Ptr Ptr, p)[2]                              ' Ptr to Base RTTI info of previous RTTI info
			If p = 0 Then Return s
		Next I
		pz = CPtr(Any Ptr Ptr, p)[1]                                 ' Ptr to mangled-typename
		Do
			Do While (*pz)[0] > Asc("9") OrElse (*pz)[0] < Asc("0")
				If (*pz)[0] = 0 Then Return s
				pz += 1
			Loop
			Dim As Integer N = Val(*pz)
			Do
				pz += 1
			Loop Until (*pz)[0] > Asc("9") OrElse (*pz)[0] < Asc("0")
			If s <> "" Then s &= "."
			s &= Left(*pz, N)
			pz += N
		Loop
End Function

Function typeNameHierarchyFromRTTI (ByVal po As Object Ptr) As String
	' Function to get the typename inheritance up hierarchy
	' of the type of an instance (address: po) compatible with the built-in 'Object'
	'
		Dim As String s = TypeNameFromRTTI(po)
		Dim As Integer i = -1
		Do
			Dim As String s0 = typeNameFromRTTI(po, i)
			If s0 = "" Then Exit Do
			s &= "->" & s0
			i -= 1
		Loop
		Return s
End Function

Function typeNameEqualFromRTTI (ByVal po As Object Ptr, ByRef typeName As String) As Boolean
	' Function to get true if the instance typename (address: po) is the same than the passed string
	'
		Dim As String t = UCase(typeName)
		Dim As ZString Ptr pz = CPtr(Any Ptr Ptr Ptr Ptr, po)[0][-1][1] ' Ptr to Mangled Typename
		Dim As Integer i = 1
		Do
			Do While (*pz)[0] > Asc("9") OrElse (*pz)[0] < Asc("0")
				If (*pz)[0] = 0 Then Return True
				pz += 1
			Loop
			Dim As Integer N = Val(*pz)
			Do
				pz += 1
			Loop Until (*pz)[0] > Asc("9") OrElse (*pz)[0] < Asc("0")
			If i > 1 Then
				If Mid(t, i, 1) <> "." Then Return False Else i += 1
			End If
			If Mid(t, i, N) <> Left(*pz, N) Then Return False Else pz += N : i += N
		Loop
End Function

Dim As Object Ptr p = New oop.grandchild

Print "Mangled typenames list, from RTTI info:"
Print "  " & mangledTypeNameFromRTTI(p, 0)
Print "  " & mangledTypeNameFromRTTI(p, -1)
Print "  " & mangledTypeNameFromRTTI(p, -2)
Print "  " & mangledTypeNameFromRTTI(p, -3)
Print
Print "Typenames (demangled) list, from RTTI info:"
Print "  " & typeNameFromRTTI(p, 0)
Print "  " & typeNameFromRTTI(p, -1)
Print "  " & typeNameFromRTTI(p, -2)
Print "  " & typeNameFromRTTI(p, -3)
Print
Print "Typename (demangled) and all those of its base-types hierarchy, from RTTI info:"
Print "  " & typeNameHierarchyFromRTTI(p)
Delete p
Print
p = New oop.child
Print "Is the typename of an oop.child instance the same as ""child""?"
Print "  " & typeNameEqualFromRTTI(p, "child")
Print "Is the typename of an oop.child instance the same as ""oop.child""?"
Print "  " & typeNameEqualFromRTTI(p, "oop.child")
Print "Is the typename of an oop.child instance the same as ""oop.grandchild""?"
Print "  " & typeNameEqualFromRTTI(p, "oop.grandchild")
Print "Is the typename of an oop.child instance the same as ""oop.parent""?"
Print "  " & typeNameEqualFromRTTI(p, "oop.parent")
Delete p

Sleep
			

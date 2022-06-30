#include once "_typemacros.bi"
#include once "_helpers.bi"
#include once "ilist.bi"
#include once "listiterator.bi"

#pragma once

'' Defines a contiguous resizeable array container like a C++ vector
'' or a C#/Java/Python list

#macro __CONT_DefineListOf_(FBType, PPType)

__CONT_DefineIListOf_(FBType, PPType)
__CONT_DefineListIteratorOf_(FBType, PPType)

#define _ListType				__FB_JOIN__(List, PPType)
#define _ListIteratorType		__FB_JOIN__(ListIterator, PPType)
#define _ListInterfaceType		__FB_JOIN__(IList, PPType)
#define _ContainerInterfaceType __FB_JOIN__(IContainer, PPType)
#define _IteratorInterfaceType	__FB_JOIN__(IIterator, PPType)
#define _TypeDefine()			__FB_JOIN__(__CONT_, __FB_JOIN__(_ListType, _DEFINED))
__FB_DefinePassType(FBType, _PassType)

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _ListType)
#endif

#define _Min(x, y) (IIf(x < y, x, y))

Type _ListType extends _ListInterfaceType
Private:
    Dim _objects(Any) As FBType
    Dim _count As Long

    Declare Sub _AddOrInsert( _
        newData() As FBType, _
        ByVal start As Long, _ 
        ByVal howMany As Long, _ 
        ByVal where As Long _
    )

Public:
    Declare Constructor
    Declare Constructor(initialCapacity As Long)
    Declare Constructor(Byref copy As _ListType)
    Declare Constructor(ByRef iterator As _IteratorInterfaceType)
    Declare Constructor(ByVal iterator As _IteratorInterfaceType Ptr)
    Declare Constructor(newData() As FBType)
    Declare Constructor(ByRef objects As _ContainerInterfaceType)
    Declare Constructor(ByVal objects As _ContainerInterfaceType Ptr)
    
    Declare Sub Add(_PassType newData As FBType) Override
    Declare Sub Add(newData() As FBType)
    Declare Sub Add(newData() As FBType, ByVal start As Long, ByVal howMany As Long)
    Declare Sub Add(ByRef newData As _ContainerInterfaceType)
    Declare Sub Add(ByRef newData As _IteratorInterfaceType)
    Declare Sub Add(ByVal newData As _ContainerInterfaceType Ptr)
    Declare Sub Add(ByVal newData As _IteratorInterfaceType Ptr)
    Declare Sub Clear() Override
    Declare Function Contains(_PassType data As FBType) As Boolean Override
    Declare Sub CopyTo(data() As FBType) Override
    Declare Sub CopyTo(data() As FBType, ByVal listStart As Long, ByVal listCount As Long, ByVal arrayStart As Long)
    Declare Function Empty() As Boolean
    Declare Function First() ByRef As FBType Override
    Declare Function GetIterator() As _IteratorInterfaceType Ptr Override
    Declare Function IndexOf(_PassType needle As FBType) As Long Override
    Declare Sub Insert(ByVal index As Long, _PassType newData As FBType) Override
    Declare Sub Insert(ByVal index As Long, newData() As FBType)
    Declare Sub Insert(ByVal index As Long, newData() As FBType, ByVal newDataStart As Long, ByVal howMany As Long)
    Declare Sub Insert(ByVal index As Long, ByVal newData As _ContainerInterfaceType Ptr)
    Declare Sub Insert(ByVal index As Long, ByRef newData As _ContainerInterfaceType)
    Declare Sub Insert(ByVal index As Long, ByVal newData As _IteratorInterfaceType Ptr)
    Declare Sub Insert(ByVal index As Long, ByRef newData As _IteratorInterfaceType)
    Declare Function Last() ByRef As FBType Override
    Declare Function LastIndexOf(_PassType needle As FBType) As Long Override
    Declare Sub Remove(_PassType item As FBType) Override
    Declare Sub RemoveAt(ByVal index As Long) Override
    Declare Sub RemoveSpan(ByVal index As Long, ByVal count As Long)
    Declare Sub Resize(ByVal newSize As Long)
    Declare Sub Reserve(ByVal newSize As Long)
    
    Declare Property Count() As Long Override
    Declare Property Capacity() As Long
    
    Declare Operator [] (ByVal index AS Long) ByRef As FBType Override
    Declare Operator +=(_PassType newData AS FBType)
    '' Also Operator Len()
    
#ifdef FB_CONTAINER_DEBUG
    Declare Sub PrintContainer() Override
#endif

End Type

Private Constructor _ListType()
    Constructor(16)
End Constructor

Private Constructor _ListType(initialCapacity As Long)
__CONT_DBG_PRINT("Capacity constructor for & items", initialCapacity)
    Reserve(initialCapacity)
    _count = 0
End Constructor

Private Constructor _ListType(Byref copy As _ListType)
__CONT_DBG_PRINT("Copy constructor")
	copy.CopyTo(_objects())
	Reserve(copy.Capacity)
	_count = copy.Count
End Constructor

Private Constructor _ListType(ByVal iterator As _IteratorInterfaceType Ptr)
	Constructor()
__CONT_DBG_PRINT("Iterator constructor")
    
    Add(iterator)
    
End Constructor

Private Constructor _ListType(ByRef iterator As _IteratorInterfaceType)
	Constructor(@iterator)    
End Constructor

Private Constructor _ListType(newData() As FBType)
	Constructor()
__CONT_DBG_PRINT("Array constructor, LBound = &, UBound = &", LBound(newData); UBound(newData))
    
    Add(newData())

End Constructor

Private Constructor _ListType(ByVal newData As _ContainerInterfaceType Ptr)
	Constructor()
__CONT_DBG_PRINT("Container interface constructor")
	
    Add(newData)

End Constructor

Private Constructor _ListType(ByRef newData As _ContainerInterfaceType)
	Constructor(@newData)
End Constructor

Private Sub _ListType.Add(_PassType newData As FBType)
__CONT_DBG_PRINT("Adding item to position &", Count)

    Dim n As Long = Count
    If Capacity < (n + 1) Then
        Reserve(n + 16)
    End If

    _objects(n) = newData
    _count += 1

End Sub

Private Sub _ListType.Add(newData() As FBType)
    Dim arrLBound As Long
    Dim arrUBound As Long    
    Dim numElems As Long = __CONT_GetArrayInfo(newData, arrLBound, arrUBound)
__CONT_DBG_PRINT("Adding & items at position &", numElems; Count)
    
    If numElems > 0 Then
		_AddOrInsert(newData(), arrLBound, numElems, -1)
	End If

End Sub

Private Sub _ListType.Add(newData() As FBType, ByVal start As Long, ByVal howMany As Long)
__CONT_DBG_PRINT("Adding & objects at position &, starting from &", howMany; Count; start)

    If __CONT_IsValidArray(newData) Then
		_AddOrInsert(newData(), start, howMany, -1)
	End If

End Sub

Private Sub _ListType.Add(ByVal newData As _ContainerInterfaceType Ptr)
	Assert(newData <> 0)
	If newData = 0 Then
		__CONT_Internals_SetError(1)
		Exit Sub
	End If
__CONT_DBG_PRINT("Adding & items from Container &", newData->Count; Hex(newData))
    Dim iter As _IteratorInterfaceType Ptr = newData->GetIterator()
    Add(iter)
    Delete iter

End Sub

Private Sub _ListType.Add(ByVal iterator As _IteratorInterfaceType Ptr)
	Assert(iterator <> 0)
	If iterator = 0 Then
		__CONT_Internals_SetError(1)
		Exit Sub
	End If
__CONT_DBG_PRINT("Adding items via iterator &", Hex(iterator))
	While iterator->Advance()
        Add(iterator->Item())
    Wend
End Sub

Private Sub _ListType.Add(ByRef newData As _ContainerInterfaceType)
	Add(@newData)
End Sub

Private Sub _ListType.Add(ByRef iterator As _IteratorInterfaceType)
	Add(@iterator)
End Sub

Private Sub _ListType._AddOrInsert( _
    newData() As FBType, _
    ByVal start As Long, _
    ByVal howMany As Long, _
    ByVal insertAt As Long _
)
__CONT_DBG_PRINT("Adding & objects at position &, starting from &", howMany; insertAt; start)
	Dim n As Long = Count
	
	If (insertAt < -1) OrElse (insertAt > n) Then
__CONT_DBG_PRINT("Insert index (&) wasn't -1 or inside list bounds (0-&), not adding anything", insertAt; n)
		__CONT_Internals_SetError(6)
		Exit Sub
	ElseIf insertAt = -1 Then
		insertAt = n
	End If

    Dim As Long arrUBound, arrLBound
    Dim numElems As Long = __CONT_GetArrayInfo(newData, arrLBound, arrUBound)

    If (start > arrUBound) OrElse (start < arrLBound) OrElse (numElems <= 0) Then
__CONT_DBG_PRINT("Start (&) was outside array bounds of &-&, or array was empty, not adding anything", start; arrLBound; arrUBound)
		__CONT_Internals_SetError(6)
        Exit Sub
    End If

	Dim newDataEnd As Long = start + (howMany - 1)
    If newDataEnd > arrUBound Then
        newDataEnd = arrUBound
        howMany = (newDataEnd - start) + 1
__CONT_DBG_PRINT("Changing howMany to & because start + howMany was beyond array uBound", howMany)
    End If
    
    Dim newCount As Long = n + howMany

    If newCount > Capacity Then
        Reserve(newCount + 16)
    End If

    Dim srcPtr As FBType Ptr
    Dim dstPtr As FBType Ptr

    If insertAt <> n Then

		'' Move all the elements after the insert position up
		srcPtr = @_objects(n)
		dstPtr = @_objects(newCount)
		Dim i As Long
		Dim toCopy As Long = n - insertAt
		For i = 1 To toCopy
			dstPtr -= 1
			srcPtr -= 1
			*dstPtr = *srcPtr
		Next
		dstPtr = srcPtr
	Else
		dstPtr = @_objects(insertAt)
    End If

    srcPtr = @newData(start)

    Dim i As Long
    For i = start To newDataEnd
        *dstPtr = *srcPtr
        dstPtr += 1
        srcPtr += 1
    Next

    _count = newCount

End Sub

Private Sub _ListType.Clear()
__CONT_DBG_PRINT("Clearing")
	Erase _objects
	_count = 0
	Reserve(16)

End Sub

Private Function _ListType.Contains(_PassType item As FBType) As Boolean
    Return IndexOf(item) <> -1
End Function

Private Sub _ListType.CopyTo(items() As FBType)
__CONT_DBG_PRINT("Copying all list elements to an array (& elements)", Count)

   __CONT_Internals.ContainerToArray(@This, items())

End Sub

'' listCount can be -1 to copy all elements
'' If arr is undimensioned, arrayStart is ignored and the returned array is dimensioned from 0 to elementsCopied - 1
'' elementsCopied is the minimum of:
''    listCount - listStart
''    Len(list) - listStart
''    UBound(arr) - arrayStart + 1 (with a valid array)
'' 
Private Sub _ListType.CopyTo(arr() As FBType, ByVal listStart As Long, ByVal listCount As Long, ByVal arrayStart As Long)
__CONT_DBG_PRINT("Copying & list elements starting at list position & to an array, starting at array position &", listCount; listStart; arrayStart)

    Dim n As Long = Count
    If (listStart < 0) OrElse (listStart >= n) OrElse (n = 0) Then
        __CONT_DBG_PRINT("listStart (&) is less than 0 and beyond the number of items in the list (&), or the list is empty, ignoring CopyTo", listStart; n)
        '' Don't set error on empty list
        If n > 0 Then __CONT_Internals_SetError(1)
        Exit Sub
    End If
    
    If listCount = -1 Then listCount = n
    
    Dim arrUBound As Long
    Dim arrLBound As Long
    '' Constrain the number to copy to the number of elements available
    If (listStart + listCount) > n Then listCount = (n - listStart)
    
    If __CONT_GetArrayInfo(arr, arrLBound, arrUBound) > 0 Then '' dimensioned non-zero size array
    		
		'' Check the start point of the array is valid
		If (arrayStart < arrLBound) OrElse (arrayStart > arrUBound) Then
			__CONT_DBG_PRINT("arrayStart (&) is less than array LBound (&) or larger than the array UBound (&), ignoring CopyTo", arrayStart; arrLBound; arrUBound)
			__CONT_Internals_SetError(6)
			Exit Sub
		End If
		'' If the array is dimensioned, we won't resize it so cap to its ubound
		dim availableArraySlots As Long = (arrUBound - arrayStart) + 1
        listCount = _Min(listCount, availableArraySlots)
        
    Else '' non-dimensioned array
    
		Redim arr(0 To listCount - 1)
		arrayStart = 0
    End If
    
    dim srcPtr As FBType Ptr = @_objects(listStart)
    dim dstPtr As FBType Ptr = @arr(arrayStart)
   
    While listCount > 0
        *dstPtr = *srcPtr
        listCount -= 1
        srcPtr += 1
        dstPtr += 1
    Wend

End Sub

Private Function _ListType.Empty() As Boolean
    Return Count = 0
End Function

Private Function _ListType.First() ByRef As FBType
__CONT_DBG_PRINT("Getting first value")
    Return this[0]
End Function

Private Function _ListType.GetIterator() As _IteratorInterfaceType Ptr
__CONT_DBG_PRINT("Creating new iterator")
	Return New _ListIteratorType(@This)
End Function

Private Function _ListType.IndexOf(_PassType needle As FBType) As Long
	Dim itemCount As Long = Count
    Dim i As Long = 0
    
    While i < itemCount
        If _objects(i) = needle Then
            Return i
        End If
        i += 1
    Wend
    Return -1
End Function

Private Sub _ListType.Insert(ByVal insertAt As Long, _PassType newData As FBType)
__CONT_DBG_PRINT("Inserting value at &", insertAt)

    Dim tempArr(0 To 0) As FBType
    tempArr(0) = newData
    _AddOrInsert(tempArr(), 0, 1, insertAt)

End Sub

Private Sub _ListType.Insert(ByVal insertAt As Long, newData() As FBType)
    Dim arrLBound As Long
    Dim arrUBound As Long
    Dim numElems As Long = __CONT_GetArrayInfo(newData, arrLBound, arrUBound)
__CONT_DBG_PRINT("Inserting array of & elements at &", numElems; insertAt)
    If numElems > 0 Then
		_AddOrInsert(newData(), arrLBound, numElems, insertAt)
	Else
		__CONT_Internals_SetError(1) '' undimmed or empty array
	End If

End Sub

'' insertAt can be Count or -1 to insert at the end of the list (equalivalent to Add)
Private Sub _ListType.Insert(ByVal insertAt As Long, newData() As FBType, ByVal arrStartIndex As Long, ByVal howMany As Long)
__CONT_DBG_PRINT("Inserting array from &-& at &", arrStartIndex; arrStartIndex + howMany; insertAt)

	If __CONT_IsValidArray(newData) Then
        _AddOrInsert(newData(), arrStartIndex, howMany, insertAt)
    Else
		__CONT_Internals_SetError(1) '' undimmed or empty array
	End If

End Sub

Private Sub _ListType.Insert(ByVal insertAt As Long, ByVal newData As _ContainerInterfaceType Ptr)
__CONT_DBG_PRINT("Inserting container & at &", Hex(newData); insertAt)
	If newData = 0 Then
	__CONT_DBG_PRINT("Null/0 container ptr not allowed, ignoring insert")
		__CONT_Internals_SetError(1)
		Exit Sub
	End If

    Dim listCount As Long = newData->Count
    Dim localErr As Long
    
    If listCount > 0 Then
        Dim tempArr(Any) As FBType    
        newData->CopyTo(tempArr())
        _AddOrInsert(tempArr(), 0, listCount, insertAt)
        localErr = Err
    Else 
		__CONT_Internals_SetError(1)
    End If
    '' Destroying tempArr in the > 0 case resets Err to 0, so we need to re-set any error status
    If localErr <> 0 Then
		Err = localErr
	End If

End Sub

Private Sub _ListType.Insert(ByVal index As Long, ByRef newData As _ContainerInterfaceType)
	Insert(index, @newData) 
End Sub

Private Sub _ListType.Insert(ByVal insertAt As Long, ByVal newData As _IteratorInterfaceType Ptr)
__CONT_DBG_PRINT("Inserting iterator & at &", Hex(newData); insertAt)
	If newData = 0 Then
	__CONT_DBG_PRINT("Null/0 iterator ptr not allowed, ignoring insert")
		__CONT_Internals_SetError(1)
		Exit Sub
	End If
	
	Dim localErr As Long = 0
	
	Scope
		Dim insertCont As _ListType = newData
		Insert(insertAt, @insertCont)
		localErr = Err
	End Scope
	'' Destroying the container resets Err to 0, so it needs re-setting before we exit
    If localErr <> 0 Then
		Err = localErr
    End If

End Sub

Private Sub _ListType.Insert(ByVal index As Long, ByRef newData As _IteratorInterfaceType)
	Insert(index, @newData) 
End Sub

Private Function _ListType.Last() ByRef As FBType
    Dim lastIndex As Long = Count - 1
__CONT_DBG_PRINT("Last index = &", lastIndex)
    Return This[lastIndex]
End Function

Private Function _ListType.LastIndexOf(_PassType needle As FBType) As Long
__CONT_DBG_PRINT("")
	Dim itemCount As Long = Count - 1
    Dim i As Long = itemCount
    
    While i >= 0
        If _objects(i) = needle Then
            Return i
        End If
        i -= 1
    Wend
    Return -1
End Function

Private Sub _ListType.Remove(_PassType item As FBType)
    Dim index As Long = IndexOf(item)
    If index <> -1 Then
        RemoveAt(index)
        
#if __FB_QUOTE__(_PassType) = "ByRef"
    Else
		__CONT_DBG_PRINT("Item not found. If this is a UDT, and you're sure it should be here, is your Operator= correct?")
#endif
	End if
End Sub

Private Sub _ListType.RemoveAt(ByVal index As Long)
__CONT_DBG_PRINT("Removing index &", index)
    RemoveSpan(index, 1)
End Sub

Private Sub _ListType.RemoveSpan(ByVal index As Long, ByVal howMany As Long)
__CONT_DBG_PRINT("Removing & elements from position &", index; howMany)
    Dim n As Long = Count
    If (index < 0) OrElse (index >= n) OrElse (howMany <= 0) Then
__CONT_DBG_PRINT("Index (&) was out of bounds (0-&) or howMany (&) was 0 or negative, ignoring remove", index; n - 1; howMany)
		__CONT_Internals_SetError(IIf(howMany <= 0, 1, 6))
        Exit Sub
    End If
    
    If (index = 0) AndAlso (howMany = n) Then
		Clear()
		Exit Sub
	End If
    
    howMany = _Min(n - index, howMany)
    
    if howMany > 0 Then
    
        Dim newCount As Long = n - howMany
        If index < newCount Then
            Dim src As Long = index + howMany
            Dim dst As Long = index
            Dim toCopy As Long = newCount - index
            CopyTo(_objects(), src, toCopy, dst)
        End If
        '' call any destructors for ones deleted
        Redim Preserve _objects(0 To newCount)
        Resize(newCount)
    
    End If
    
End Sub

Private Sub _ListType.Resize(ByVal newSize As Long)
__CONT_DBG_PRINT("Resizing from & to &", Capacity; newSize)
    Assert(newSize >= 0)
    If newSize < 0 Then
        __CONT_Internals_SetError(1)
        Exit Sub
    End If
    Reserve(newSize + 16)
    _count = newSize
    
End Sub

Private Sub _ListType.Reserve(ByVal newSize As Long)

	If newSize > Count Then
__CONT_DBG_PRINT("Changing capacity to &", newSize)
		Redim Preserve _objects(0 To newSize - 1)
	End If

End Sub

Private Property _ListType.Count() As Long
__CONT_DBG_PRINT("returning &", _count)
    Return _count
End Property

Private Property _ListType.Capacity() As Long
__CONT_DBG_PRINT("Returning &", UBound(_objects) + 1)
	Return UBound(_objects) + 1

End Property

Private Operator _ListType.[] (ByVal index As Long) ByRef As FBType
__CONT_DBG_PRINT("Indexing at position & of &", index; Count - 1)

    If (index < 0) OrElse (index >= Count) Then
		Assert(StrPtr("Index location out of bounds") <> 0)
		__CONT_Internals_SetError(6)
    End If
    Return _objects(index)
End Operator

Private Operator _ListType.+=(_PassType newData As FBType)
	Add(newData)
End Operator

Private Operator Len(ByRef list As _ListType) As Integer
	Return list.Count
End Operator

#ifdef FB_CONTAINER_DEBUG
Private Sub _ListType.PrintContainer()
    Print __FB_QUOTE__(_ListType) " at " & Hex(@This) & " has " & Count & " elements:"
    '' If these are primitives or pointers, we can print them out, otherwise we can't
#if ((__FB_Is_BuiltIn(FBType)) OrElse (__FB_Is_Ptr(FBType)))
    Dim i As Long, n As Long = Count
    For i = 0 To n - 1
        Print Using "&) &, "; i; Str(_objects(i))
    Next
#endif
End Sub
#endif '' FB_CONTAINER_DEBUG

#undef _Min

#endif '' __FB_QUOTE__(_TypeDefine()) <> "1"

#undef _ListType
#undef _ListIteratorType
#undef _ListInterfaceType
#undef _ContainerInterfaceType
#undef _IteratorInterfaceType
#undef _TypeDefine
#undef _PassType

#endmacro '' __CONT_DefineListOf_


'' Use this at global scope to generate the code for the list type
'' One of these is required for every separate type you want to put in a list
'' FBCont_DefineListOf(Any Ptr) '' for an any ptr list
'' FBCont_DefineListOf(MyNamespace, MyType) '' for a type in a namespace
''
'' If you get a Type Mismatch error on the macro line when defining a list for your UDT type
'' You need to implement Operator= 
#macro FBCont_DefineListOf(Type...)

__CONT_DefineListOf_(__FB_MakeFBType(Type), __FB_MakePPType(Type))

#endmacro '' FBCont_DefineListOf

'' Use this to declare your variable type
'' Dim myList As FB_List(Any Ptr)
'' Dim myList As FB_List(MyNamespace, MyType)
#define FB_List(Type...) __FB_JOIN__(List, __FB_MakePPType(Type))

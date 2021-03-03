#include once "_typemacros.bi"
#include once "icontainer.bi"
#include once "list.bi"
#include once "reverselistiterator.bi"
#include once "_helpers.bi"

#pragma once

'' Defines a Last-in, First-Out stack
#macro __CONT_DefineStackOf_(FBType, PPType)

__CONT_DefineListOf_(FBType, PPType)
__CONT_DefineReverseListIteratorOf_(FBType, PPType)

#define _StackType					__FB_JOIN__(Stack, PPType)
#define _StackTypeIterator			__FB_JOIN__(ReverseListIterator, PPType)
#define _ListType					__FB_JOIN__(List, PPType)
#define _ContainerInterfaceType		__FB_JOIN__(IContainer, PPType)
#define _IteratorInterfaceType		__FB_JOIN__(IIterator, PPType)
#define _TypeDefine()				__FB_JOIN__(__CONT_, __FB_JOIN__(_StackType, _DEFINED))
__FB_DefinePassType(FBType, _PassType)

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _StackType)
#endif

Type _StackType extends _ContainerInterfaceType
Private:
	dim _stack As _ListType

Public:
	Declare Constructor()
	Declare Constructor(ByRef otherStack As _StackType)
	Declare Constructor(ByVal iter As _IteratorInterfaceType Ptr)
	Declare Constructor(ByRef iter As _IteratorInterfaceType)
	Declare Constructor(ByVal cont As _ContainerInterfaceType Ptr)
	Declare Constructor(ByRef cont As _ContainerInterfaceType)
	Declare Constructor(items() As FBType)
	
	Declare Sub Clear() override
    Declare Function Contains(_PassType element As FBType) As Boolean override
    Declare Sub CopyTo(newData() As FBType) override
    Declare Function Empty() As Boolean
    Declare Function GetIterator() As _IteratorInterfaceType Ptr override
    Declare Sub Push(_PassType element As FBType)
    Declare Function Pop() As FBType
    
    Declare Property Count() As Long override
    Declare Property Top() ByRef As FBType
    
    Declare Operator +=(_PassType newData AS FBType)
    '' Also Operator Len()
    
#ifdef FB_CONTAINER_DEBUG
    Declare Sub PrintContainer() override
#endif

End Type

'' Can't use the general container or iterator constructors to copy construct
'' as the stack iterator goes from top to bottom, if we push in iterator order
'' we end up with a reversed copy of the stack
Private Constructor _StackType(ByRef otherStack As _StackType)
	_stack.Constructor(otherStack._stack)
__CONT_DBG_PRINT("Copy constructor with & elements"; otherStack.Count)
	
End Constructor

Private Constructor _StackType()
__CONT_DBG_PRINT("Default constructor")
End Constructor

Private Constructor _StackType(ByVal iter As _IteratorInterfaceType Ptr)
	_stack.Constructor(iter)
__CONT_DBG_PRINT("iterator constructor")
End Constructor

Private Constructor _StackType(ByRef iter As _IteratorInterfaceType)
	Constructor(@iter)
End Constructor

Private Constructor _StackType(ByVal cont As _ContainerInterfaceType Ptr)
	_stack.Constructor(cont)
__CONT_DBG_PRINT("container constructor")
End Constructor

Private Constructor _StackType(ByRef cont As _ContainerInterfaceType)
	Constructor(@cont)
End Constructor

Private Constructor _StackType(items() As FBType)
	_stack.Constructor(items())
__CONT_DBG_PRINT("array constructor")
End Constructor

Private Sub _StackType.Clear()
__CONT_DBG_PRINT("")
	_stack.Clear()
End Sub

Private Function _StackType.Contains(_PassType element As FBType) As Boolean
__CONT_DBG_PRINT("")
	Return _stack.Contains(element)
End Function

'' This returns elements in most-recently-pushed-first order
'' ie from the Top down
Private Sub _StackType.CopyTo(elements() As FBType)
__CONT_DBG_PRINT("with & elements", Count)
	Dim localErr As Long
	'' If _stack.CopyTo errors, then Err will be reset at the of the scope
	'' when tempElems is destroyed, so we introduce a scope so we can control
	'' when that happens so we can reset the error
	Scope
		Dim curStackCount As Long = Count
		Dim tempElems(Any) As FBType
		Err = 0
		_stack.CopyTo(tempElems())
		localErr = Err
		if localErr = 0 Then
			__CONT_Internals.ReverseArray(tempElems())
			Dim As Long arrLBound, arrUBound, numElems = __CONT_GetArrayInfo(elements, arrLBound, arrUBound)
			If numElems = 0 Then
				arrUBound = UBound(tempElems)
				Redim elements(0 To arrUBound)
				Assert(arrLBound = 0)
			ElseIf (numElems >= curStackCount) Then
				arrUBound = arrLBound + curStackCount - 1
			End If
			
			Dim As FBType Ptr pSrc = @tempElems(0), pDest = @elements(arrLBound)
			For i As Long = arrLBound To arrUBound
				*pDest = *pSrc
				pDest += 1
				pSrc += 1
			Next
		End If
	End Scope
	Err = localErr
End Sub

Private Function _StackType.Empty() As Boolean
__CONT_DBG_PRINT("")
	Return Count = 0
End Function

Private Function _StackType.GetIterator() As _IteratorInterfaceType Ptr
__CONT_DBG_PRINT("for stack of size &", Count)
	Return New _StackTypeIterator(@_stack)
End Function

Private Sub _StackType.Push(_PassType element As FBType)
__CONT_DBG_PRINT("to stack of size &", Count)
	_stack.Add(element)
End Sub

Private Function _StackType.Pop() As FBType
	Dim elems As Long = Count
__CONT_DBG_PRINT("from stack of size &", elems)
	Assert(elems > 0)
	If elems = 0 Then
		__CONT_Internals_SetError(6)
	End If
	Dim temp As FBType = Top
	_stack.RemoveAt(_stack.Count - 1)
	Return temp
End Function

#ifdef FB_CONTAINER_DEBUG
Private Sub _StackType.PrintContainer()
	Print __FB_QUOTE__(_StackType) " at " & Hex(@This) & " has " & Count & " elements"
	Print "Inner List";
	_stack.PrintContainer()
End Sub
#endif

Private Property _StackType.Top() ByRef As FBType
    dim elems As Long = Count
__CONT_DBG_PRINT("of stack of size &", elems)
	Assert(elems > 0)
	If elems = 0 Then
		__CONT_Internals_SetError(6)
	End If
	Return _stack.Last()
End Property

Private Property _StackType.Count() As Long
	Return _stack.Count
End Property

Private Operator _StackType.+=(_PassType newData As FBType)
	Push(newData)
End Operator

Private Operator Len(Byref stack As _StackType) As Integer
	Return stack.Count
End Operator

#endif '' __FB_QUOTE__(_TypeDefine()) <> "1"

#undef _StackType
#undef _StackTypeIterator
#undef _ListType
#undef _ContainerInterfaceType
#undef _IteratorInterfaceType
#undef _TypeDefine
#undef _PassType

#endmacro

'' Use this at global scope to generate the code for the list type
'' One of these is required for every separate type you want to put in a list
'' FBCont_DefineStackOf(Any Ptr) '' for an any ptr list
'' FBCont_DefineStackOf(MyNamespace, MyType) '' for a type in a namespace
#macro FBCont_DefineStackOf(Type...)

__CONT_DefineStackOf_(__FB_MakeFBType(Type), __FB_MakePPType(Type))

#endmacro '' FBCont_DefineStackOf
#define FBCont_DefineStackIteratorOf(Type...) FBCont_DefineReverseListIteratorOf(Type)

'' Use this to declare your variable type
'' Dim myList As FB_Stack(Any Ptr)
'' Dim myList As FB_Stack(MyNamespace, MyType)
#define FB_Stack(Type...) __FB_JOIN__(Stack, __FB_MakePPType(Type))
#define FB_StackIterator(Type...) __FB_JOIN__(ReverseListIterator, __FB_MakePPType(Type))

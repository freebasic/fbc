#include once "_typemacros.bi"
#include once "iiterator.bi"
#include once "ilist.bi"

#pragma once

'' Defines an iterator that enumerates an IList backwards (from list.Last() to list.First())
#macro __CONT_DefineReverseListIteratorOf_(FBType, PPType)

__CONT_DefineIListOf_(FBType, PPType)
__CONT_DefineIIteratorOf_(FBType, PPType)

#define _ReverseListIteratorType		__FB_JOIN__(ReverseListIterator, PPType)
#define _IteratorInterfaceType			__FB_JOIN__(IIterator, PPType)
#define _ListInterfaceType				__FB_JOIN__(IList, PPType)
#define _TypeDefine()					__FB_JOIN__(__CONT_, __FB_JOIN__(_ReverseListIteratorType, _DEFINED))

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _ReverseListIteratorType)
#endif

Type _ReverseListIteratorType extends _IteratorInterfaceType
Private:
    dim parentList As _ListInterfaceType Ptr
    dim curPos As Long
    
Public:
    Declare Constructor(ByVal parent As _ListInterfaceType Ptr)
    Declare Constructor()
    Declare Operator For()
	Declare Operator Next(ByRef cond As _ReverseListIteratorType) As Integer
	Declare Operator Step()
	
	Declare Function Advance() As Boolean Override
	Declare Function Item() Byref As FBType Override
	Declare Sub Reset() Override
End Type

Private Constructor _ReverseListIteratorType(ByVal parent As _ListInterfaceType Ptr)
__CONT_DBG_PRINT("List constructor with list &", Hex(parent))
    parentList = parent
    curPos = parentList->Count
End Constructor

Private Constructor _ReverseListIteratorType()
__CONT_DBG_PRINT("Default constructor (end iterator)")
    parentList = 0
    curPos = &H7fffffff
End Constructor

Private Operator _ReverseListIteratorType.For()
__CONT_DBG_PRINT("Starting for")
    curPos = parentList->Count - 1
End Operator

Private Operator _ReverseListIteratorType.Next(ByRef cond As _ReverseListIteratorType) As Integer
__CONT_DBG_PRINT("")
    Return (curPos <> cond.curPos) AndAlso (curPos < parentList->Count)
End Operator

Private Operator _ReverseListIteratorType.Step()
    Dim from As Long = curPos
    curPos -= 1
    If curPos < 0 Then
        curPos = parentList->Count
    End If
__CONT_DBG_PRINT("Stepped from & to &", from; curPos)
End Operator

Private Function _ReverseListIteratorType.Advance() As Boolean
__CONT_DBG_PRINT("Advancing from & to &", curPos; curPos - 1)
    curPos -= 1
    Return curPos >= 0
End Function

Private Function _ReverseListIteratorType.Item() ByRef As FBType
__CONT_DBG_PRINT("Accessing Item &", curPos)
    Return (*parentList)[curPos]
End Function

Private Sub _ReverseListIteratorType.Reset()
__CONT_DBG_PRINT("")
    curPos = parentList->Count
End Sub

#endif '' __FB_JOIN__(_ReverseListIteratorType, _DEFINED)

#undef _ReverseListIteratorType
#undef _IteratorInterfaceType
#undef _ListInterfaceType
#undef _TypeDefine

#endmacro '' _CONT_DefineReverseListIterator_

'' Use this at global scope to generate the code for the reverselistiterator type
'' You shouldn't need to do this manually, a compatible list iterator type is 
'' automatically generated for each type of container defined
''
'' Otherwise one of these is required for every separate type of list to iterate
'' The type should be the type contained in the list being iterated
'' FBCont_DefineReverseListIteratorOf(Any Ptr) '' for an any ptr list iterator
'' FBCont_DefineReverseListIteratorOf(MyNamespace, MyType) '' for a type in a namespace
#macro FBCont_DefineReverseListIteratorOf(Type...)

__CONT_DefineReverseListIteratorOf_(__FB_MakeFBType(Type), __FB_MakePPType(Type))

#endmacro

'' Use this to declare your variable type
'' Dim myList As FB_ReverseListIterator(Any Ptr)
'' Dim myList As FB_ReverseListIterator(MyNamespace, MyType)
#define FB_ReverseListIterator(Type...) __FB_JOIN__(ReverseListIterator, __FB_MakePPType(Type))

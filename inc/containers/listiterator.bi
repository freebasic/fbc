#include once "_typemacros.bi"
#include once "iiterator.bi"
#include once "ilist.bi"

#pragma once

'' Defines an iterator that enumerates an IList forwards (from list.First() to list.Last())
#macro __CONT_DefineListIteratorOf_(FBType, PPType)

__CONT_DefineIListOf_(FBType, PPType)
__CONT_DefineIIteratorOf_(FBType, PPType)

#define _ListIteratorType		__FB_JOIN__(ListIterator, PPType)
#define _IteratorInterfaceType	__FB_JOIN__(IIterator, PPType)
#define _ListInterfaceType		__FB_JOIN__(IList, PPType)
#define _TypeDefine()			__FB_JOIN__(__CONT_, __FB_JOIN__(_ListIteratorType, _DEFINED))

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _ListIteratorType)
#endif

Type _ListIteratorType extends _IteratorInterfaceType
Private:
    dim parentList As _ListInterfaceType Ptr
    dim curPos As Long
    
Public:
    Declare Constructor(ByVal parent As _ListInterfaceType Ptr)
    Declare Constructor()
    Declare Operator For()
	Declare Operator Next(ByRef cond As _ListIteratorType) As Integer
	Declare Operator Step()
	
	Declare Function Advance() As Boolean Override
	Declare Function Item() Byref As FBType Override
	Declare Sub Reset() Override
End Type

Private Constructor _ListIteratorType(ByVal parent As _ListInterfaceType Ptr)
__CONT_DBG_PRINT("List constructor with list &", Hex(parent))
    parentList = parent
    curPos = -1
End Constructor

Private Constructor _ListIteratorType()
__CONT_DBG_PRINT("Default constructor (end iterator)")
    parentList = 0
    curPos = -1
End Constructor

Private Operator _ListIteratorType.For()
__CONT_DBG_PRINT("Starting for")
    curPos = 0
End Operator

Private Operator _ListIteratorType.Next(ByRef cond As _ListIteratorType) As Integer
__CONT_DBG_PRINT("")
    Return (curPos <> cond.curPos) AndAlso (curPos >= 0)
End Operator

Private Operator _ListIteratorType.Step()
    Dim from As Long = curPos
    curPos += 1
    If curPos >= parentList->Count Then
        curPos = -1
    End If
__CONT_DBG_PRINT("Stepped from & to &", from; curPos)
End Operator

Private Function _ListIteratorType.Advance() As Boolean
__CONT_DBG_PRINT("Advancing from & to &", curPos; curPos + 1)
    curPos += 1
    Return curPos < parentList->Count
End Function

Private Function _ListIteratorType.Item() ByRef As FBType
__CONT_DBG_PRINT("Accessing Item &", curPos)
    Return (*parentList)[curPos]
End Function

Private Sub _ListIteratorType.Reset()
__CONT_DBG_PRINT("Resetting")
    curPos = -1
End Sub

#endif '' __FB_JOIN__(_ListIteratorType, _DEFINED)

#undef _ListIteratorType
#undef _IteratorInterfaceType
#undef _ListInterfaceType
#undef _TypeDefine

#endmacro '' _CONT_DefineListIterator_

'' Use this at global scope to generate the code for the listiterator type
'' You shouldn't need to do this manually, a compatible list iterator type is 
'' automatically generated for each type of container defined
''
'' Otherwise one of these is required for every separate type of list to iterate
'' The type should be the type contained in the list being iterated
'' FBCont_DefineListIteratorOf(Any Ptr) '' for an any ptr list iterator
'' FBCont_DefineListIteratorOf(MyNamespace, MyType) '' for a type in a namespace
#macro FBCont_DefineListIteratorOf(Type...)

__CONT_DefineListIteratorOf_(__FB_MakeFBType(Type), __FB_MakePPType(Type))

#endmacro

'' Use this to declare your variable type
'' Dim myList As FB_ListIterator(Any Ptr)
'' Dim myList As FB_ListIterator(MyNamespace, MyType)
#define FB_ListIterator(Type...) __FB_JOIN__(ListIterator, __FB_MakePPType(Type))

#include once "_typemacros.bi"
#include once "iiterator.bi"

#pragma once

'' Defines an iterator that enumerates a LinkedList from Head to Tail
#macro __CONT_DefineLinkedListIteratorOf_(FBType, PPType)

__CONT_DefineIIteratorOf_(FBType, PPType)

#ifndef _LinkedListIteratorType
#define __CONT_NEEDS_TYPE_UNDEF
#define _LinkedListIteratorType	__FB_JOIN__(LinkedListIterator, PPType)
#endif
#ifndef _LinkedListNodeType
#define __CONT_NEEDS_NODE_UNDEF
#define _LinkedListNodeType		__FB_JOIN__(LinkedListNode, PPType)
#endif
#ifndef _IteratorInterfaceType
#define __CONT_NEEDS_ITER_UNDEF
#define _IteratorInterfaceType	__FB_JOIN__(IIterator, PPType)
#endif
#define _IteratorTypeDefine()	__FB_JOIN__(__CONT_, __FB_JOIN__(_LinkedListIteratorType, _DEFINED))
#define _NodePtr _LinkedListNodeType Ptr

#if __FB_QUOTE__(_IteratorTypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_IteratorTypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _LinkedListIteratorType)
#endif

Type _LinkedListIteratorType extends _IteratorInterfaceType
Private:
    dim _head As _NodePtr
    dim _curPos As _NodePtr
    dim _stop As Boolean
    
Public:
    Declare Constructor(ByVal head As _NodePtr)
    Declare Constructor()
    Declare Operator For()
	Declare Operator Next(ByRef cond As _LinkedListIteratorType) As Integer
	Declare Operator Step()
	
	Declare Function Advance() As Boolean Override
	Declare Function Item() Byref As FBType Override
	Declare Sub Reset() Override
End Type

Private Constructor _LinkedListIteratorType(ByVal head As _NodePtr)
__CONT_DBG_PRINT("Head constructor with &", Hex(head))
    _head = head
    _curPos = 0
    _stop = False
End Constructor

Private Constructor _LinkedListIteratorType()
__CONT_DBG_PRINT("Default constructor (end iterator)")
    _head = 0
    _curPos = 0
    _stop = False
End Constructor

Private Operator _LinkedListIteratorType.For()
__CONT_DBG_PRINT("Starting for")
    _curPos = _head
    _stop = False
End Operator

Private Operator _LinkedListIteratorType.Next(ByRef cond As _LinkedListIteratorType) As Integer
__CONT_DBG_PRINT("")
    Return (_curPos <> cond._curPos) AndAlso (_curPos <> 0)
End Operator

Private Operator _LinkedListIteratorType.Step()
    dim nextPos As NodePtr = _curPos->Forward
__CONT_DBG_PRINT("Stepping from & to &", Hex(_curPos); Hex(nextPos))
    _curPos = IIf(nextPos = _head, 0, nextPos)
End Operator

Private Function _LinkedListIteratorType.Advance() As Boolean
	If _stop OrElse _head = 0 Then '' we've gone all the way around to the head, stop
__CONT_DBG_PRINT("Advanced to end")
		_curPos = 0
	Else
		dim As NodePtr newCur
		If _curPos = 0 Then '' we haven't started yer, set to start
			newCur = _head
		Else
			newCur = _curPos->Forward
		End If
		_stop = (newCur->Forward = _head) '' If the one after this is the _head, this is the last element
__CONT_DBG_PRINT("Advancing from & to &", Hex(_curPos); Hex(newCur))
		_curPos = newCur
	End If
    Return _curPos <> 0
End Function

Private Function _LinkedListIteratorType.Item() ByRef As FBType
__CONT_DBG_PRINT("Accessing Item &", Hex(_curPos))
    Return _curPos->Data
End Function

Private Sub _LinkedListIteratorType.Reset()
__CONT_DBG_PRINT("Resetting")
    _curPos = 0
    _stop = False
End Sub

#endif '' __FB_JOIN__(_LinkedListIteratorType, _DEFINED)

#ifdef __CONT_NEEDS_TYPE_UNDEF
#undef _LinkedListIteratorType
#undef __CONT_NEEDS_TYPE_UNDEF
#endif
#ifdef __CONT_NEEDS_NODE_UNDEF
#undef _LinkedListNodeType
#undef __CONT_NEEDS_NODE_UNDEF
#endif
#ifdef __CONT_NEEDS_ITER_UNDEF
#undef _IteratorInterfaceType
#undef __CONT_NEEDS_ITER_UNDEF
#endif
#undef _IteratorTypeDefine
#undef _NodePtr

#endmacro '' _CONT_DefineListIterator_

'' Use this at global scope to generate the code for the listiterator type
'' You shouldn't need to do this manually, a compatible list iterator type is 
'' automatically generated for each type of container defined
''
'' Otherwise one of these is required for every separate type of list to iterate
'' The type should be the type contained in the list being iterated
'' FBCont_DefineLinkedListIteratorOf(Any Ptr) '' for an any ptr list iterator
'' FBCont_DefineLinkedListIteratorOf(MyNamespace, MyType) '' for a type in a namespace
#macro FBCont_DefineLinkedListIteratorOf(Type...)

__CONT_DefineLinkedListIteratorOf_(__FB_MakeFBType(Type), __FB_MakePPType(Type))

#endmacro

'' Use this to declare your variable type
'' Dim myList As FB_LinkedListIterator(Any Ptr)
'' Dim myList As FB_LinkedListIterator(MyNamespace, MyType)
#define FB_LinkedListIterator(Type...) __FB_JOIN__(LinkedListIterator, __FB_MakePPType(Type))

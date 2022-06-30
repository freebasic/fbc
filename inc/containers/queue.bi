#include once "_typemacros.bi"
#include once "icontainer.bi"
#include once "linkedlist.bi"
#include once "_helpers.bi"

#pragma once

'' Defines a First-in, First-Out queue
#macro __CONT_DefineQueueOf_(FBType, PPType)

__CONT_DefineLinkedListOf_(FBType, PPType)

#define _QueueType					__FB_JOIN__(Queue, PPType)
#define _LinkedListType				__FB_JOIN__(LinkedList, PPType)
#define _LinkedListNodeType			__FB_JOIN__(LinkedListNode, PPType)
#define _ContainerInterfaceType		__FB_JOIN__(IContainer, PPType)
#define _IteratorInterfaceType		__FB_JOIN__(IIterator, PPType)
#define _TypeDefine()				__FB_JOIN__(__CONT_, __FB_JOIN__(_QueueType, _DEFINED))
__FB_DefinePassType(FBType, _PassType)

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _QueueType)
#endif

Type _QueueType extends _ContainerInterfaceType
Private:
	dim _queue As _LinkedListType

Public:
	Declare Constructor()
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
    Declare Property Front() ByRef As FBType
    
    Declare Operator +=(_PassType newData AS FBType)
    '' Also Operator Len()
    
#ifdef FB_CONTAINER_DEBUG
    Declare Sub PrintContainer() override
#endif

End Type

Private Constructor _QueueType()
__CONT_DBG_PRINT("Default constructor")
End Constructor

Private Constructor _QueueType(ByVal iter As _IteratorInterfaceType Ptr)
	_queue.Constructor(iter)
__CONT_DBG_PRINT("iterator constructor")
End Constructor

Private Constructor _QueueType(ByRef iter As _IteratorInterfaceType)
	Constructor(@iter)
End Constructor

Private Constructor _QueueType(ByVal cont As _ContainerInterfaceType Ptr)
	_queue.Constructor(cont)
__CONT_DBG_PRINT("container constructor")
End Constructor

Private Constructor _QueueType(ByRef cont As _ContainerInterfaceType)
	Constructor(@cont)
End Constructor

Private Constructor _QueueType(items() As FBType)
	_queue.Constructor(items())
__CONT_DBG_PRINT("array constructor")
End Constructor

Private Sub _QueueType.Clear()
__CONT_DBG_PRINT("")
	_queue.Clear()
End Sub

Private Function _QueueType.Contains(_PassType element As FBType) As Boolean
__CONT_DBG_PRINT("")
	Return _queue.Contains(element)
End Function

Private Sub _QueueType.CopyTo(elements() As FBType)
__CONT_DBG_PRINT("")
	_queue.CopyTo(elements())
End Sub

Private Function _QueueType.Empty() As Boolean
__CONT_DBG_PRINT("")
	Return Count = 0
End Function

Private Function _QueueType.GetIterator() As _IteratorInterfaceType Ptr
__CONT_DBG_PRINT("for queue of size &", Count)
	Return _queue.GetIterator()
End Function

Private Sub _QueueType.Push(_PassType element As FBType)
__CONT_DBG_PRINT("to queue of size &", Count)
	_queue.AddTail(element)
End Sub

Private Function _QueueType.Pop() As FBType
__CONT_DBG_PRINT("from stack of size &", Count)
    Dim n As Long = Count
	Assert(n > 0)
	If n = 0 Then
		__CONT_Internals_SetError(6)
	End If
	Dim temp As FBType = Front
	_queue.RemoveNode(_queue.Head)
	Return temp
End Function

#ifdef FB_CONTAINER_DEBUG
Private Sub _QueueType.PrintContainer()
	Print __FB_QUOTE__(_QueueType) " at " & Hex(@This) & " has " & Count & " elements"
	Print "Inner List";
	_queue.PrintContainer()
End Sub
#endif

Private Property _QueueType.Front() ByRef As FBType
    dim elems As Long = Count
__CONT_DBG_PRINT("of stack of size &", elems)
	Assert(elems > 0)
	If elems = 0 Then
		__CONT_Internals_SetError(6)
	End If
	Return _queue.Head->Data
End Property

Private Property _QueueType.Count() As Long
	Return _queue.Count
End Property

Private Operator _QueueType.+=(_PassType newData As FBType)
	Push(newData)
End Operator

Private Operator Len(Byref queue As _QueueType) As Integer
	Return queue.Count
End Operator

#endif '' __FB_QUOTE__(_TypeDefine()) <> "1"

#undef _QueueType
#undef _LinkedListType
#undef _LinkedListNodeType
#undef _ContainerInterfaceType
#undef _IteratorInterfaceType
#undef _TypeDefine
#undef _PassType

#endmacro

'' Use this at global scope to generate the code for the list type
'' One of these is required for every separate type you want to put in a list
'' FBCont_DefineQueueOf(Any Ptr) '' for an any ptr list
'' FBCont_DefineQueueOf(MyNamespace, MyType) '' for a type in a namespace
#macro FBCont_DefineQueueOf(Type...)

__CONT_DefineQueueOf_(__FB_MakeFBType(Type), __FB_MakePPType(Type))

#endmacro '' FBCont_DefineQueueOf
#define FBCont_DefineQueueIteratorOf(Type...) FBCont_DefineLinkedListIteratorOf(Type)

'' Use this to declare your variable type
'' Dim myList As FB_Queue(Any Ptr)
'' Dim myList As FB_Queue(MyNamespace, MyType)
#define FB_Queue(Type...) __FB_JOIN__(Queue, __FB_MakePPType(Type))
#define FB_QueueIterator(Type...) __FB_JOIN__(LinkedList, __FB_MakePPType(Type))

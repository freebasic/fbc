#include once "_typemacros.bi"
#include once "icontainer.bi"
#include once "linkedlistiterator.bi"
#include once "_helpers.bi"

#pragma once

'' Defines a Linked List Node
#macro __CONT_DefineLinkedListNodeOf_(FBType, PPType)

#define _LinkedListNodeType			__FB_JOIN__(LinkedListNode, PPType)
#define _LinkedListType				__FB_JOIN__(LinkedList, PPType)
#define _TypeDefine()				__FB_JOIN__(__CONT_, __FB_JOIN__(_LinkedListNodeType, _DEFINED))
__FB_DefinePassType(FBType, _PassType)

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#define NodePtr _LinkedListNodeType Ptr

Type _LinkedListNodeType
Protected:
    dim _next As NodePtr
    dim _prev As NodePtr
    dim _data As FBType

Public:
    Declare Property Back() As NodePtr
    '' Next by itself is an operator so it has to be Forward
    Declare Property Forward() As NodePtr
    Declare Property Data() ByRef As FBType
    Declare Property Data(_PassType newData As FBType)

End Type

Private Property _LinkedListNodeType.Forward() As NodePtr
    Return _next
End Property

Private Property _LinkedListNodeType.Back() As NodePtr
    Return _prev
End Property

Private Property _LinkedListNodeType.Data() ByRef As FBType
    Return _data
End Property

Private Property _LinkedListNodeType.Data(_PassType newData As FBType)
    _data = newData
End Property

#undef NodeType

#endif '' __FB_QUOTE__(_TypeDefine())

#undef _LinkedListType
#undef _LinkedListNodeType
#undef _TypeDefine
#undef _PassType

#endmacro '' __CONT_DefineLinkedListNodeOf_

'' Defines a circular doubly linked list
#macro __CONT_DefineLinkedListOf_(FBType, PPType)

__CONT_DefineIContainerOf_(FBType, PPType)
__CONT_DefineLinkedListNodeOf_(FBType, PPType)

#define _LinkedListType				__FB_JOIN__(LinkedList, PPType)
#define _LinkedListNodeType			__FB_JOIN__(LinkedListNode, PPType)
#define _LinkedListNodeSuperType	__FB_JOIN__(LinkedListSuperNode, PPType)
#define _LinkedListTypePtr			__FB_JOIN__(LinkedList, __FB_JOIN__(PPType, Ptr))
#define _LinkedListIteratorType		__FB_JOIN__(LinkedListIterator, PPType)
#define _ContainerInterfaceType		__FB_JOIN__(IContainer, PPType)
#define _IteratorInterfaceType		__FB_JOIN__(IIterator, PPType)
#define _TypeDefine()				__FB_JOIN__(__CONT_, __FB_JOIN__(_LinkedListType, _DEFINED))
__FB_DefinePassType(FBType, _PassType)

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _LinkedListType)
#endif

__CONT_DefineLinkedListIteratorOf_(FBType, PPType)

'' This Type alias is required for a forward declare. 
'' The SuperNode needs to know about the list, and the list uses SuperNodes
'' so one is required to be forwarded
Type _LinkedListTypePtr As _LinkedListType Ptr
#define NodePtr _LinkedListNodeType Ptr

'' C++ style friendship isn't available, so to avoid exposing these setters to users
'' on the base type that could be used to mess up the list, 
'' we restrict them to a super type that only the list creates/knows about
Namespace __CONT_Internals
#define SuperNodePtr __FB_JOIN__(__CONT_Internals., _LinkedListNodeSuperType) Ptr

Type _LinkedListNodeSuperType extends _LinkedListNodeType
	dim _parent As _LinkedListTypePtr

Declare Constructor(_PassType newData As FBType, ByVal owner As _LinkedListTypePtr, byVal newNext As NodePtr, byVal newPrev As NodePtr)
Declare Property Parent() As _LinkedListTypePtr
Declare Property Parent(ByVal owner As _LinkedListTypePtr)
Declare Property Forward(ByVal newNext As NodePtr)
Declare Property Back(ByVal newPrev As NodePtr)
    
End Type

Private Constructor _LinkedListNodeSuperType(_PassType newData As FBType, ByVal owner As _LinkedListTypePtr, byVal newNext As NodePtr, byVal newPrev As NodePtr)
    _data = newData
    _parent = owner
    _prev = newPrev
    
    If newNext <> 0 Then
		_next = newNext
		
		cast(SuperNodePtr, newNext)->Back = @This
	Else
		_next = @This
	End If

	If newPrev <> 0 Then
		_prev = newPrev
		
		cast(SuperNodePtr, newPrev)->Forward = @This
	Else
		_prev = @This
	End If
End Constructor

Private Property _LinkedListNodeSuperType.Parent() As _LinkedListTypePtr
    Return _parent
End Property

Private Property _LinkedListNodeSuperType.Parent(ByVal newParent As _LinkedListTypePtr)
    _parent = newParent
End Property

Private Property _LinkedListNodeSuperType.Forward(ByVal newNext As NodePtr)
    _next = newNext
End Property

Private Property _LinkedListNodeSuperType.Back(ByVal newPrev As NodePtr)
    _prev = newPrev
End Property

End Namespace

Type _LinkedListType extends _ContainerInterfaceType
Private:
	dim _head as NodePtr
	dim _count As Long
	
	Declare Function _CheckNodeOwnership(ByVal node As NodePtr, ByVal container As _LinkedListType Ptr) As Boolean
	Declare Function _Add(_PassType newData As FBType, ByVal prevNode As SuperNodePtr, ByVal nextNode As SuperNodePtr) As NodePtr
	
Public:
	Declare Constructor
    Declare Constructor(ByVal iterator As _IteratorInterfaceType Ptr)
    Declare Constructor(ByRef iterator As _IteratorInterfaceType)
    Declare Constructor(newData() As FBType)
    Declare Constructor(ByVal objects As _ContainerInterfaceType Ptr)
    Declare Constructor(ByRef objects As _ContainerInterfaceType)
    
    Declare Function AddAfter(_PassType newData As FBType, ByVal afterThis As NodePtr) As NodePtr
    Declare Function AddBefore(_PassType newData As FBType, ByVal beforeThis As NodePtr) As NodePtr
    Declare Function AddHead(_PassType newData As FBType) As NodePtr
    Declare Function AddTail(_PassType newData As FBType) As NodePtr
	Declare Sub Clear() override
    Declare Sub CopyTo(newData() As FBType) override
    Declare Function Contains(_PassType element As FBType) As Boolean override
    Declare Function Empty() As Boolean
    Declare Function Find(_PassType data As FBType, ByVal startNode As NodePtr) As NodePtr
    Declare Function GetIterator() As _IteratorInterfaceType Ptr override
    Declare Function RemoveNode(ByVal node As NodePtr) As NodePtr
    
    Declare Property Count() As Long override
    Declare Property Head() As NodePtr
    Declare Property Tail() As NodePtr
    
    '' shallow copy isn't good enough for a LinkedList
    Declare Operator Let(ByRef other As _LinkedListType)
    Declare Operator +=(_PassType newData As FBType)
    '' Also Operator Len()
    
#ifdef FB_CONTAINER_DEBUG
    Declare Sub PrintContainer() override
#endif
    Declare Destructor()

End Type

Private Constructor _LinkedListType
__CONT_DBG_PRINT("Default constructor")
    _head = 0
    _count = 0
End Constructor

Private Constructor _LinkedListType(ByVal iterator As _IteratorInterfaceType Ptr)
	Constructor()
__CONT_DBG_PRINT("Iterator constructor")
    
    While iterator->Advance()
        AddTail(iterator->Item())
    Wend
End Constructor

Private Constructor _LinkedListType(ByRef iterator As _IteratorInterfaceType)
	Constructor(@iterator)
End Constructor

Private Constructor _LinkedListType(newData() As FBType)
	Constructor()
__CONT_DBG_PRINT("Array constructor")
    dim arrLBound As Long
    dim arrUBound As Long
    
    If __CONT_GetArrayInfo(newData, arrLBound, arrUBound) > 0 Then
        dim i As Long
		For i = arrLBound to arrUBound
		    AddTail(newData(i))
		Next
    End If
    
End Constructor

Private Constructor _LinkedListType(ByVal objects As _ContainerInterfaceType Ptr)
	Constructor()
__CONT_DBG_PRINT("ContainerPtr constructor - &", Hex(objects))
    Dim iter As _IteratorInterfaceType Ptr = objects->GetIterator()
    While iter->Advance()
		AddTail(iter->Item())
    Wend
    Delete iter
End Constructor

Private Constructor _LinkedListType(ByRef objects As _ContainerInterfaceType)
	Constructor(@objects)
	Print "ContainerRef cons"
End Constructor

Private Destructor _LinkedListType
    Clear()
End Destructor

Private Function _LinkedListType._Add(_PassType newData As FBType, ByVal prevNode As SuperNodePtr, ByVal nextNode As SuperNodePtr) As NodePtr
    Dim newNode As SuperNodePtr = New __CONT_Internals._LinkedListNodeSuperType(newData, @This, nextNode, prevNode)
    Dim numElems As Long = Count
    If numElems = 0 Then
		_head = newNode
    End If
    _count = numElems + 1
    Return newNode
End Function

Private Function _LinkedListType.AddHead(_PassType newData As FBType) As NodePtr
    Dim oldHead As NodePtr = Head
__CONT_DBG_PRINT("before node &", Hex(oldHead))
    _head = _Add(newData, cast(SuperNodePtr, Tail), cast(SuperNodePtr, oldHead))
    Return _head
End Function

Private Function _LinkedListType.AddTail(_PassType newData As FBType) As NodePtr
    Dim oldTail As NodePtr = Tail
__CONT_DBG_PRINT("after node &", Hex(oldTail))
    Return _Add(newData, cast(SuperNodePtr, oldTail), cast(SuperNodePtr, Head))
End Function

Private Function _LinkedListType.AddBefore(_PassType newData As FBType, ByVal beforeThis As NodePtr) As NodePtr
__CONT_DBG_PRINT("before node &", Hex(beforeThis))
    
    If beforeThis = 0 Then 
		Return AddTail(newData)
    End If
    If _CheckNodeOwnership(beforeThis, @This) = False Then
		Dim pSuperNode As SuperNodePtr = cast(SuperNodePtr, beforeThis)
__CONT_DBG_PRINT("Trying to AddBefore node & that belongs to a different list (&), this list (&), ignoring", Hex(beforeThis); Hex(pSuperNode->Parent); Hex(@This))
		__CONT_Internals_SetError(1)
		Return 0
    End If
    dim newNode As NodePtr =  _Add(newData, cast(SuperNodePtr, beforeThis->Back), cast(SuperNodePtr, beforeThis))
    If beforeThis = _head Then
		_head = newNode
    End If
    Return newNode
End Function

Private Function _LinkedListType.AddAfter(_PassType newData As FBType, ByVal afterThis As NodePtr) As NodePtr
__CONT_DBG_PRINT("after node &", Hex(afterThis))
    If afterThis = 0 Then
		Return AddHead(newData)
    End If
    If _CheckNodeOwnership(afterThis, @This) = False Then
		Dim pSuperNode As SuperNodePtr = cast(SuperNodePtr, afterThis)
__CONT_DBG_PRINT("Trying to AddAfter node & that belongs to a different list (&), this list (&), ignoring", Hex(afterThis); Hex(pSuperNode->Parent); Hex(@This))
		__CONT_Internals_SetError(1)
		Return 0
    End If
    Return _Add(newData, cast(SuperNodePtr, afterThis), cast(SuperNodePtr, afterThis->Forward))
End Function

Private Sub _LinkedListType.Clear()
	Dim n As Long = Count
__CONT_DBG_PRINT("& elements"; n)

	If n > 0 Then
		Dim As _LinkedListNodeType Ptr pNext = Head, pCur
		For i As Long = 0 To n - 1
			pCur = pNext
			pNext = pNext->Forward
			Delete cast(SuperNodePtr, pCur)
		Next
		Assert(pNext = _head)
		_head = 0
		_count = 0
    End If
End Sub

Private Sub _LinkedListType.CopyTo(newData() as FBType)
__CONT_DBG_PRINT("with & elements"; Count)

    __CONT_Internals.ContainerToArray(@This, newData())
End Sub

Private Function _LinkedListType.Contains(_PassType element As FBType) As Boolean
__CONT_DBG_PRINT("")
    Dim savedHead As NodePtr = Head
    Dim temp As NodePtr = savedHead
    Dim found As Boolean = False
    
    If savedHead <> 0 Then    
		Do
			found = (temp->Data = element)
			temp = temp->Forward
		Loop While (found = False) AndAlso (temp <> savedHead)
    End If
    
    Return found
    
End Function

Private Function _LinkedListType.Empty() As Boolean
	Dim n As Long = Count
__CONT_DBG_PRINT("Returning &", n = 0)
	Return n = 0
End Function

Private Function _LinkedListType.Find(_PassType toFind As FBType, ByVal startNode As NodePtr) As NodePtr
	Dim n As Long = Count
__CONT_DBG_PRINT("looking through & nodes starting at &", n; Hex(startNode))
	If (startNode <> 0) AndAlso (_CheckNodeOwnership(startNode, @This) = False) Then
		Dim pSuperNode As SuperNodePtr = cast(SuperNodePtr, startNode)
__CONT_DBG_PRINT("Trying to search from node & that belongs to a different list (&), this list (&), ignoring", Hex(startNode); Hex(pSuperNode->Parent); Hex(@This))
		__CONT_Internals_SetError(1)
		Return 0
    End If
	If n > 0 Then
		Dim As NodePtr pIter = Iif(startNode = 0, Head, startNode), pEnd = pIter
		Do
			If pIter->Data = toFind Then Return pIter
			pIter = pIter->Forward
		Loop While pIter <> pEnd
	End If
	Return 0
End Function

Private Function _LinkedListType.GetIterator() As _IteratorInterfaceType Ptr
__CONT_DBG_PRINT("for & elements"; Count)
    Return New _LinkedListIteratorType(Head)

End Function

Private Function _LinkedListType.RemoveNode(ByVal node As NodePtr) As NodePtr
	Dim numNodes As Long = Count
__CONT_DBG_PRINT("Removing node at & from list with & entries", Hex(node); numNodes)
    If node = 0 OrElse numNodes = 0 Then Return 0
    
    If _CheckNodeOwnership(node, @This) = False Then
		Dim pSuperNode As SuperNodePtr = cast(SuperNodePtr, node)
__CONT_DBG_PRINT("Trying to remove node & that belongs to a different list (&), this list (&), ignoring", Hex(node); Hex(pSuperNode->Parent); Hex(@This))
		__CONT_Internals_SetError(1)
		Return 0
	End If
    
    Dim next_ As SuperNodePtr = cast(SuperNodePtr, node->Forward)
    Dim prev As SuperNodePtr = cast(SuperNodePtr, node->Back)
    
    '' Circuar list, this should never happen
    Assert((next_ <> 0) AndAlso (prev <> 0))
    
    next_->Back = prev
    prev->Forward = next_
    
    '' If we're removing the head and its the last node, 
    '' set our list to 0, otherwise set the new head
    If node = _head Then
		If numNodes = 1 Then
			next_ = 0
		End If
		_head = next_
    End If
    
    Delete cast(SuperNodePtr, node)
    _count = numNodes - 1
    
    Return next_

End Function

Private Property _LinkedListType.Count() As Long
__CONT_DBG_PRINT("Count returning &", _count)
    Return _count
End Property

Private Property _LinkedListType.Head() As NodePtr
__CONT_DBG_PRINT("Returning &", Hex(_head))
    Return _head
End Property

Private Property _LinkedListType.Tail() As NodePtr
	Dim ret As NodePtr = IIf(_head = 0, 0, _head->Back)
__CONT_DBG_PRINT("Returning &", Hex(ret))
	Return ret
End Property

Private Operator _LinkedListType.Let(ByRef other As _LinkedListType)
__CONT_DBG_PRINT("assigning LinkedList & from LinkedList & with & elements"; Hex(@This); Hex(@other); other.Count)
	'' Self assignation is logically a no-op and it could be quite an expensive 'do-nothing'
	'' so don't do it
	If @other = @This Then Exit Operator
	Clear()
	Dim As NodePtr pHead = other.Head, pIter = pHead
	If pHead <> 0 Then
		Do
			AddTail(pIter->Data)
			pIter = pIter->Forward
		Loop Until pIter = pHead
	End If
End Operator

Private Function _LinkedListType._CheckNodeOwnership(ByVal node As NodePtr, ByVal container As _LinkedListType Ptr) As Boolean

    Return cast(SuperNodePtr, node)->Parent = container

End Function

#ifdef FB_CONTAINER_DEBUG
Private Sub _LinkedListType.PrintContainer()
	Dim n As Long = Count
	Print __FB_QUOTE__(_ListType) " at " & Hex(@This) & " has " & n & " elements:"
	
	If n > 0 Then
		Dim i As Long = 1
		Dim iter As NodePtr = Head
		Do
			Print Using "Node &) 0x&"; i; Hex(iter)
			i += 1
			iter = iter->Forward
		Loop Until iter = head
	End If
	
End Sub
#endif

Private Operator _LinkedListType.+=(_PassType newData As FBType)
	__CONT_DBG_PRINT("")
	AddTail(newData)
End Operator

Private Operator Len(Byref list As _LinkedListType) As Integer
	Return list.Count
End Operator

#undef SuperNodePtr
#undef NodePtr

#endif '' __FB_QUOTE__(_TypeDefine()) <> "1"

#undef _LinkedListType
#undef _LinkedListNodeType
#undef _LinkedListNodeSuperType
#undef _LinkedListTypePtr
#undef _LinkedListIteratorType
#undef _ContainerInterfaceType
#undef _IteratorInterfaceType
#undef _TypeDefine
#undef _PassType

#endmacro

'' Use this at global scope to generate the code for the list type
'' One of these is required for every separate type you want to put in a list
'' FBCont_DefineLinkedListOf(Any Ptr) '' for an any ptr list
'' FBCont_DefineLinkedListOf(MyNamespace, MyType) '' for a type in a namespace
#macro FBCont_DefineLinkedListOf(Type...)

__CONT_DefineLinkedListOf_(__FB_MakeFBType(Type), __FB_MakePPType(Type))

#endmacro '' FBCont_DefineLinkedListOf

#macro FBCont_DefineLinkedListNodeOf(Type...)

__CONT_DefineLinkedListNodeOf_(__FB_MakeFBType(Type), __FB_MakePPType(Type))

#endmacro

'' Use these to declare your variable types
'' Dim myList As FB_LinkedList(Any Ptr)
'' Dim myList As FB_LinkedList(MyNamespace, MyType)
'' Dim myNode As FB_LinkedListNode(MyNamespace, MyType)
'' Dim pMyNode As FB_LinkedListNode(MyNamespace, MyType) Ptr
#define FB_LinkedList(Type...) __FB_JOIN__(LinkedList, __FB_MakePPType(Type))
#define FB_LinkedListNode(Type...) __FB_JOIN__(LinkedListNode, __FB_MakePPType(Type)) Ptr
#define FB_LinkedListNodePtr(Type...) FB_LinkedListNode(Type)

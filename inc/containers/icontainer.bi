#include once "_typemacros.bi"
#include once "iiterator.bi"
#include once "_helpers.bi"

#pragma once

#if defined(FB_CONTAINER_LOG_CALLS)
#macro __CONT_DBG_PRINT(str, params...) 
If ..__CONT_Internals.g_stopRecursiveLoggingFlag = False Then
    ..__CONT_Internals.g_stopRecursiveLoggingFlag = True
#if __FB_ARG_COUNT__(params) > 0
    Print Using "FBContainerDbg: & " str; __FUNCTION__; params
#else
    Print Using "FBContainerDbg: & " str; __FUNCTION__
#endif
    ..__CONT_Internals.g_stopRecursiveLoggingFlag = False
End If
#endmacro
#else
#define __CONT_DBG_PRINT(str, params...) 
#endif

#macro __CONT_DefineIContainerOf_(FBType, PPType)

__CONT_DefineIIteratorOf_(FBType, PPType)

#define _ContainerInterfaceType __FB_JOIN__(IContainer, PPType)
#define _IteratorInterfaceType __FB_JOIN__(IIterator, PPType)
#define _TypeDefine() __FB_JOIN__(__CONT_, __FB_JOIN__(_ContainerInterfaceType, _DEFINED))
__FB_DefinePassType(FBType, _PassType)

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _ContainerInterfaceType)
#endif

Type _ContainerInterfaceType extends Object

    Declare abstract Sub Clear()
    Declare abstract Property Count() As Long
    Declare abstract Sub CopyTo(newData() As FBType)
    Declare abstract Function Contains(_PassType element As FBType) As Boolean
    Declare abstract Function GetIterator() As _IteratorInterfaceType Ptr
#ifdef FB_CONTAINER_DEBUG
    Declare abstract Sub PrintContainer()
#endif
    Declare virtual Destructor()

End Type

Private Virtual Destructor _ContainerInterfaceType()
End Destructor

Namespace __CONT_Internals

Private Sub ContainerToArray Overload (ByVal pContainer As _ContainerInterfaceType Ptr, newData() As FBType)
    If pContainer = 0 OrElse pContainer->Count = 0 Then
        __CONT_DBG_PRINT("Container (&) was null or empty, not copying", Hex(pContainer))
        __CONT_Internals_SetError(1)
        Exit Sub
    End If
    Dim pIterator As _IteratorInterfaceType Ptr = pContainer->GetIterator()
    dim toCopy As Long = pContainer->Count
    dim arrUBound As Long
    dim arrLBound As Long
    dim arrayElems As Long = __CONT_GetArrayInfo(newData, arrLBound, arrUBound)
    if arrayElems <= 0 Then
        arrayElems = toCopy
        Redim newData(0 To arrayElems - 1)
    End If
    dim newDataPtr As FBType Ptr = @newData(arrLBound)
    dim maxToCopy As Long = IIf(toCopy < arrayElems, toCopy, arrayElems)
    dim i As Long = 0
    While (pIterator->Advance()) AndAlso (i < maxToCopy)
        newDataPtr[i] = pIterator->Item()
        i += 1
    Wend
    Delete pIterator
End Sub

Private Sub ReverseArray Overload(arr() As FBType)
	Dim As Long arrLBound, arrUBound, numElems = __CONT_GetArrayInfo(arr, arrLBound, arrUBound)
	If numElems > 0 Then
		Dim elemPtr As FBType Ptr = @arr(arrLBound)
		Dim halfWay As Long = numElems \ 2
		For i As Long = 0 To halfWay - 1
			Swap elemPtr[arrLBound + i], elemPtr[arrUBound - i]
		Next
	End If
End Sub

End Namespace

#endif '' __FB_QUOTE__(__TypeDefine()) <> "1"

#undef _ContainerInterfaceType
#undef _IteratorInterfaceType
#undef _TypeDefine
#undef _PassType

#endmacro

'' Use this at global scope to generate the code for the container interface type
'' You shouldn't need to do this manually, a compatible interface type is 
'' automatically generated for each type of container defined
''
'' Otherwise, if you require one seperately then the type arguments should be the
'' type to be contained
'' FBCont_DefineIContainerOf(Any Ptr) '' for an any ptr container interface
'' FBCont_DefineIContainerOf(MyNamespace, MyType) '' for a type in a namespace
#macro FBCont_DefineIContainerOf(Type...)

__CONT_DefineIContainerOf_(__FB_MakeFBType(Type), __FB_MakePPType(Type))

#endmacro '' FBCont_DefineIContainerOf

'' Use this to declare your variable type
'' Dim myList As FB_IContainer(Any Ptr)
'' Dim myList As FB_IContainer(MyNamespace, MyType)
#define FB_IContainer(Type...) __FB_JOIN__(IContainer, __FB_MakePPType(Type))

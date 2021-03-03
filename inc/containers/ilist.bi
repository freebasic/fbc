#include once "_typemacros.bi"
#include once "icontainer.bi"

#pragma once

#macro __CONT_DefineIListOf_(FBType, PPType)

__CONT_DefineIContainerOf_(FBType, PPType)

#define _ListInterfaceType		__FB_JOIN__(IList, PPType)
#define _ContainerInterfaceType __FB_JOIN__(IContainer, PPType)
#define _IteratorInterfaceType	__FB_JOIN__(IIterator, PPType)
#define _TypeDefine()			__FB_JOIN__(__CONT_, __FB_JOIN__(_ListInterfaceType, _DEFINED))
__FB_DefinePassType(FBType, _PassType)

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _ListInterfaceType)
#endif

Type _ListInterfaceType extends _ContainerInterfaceType

    Declare abstract Sub Add(_PassType element As FBType)
    Declare abstract Function First() ByRef As FBType
    Declare abstract Function Last() ByRef As FBType
    Declare abstract Function IndexOf(_PassType element As FBType) As Long
    Declare abstract Sub Insert(ByVal index As Long, _PassType newData As FBType)
    Declare abstract Function LastIndexOf(_PassType element As FBType) As Long
    Declare abstract Sub Remove(_PassType element As FBType)
    Declare abstract Sub RemoveAt(Byval index As Long)
    Declare abstract Operator [] (ByVal index AS Long) ByRef As FBType

End Type

#endif '' __FB_QUOTE__(_TypeDefine()) <> "1"

#undef _ListInterfaceType
#undef _ContainerInterfaceType
#undef _IteratorInterfaceType
#undef _TypeDefine
#undef _PassType

#endmacro '' __CONT_DefineIListOf_

'' Use this at global scope to generate the code for the list interface type
'' You shouldn't need to do this manually, a compatible interface type is 
'' automatically generated for each type of container defined
''
'' Otherwise, if you require one seperately then the type arguments should be the
'' type to be contained in the list
'' FBCont_DefineIListOf(Any Ptr) '' for an any ptr list interface
'' FBCont_DefineIListOf(MyNamespace, MyType) '' for a type in a namespace
#macro FBCont_DefineIListOf(args...)

__CONT_DefineIListOf_(__FB_MakeFBType(args), __FB_MakePPType(args))

#endmacro '' FBCont_DefineIListOf

'' Use this to declare your variable type
'' Dim myList As FB_IList(Any Ptr)
'' Dim myList As FB_IList(MyNamespace, MyType)
#define FB_IList(Type...) __FB_JOIN__(IList, __FB_MakePPType(Type))

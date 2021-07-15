#include once "_typemacros.bi"

#pragma once

#macro __CONT_DefineIIteratorOf_(FBType, PPType)

#ifndef _IteratorInterfaceType
#define __CONT_NEEDS_ITER_UNDEF 1
#define _IteratorInterfaceType	 __FB_JOIN__(IIterator, PPType)
#endif
#define _IteratorTypeDefine()	 __FB_JOIN__(__CONT_, __FB_JOIN__(_IteratorInterfaceType, _DEFINED))

#if __FB_QUOTE__(_IteratorTypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_IteratorTypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _IteratorInterfaceType)
#endif

Type _IteratorInterfaceType extends object
	
	'' Types deriving from this base should also
	'' implement the for loop operators, these cannot be abstract
	'' so they're not listed here
	
	'' Declare Operator For()
	'' Declare Operator Next(ByRef cond As IteratorInterfaceType) As Integer
	'' Declare Operator Step()
	
	Declare abstract Function Advance() As Boolean
	Declare abstract Function Item() ByRef As FBType
	Declare abstract Sub Reset()
	
	Declare virtual Destructor()

End Type

Private Destructor _IteratorInterfaceType()
End Destructor

#endif '' _IteratorTypeDefine <> "1"

#ifdef __CONT_NEEDS_ITER_UNDEF
#undef _IteratorInterfaceType
#undef __CONT_NEEDS_ITER_UNDEF
#endif
#undef _IteratorTypeDefine

#endmacro '' DefineIIteratorOf_


'' Use this at global scope to generate the code for the iterator interface type
'' You shouldn't need to do this manually, a compatible interface type is 
'' automatically generated for each type of container defined
''
'' Otherwise, if you require one seperately then the type arguments should be the
'' type to be iterated
'' FBCont_DefineIIteratorOf(Any Ptr) '' for an any ptr iterator interface
'' FBCont_DefineIIteratorOf(MyNamespace, MyType) '' for a type in a namespace
#macro FBCont_DefineIIteratorOf(Type...)

__CONT_DefineIIteratorOf_(__FB_MakeFBType(Type), __FB_MakePPType(Type))

#endmacro '' FBCont_DefineIIteratorOf

'' Use this to declare your variable type
'' Dim myList As FB_IIterator(Any Ptr)
'' Dim myList As FB_IIterator(MyNamespace, MyType)
#define FB_IIterator(Type...) __FB_JOIN__(IIterator, __FB_MakePPType(Type))

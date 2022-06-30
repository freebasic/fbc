#include once "_typemacros.bi"
#include once "iiterator.bi"
#include once "ilist.bi"

#pragma once

'' Defines an iterator that enumerates a Dictionary's items in no particular order
'' TupleType - the tuple that contains key & value
'' ListType - the _ContainedDictType from the Dictionary being iterated
#macro __CONT_DefineDictionaryIteratorOf_(FBTupleType, PPTupleType, FBListType, PPListType)

__CONT_DefineIListOf_(FBListType, PPListType)
__CONT_DefineIIteratorOf_(FBTupleType, PPTupleType)

#define _DictionaryIteratorType		__FB_JOIN__(DictionaryIterator, PPTupleType)
#define _IteratorInterfaceType		__FB_JOIN__(IIterator, PPTupleType)
#define _ListInterfaceType		__FB_JOIN__(IList, PPListType)
#define _TypeDefine()			__FB_JOIN__(__CONT_, __FB_JOIN__(_DictionaryIteratorType, _DEFINED))

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _DictionaryIteratorType)
#endif

Type _DictionaryIteratorType extends _IteratorInterfaceType
Private:
    dim parentDictionary As _ListInterfaceType Ptr
    dim curPos As Long

    Declare Function _FindNext() As Long
    
Public:
    Declare Constructor(ByVal parent As _ListInterfaceType Ptr)
    Declare Constructor()
    Declare Operator For()
    Declare Operator Next(ByRef cond As _DictionaryIteratorType) As Integer
    Declare Operator Step()
	
    Declare Function Advance() As Boolean Override
    Declare Function Item() Byref As FBTupleType Override
    Declare Sub Reset() Override
End Type

Private Constructor _DictionaryIteratorType(ByVal parent As _ListInterfaceType Ptr)
__CONT_DBG_PRINT("Dictionary iterator constructor with list &", Hex(parent))
    parentDictionary = parent
    curPos = -1
End Constructor

Private Constructor _DictionaryIteratorType()
__CONT_DBG_PRINT("Default constructor (end iterator)")
    parentDictionary = 0
    curPos = -1
End Constructor

Private Function _DictionaryIteratorType._FindNext() As Long
    dim iter as Long = curPos
    iter += 1
    dim numElems As Long = parentDictionary->Count
    While iter < numElems
        if((*parentDictionary)[iter].hash <> ..__CONT_Internals.g_invalidHash) then
            Return iter
        end if
        iter += 1
    Wend
    Return -1
End Function

Private Operator _DictionaryIteratorType.For()
__CONT_DBG_PRINT("Starting for")
    curPos = 0
End Operator

Private Operator _DictionaryIteratorType.Next(ByRef cond As _DictionaryIteratorType) As Integer
__CONT_DBG_PRINT("")
    Return (curPos <> cond.curPos) AndAlso (curPos >= 0)
End Operator

Private Operator _DictionaryIteratorType.Step()
    Dim from As Long = curPos
    curPos = _FindNext()
__CONT_DBG_PRINT("Stepped from & to &", from; curPos)
End Operator

Private Function _DictionaryIteratorType.Advance() As Boolean
    Dim from As Long = curPos
    dim nextPos as Long = _FindNext()
__CONT_DBG_PRINT("Advancing from & to &", from; nextPos)
    curPos = nextPos
    Return (curPos > 0) AndAlso (curPos < parentDictionary->Count)
End Function

Private Function _DictionaryIteratorType.Item() ByRef As FBTupleType
__CONT_DBG_PRINT("Accessing Item &", curPos)
    dim byref entryData as FBListType = (*parentDictionary)[curPos]
    Return entryData.tuple
End Function

Private Sub _DictionaryIteratorType.Reset()
__CONT_DBG_PRINT("Resetting")
    curPos = -1
End Sub

#endif '' __FB_JOIN__(_DictionaryIteratorType, _DEFINED)

#undef _DictionaryIteratorType
#undef _IteratorInterfaceType
#undef _ListInterfaceType
#undef _TypeDefine

#endmacro '' _CONT_DefineDictionaryIterator_

'' Use this at global scope to generate the code for the listiterator type
'' You shouldn't need to do this manually, a compatible list iterator type is 
'' automatically generated for each type of container defined
''
'' Otherwise one of these is required for every separate type of list to iterate
'' The type should be the type contained in the list being iterated
'' FBCont_DefineDictionaryIteratorOf(Any Ptr) '' for an any ptr list iterator
'' FBCont_DefineDictionaryIteratorOf(MyNamespace, MyType) '' for a type in a namespace
#macro FBCont_DefineDictionaryIteratorOf(KeyType, ValueType)

#define PPKey _FB_MakePPType KeyType
#define PPValue _FB_MakePPType ValueType
#define TupleType __CONT_MakeDictionaryTupleTypeName(PPKey, PPValue)
#define DictType __CONT_MakeContainedDictionaryTypeName(PPKey, PPValue)
#define TupleTypeNS __CONT_MakeDictionaryTupleTypeName(PPKey, PPValue)
#define DictTypeNS __CONT_MakeContainedDictionaryTypeName(PPKey, PPValue)

__CONT_DefineDictionaryIteratorOf_( __CONT_Internals.TupleType, TupleType, __CONT_Internals.DictType, DictType )

#undef PPKey
#undef PPValue
#undef TupleType
#undef DictType
#undef TupleTypeNS
#undef DictTypeNS

#endmacro

'' Use this to declare your variable type
'' Dim myDictionary As FB_DictionaryIterator((Any Ptr), (Uinteger))
'' Dim myDictionary As FB_DictionaryIterator((MyNamespace, MyType), (Boolean))
#define FB_DictionaryIterator(KeyType, ValueType) _
    __FB_JOIN__(DictionaryIterator, _
        __CONT_MakeDictionaryTupleTypeName( _
            __FB_MakePPType KeyType, _
            __FB_MakePPType ValueType _
        ) _
    )

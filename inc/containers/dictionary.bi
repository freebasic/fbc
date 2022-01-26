#include once "_typemacros.bi"
#include once "_helpers.bi"
#include once "icontainer.bi"
#include once "list.bi"
#include once "dictionaryiterator.bi"

#pragma once

namespace __CONT_Internals

#Ifdef __FB_64BIT__
Const g_hashMask As UInteger = &H7fffffffffffffff
Const g_hashPrime As UInteger = 1099511628211
Const g_hashSeed As UInteger = 14695981039346656037
#else
Const g_hashMask As UInteger = &H7fffffff
Const g_hashPrime As UInteger = 16777619
Const g_hashSeed As UInteger = 2166136261
#endif
const g_invalidHash As UInteger = cast(UInteger, -1)
const g_invalidnextIndex As Long = -1
Const g_maxPrimeIndex as ULong = 71
Dim Shared g_sizePrimes(0 To g_maxPrimeIndex) as Const ULong = { _
    3, 7, 11, 17, 23, 29, 37, 47, 59, 71, 89, 107, 131, 163, 197, 239, 293, 353, 431, 521, 631, 761, 919, _
    1103, 1327, 1597, 1931, 2333, 2801, 3371, 4049, 4861, 5839, 7013, 8419, 10103, 12143, 14591, _
    17519, 21023, 25229, 30293, 36353, 43627, 52361, 62851, 75431, 90523, 108631, 130363, 156437, _
    187751, 225307, 270371, 324449, 389357, 467237, 560689, 672827, 807403, 968897, 1162687, 1395263, _
    1674319, 2009191, 2411033, 2893249, 3471899, 4166287, 4999559, 5999471, 7199369 _
}

'' simple FNV1a hash over a string
Private Function SimpleHashString(key as String) As UInteger
    dim size as Long = Len(key)
    dim keyPtr as UByte Ptr = StrPtr(key)

    dim hash as UInteger = g_hashSeed
    For i As Long = 0 to size - 1
        hash Xor= keyPtr[i]
        hash *= g_hashPrime
    Next
    return hash
End Function

Private Function SimpleHashZStringPtr(key as ZString Ptr) As UInteger
    dim size as Long = Len(*key)

    dim hash as UInteger = g_hashSeed
    For i As Long = 0 to size - 1
        hash Xor= key[i]
        hash *= g_hashPrime
    Next
    return hash
End Function

End Namespace

#define __CONT_MakeDictionaryTupleTypeName(PPKeyType, PPValueType) __FB_JOIN__(DictionaryTypeTuple, __FB_MakeTypeName(PPKeyType, PPValueType))
#define __CONT_MakeContainedDictionaryTypeName(PPKeyType, PPValueType) __FB_JOIN__(Contained, __FB_MakeTypeName(PPKeyType, PPValueType))

#macro __CONT_DefineDictionaryTupleTypes(FBKeyType, PPKeyType, FBValueType, PPValueType)

#define _DictTupleExt	__FB_MakeTypeName(PPKeyType, PPValueType)
#define _DictTupleType __FB_JOIN__(DictionaryTypeTuple, _DictTupleExt)
#define _ContainedDictType	__FB_JOIN__(Contained, _DictTupleExt)

#define _TupleTypeDefine()	__FB_JOIN__(__CONT_, __FB_JOIN__(_DictTupleType, _DEFINED))

#if __FB_QUOTE__(_TupleTypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TupleTypeDefine()) " 1"))

Namespace __CONT_Internals

Type _DictTupleType
    dim key as FBKeyType
    dim value as FBValueType
End Type

Type _ContainedDictType
    as _DictTupleType tuple
    as Long nextIndex
    as UInteger hash

    Declare Constructor()
End Type

Private Constructor _ContainedDictType()
    nextIndex = ..__CONT_Internals.g_invalidnextIndex
    hash = ..__CONT_Internals.g_invalidHash
End Constructor

Private Operator=(Byref one as _ContainedDictType, Byref two as _ContainedDictType) As Integer
    Return (one.hash = two.hash) AndAlso (one.tuple.key = two.tuple.key)
End Operator

End Namespace '' __CONT_Internals

#endif '' _TupleTypeDefine()

#undef _TupleTypeDefine
#undef _ContainedDictType
#undef _DictTupleExt
#undef _DictTupleType

#endmacro '' __CONT_DefineDictionaryTupleType

'' Defines a mapping from keys to values like a C++ map or 
'' or a C#/Java/Python dictionary
'' Each key can only be in the dictionary once!

#macro __CONT_DefineDictionaryOf_(FBKeyType, PPKeyType, FBValueType, PPValueType)

__CONT_DefineDictionaryTupleTypes(FBKeyType, PPKeyType, FBValueType, PPValueType)

#define _DictTupleExt __FB_JOIN__(PPKeyType, PPValueType)
#define _DictTupleType __CONT_MakeDictionaryTupleTypeName(PPKeyType, PPValueType)
#define _DictTupleTypeNS __CONT_Internals._DictTupleType
#define _ContainedDictType __CONT_MakeContainedDictionaryTypeName(PPKeyType, PPValueType)
#define _ContainedDictTypeNS __CONT_Internals._ContainedDictType

__CONT_DefineIContainerOf_(_DictTupleTypeNS, _DictTupleType)
__CONT_DefineDictionaryIteratorOf_(_DictTupleTypeNS, _DictTupleType, _ContainedDictTypeNS, _ContainedDictType)
__CONT_DefineListOf_(_ContainedDictTypeNS, _ContainedDictType)
__CONT_DefineListOf_(Long, Long)

#define _HashFnType		__FB_JOIN__(FBDictionaryHashFn, PPKeyType)
#define _HashFnTypeDefine() 	__FB_JOIN__(__CONT_, __FB_JOIN__(_HashFnType, _DEFINED))
#define _DictType		__FB_JOIN__(Dictionary, _DictTupleExt)
#define _DictIteratorType	__FB_JOIN__(DictionaryIterator, _DictTupleType)
#define _ContainerInterfaceType __FB_JOIN__(IContainer, _DictTupleType)
#define _IteratorInterfaceType	__FB_JOIN__(IIterator, _DictTupleType)
#define _TypeDefine()		__FB_JOIN__(__CONT_, __FB_JOIN__(_DictType, _DEFINED))
__FB_DefinePassType(FBKeyType, _PassTypeKey)
__FB_DefinePassType(FBValueType, _PassTypeValue)

#if __FB_QUOTE__(_HashFnTypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_HashFnTypeDefine()) " 1"))

Type _HashFnType As Function (_PassTypeKey key As FBKeyType) As UInteger

#define _HashFnName		__FB_JOIN__(SimpleHash, PPKeyType)

#If Not (__FB_Is_String(FBKeyType) OrElse __FB_Type_Equals(FBKeyType, ZString Ptr))

Namespace __CONT_Internals

'' simple FNV1a hash over the bytes of key
Private Function _HashFnName(_PassTypeKey key as FBKeyType) As UInteger
#If __FB_Is_Ptr(FBKeyType)
    dim size as Long = SizeOf(*key)
    dim keyPtr as UByte Ptr = cast(UByte Ptr, key)
#else
    dim size as Long = SizeOf(FBKeyType)
    dim keyPtr as UByte Ptr = cast(UByte Ptr, @key)
#endif

    dim hash as UInteger = ..__CONT_Internals.g_hashSeed
    For i As Long = 0 to size - 1
        hash Xor= keyPtr[i]
        hash *= ..__CONT_Internals.g_hashPrime
    Next
    return hash
End Function

End Namespace

#endif '' KeyType = String

#endif '' _HashFnTypeDefine

#if __FB_QUOTE__(_TypeDefine()) <> "1"
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(_TypeDefine()) " 1"))

#ifdef FB_CONTAINER_DEBUG
#Print __FB_JOIN__(Containers: Generating-, _DictType)
#endif

Type _DictType extends _ContainerInterfaceType
Private:
    dim _hasher as _HashFnType
    dim _items as FB_List(_ContainedDictType)
    dim _slots as FB_List(Long)
    dim _primeIndex as Long
    dim _count as Long
    dim _freeEntry As Long

    Declare Sub _Add(_PassTypeKey key as FBKeyType, _PassTypeValue value as FBValueType, overwrite as Boolean)
    Declare Sub _InitLists()
    Declare Sub _Resize(reHash as Boolean)
    Declare Function _FindItem(_PassTypeKey key as FBKeyType) As Long
    
Public:
    Declare Constructor(hashFn as _HashFnType = @__CONT_Internals._HashFnName)
    Declare Constructor(ByRef cont as _ContainerInterfaceType, hasher as _HashFnType = @__CONT_Internals._HashFnName)
    Declare Constructor(cont as _ContainerInterfaceType Ptr, hasher as _HashFnType = @__CONT_Internals._HashFnName)
    Declare Constructor(ByRef iterator as _IteratorInterfaceType, hasher as _HashFnType = @__CONT_Internals._HashFnName)
    Declare Constructor(iterator as _IteratorInterfaceType Ptr, hasher as _HashFnType = @__CONT_Internals._HashFnName)

    Declare Sub Add(_PassTypeKey key as FBKeyType, _PassTypeValue value as FBValueType)
    Declare Sub Add(iterator As _IteratorInterfaceType Ptr)
    Declare Sub Add(container As _ContainerInterfaceType Ptr)
    Declare Sub Add(ByRef iterator As _IteratorInterfaceType)
    Declare Sub Add(ByRef container As _ContainerInterfaceType)
    Declare Sub Clear() override
    Declare Sub CopyTo(newData() As _DictTupleTypeNS) override
    Declare Function Contains(ByRef element As __CONT_Internals._DictTupleType) As Boolean override
    Declare Function Empty() As Boolean
    Declare Function Exists(_PassTypeKey key as FBKeyType) As Boolean
    Declare Function GetIterator() As _IteratorInterfaceType Ptr override
    Declare Function Get(_PassTypeKey key as FBKeyType) ByRef as FBValueType
    Declare Sub Remove(_PassTypeKey key as FBKeyType)
    Declare Function TestAndGet(_PassTypeKey key as FBKeyType, outValue as FBValueType Ptr) As Boolean
    Declare Sub Update(_PassTypeKey key as FBKeyType, _PassTypeValue value as FBValueType)

#ifdef FB_CONTAINER_DEBUG
    Declare Sub PrintContainer() override
#endif

    Declare Property Item(_PassTypeKey key AS FBKeyType) ByRef As FBValueType
    Declare Property Item(_PassTypeKey key AS FBKeyType, _PassTypeValue As FBValueType)
    Declare Property Count() As Long override

    Declare Operator [] (_PassTypeKey key AS FBKeyType) ByRef As FBValueType
    '' Also Operator Len()
End Type

Private Constructor _DictType(hashFn as _HashFnType)
__CONT_DBG_PRINT("Default constructor with hashFn at &", Hex(hashFn))
    _hasher = hashFn
    _InitLists()
End Constructor

Private Constructor _DictType(cont as _ContainerInterfaceType Ptr, hashFn as _HashFnType)
__CONT_DBG_PRINT("Container constructor with hashFn at &", Hex(hashFn))
    _hasher = hashFn
    _InitLists()
    dim pIter As _IteratorInterfaceType Ptr = cont->GetIterator()
    Add(pIter)
    Delete pIter
End Constructor

Private Constructor _DictType(ByRef cont as _ContainerInterfaceType, hasher as _HashFnType)
    Constructor(@cont, hasher)
End Constructor

Private Constructor _DictType(iter as _IteratorInterfaceType Ptr, hasher as _HashFnType)
__CONT_DBG_PRINT("Iterator constructor with hashFn at &", Hex(hasher))
    _hasher = hasher
    _InitLists()
    Add(iter)
End Constructor

Private Constructor _DictType(ByRef iter as _IteratorInterfaceType, hasher as _HashFnType)
    Constructor(@iter, hasher)
End Constructor

Private Sub _DictType._InitLists()
    _primeIndex = 1
    _freeEntry = -1
    _count = 0
    _Resize(False)
End Sub

Private Sub _DictType._Resize(reHash as Boolean)
    '' resize in larger steps at smaller sizes, 20 is arbitrary
    dim newPrimeIndex as ULong
    if _primeIndex < 20 then 
        newPrimeIndex = _primeIndex + 2
    else
        newPrimeIndex = _primeIndex + 1
    end if
    '' can't get bigger than a max prime figure
    If newPrimeIndex > ..__CONT_Internals.g_maxPrimeIndex then Exit Sub
    _primeIndex = newPrimeIndex
    dim newSize As ULong = ..__CONT_Internals.g_sizePrimes(newPrimeIndex)
    dim origSize As ULong = _slots.Count
__CONT_DBG_PRINT("From & to & slots", origSize; newSize)
    dim newSlots As FB_List(Long)
    newSlots.Resize(newSize)
    dim pNewSlots As Long Ptr = @newSlots[0]
    dim i As Long
    For i = 0 To newSize - 1
        pNewSlots[i] = -1
    Next
    dim newItems As FB_List(_ContainedDictType) = newSize
    If origSize > 0 Then
        newItems.Add(_items)
        dim As __CONT_Internals._ContainedDictType Ptr pItem = @newItems[0], pItemBase = pItem
        For i = 0 To origSize - 1
            if(reHash AndAlso (pItem->hash <> ..__CONT_Internals.g_invalidHash)) then
                pItem->hash = _hasher(pItem->tuple.key) And ..__CONT_Internals.g_hashMask
            end if
            if (pItem->hash <> ..__CONT_Internals.g_invalidHash) then
                dim as long slot = pItem->hash Mod newSize
                pItem->nextIndex = pNewSlots[slot]
                pNewSlots[slot] = i
            end if
        Next
    End If
    newItems.Resize(newSize)
    _slots = newSlots
    _items = newItems
End Sub

Private Sub _DictType.Add(iterator As _IteratorInterfaceType Ptr)
    Assert(iterator <> 0)
__CONT_DBG_PRINT("Adding items via iterator &", Hex(iterator))
    While iterator->Advance()
        dim byref pair as __CONT_Internals._DictTupleType = iterator->Item()
        _Add(pair.key, pair.value, False)
    Wend
End Sub

Private Sub _DictType.Add(container As _ContainerInterfaceType Ptr)
    Assert(container <> 0)
    dim iterator as _IteratorInterfaceType Ptr = container->GetIterator()
    Add(iterator)
    Delete iterator
End Sub

Private Sub _DictType.Add(ByRef iterator As _IteratorInterfaceType)
    Add(@iterator)
End Sub

Private Sub _DictType.Add(ByRef container As _ContainerInterfaceType)
    Add(@container)
End Sub

Private Sub _DictType.Add(_PassTypeKey key as FBKeyType, _PassTypeValue value as FBValueType)
    _Add(key, value, False)
End Sub

Private Sub _DictType._Add(_PassTypeKey key as FBKeyType, _PassTypeValue value as FBValueType, overwrite as Boolean)
    dim hash as UInteger = _hasher(key) And ..__CONT_Internals.g_hashMask
    dim slot as Long = hash Mod _slots.Count
    dim i as Long = _slots[slot]
    dim pItems As __CONT_Internals._ContainedDictType Ptr = @_items[0]
    While i <> ..__CONT_Internals.g_invalidnextIndex
        dim byref obj As __CONT_Internals._ContainedDictType = pItems[i]
        if(obj.hash = hash) AndAlso (key = obj.tuple.key) then
            if overwrite = False then
__CONT_DBG_PRINT("Attempting to add a duplicate key, erroring out", 0)
                 __CONT_Internals_SetError(1)
            end if
__CONT_DBG_PRINT("Updating item & with hash &"; i; Hex(hash))
            obj.tuple.value = value
            Exit Sub
        end if
        i = obj.nextIndex
    Wend
    dim entryIndex As Long
    If _freeEntry <> ..__CONT_Internals.g_invalidnextIndex Then
        entryIndex = _freeEntry
        _freeEntry = pItems[entryIndex].nextIndex
    Else
        If (_count = _items.Count) Then
            _Resize(False)
            slot = hash Mod _slots.Count
        End If
        entryIndex = _count
        _count += 1
    End If
__CONT_DBG_PRINT("Adding item at index &, slot &, with hash &"; entryIndex; slot; Hex(hash))
    dim byref newEntry As __CONT_Internals._ContainedDictType = _items[entryIndex]
    newEntry.tuple.key = key
    newEntry.tuple.value = value
    newEntry.hash = hash
    newEntry.nextIndex = _slots[slot]
    _slots[slot] = entryIndex
End Sub

Private Sub _DictType.Clear()
__CONT_DBG_PRINT("Clearing", 0)
    dim pSlots As Long Ptr = @_slots[0]
    For i As Long = 0 To _slots.Count
        pSlots[i] = -1
    Next
    _freeEntry = ..__CONT_Internals.g_invalidnextIndex
    _count = 0
    _items.Clear()
End Sub

Private Function _DictType.Contains(ByRef element As __CONT_Internals._DictTupleType) As Boolean
    Return Exists(element.key)
End Function

Private Sub _DictType.CopyTo(newData() As _DictTupleTypeNS)
    __CONT_Internals.ContainerToArray(@This, newData())
End Sub

Private Function _DictType.Empty() As Boolean
    Return _count = 0
End Function

Private Function _DictType._FindItem(_PassTypeKey key as FBKeyType) As Long
    If Empty() Then Return ..__CONT_Internals.g_invalidnextIndex
    dim hash as UInteger = _hasher(key) And ..__CONT_Internals.g_hashMask
    dim entryIndex as Long = _slots[hash Mod _slots.Count]
    dim pItems as __CONT_Internals._ContainedDictType Ptr = @_items[0]
    While entryIndex <> ..__CONT_Internals.g_invalidnextIndex
        dim byref obj As __CONT_Internals._ContainedDictType = pItems[entryIndex]
        if(obj.hash = hash) AndAlso (key = obj.tuple.key) then
            Exit While
        end if
        entryIndex = obj.nextIndex
    Wend
    Return entryIndex
End Function

Private Function _DictType.Exists(_PassTypeKey key as FBKeyType) As Boolean
    Return _FindItem(key) <> ..__CONT_Internals.g_invalidnextIndex
End Function

Private Function _DictType.Get(_PassTypeKey key as FBKeyType) ByRef As FBValueType
    dim index as Long = _FindItem(key)
    If index = ..__CONT_Internals.g_invalidnextIndex then
__CONT_DBG_PRINT("Couldn't find item, erroring")
        __CONT_Internals_SetError(1)
    End If
    Return _items[index].tuple.value
End Function

Private Function _DictType.GetIterator() As _IteratorInterfaceType Ptr
    Return New _DictIteratorType(@_items)
End Function

Private Sub _DictType.Remove(_PassTypeKey key as FBKeyType)
    dim hash as UInteger = _hasher(key) And ..__CONT_Internals.g_hashMask
    dim slot as Long = hash Mod _slots.Count
    dim lastSlot As Long = ..__CONT_Internals.g_invalidnextIndex
    dim pItems as __CONT_Internals._ContainedDictType Ptr = @_items[0]
    dim found as Boolean = False
    While slot <> ..__CONT_Internals.g_invalidnextIndex
        dim byref obj As __CONT_Internals._ContainedDictType = pItems[slot]
        found = ((obj.hash = hash) AndAlso (key = obj.tuple.key))
        if found then Exit While
        lastSlot = slot
        slot = obj.nextIndex
    Wend
    If found then
        dim byref obj As __CONT_Internals._ContainedDictType = pItems[slot]
        if lastSlot = ..__CONT_Internals.g_invalidnextIndex then
            _slots[slot] = obj.nextIndex
        else
            pItems[lastSlot].nextIndex = obj.nextIndex
        end if
        obj.hash = ..__CONT_Internals.g_invalidHash
        obj.nextIndex = _freeEntry
        _freeEntry = slot
    end if
End Sub

Private Function _DictType.TestAndGet(_PassTypeKey key as FBKeyType, outValue as FBValueType Ptr) As Boolean
    dim res as Boolean = Exists(key)
    If res Then *outValue = Get(key)
    Return res
End Function

Private Sub _DictType.Update(_PassTypeKey key as FBKeyType, _PassTypeValue value as FBValueType)
    _Add(key, value, True)
End Sub

#ifdef FB_CONTAINER_DEBUG
Private Sub _DictType.PrintContainer()
    Print "Dictionary mapping " & __FB_QUOTE__(FBKeyType);
    Print " to " & __FB_QUOTE__(FBValueType) & " at " & Hex(@This)
    dim numElems As Long = Count
    Print "Count: " & Str(numElems)
    Print "Capacity: " & Str(_slots.Count)
    Print "Hash function at: " & Hex(@_hasher)
    dim numFreeEntries as long = 0
    dim pItems As __CONT_Internals._ContainedDictType Ptr = @_items[0]
    For i As Long = 0 To numElems - 1
        Print "Entry " & Str(i + 1);
        dim hash as UInteger = pItems[i].hash
        If hash = ..__CONT_Internals.g_invalidHash then
            Print " free"
            numFreeEntries += 1
        Else
            Print ", hash " & Hex(hash)
        End If
    Next
    Print "Free entries: " & Str(numFreeEntries)
End Sub
#endif

Private Property _DictType.Count() As Long
    dim outCount As Long = _count
__CONT_DBG_PRINT("Returning Count of &", outCount)
    Return outCount
End Property

Private Property _DictType.Item(_PassTypeKey key as FBKeyType) Byref As FBValueType
    Return Get(key)
End Property

Private Property _DictType.Item(_PassTypeKey key as FBKeyType, _PassTypeValue value as FBValueType)
    _Add(key, value, True)
End Property

Private Operator Len(ByRef dict As _DictType) As Integer
	Return dict.Count
End Operator

#endif '' _TypeDefine()

#undef _HashFnName
#undef _HashFnType
#undef _HashFnTypeDefine
#undef _DictTupleType
#undef _DictTupleTypeNS
#undef _DictTupleExt
#undef _DictType
#undef _ContainedDictType
#undef _ContainedDictTypeNS
#undef _DictIteratorType
#undef _ContainerInterfaceType
#undef _IteratorInterfaceType
#undef _TypeDefine
#undef _PassTypeKey
#undef _PassTypeValue

#endmacro

'' Use this at global scope to generate the code for the list type
'' One of these is required for every separate type you want to put in a list
'' FBCont_DefineDictionaryOf((Long), (Any Ptr)) '' for an Long->any ptr dictionary
'' FBCont_DefineDictionaryOf((MyNamespace, MyType), (Long)) '' for a type in a namespace
''
'' If you get a Type Mismatch error on the macro line when defining a list for your UDT type
'' You need to implement Operator= 
#macro FBCont_DefineDictionaryOf(Key, Value)

__CONT_DefineDictionaryOf_( _
	__FB_MakeFBType Key , _
	__FB_MakePPType Key , _
	__FB_MakeFBType Value , _
	__FB_MakePPType Value _
)

#endmacro '' FBCont_DefineDictionaryOf

'' Use this to declare your variable type
'' Dim myList As FB_Dictionary((Handle), (Any Ptr))
'' Dim myList As FB_Dictionary((Long), (MyNamespace, MyType))
#define FB_Dictionary(KeyType, ValueType) __FB_JOIN__(Dictionary, __FB_MakeAssocTypeName(KeyType, ValueType))

#define FB_DictionaryTuple(KeyType, ValueType) __FB_JOIN__(__CONT_Internals., _
    __CONT_MakeDictionaryTupleTypeName( _
         __FB_MakePPType KeyType, _
         __FB_MakePPType ValueType _
    ) _
)

#include once "icontainer.bi"
#include once "../fbc-int/memory.bi"
#include once "../fbc-int/array.bi"
#include once "_helpers.bi"

#pragma once

#ifndef __CONT_BitContainer_DEFINED
#define __CONT_BitContainer_DEFINED 1

FBCont_DefineIContainerOf(Boolean)

#define _Min(x, y) IIf((x) < (y), (x), (y))

'' Sorry for the dodgy name but:
'' Bitset is already a function
'' Bitmap surely will conflict with somebodies graphic type
'' BitList would imply it's resizable (like the standard List container)
Type BitContainer extends FB_IContainer(Boolean)
Private:
	Dim _bits(Any) As UByte
	Dim _numBits As Long
	Const _allBitsOn As UByte = Not 0
	
	Declare Function _RoundToNext(ByVal val1 As Long, ByVal num As Long) As Long
	Declare Sub _CreateFromPointer(ByVal numBits As Long, ByVal pBits As Any Ptr)
	Declare Sub _CreateFromBooleanPointer(ByVal numBooleans As Long, ByVal pBits As Boolean Ptr)
	
Public:
	Declare Constructor(ByVal numBits As Long)
	Declare Constructor(ByVal numBits As Long, ByVal value As Boolean)
	Declare Constructor(values() As Boolean)
	Declare Constructor(values() As UByte)
	Declare Constructor(ByVal numBits As Long, ByVal pBits As Any Ptr)
	Declare Constructor(ByVal numBooleans As Long, ByVal pBits As Boolean Ptr)
	
	Declare Sub Clear() override
	Declare Function Contains(ByVal element As Boolean) As Boolean override
	Declare Sub CopyTo(elements() As Boolean) override
	Declare Sub CopyTo(elements() As UByte)
	Declare Function Flip(ByVal bitIndex As Long) As Boolean
	Declare Function Get(ByVal bitIndex As Long) As Boolean
	Declare Sub GetBits(bits() As Boolean)
	Declare Sub GetBytes(bytes() As UByte)
	Declare Function GetIterator() As IIteratorBoolean Ptr override
	Declare Sub Reset(ByVal index As Long)
	Declare Sub Set(ByVal index As Long, ByVal value As Boolean = True)
	Declare Sub SetAll()
	Declare Sub SetSpan(ByVal index As Long, ByVal howMany As Long, ByVal value As Boolean = True)	
	
	Declare Property Count() As Long override
	Declare Operator[](ByVal bitIndex As Long) As Boolean
	'' Also:
	'' Operator Len()
	'' Operator Imp()
	'' Operator Eqv()
	'' Operator And()
	'' Operator Xor()
	'' Operator Not()
	'' Operator Or()
	
#ifdef FB_CONTAINER_DEBUG
	Declare Sub PrintContainer() override
#endif
End Type

Type BitContainerIterator extends IIteratorBoolean
Private:
	Dim _pBitset As UByte Ptr
	Dim _numBits As Long
	Dim _curPos As Long
	Dim _curBit As Boolean
	
Public:
	Declare Constructor(ByVal bitSet As UByte Ptr, ByVal length As Long)
	Declare Constructor()

	Declare Operator For()
	Declare Operator Next(ByRef cond As BitContainerIterator) As Integer
	Declare Operator Step()

	Declare Function Advance() As Boolean override
	Declare Function Item() ByRef As Boolean override
	Declare Sub Reset() override

End Type


Private Constructor BitContainer(ByVal numBits As Long)
	Constructor(numBits, False)
End Constructor

Private Constructor BitContainer(ByVal numBits As Long, ByVal value As Boolean)
__CONT_DBG_PRINT("with & bits of value &", numBits; value)
	If numBits <= 0 Then
		Assert(StrPtr("Empty array isn't allowed to construct BitContainer") = 0)
		__CONT_Internals_SetError(1)
		Exit Constructor
	End If
	_numBits = numBits
	Dim numBytes As Long = _RoundToNext(numBits, 8) \ 8
	Redim _bits(0 To numBytes - 1)
	If value = True Then
		SetAll()
	End If
End Constructor

Private Constructor BitContainer(userBits() As Boolean)
	Dim arrLBound As Long
	Dim arrUBound As Long
	Dim numElems As Long = __CONT_GetArrayInfo(userBits, arrLBound, arrUBound)
__CONT_DBG_PRINT("with bool array of & elements", numElems)
	If numElems = 0 Then
		Assert(StrPtr("Empty array isn't allowed to construct BitContainer") = 0)
		__CONT_Internals_SetError(1)
		Exit Constructor
	End If
	_CreateFromBooleanPointer(numElems, @userBits(arrLBound))
End Constructor

Private Constructor BitContainer(userBytes() As UByte)
	Dim arrLBound As Long
	Dim arrUBound As Long
	Dim numElems As Long = __CONT_GetArrayInfo(userBytes, arrLBound, arrUBound)
__CONT_DBG_PRINT("with ubyte array of & elements", numElems)
	If numElems = 0 Then
		Assert(StrPtr("Empty array isn't allowed to construct BitContainer") = 0)
		__CONT_Internals_SetError(1)
		Exit Constructor
	End If
	_CreateFromPointer(numElems * 8, @userBytes(arrLBound))
End Constructor

Private Constructor BitContainer(ByVal numBits As Long, ByVal pUserBits As Any Ptr)
__CONT_DBG_PRINT("with & bits from data ptr &", numBits; Hex(pUserBits))
	If (numBits <= 0) OrElse (pUserBits = 0) Then
		Assert(StrPtr("Empty array isn't allowed to construct BitContainer") = 0)
		__CONT_Internals_SetError(1)
		Exit Constructor
	End If
	_CreateFromPointer(numBits, pUserBits)
End Constructor

Private Constructor BitContainer(ByVal numBooleans As Long, ByVal pUserBits As Boolean Ptr)
__CONT_DBG_PRINT("with & boolean bytes from boolean ptr &", numBooleans; Hex(pUserBits))
	If (numBooleans <= 0) OrElse (pUserBits = 0) Then
		Assert(StrPtr("Empty array isn't allowed to construct BitContainer") = 0)
		__CONT_Internals_SetError(1)
		Exit Constructor
	End If	
	_CreateFromBooleanPointer(numBooleans, pUserBits)
End Constructor

Private Sub BitContainer.Clear()
__CONT_DBG_PRINT("setting all bits to 0")
	FBC.clear(@_bits(0), 0, UBound(_bits) + 1)
End Sub

Private Sub BitContainer.CopyTo(target() As Boolean)
__CONT_DBG_PRINT("& bits in container to & element array", Count; UBound(target) - LBound(target))
	__CONT_Internals.ContainerToArray(@This, target())

End Sub

Private Sub BitContainer.CopyTo(target() As UByte)
	Dim As Long arrLBound, arrUBound, numElems = __CONT_GetArrayInfo(target, arrLBound, arrUBound)
	Dim containerBytes As Long = UBound(_bits) + 1
__CONT_DBG_PRINT("& bytes in container to & element array", containerBytes; numElems)
	If numElems = 0 Then
		numElems = containerBytes
		Redim target(0 To numElems - 1)
	Else
		numElems = _Min(numElems, containerBytes)
	End If
	FBC.memcopy(@target(arrLBound), @_bits(0), numElems)

End Sub

Private Function BitContainer.Contains(ByVal value As Boolean) As Boolean
	Dim numBits As Long = Count
__CONT_DBG_PRINT("looking for & in & bits", Str(value); numBits)
	Dim lastByteBits As Long = numBits And 7
	Dim arrLen As Long = (UBound(_bits) + 1) - IIf(lastByteBits = 0, 1, 2)
	Dim i As Long
	Dim result As Boolean = False
	If value Then
		For i = 0 To arrLen
			If (_bits(i) <> 0) Then Return True
		Next
		If lastByteBits > 0 Then
			Dim lastByteMask As UByte = _allBitsOn Shr (8 - lastByteBits)
			result = ((_bits(arrLen + 1) And lastByteMask) <> 0)
		End If
	Else
		For i = 0 To arrLen
			If (_bits(i) <> &hff) Then Return True
		Next
		If lastByteBits > 0 Then
			Dim lastByteMask As UByte = _allBitsOn Shr (8 - lastByteBits)
			result = ((_bits(arrLen + 1) And lastByteMask) <> lastByteMask)
		End If
	End If
	Return result
End Function

Private Function BitContainer.Flip(ByVal bitIndex As Long) As Boolean
	Dim numBits As Long = Count
__CONT_DBG_PRINT("at position & of & bits", bitIndex; numBits)
	If (bitIndex < 0) OrElse (bitIndex >= numBits) Then
__CONT_DBG_PRINT("flipping bit out of bounds, ignoring and returning false", bitIndex; numBits)
		__CONT_Internals_SetError(6)
		Return False
    End If
    Dim byteIndex As Long = bitIndex \ 8
    bitIndex = bitIndex Mod 8
    Dim mask As UByte = 1 Shl bitIndex
    Dim pBitByte As UByte Ptr = @_bits(byteIndex)
    Dim origValue As Boolean = *pBitByte And mask
    If origValue Then
		*pBitByte And= Not mask
    Else
		*pBitByte Or= mask
    End If    
    Return origValue
End Function

Private Function BitContainer.Get(ByVal bitIndex As Long) As Boolean
	Dim numBits As Long = Count
__CONT_DBG_PRINT("position & of & bits", bitIndex; numBits)
	If (bitIndex < 0) OrElse (bitIndex >= numBits) Then
__CONT_DBG_PRINT("indexing bit out of bounds, ignoring and returning false", bitIndex; numBits)
		__CONT_Internals_SetError(6)
		Return False
    End If
    Dim byteIndex As Long = bitIndex \ 8
    bitIndex = bitIndex Mod 8
    Return (_bits(byteIndex) And (1 Shl bitIndex)) <> 0
End Function

Private Sub BitContainer.GetBits(bits() As Boolean)
	CopyTo(bits())
End Sub

Private Sub BitContainer.GetBytes(bytes() As UByte)
	CopyTo(bytes())
End Sub

Private Function BitContainer.GetIterator() As IIteratorBoolean Ptr
	Return New BitContainerIterator(@_bits(0), Count)
End Function

Private Sub BitContainer.Reset(ByVal index As Long)
	Set(index, False)
End Sub

Private Sub BitContainer.Set(ByVal index As Long, ByVal value As Boolean)
	Dim numBits As Long = Count
__CONT_DBG_PRINT("Indexing at position & of & bits", index; numBits)
	If (index < 0) OrElse (index >= numBits) Then
		__CONT_DBG_PRINT("Trying to set bit position & out of bounds of container (0-&), ignoring", index; numBits)
		__CONT_Internals_SetError(6)
		Exit Sub
    End If
    
    Dim byteIndex As Long = index \ 8
    Dim bitIndex As Long = index Mod 8
    Dim mask As UByte = 1 Shl bitIndex
    If value Then
		_bits(byteIndex) Or= mask
	Else
		_bits(byteIndex) And= Not mask
	End If
End Sub

Private Sub BitContainer.SetAll()
__CONT_DBG_PRINT("& bits to true", Count)
	FBC.clear(@_bits(0), &hff, UBound(_bits) + 1)
End Sub

Private Sub BitContainer.SetSpan(ByVal index As Long, ByVal howMany As Long, ByVal value As Boolean)

	Dim numBits As Long = Count
__CONT_DBG_PRINT("& bits from & to &", howMany; index; CLng(value))
	If (index < 0) OrElse (index >= numBits) OrElse (howMany <= 0) Then
		__CONT_DBG_PRINT("Trying to index position & out of bounds of container (0-&), ignoring ", index; numBits)
		__CONT_Internals_SetError(6)
		Exit Sub
    End If
    
    '' make sure we don't go out of bounds at the top end
    howMany = _Min(howMany, numBits - index)
    
    If howMany = 1 Then
		Set(index, value)
		Exit Sub
	ElseIf (index = 0) AndAlso (howMany = numBits) Then
		If value = True Then
			SetAll()
		Else
			Clear()
		End If
		Exit Sub
    End If
    
    Dim pBits as UByte Ptr = @_bits(0)
    
    Dim curByteIndex As Long = index \ 8
    
    Dim needsAlign As Long = index And 7
    If needsAlign <> 0 Then
		Dim mask As UByte
		Dim toAlign As Long = 8 - needsAlign
				
		'' if we're setting less than we need to align, we need to then clear the bits above
		'' the ones to set, so we don't change those
		If howMany < toAlign Then
			Dim difference As UByte = toAlign - howMany 
			'' If howMany = 2, toAlign = 4, we need to produce a mask of
			'' &b00110000
			'' so &H80 = &b10000000
			'' Shr howMany - 1 (= Shr 1) = &b11000000 '' needs a signed shift to shift in the sign bit
			'' Shr difference (= Shr 4 - 2 = Shr 2) = &b00110000
			mask = (CByte(&h80) Shr (howMany - 1)) Shr difference
			howMany = 0
		Else
			'' shift in zeroes to make a mask for the top (8 - toAlign) bits
			'' If index = 7, we only need to set the top bit, 
			'' so &hff << 7 = &h80 which is what we want
			mask = _allBitsOn Shl needsAlign
			howMany -= toAlign
		End If
		
		If value Then
			pBits[curByteIndex] Or= mask
		Else
			pBits[curByteIndex] And= Not mask
		End If
		
		curByteIndex += 1
    End If
    '' now we're aligned to whole bytes, we can just set them without any tricks
    Dim wholeValue As UByte = IIf(value, _allBitsOn, 0)
    While (howMany >= 8)
		pBits[curByteIndex] = wholeValue
		curByteIndex += 1
		howMany -= 8
    Wend
    '' pick up any that bits that are left
    If howMany > 0 Then
		Dim lowMask As UByte = _allBitsOn Shr (8 - howMany)
		If value Then
			pBits[curByteIndex] Or= lowMask
		Else
			pBits[curByteIndex] And= Not lowMask
		End If
    End If

End Sub

Private Operator BitContainer.[](ByVal bitIndex As Long) As Boolean
    Return Get(bitIndex)
End Operator

Private Property BitContainer.Count() As Long
	Return _numBits
End Property

Private Sub BitContainer._CreateFromPointer(ByVal numBits As Long, ByVal pUserBits As Any Ptr)
	Dim allocBytes As Long = _RoundToNext(numBits, 8) \ 8
	Redim _bits(0 To allocBytes - 1)
__CONT_DBG_PRINT("Creating with & bits requested from &", numBits; Hex(pUserBits))
	Assert(pUserBits <> 0)
	Dim pBitsPtr As UByte Ptr = @_bits(0)
	Dim fullBytes As Long = numBits \ 8
	Dim stragglerBits As Long = numBits And 7
	FBC.memcopy(pBitsPtr, pUserBits, fullBytes)
	If stragglerBits > 0 Then
		Dim pRemainingByte As UByte Ptr = cast(UByte Ptr, pUserBits) + fullBytes
		Dim mask As UByte = _allBitsOn Shr (8 - stragglerBits)
		pBitsPtr[fullBytes] = (*pRemainingByte) And mask
	End If
	_numBits = numBits
End Sub

Private Sub BitContainer._CreateFromBooleanPointer(ByVal numBooleans As Long, ByVal pBooleanBits As Boolean Ptr)
	Dim stragglerBits As Long = numBooleans And 7
	Dim numBytes As Long = _RoundToNext(numBooleans, 8) \ 8
	Dim wholeBytes As Long = numBooleans \ 8
	Dim byteArray(0 To numBytes - 1) As UByte
	Dim byteArrayPtr As UByte Ptr = @byteArray(0)
	Dim userBitsPtr As Boolean Ptr = pBooleanBits
	Dim i As Long
	Dim j As Long
	Dim curByte As UByte
	Dim userBitsIndex As Long = 0
	For i = 0 To wholeBytes - 1
		curByte = 0
		Dim mask As UByte = 1
		For j = 0 To 7
			Dim valueBit As UByte = CUByte(userBitsPtr[userBitsIndex]) And mask
			curByte Or= valueBit
			userBitsIndex += 1
			mask Shl= 1
		Next
		byteArrayPtr[i] = curByte
	Next
	If stragglerBits > 0 Then
		curByte = 0
		Dim mask As UByte = 1
		For j = 0 To stragglerBits - 1
			Dim valueBit As UByte = CUByte(userBitsPtr[userBitsIndex]) And mask
			curByte Or= valueBit
			userBitsIndex += 1
			mask Shl= 1
		Next
		byteArrayPtr[numBytes - 1] = curByte
	End If
	_CreateFromPointer(numBooleans, byteArrayPtr)
End Sub

Private Function BitContainer._RoundToNext(ByVal val1 As Long, ByVal val2 As Long) As Long
	Return (val1 + (val2 - 1)) And (Not (val2 - 1))
End Function

#ifdef FB_CONTAINER_DEBUG
Private Sub BitContainer.PrintContainer()
	Print "BitContainer at " & Hex(@This) & " has " & Count & " bits:"
	Dim As Long i, j, k, byteIndex = 0
	const bytesPerLine As Long = 4
	Dim bitNum As Long = 0
	Dim numBytes As Long = UBound(_bits) + 1
	Dim singleBytes As Long = numBytes And (bytesPerLine - 1)
	Dim numQuads As Long = numBytes \ bytesPerLine
	Dim lineString As String
	Dim bitString As ZString * 9
	For i = 0 To numQuads - 1
		'' print the highest bit number for this line
		lineString = Str(bitNum + (bytesPerLine * 8) - 1) & " "
		'' print the bytes backwards so the highest bytes are on the left
		For j = byteIndex + (bytesPerLine - 1) To byteIndex Step -1
			bitString = Bin(_bits(j), 8)
			lineString += (bitString & " ")
		Next
		byteIndex += bytesPerLine
		'' print the lowest bit number for this line
		lineString += Str(bitNum)
		Print lineString
		lineString = ""
		bitNum += bytesPerLine * 8
	Next
	If singleBytes > 0 Then
		Dim spaces As Long = (4 - singleBytes) * 9
		lineString = Str(bitNum + (bytesPerLine * 8) - 1) & " " & Space(spaces)
		For j = ((byteIndex + singleBytes) - 1) To byteIndex Step -1
			bitString = Bin(_bits(j), 8)
			lineString += (bitString & " ")
			byteIndex += 1
		Next
		lineString += Str(bitNum)
		Print lineString
	End If
End Sub
#endif

#macro ImplementBitContainerBinaryOp(first, second, op)
	Dim firstN As Long = first.Count
	Dim secondN As Long = second.Count
	Const integerSize As ULong = Sizeof(UInteger)
__CONT_DBG_PRINT("with bitsets of & (first) and & (second) elements", firstN; secondN)

	Dim retBits As Long = _Min(firstN, secondN)
    Dim bytesSize As Long = (retBits + 7) \ 8
    Dim numCopies As Long = bytesSize \ integerSize
    
    Dim newArr(0 To bytesSize - 1) As UByte
    Dim firstArr(0 To bytesSize - 1) As UByte
    Dim secondArr(0 To bytesSize - 1) As UByte
    
    first.GetBytes(firstArr())
    second.GetBytes(secondArr())
    Dim pFirstArr As UByte Ptr = @firstArr(0)
    Dim pFirstArrBase As UByte Ptr = pFirstArr
    Dim pSecondArr As UByte Ptr = @secondArr(0)
    Dim pResArr As UByte Ptr = @newArr(0)
    Dim pFirstEndArr As UByte Ptr = pFirstArr + (numCopies * integerSize)
    '' do integer size chunks
    While pFirstArr < pFirstEndArr
		*cast(UInteger Ptr, pResArr) = *cast(UInteger Ptr, pFirstArr) op *cast(UInteger Ptr, pSecondArr)
		pResArr += integerSize
		pFirstArr += integerSize
		pSecondArr += integerSize
    Wend
    '' then any straggler bytes
    numCopies = bytesSize And (integerSize - 1)
    pFirstEndArr = pFirstArrBase + bytesSize
    While pFirstArr < pFirstEndArr
		*pResArr = *pFirstArr op *pSecondArr
		pResArr += 1
		pFirstArr += 1
		pSecondArr += 1
    Wend
    '' This is apprently ambiguous without the cast
    '' Dim retCont As BitContainer = Type(retBits, cast(@newArr(0), Any Ptr))
    Return BitContainer(retBits, cast(Any Ptr, @newArr(0)))
#endmacro

Private Operator And(ByRef first As BitContainer, ByRef second As BitContainer) As BitContainer
	ImplementBitContainerBinaryOp(first, second, And)
End Operator

Private Operator Or(ByRef first As BitContainer, ByRef second As BitContainer) As BitContainer
	ImplementBitContainerBinaryOp(first, second, Or)
End Operator

Private Operator Xor(ByRef first As BitContainer, ByRef second As BitContainer) As BitContainer
	ImplementBitContainerBinaryOp(first, second, Xor)
End Operator

Private Operator Eqv(ByRef first As BitContainer, ByRef second As BitContainer) As BitContainer
__CONT_DBG_PRINT("with bitsets of & (first) and & (second) elements", first.Count; second.Count)
	ImplementBitContainerBinaryOp(first, second, Eqv)
End Operator

Private Operator Imp(ByRef first As BitContainer, ByRef second As BitContainer) As BitContainer
__CONT_DBG_PRINT("with bitsets of & (first) and & (second) elements", first.Count; second.Count)
	ImplementBitContainerBinaryOp(first, second, Imp)
End Operator

#undef ImplementBitContainerBinaryOp

Private Operator Not(ByRef first As BitContainer) As BitContainer
	Dim firstN As Long = first.Count
	Const integerSize As ULong = Sizeof(UInteger)
__CONT_DBG_PRINT("with bitset of & (first) elements", firstN)

    Dim bytesSize As Long = (firstN + 7) \ 8
    Dim numCopies As Long = bytesSize \ integerSize
    
    Dim newArr(0 To bytesSize - 1) As UByte
    Dim firstArr(0 To bytesSize - 1) As UByte
    
    first.GetBytes(firstArr())
    
    Dim pFirstArr As UByte Ptr = @firstArr(0)
    Dim pFirstArrBase As UByte Ptr = pFirstArr
    Dim pResArr As UByte Ptr = @newArr(0)
    Dim pFirstEndArr As UByte Ptr = pFirstArrBase + (numCopies * integerSize)
    '' do integer size chunks
    While pFirstArr < pFirstEndArr
		*cast(UInteger Ptr, pResArr) = Not *cast(UInteger Ptr, pFirstArr)
		pResArr += integerSize
		pFirstArr += integerSize
    Wend
    '' then any straggler bytes
    numCopies = bytesSize And (integerSize - 1)
    pFirstEndArr = pFirstArrBase + bytesSize
    While pFirstArr < pFirstEndArr
		*pResArr = Not *pFirstArr
		pResArr += 1
		pFirstArr += 1
    Wend
    '' This is apprently ambiguous without the cast
    Return BitContainer(firstN, cast(Any Ptr, @newArr(0)))
End Operator

Private Operator Len(ByRef cont As BitContainer) As Integer
	Return cont.Count
End Operator

#undef _Min

'''
'' Iterator functions
''''
Private Constructor BitContainerIterator(ByVal bitSet As UByte Ptr, ByVal length As Long)
	_pBitset = bitSet
	_numBits = length
	_curPos = -1
End Constructor

Private Constructor BitContainerIterator()
	_pBitset = 0
	_numBits = 0
	_curPos = -1
End Constructor

Private Operator BitContainerIterator.For()
	_curPos = 0
End Operator

Private Operator BitContainerIterator.Next(ByRef cond As BitContainerIterator) As Integer
	Return (_curPos < _numBits) AndAlso (_curPos <> cond._curPos)
End Operator

Private Operator BitContainerIterator.Step()
	Advance()
End Operator

Private Function BitContainerIterator.Advance() As Boolean
	Dim nextPos As Long = _curPos + 1
	Dim ret As Boolean = nextPos < _numBits
	If ret Then
		Dim numByte As Long = nextPos \ 8
		Dim numBit As Long = nextPos Mod 8
		_curBit = (_pBitset[numByte] And (1 Shl numBit)) <> 0
		_curPos = nextPos
	End If
	Return ret
End Function

Private Function BitContainerIterator.Item() ByRef As Boolean
	Return _curBit
End Function

Private Sub BitContainerIterator.Reset()
	_curPos = -1
End Sub

#endif '' __CONT_BitContainer_DEFINED

'' this isn't necessary, but as the other containers need it
'' users may try to do it and get errors when it doesn't exist
#macro FBCont_DefineBitContainerOf(Type...)
#Print "FBCont_DefineBitContainerOf isn't necessary"
#endmacro

#define FB_BitContainer(Type...) BitContainer

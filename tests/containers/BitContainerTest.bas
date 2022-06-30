''#define FB_CONTAINER_DEBUG 1
#include "../../inc/containers/bitcontainer.bi"
#include "fbcunit.bi"

Private Function RoundToNext(ByVal num As Long, Byval nextWhat As Long) As Long
	Return (num + (nextWhat - 1)) And Not (nextWhat - 1)
End Function

SUITE(fbc_tests.containers.bitcontainers)
	TEST(ConstructorTest)
		Dim contSize As Long = 9
		Dim contSizeBits As Long = contSize * 8
		dim allFalse As BitContainer = (contSizeBits)
		CU_ASSERT_EQUAL(allFalse.Count, contSizeBits)
		Dim i As Long
		For i = 0 To contSizeBits - 1
			CU_ASSERT_EQUAL(allFalse[i], False)
		Next
		
		dim allFalse2 As BitContainer = (1)
		CU_ASSERT_EQUAL(allFalse2.Count, 1)
		CU_ASSERT_EQUAL(allFalse2[0], False)
		
		contSize *= 2
		contSizeBits = contSize * 8
		dim allTrue As BitContainer = Type(contSizeBits, True)
		CU_ASSERT_EQUAL(allTrue.Count, contSizeBits)

		For i = 0 To contSizeBits - 1
			CU_ASSERT_EQUAL(allTrue[i], True)
		Next
		
		dim allFalse3 As BitContainer = Type(5, False)
		CU_ASSERT_EQUAL(allFalse3.Count, 5)
		For i = 0 To 4
			CU_ASSERT_EQUAL(allFalse3[i], False)
		Next
		
		contSize = 90
		contSizeBits = contSize * 8
		dim boolArray(0 To contSize - 1) As Boolean
		For i = 0 To contSize - 1
			boolArray(i) = CBool(i And 1)
		Next
		
		dim boolArrayCont As BitContainer = boolArray()
		CU_ASSERT_EQUAL(boolArrayCont.Count, contSize)
		For i = 0 To contSize - 1
			CU_ASSERT_EQUAL(boolArrayCont[i], boolArray(i))
			boolArray(i) = Not boolArray(i)
		Next
		
		dim boolArrayCont2 As BitContainer = boolArray()
		CU_ASSERT_EQUAL(boolArrayCont2.Count, contSize)
		For i = 0 To contSize
			CU_ASSERT_EQUAL(boolArrayCont2[i], boolArray(i))
		Next
		
		dim alternaBitByte As UByte = &B10101010
		Dim alternaByteArray(Any) As UByte
		contSize = 56
		contSizeBits = contSize * 8
		dim alternaLBound As Long = 7
		dim alternaUBound As Long = alternaLBound + contSize - 1
		Redim alternaByteArray(alternaLBound To alternaUBound)
		For i = alternaLBound To alternaUBound
			alternaByteArray(i) = alternaBitByte
		Next
		
		dim byteArrayCont As BitContainer = alternaByteArray()
		CU_ASSERT_EQUAL(byteArrayCont.Count, contSizeBits)
		For i = 0 To contSizeBits - 1
			dim curByte As Long = alternaLBound + (i \ 8)
			dim alternaByte As UByte = alternaByteArray(curByte)
			dim alternaBit As Boolean = alternaByte And (1 Shl (i Mod 8))
			CU_ASSERT_EQUAL(byteArrayCont[i], alternaBit)
			CU_ASSERT_EQUAL(byteArrayCont[i], CBool(i And 1))
		Next
		For i = 7 To 62
			alternaByteArray(i) = Not alternaBitByte
		Next
		
		dim pByteArray As UByte Ptr = @alternaByteArray(alternaLBound)
		dim anyPtrArrayCont As BitContainer = Type(contSizeBits, cast(Any Ptr, pByteArray))
		CU_ASSERT_EQUAL(anyPtrArrayCont.Count, contSizeBits)
		For i = 0 To contSizeBits - 1
			dim curByte As Long = alternaLBound + (i \ 8)
			dim alternaByte As UByte = alternaByteArray(curByte)
			dim alternaBit As Boolean = alternaByte And (1 Shl (i Mod 8))
			CU_ASSERT_EQUAL(anyPtrArrayCont[i], alternaBit)
			CU_ASSERT_EQUAL(anyPtrArrayCont[i], CBool((i And 1) = 0))
		Next
		
		dim anyPtrArrayCont2 As BitContainer = Type(24, cast(Any Ptr, pByteArray + 8))
		CU_ASSERT_EQUAL(anyPtrArrayCont2.Count, 24)
		For i = 0 To 23
			dim curByte As Long = alternaLBound + 8 + (i \ 8)
			dim alternaByte As UByte = alternaByteArray(curByte)
			dim alternaBit As Boolean = alternaByte And (1 Shl (i Mod 8))
			CU_ASSERT_EQUAL(anyPtrArrayCont2[i], alternaBit)
			CU_ASSERT_EQUAL(anyPtrArrayCont2[i], CBool((i And 1) = 0))
		Next
		
		Dim allTrueArray(0 To 17) As Boolean
		For i = 0 To 17
			allTrueArray(i) = True
		Next
		Dim pBooleanArray As Boolean Ptr = @allTrueArray(0)
		dim fromTruePtrCont As BitContainer = Type(15, pBooleanArray + 1)
		CU_ASSERT_EQUAL(fromTruePtrCont.Count, 15)
		
		'' undimmed/empty array to constructs is an error...
		Dim undimmedArr(Any) As Boolean
		On Local Error Goto nextTest
		dim localErr As Long
		Err = 0
		dim udCont As BitContainer = undimmedArr()
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)
	nextTest:
	
		'' ...no matter which type
		dim undimmedByteArr(Any) As UByte
		On Local Error Goto nextTest2
		localErr = 0
		Err = 0
		dim udCont2 As BitContainer = undimmedByteArr()
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)
	nextTest2:
	
		'' a negative or 0 number of bits is an error too
		On Local Error Goto nextTest3
		localErr = 0
		Err = 0
		dim udCont3 As BitContainer = Type(-7, cast(Any Ptr, pByteArray))
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)
	nextTest3:
	
		On Local Error Goto nextTest4
		localErr = 0
		Err = 0
		dim udCont4 As BitContainer = Type(0, pBooleanArray)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)
	nextTest4:
		On Local Error Goto 0
	END_TEST
	
	TEST(Clear)
		dim bits As BitContainer = Type(50, True)
		dim i As Long
		bits.Clear()
		For i = 0 To 50
			CU_ASSERT_EQUAL(bits[i], False)
		Next
		
		dim alternaBitByte As UByte = &B10101010
		Dim alternaByteArray(Any) As UByte
		Redim alternaByteArray(7 To 62)
		For i = 7 To 62
			alternaByteArray(i) = alternaBitByte
		Next
		
		dim bits2 As BitContainer = Type(32, cast(Any Ptr, @alternaByteArray(7)))
		Dim contBytes(Any) As UByte
		dim contBytesUBound As Long = UBound(contBytes)
		bits2.Clear()
		bits2.GetBytes(contBytes())
		For i = 0 To contBytesUBound
			CU_ASSERT_EQUAL(contBytes(i), 0)
		Next
		For i = 0 To 32 - 1
			CU_ASSERT_EQUAL(bits2[i], False)
		Next
		
		bits2.Set(31, True)
		bits2.Clear()
		CU_ASSERT_EQUAL(bits2[31], False)
		
		bits2.SetSpan(3, 5, True)
		bits2.Clear()
		For i = 3 To 7
			CU_ASSERT_EQUAL(bits2[i], False)
		Next
	END_TEST
	
	TEST(Contains)
		dim haystack As BitContainer = Type(46, False)
		dim needle As Boolean = True
		dim result As Boolean
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, False)
		hayStack.Set(7, True)
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, True)
		haystack.SetSpan(30, 9)
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, True)
		result = haystack.Contains(False)
		CU_ASSERT_EQUAL(result, True)
		haystack.Clear()
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, False)
		haystack.SetAll()
		result = haystack.Contains(False)
		CU_ASSERT_EQUAL(result, False)
		haystack.Set(0, False)
		result = haystack.Contains(False)
		CU_ASSERT_EQUAL(result, True)
	END_TEST
	
	TEST(CopyTo)
		dim As BitContainer bits = Type(64, True), bitsAlt = bits
		dim i As Long
		'' Undimmed arrays are redimmed to be the size of the container, from 0 To n-1
		dim undimmedArr(Any) As Boolean
		bits.CopyTo(undimmedArr())
		dim arrUBound As Long = UBound(undimmedArr)
		dim arrLBound As Long = LBound(undimmedArr)
		dim numElems As Long = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, bits.Count)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedArr(i), True)
			If (i And 1) Then bitsAlt.Set(i, False)
		Next
		
		dim undimmedArr2(Any) As Boolean
		bitsAlt.CopyTo(undimmedArr2())
		arrUBound = UBound(undimmedArr2)
		arrLBound = LBound(undimmedArr2)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, bitsAlt.Count)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedArr2(i), ((i And 1) = 0))
		Next
		
		dim undimmedBytes(Any) As UByte
		bits.CopyTo(undimmedBytes())
		arrUBound = UBound(undimmedBytes)
		arrLBound = LBound(undimmedBytes)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, RoundToNext(bits.Count, 8) \ 8)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedBytes(i), &HFF)
		Next
		
		dim undimmedBytes2(Any) As UByte
		bitsAlt.CopyTo(undimmedBytes2())
		arrUBound = UBound(undimmedBytes2)
		arrLBound = LBound(undimmedBytes2)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, RoundToNext(bits.Count, 8) \ 8)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedBytes2(i), &B01010101)
		Next
		
		'' already sized arrays copy the number of items in the container or the size of the array
		'' whichever is smaller
		dim largerThanContBitArr(11 To 81) As Boolean
		bits.CopyTo(largerThanContBitArr())
		arrUBound = UBound(largerThanContBitArr)
		arrLBound = LBound(largerThanContBitArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 71)
		CU_ASSERT_EQUAL(arrLBound, 11)
		CU_ASSERT_EQUAL(arrUBound, 81)
		For i = arrLBound To arrUBound
			CU_ASSERT_EQUAL(largerThanContBitArr(i), i < 75)
		Next
		
		bitsAlt.CopyTo(largerThanContBitArr())
		arrUBound = UBound(largerThanContBitArr)
		arrLBound = LBound(largerThanContBitArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 71)
		CU_ASSERT_EQUAL(arrLBound, 11)
		CU_ASSERT_EQUAL(arrUBound, 81)
		For i = arrLBound To arrUBound
			CU_ASSERT_EQUAL(largerThanContBitArr(i), (i < (64 + arrLBound)) AndAlso ((i And 1) = 1))
		Next
		
		dim largerThanContByteArr(10 To 18) As UByte
		For i = 10 To 18
			largerThanContByteArr(i) = i
		Next
		bits.CopyTo(largerThanContByteArr())
		arrUBound = UBound(largerThanContByteArr)
		arrLBound = LBound(largerThanContByteArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 9)
		CU_ASSERT_EQUAL(arrLBound, 10)
		CU_ASSERT_EQUAL(arrUBound, 18)
		For i = 10 To 18
			CU_ASSERT_EQUAL(largerThanContByteArr(i), IIf(i <= 17, &b11111111, i))
		Next
		
		For i = 10 To 18
			largerThanContByteArr(i) = i
		Next
		bitsAlt.CopyTo(largerThanContByteArr())
		arrUBound = UBound(largerThanContByteArr)
		arrLBound = LBound(largerThanContByteArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 9)
		CU_ASSERT_EQUAL(arrLBound, 10)
		CU_ASSERT_EQUAL(arrUBound, 18)
		For i = 10 To 18
			CU_ASSERT_EQUAL(largerThanContByteArr(i), IIf(i <= 17, &b01010101, i))
		Next
		
		dim smallerThanContArr(21 To 24) As Boolean
		bits.CopyTo(smallerThanContArr())
		arrUBound = UBound(smallerThanContArr)
		arrLBound = LBound(smallerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 4)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 24)
		For i = 21 To 24
			CU_ASSERT_EQUAL(smallerThanContArr(i), True)
		Next
		
		For i = 21 To 24
			smallerThanContArr(i) = False
		Next
		bitsAlt.CopyTo(smallerThanContArr())
		arrUBound = UBound(smallerThanContArr)
		arrLBound = LBound(smallerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 4)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 24)
		For i = 21 To 24
			CU_ASSERT_EQUAL(smallerThanContArr(i), CBool((i And 1) = 1))
		Next
		
		dim smallerThanContByteArr(21 To 23) As UByte
		bits.CopyTo(smallerThanContByteArr())
		arrUBound = UBound(smallerThanContByteArr)
		arrLBound = LBound(smallerThanContByteArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 3)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 23)
		For i = 21 To 23
			CU_ASSERT_EQUAL(smallerThanContByteArr(i), &b11111111)
		Next
		
		For i = 21 To 23
			smallerThanContArr(i) = 0
		Next
		bitsAlt.CopyTo(smallerThanContByteArr())
		arrUBound = UBound(smallerThanContByteArr)
		arrLBound = LBound(smallerThanContByteArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 3)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 23)
		For i = 21 To 23
			CU_ASSERT_EQUAL(smallerThanContByteArr(i), &b01010101)
		Next
	END_TEST
	
	TEST(Flip)
		dim As BitContainer bits = Type(64, True), bitsAlt = bits
		dim i As Long
		For i = 0 To bits.Count - 1
			CU_ASSERT_EQUAL(bits.Flip(i), True)
			If (i And 1) Then bitsAlt.Set(i, False)
		Next
		CU_ASSERT_EQUAL(bits.Contains(True), False)
		CU_ASSERT_EQUAL(bits.Flip(59), False)
		For i = 0 To bits.Count - 1
			CU_ASSERT_EQUAL(bits[i], i = 59)
		Next
		CU_ASSERT_EQUAL(bitsAlt.Flip(0), True)
		CU_ASSERT_EQUAL(bitsAlt[0], False)
		For i = 1 To bitsAlt.Count - 1
			CU_ASSERT_EQUAL(bitsAlt[i], (i And 1) = 0)
		Next
		bitsAlt.Set(0)
		For i = 0 To bitsAlt.Count - 1
			CU_ASSERT_EQUAL(bitsAlt.Flip(i), (i And 1) = 0)
			CU_ASSERT_EQUAL(bitsAlt[i], CBool((i And 1) = 1))
		Next
		bits.Clear()
		'' set only the lowest bits
		For i = 0 To 7
			bits.Flip(i * 8)
		Next
		'' check only the lowest bits are set
		dim bytes(Any) As UByte
		bits.GetBytes(bytes())
		For i = 0 To UBound(bytes)
			CU_ASSERT_EQUAL(bytes(i), 1)
		Next
		
		On Local Error Goto nextTest
		dim localErr As Long = 0
		Err = 0
		dim oobBit As Boolean = bits.Flip(866)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(oobBit, False)
	nextTest:
		On Local Error Goto nextTest2
		localErr = 0
		Err = 0
		oobBit = bits.Flip(-7)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(oobBit, False)
	nextTest2:
		On Local Error Goto 0
	END_TEST
	
	TEST(GetTest)
		dim As BitContainer bits = Type(64, True), bitsAlt = bits
		dim i As Long
		For i = 0 To bits.Count - 1
			CU_ASSERT_EQUAL(bits.Get(i), True)
			If (i And 1) Then bitsAlt.Set(i, False)
		Next
		For i = 0 To bits.Count - 1
			CU_ASSERT_EQUAL(bits[i], True)
		Next
		
		For i = 0 To bitsAlt.Count - 1
			CU_ASSERT_EQUAL(bitsAlt.Get(i), (i And 1) = 0)
		Next
		For i = 0 To bitsAlt.Count - 1
			CU_ASSERT_EQUAL(bitsAlt[i], (i And 1) = 0)
		Next
		bits.Clear()
		For i = 0 To bits.Count - 1
			CU_ASSERT_EQUAL(bits.Get(i), False)
		Next
		bits.Flip(34)
		For i = 0 To bits.Count - 1
			CU_ASSERT_EQUAL(bits.Get(i), i = 34)
		Next
		
		bitsAlt.SetAll()
		For i = 0 To bitsAlt.Count - 1
			CU_ASSERT_EQUAL(bitsAlt.Get(i), True)
		Next
		bitsAlt.Flip(19)
		For i = 0 To bitsAlt.Count - 1
			CU_ASSERT_EQUAL(bitsAlt[i], i <> 19)
		Next
		
		On Local Error Goto nextTest
		dim localErr As Long = 0
		Err = 0
		dim oobBit As Boolean = bits.Get(65)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(oobBit, False)
	nextTest:
		On Local Error Goto nextTest2
		localErr = 0
		Err = 0
		oobBit = bitsAlt.Get(-6)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(oobBit, False)
	nextTest2:
		On Local Error Goto 0		
	END_TEST
	
	TEST(GetBitsBytes)
		dim As BitContainer bits = Type(64, True), bitsAlt = bits
		dim i As Long
		'' Undimmed arrays are redimmed to be the size of the container, from 0 To n-1
		dim undimmedArr(Any) As Boolean
		bits.GetBits(undimmedArr())
		dim arrUBound As Long = UBound(undimmedArr)
		dim arrLBound As Long = LBound(undimmedArr)
		dim numElems As Long = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, bits.Count)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedArr(i), True)
			If (i And 1) Then bitsAlt.Set(i, False)
		Next
		
		dim undimmedArr2(Any) As Boolean
		bitsAlt.GetBits(undimmedArr2())
		arrUBound = UBound(undimmedArr2)
		arrLBound = LBound(undimmedArr2)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, bitsAlt.Count)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedArr2(i), ((i And 1) = 0))
		Next
		
		dim undimmedBytes(Any) As UByte
		bits.GetBytes(undimmedBytes())
		arrUBound = UBound(undimmedBytes)
		arrLBound = LBound(undimmedBytes)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, RoundToNext(bits.Count, 8) \ 8)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedBytes(i), &HFF)
		Next
		
		dim undimmedBytes2(Any) As UByte
		bitsAlt.GetBytes(undimmedBytes2())
		arrUBound = UBound(undimmedBytes2)
		arrLBound = LBound(undimmedBytes2)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, RoundToNext(bitsAlt.Count, 8) \ 8)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedBytes2(i), &B01010101)
		Next
		
		'' already sized arrays copy the number of items in the container or the size of the array
		'' whichever is smaller
		dim largerThanContBitArr(11 To 81) As Boolean
		bits.GetBits(largerThanContBitArr())
		arrUBound = UBound(largerThanContBitArr)
		arrLBound = LBound(largerThanContBitArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 71)
		CU_ASSERT_EQUAL(arrLBound, 11)
		CU_ASSERT_EQUAL(arrUBound, 81)
		For i = arrLBound To arrUBound
			CU_ASSERT_EQUAL(largerThanContBitArr(i), i < 75)
		Next
		
		bitsAlt.GetBits(largerThanContBitArr())
		arrUBound = UBound(largerThanContBitArr)
		arrLBound = LBound(largerThanContBitArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 71)
		CU_ASSERT_EQUAL(arrLBound, 11)
		CU_ASSERT_EQUAL(arrUBound, 81)
		For i = arrLBound To arrUBound
			CU_ASSERT_EQUAL(largerThanContBitArr(i), (i < (64 + arrLBound)) AndAlso ((i And 1) = 1))
		Next
		
		dim largerThanContByteArr(10 To 18) As UByte
		For i = 10 To 18
			largerThanContByteArr(i) = i
		Next
		bits.GetBytes(largerThanContByteArr())
		arrUBound = UBound(largerThanContByteArr)
		arrLBound = LBound(largerThanContByteArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 9)
		CU_ASSERT_EQUAL(arrLBound, 10)
		CU_ASSERT_EQUAL(arrUBound, 18)
		For i = 10 To 18
			CU_ASSERT_EQUAL(largerThanContByteArr(i), IIf(i <= 17, &b11111111, i))
		Next
		
		For i = 10 To 18
			largerThanContByteArr(i) = i
		Next
		bitsAlt.GetBytes(largerThanContByteArr())
		arrUBound = UBound(largerThanContByteArr)
		arrLBound = LBound(largerThanContByteArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 9)
		CU_ASSERT_EQUAL(arrLBound, 10)
		CU_ASSERT_EQUAL(arrUBound, 18)
		For i = 10 To 18
			CU_ASSERT_EQUAL(largerThanContByteArr(i), IIf(i <= 17, &b01010101, i))
		Next
		
		dim smallerThanContArr(21 To 24) As Boolean
		bits.GetBits(smallerThanContArr())
		arrUBound = UBound(smallerThanContArr)
		arrLBound = LBound(smallerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 4)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 24)
		For i = 21 To 24
			CU_ASSERT_EQUAL(smallerThanContArr(i), True)
		Next
		
		For i = 21 To 24
			smallerThanContArr(i) = False
		Next
		bitsAlt.GetBits(smallerThanContArr())
		arrUBound = UBound(smallerThanContArr)
		arrLBound = LBound(smallerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 4)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 24)
		For i = 21 To 24
			CU_ASSERT_EQUAL(smallerThanContArr(i), CBool((i And 1) = 1))
		Next
		
		dim smallerThanContByteArr(21 To 23) As UByte
		bits.GetBytes(smallerThanContByteArr())
		arrUBound = UBound(smallerThanContByteArr)
		arrLBound = LBound(smallerThanContByteArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 3)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 23)
		For i = 21 To 23
			CU_ASSERT_EQUAL(smallerThanContByteArr(i), &b11111111)
		Next
		
		For i = 21 To 23
			smallerThanContArr(i) = 0
		Next
		bitsAlt.GetBytes(smallerThanContByteArr())
		arrUBound = UBound(smallerThanContByteArr)
		arrLBound = LBound(smallerThanContByteArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 3)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 23)
		For i = 21 To 23
			CU_ASSERT_EQUAL(smallerThanContByteArr(i), &b01010101)
		Next
	END_TEST
	
	TEST(GetIterator)
		dim bits As BitContainer = Type(80, True)
		dim pBitIter As FB_IIterator(Boolean) Ptr = bits.GetIterator()
		dim pBitIter2 As FB_IIterator(Boolean) Ptr = bits.GetIterator()
		dim i As Long
		CU_ASSERT(pBitIter <> 0)
		CU_ASSERT(pBitIter2 <> 0)
		CU_ASSERT(pBitIter <> pBitIter2)
		CU_ASSERT(pBitIter->Advance() = True)
		CU_ASSERT_EQUAL(pBitIter->Item(), True)
		CU_ASSERT(pBitIter2->Advance() = True)
		CU_ASSERT_EQUAL(pBitIter->Item(), True)
		CU_ASSERT_EQUAL(pBitIter2->Item(), True)
		Delete pBitIter
		Delete pBitIter2
		pBitIter = 0
		pBitIter2 = 0
		dim bitsFalse As BitContainer = Type(80, False)
		pBitIter = bits.GetIterator()
		pBitIter2 = bitsFalse.GetIterator()
		CU_ASSERT(pBitIter <> 0)
		For i = 0 To 79
			CU_ASSERT(pBitIter->Advance() = True)
			CU_ASSERT(pBitIter2->Advance() = True)
			CU_ASSERT_EQUAL(pBitIter->Item(), True)
			CU_ASSERT_EQUAL(pBitIter2->Item(), False)
		Next
		CU_ASSERT(pBitIter->Advance() = False)
		CU_ASSERT(pBitIter2->Advance() = False)
		Delete pBitIter
		Delete pBitIter2
	END_TEST
	
	TEST(SetTest)
		dim bits As BitContainer = Type(64, False)
		dim bitsUBound As Long = bits.Count - 1
		dim i As Long
		For i = 0 To bitsUBound
			bits.Set(i, True)
		Next
		
		CU_ASSERT_EQUAL(bits.Contains(False), False)
		bits.Set(0, False)
		CU_ASSERT_EQUAL(bits.Contains(False), True)
		CU_ASSERT_EQUAL(bits[0], False)
		For i = 1 To bitsUBound
			CU_ASSERT_EQUAL(bits[i], True)
		Next
		bits.Set(37)
		CU_ASSERT_EQUAL(bits[37], True)
		CU_ASSERT_EQUAL(bits[0], False)
		For i = 1 To bitsUBound
			CU_ASSERT_EQUAL(bits[i], True)
		Next
		bits.Set(37, False)
		For i = 0 To bitsUBound
			CU_ASSERT_EQUAL(bits[i], (i > 0) AndAlso (i <> 37))
		Next
		For i = 0 To bitsUBound
			bits.Set(i, False)
		Next
		CU_ASSERT_EQUAL(bits.Contains(True), False)
		
		On Local Error Goto nextTest
		Dim localErr As Long = 0
		Err = 0
		bits.Set(866, False)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
	nextTest:
	
		On Local Error Goto nextTest2
		localErr = 0
		Err = 0
		bits.Set(-7, True)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
	nextTest2:
		On Local Error Goto 0		
	END_TEST
	
	TEST(SetAll)
		dim bits As BitContainer = Type(50, False)
		dim i As Long
		bits.SetAll()
		For i = 0 To 49
			CU_ASSERT_EQUAL(bits[i], True)
		Next
		
		dim alternaBitByte As UByte = &B10101010
		Dim alternaByteArray(Any) As UByte
		Redim alternaByteArray(7 To 62)
		For i = 7 To 62
			alternaByteArray(i) = alternaBitByte
		Next
		
		dim bits2 As BitContainer = Type(32, cast(Any Ptr, @alternaByteArray(7)))
		Dim contBytes(Any) As UByte
		dim contBytesUBound As Long = UBound(contBytes)
		bits2.SetAll()
		bits2.GetBytes(contBytes())
		For i = 0 To contBytesUBound
			CU_ASSERT_EQUAL(contBytes(i), &Hff)
		Next
		For i = 0 To 32 - 1
			CU_ASSERT_EQUAL(bits2[i], True)
		Next
		
		bits2.Set(31, False)
		CU_ASSERT_EQUAL(bits2[31], False)
		bits2.SetAll()
		CU_ASSERT_EQUAL(bits2[31], True)
		
		bits2.SetSpan(3, 5, False)
		bits2.SetAll()
		For i = 0 To 32 - 1
			CU_ASSERT_EQUAL(bits2[i], True)
		Next
	END_TEST
	
	TEST(SetSpan)
		dim bits As BitContainer = Type(50, True)
		dim i As Long
		bits.SetSpan(0, 8, False)
		
		For i = 0 To 49
			CU_ASSERT_EQUAL(bits[i], i > 7)
		Next
		
		bits.Clear()
		bits.SetSpan(4, 12)
		For i = 0 To 49
			CU_ASSERT_EQUAL(bits[i], i >= 4 AndAlso i <= 15)
		Next
		bits.SetSpan(4, 5, False)
		For i = 0 To 49
			CU_ASSERT_EQUAL(bits[i], i >= 9 AndAlso i <= 15)
		Next
		
		dim alternaBitByte As UByte = &B10101010
		Dim alternaByteArray(Any) As UByte
		Redim alternaByteArray(7 To 62)
		For i = 7 To 62
			alternaByteArray(i) = alternaBitByte
		Next
		
		dim bits2 As BitContainer = Type(51, cast(Any Ptr, @alternaByteArray(8)))
		bits2.SetSpan(35, 10)
		For i = 0 To 50
			If i >= 35 AndAlso i <= 44 Then
				CU_ASSERT_EQUAL(bits2[i], True)
			Else
				CU_ASSERT_EQUAL(bits2[i], CBool((i And 1) = 1))
			End If
		Next
		bits2.SetSpan(35, 1, False)
		For i = 0 To 50
			If i >= 36 AndAlso i <= 44 Then
				CU_ASSERT_EQUAL(bits2[i], True)
			Else
				CU_ASSERT_EQUAL(bits2[i], CBool((i <> 35) AndAlso (i And 1) = 1))
			End If
		Next
		bits2.SetSpan(20, 100)
		CU_ASSERT_EQUAL(bits2.Count, 51)
		For i = 0 To 50
			If i >= 20 Then
				CU_ASSERT_EQUAL(bits2[i], True)
			Else
				CU_ASSERT_EQUAL(bits2[i], CBool((i And 1) = 1))
			End If
		Next
		bits.SetSpan(0, 500, False)
		CU_ASSERT_EQUAL(bits.Count, 50)
		For i = 0 To 49
			CU_ASSERT_EQUAL(bits[i], False)
		Next
		
		On Local Error Goto nextTest
		Dim localErr As Long = 0
		Err = 0
		bits.SetSpan(-5, 20, False)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
	nextTest:
	
		On Local Error Goto nextTest2
		localErr = 0
		Err = 0
		bits.SetSpan(5, -20, False)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
	nextTest2:
	
		On Local Error Goto nextTest3
		localErr = 0
		Err = 0
		bits2.SetSpan(-9, -23)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
	nextTest3:
		On Local Error Goto 0
	END_TEST
	
	TEST(AndTest)
		dim i As Long
		dim alternaBitByte As UByte = &B10101010
		Dim alternaByteArray(Any) As UByte
		Redim alternaByteArray(7 To 62)
		For i = 7 To 62
			alternaByteArray(i) = alternaBitByte
		Next
		
		dim bits As BitContainer = Type(32, cast(Any Ptr, @alternaByteArray(7)))
		dim bitsRes As BitContainer = bits And bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bitsRes[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(bits[i], bitsRes[i])
		Next
		dim allSet As BitContainer = Type(32, True)
		bitsRes = allSet And bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bitsRes[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(bits[i], bitsRes[i])
			CU_ASSERT_EQUAL(allSet[i], True)
		Next
		dim oneByte As UByte = 0
		dim oneByteBits As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		dim oneByteAndRes As BitContainer = oneByteBits And allSet
		CU_ASSERT_EQUAL(oneByteAndRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteAndRes[i], False)
			CU_ASSERT_EQUAL(allSet[i], True)
		Next
		oneByte = 1
		dim oneByteBits2 As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		oneByteAndRes = oneByteBits2 And bits
		CU_ASSERT_EQUAL(oneByteAndRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteAndRes[i], False)
		Next
		oneByteAndRes = oneByteBits2 And allSet
		CU_ASSERT_EQUAL(oneByteAndRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteAndRes[i], i = 0)
		Next
	END_TEST
	
	TEST(OrTest)
		dim i As Long
		dim alternaBitByte As UByte = &B10101010
		Dim alternaByteArray(Any) As UByte
		Redim alternaByteArray(7 To 62)
		For i = 7 To 62
			alternaByteArray(i) = alternaBitByte
		Next
		
		dim bits As BitContainer = Type(32, cast(Any Ptr, @alternaByteArray(7)))
		dim bitsRes As BitContainer = bits Or bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bitsRes[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(bits[i], bitsRes[i])
		Next
		dim allSet As BitContainer = Type(32, True)
		bitsRes = allSet Or bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bitsRes[i], True)
			CU_ASSERT_EQUAL(bits[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(allSet[i], True)
		Next
		dim oneByte As UByte = 0
		dim oneByteBits As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		dim oneByteOrRes As BitContainer = oneByteBits Or allSet
		CU_ASSERT_EQUAL(oneByteOrRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteOrRes[i], allSet[i])
			CU_ASSERT_EQUAL(oneByteOrRes[i], True)
		Next
		oneByte = 1
		dim oneByteBits2 As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		oneByteOrRes = oneByteBits2 Or bits
		CU_ASSERT_EQUAL(oneByteOrRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteOrRes[i], (CBool((i And 1) = 1) OrElse (i = 0)))
		Next
	END_TEST
	
	TEST(XorTest)
		dim i As Long
		dim alternaBitByte As UByte = &B10101010
		Dim alternaByteArray(Any) As UByte
		Redim alternaByteArray(7 To 62)
		For i = 7 To 62
			alternaByteArray(i) = alternaBitByte
		Next
		
		dim bits As BitContainer = Type(32, cast(Any Ptr, @alternaByteArray(7)))
		dim bitsRes As BitContainer = bits Xor bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bits[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(bitsRes[i], False)
		Next
		dim allSet As BitContainer = Type(32, True)
		bitsRes = allSet Xor bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bitsRes[i], CBool((i And 1) = 0))
			CU_ASSERT_EQUAL(bits[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(allSet[i], True)
		Next
		dim oneByte As UByte = 0
		dim oneByteBits As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		dim oneByteXOrRes As BitContainer = oneByteBits Xor allSet
		CU_ASSERT_EQUAL(oneByteXOrRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteXOrRes.Get(i), True)
		Next
		oneByte = 1
		dim oneByteBits2 As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		oneByteXOrRes = oneByteBits2 Xor bits
		CU_ASSERT_EQUAL(oneByteXorRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteXOrRes[i], (CBool((i And 1) = 1) OrElse (i = 0)))
		Next
	END_TEST
	
	TEST(ImpTest)
		dim i As Long
		dim alternaBitByte As UByte = &B10101010
		Dim alternaByteArray(Any) As UByte
		Redim alternaByteArray(7 To 62)
		For i = 7 To 62
			alternaByteArray(i) = alternaBitByte
		Next
		
		dim bits As BitContainer = Type(32, cast(Any Ptr, @alternaByteArray(7)))
		dim bitsRes As BitContainer = bits Imp bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bits[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(bitsRes[i], True)
		Next
		
		dim allSet As BitContainer = Type(32, True)
		bitsRes = allSet Imp bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bitsRes[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(bits[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(allSet[i], True)
		Next
		dim oneByte As UByte = 0
		dim oneByteBits As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		dim oneByteImpRes As BitContainer = oneByteBits Imp allSet
		CU_ASSERT_EQUAL(oneByteImpRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteImpRes.Get(i), True)
		Next
		oneByteImpRes = allSet Imp oneByteBits
		CU_ASSERT_EQUAL(oneByteImpRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteImpRes.Get(i), False)
		Next
		oneByte = 1
		dim oneByteBits2 As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		oneByteImpRes = oneByteBits2 Imp bits
		CU_ASSERT_EQUAL(oneByteImpRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteImpRes[i], i > 0)
		Next
		oneByteImpRes = bits Imp oneByteBits2
		CU_ASSERT_EQUAL(oneByteImpRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteImpRes[i], CBool((i And 1) = 0))
		Next
	END_TEST
	
	TEST(EqvTest)
		dim i As Long
		dim alternaBitByte As UByte = &B10101010
		Dim alternaByteArray(Any) As UByte
		Redim alternaByteArray(7 To 62)
		For i = 7 To 62
			alternaByteArray(i) = alternaBitByte
		Next
		
		dim bits As BitContainer = Type(32, cast(Any Ptr, @alternaByteArray(7)))
		dim bitsRes As BitContainer = bits Eqv bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bits[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(bitsRes[i], True)
		Next
		
		dim allSet As BitContainer = Type(32, True)
		bitsRes = allSet Eqv bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bitsRes[i], bits[i])
			CU_ASSERT_EQUAL(bits[i], CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(allSet[i], True)
		Next
		dim oneByte As UByte = 0
		dim oneByteBits As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		dim oneByteEqvRes As BitContainer = oneByteBits Eqv allSet
		CU_ASSERT_EQUAL(oneByteEqvRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteEqvRes.Get(i), False)
		Next
		oneByte = 1
		dim oneByteBits2 As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		oneByteEqvRes = oneByteBits2 Eqv bits
		CU_ASSERT_EQUAL(oneByteEqvRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteEqvRes[i], CBool((i > 0) AndAlso (i And 1) = 0))
		Next
		oneByteEqvRes = bits Eqv oneByteBits2
		CU_ASSERT_EQUAL(oneByteEqvRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteEqvRes[i], CBool((i > 0) AndAlso (i And 1) = 0))
		Next
	END_TEST
	
	TEST(NotTest)
		dim i As Long
		dim alternaBitByte As UByte = &B10101010
		Dim alternaByteArray(Any) As UByte
		Redim alternaByteArray(7 To 62)
		For i = 7 To 62
			alternaByteArray(i) = alternaBitByte
		Next		

		dim bits As BitContainer = Type(32, cast(Any Ptr, @alternaByteArray(7)))
		dim bitsRes As BitContainer = Not bits
		For i = 0 To 31
			CU_ASSERT_EQUAL(bitsRes[i], CBool((i And 1) = 0))
			CU_ASSERT_EQUAL(bits[i], CBool((i And 1) = 1))
		Next
		dim allSet As BitContainer = Type(32, True)
		bitsRes = Not allSet
		For i = 0 To 31
			CU_ASSERT_EQUAL(bitsRes[i], False)
			CU_ASSERT_EQUAL(allSet[i], True)
		Next
		dim oneByte As UByte = 0
		dim oneByteBits As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		dim oneByteNotRes As BitContainer = Not oneByteBits
		CU_ASSERT_EQUAL(oneByteNotRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteNotRes[i], True)
			CU_ASSERT_EQUAL(oneByteBits[i], False)
		Next
		oneByte = 1
		dim oneByteBits2 As BitContainer = Type(8, cast(Any Ptr, @oneByte))
		oneByteNotRes = Not oneByteBits2
		CU_ASSERT_EQUAL(oneByteNotRes.Count, oneByteBits2.Count)
		CU_ASSERT_EQUAL(oneByteNotRes.Count, 8)
		For i = 0 To 7
			CU_ASSERT_EQUAL(oneByteNotRes[i], CBool(i > 0))
		Next
	END_TEST
	
	TEST(LenTest)
		dim bits As BitContainer = Type(65)
		dim i As Long
		CU_ASSERT_EQUAL(Len(bits), 65)
		For i = 0 To 32
			dim loopCont As BitContainer = Type(i * 3, CBool((i And 1) = 1))
			CU_ASSERT_EQUAL(loopCont.Count, i * 3)
			CU_ASSERT_EQUAL(Len(loopCont), loopCont.Count)
		Next
		dim arr(Any) As Boolean
		Redim arr(0 To 63)
		Randomize
		For i = 0 To 50
			dim numBits As Long = (Rnd * 62) + 1
			dim arrCont As BitContainer = Type(numBits, cast(Any Ptr, @arr(0)))
			CU_ASSERT_EQUAL(Len(arrCont), numBits)
			CU_ASSERT_EQUAL(arrCont.Count, numBits)
		Next
	END_TEST
END_SUITE
''#define FB_CONTAINER_DEBUG 1
#include "../../inc/containers/stack.bi"
#include "ContainerTestPrereqs.bi"
#include "fbcunit.bi"

FBCont_DefineStackOf(Long)
Type LongStack As FB_Stack(Long)

Private Sub CheckStackAgainstArray(Byref stack As LongStack, arr() As Long)
    Dim stackCopy As LongStack = stack
    Dim As Long arrLBound, arrUBound, numElems, i
    arrLBound = LBound(arr)
    arrUBound = UBound(arr)
    numElems = (arrUBound - arrLBound) + 1
    CU_ASSERT_EQUAL(numElems, Len(stack))
    For i = arrUBound To arrLBound Step -1
        CU_ASSERT_EQUAL(arr(i), stackCopy.Pop())
    Next
End Sub

SUITE(fbc_tests.containers.stacks.primitive)
	TEST(ConstructorTest)
		dim emptyStack As LongStack
		CU_ASSERT_EQUAL(emptyStack.Count, 0)
		dim emptyIterator As SequentialLongGenerator = Type(0, 1)

		Dim zt1NumToGenerate As Long = 15
		Dim zt1StartNum As Long = 0
		Dim i As Long
		Dim zeroTo14Iterator As SequentialLongGenerator = Type(zt1NumToGenerate, zt1StartNum)
		Dim tt2NumToGenerate As Long = 7
		Dim tt2StartNum As Long = 203
		Dim twoHundred3To210Iterator As SequentialLongGenerator = Type(tt2NumToGenerate, tt2StartNum)

		'' Iterator constructor
		Dim zt1Stack As LongStack = zeroTo14Iterator
		Dim zt1StackCopy As LongStack = zt1Stack
		CU_ASSERT_EQUAL(zt1Stack.Count, zt1NumToGenerate)
		For i = (zt1NumToGenerate - 1) To 0 Step -1
			CU_ASSERT_EQUAL(zt1Stack.Pop(), zt1StartNum + i)
		Next
		zt1Stack = zt1StackCopy
		
		Dim tt2Stack As LongStack = twoHundred3To210Iterator
		Dim tt2StackCopy As LongStack = tt2Stack
		CU_ASSERT_EQUAL(tt2Stack.Count, tt2NumToGenerate)
		For i = (tt2NumToGenerate - 1) To 0 Step -1
			CU_ASSERT_EQUAL(tt2Stack.Pop(), tt2StartNum + i)
		Next
		tt2Stack = tt2StackCopy
		zeroTo14Iterator.Reset()

		Dim zt1Stack2 As LongStack = @zeroTo14Iterator
		Dim zt1Stack2Copy As LongStack = zt1Stack2
		CU_ASSERT_EQUAL(zt1Stack.Count, zt1Stack2.Count)
		For i = (zt1NumToGenerate - 1) To 0 Step -1
			CU_ASSERT_EQUAL(zt1Stack2.Pop(), zt1Stack.Pop())
		Next		
		zt1Stack2 = zt1Stack2Copy
		twoHundred3To210Iterator.Reset()

		Dim tt2Stack2 As LongStack = @twoHundred3To210Iterator
		Dim tt2StackCopy2 As LongStack = tt2Stack2
		CU_ASSERT_EQUAL(tt2Stack2.Count, tt2Stack.Count)
		For i = (tt2NumToGenerate - 1) To 0 Step -1
			CU_ASSERT_EQUAL(tt2Stack.Pop(), tt2StartNum + i)
		Next
		tt2Stack2 = tt2StackCopy2
		
		dim newEmptyStack As LongStack = emptyIterator
		CU_ASSERT_EQUAL(newEmptyStack.Count, 0)
		emptyIterator.Reset()

		'' Copy Constructors
		Dim zt1Temp As LongStack = zt1Stack
		CU_ASSERT_EQUAL(zt1Temp.Count, zt1Stack.Count)
		For i = 0 To zt1Stack.Count - 1
			CU_ASSERT_EQUAL(zt1Temp.Pop(), zt1Stack.Pop())
		Next

		Dim tt2Temp As LongStack = tt2Stack
		CU_ASSERT_EQUAL(tt2Temp.Count, tt2Stack.Count)
		For i = 0 To tt2Stack.Count - 1
			CU_ASSERT_EQUAL(tt2Temp.Pop(), tt2Stack.Pop())
		Next
		
		dim numArray(7) As Long
		dim numArrayLBound As Long = LBound(numArray)
		dim numArrayUBound As Long = UBound(numArray)
		For i = numArrayLBound To numArrayUBound
			numArray(i) = i
		Next
		
		Dim arrayStack As LongStack = numArray()
		CheckStackAgainstArray(arrayStack, numArray())
		
		dim numArrayBased(5 To 9) As Long
		numArrayLBound = LBound(numArrayBased)
		numArrayUBound = UBound(numArrayBased)
		For i = numArrayLBound To numArrayUBound
			numArrayBased(i) = i
		Next
		
		Dim arrayStackBased As LongStack = numArrayBased()
		CheckStackAgainstArray(arrayStackBased, numArrayBased())
		
		dim undimmedArray(Any) As Long
		dim anyArrayStack As LongStack = undimmedArray()
		CU_ASSERT_EQUAL(anyArrayStack.Count, 0)

		'' Container constructors
		'' The stack iterator goes from top to bottom so the contents
		'' of a stack created from that will be in reverse order
		dim contStack As LongStack = @arrayStackBased
		For i = numArrayLBound To numArrayUBound
			CU_ASSERT_EQUAL(numArrayBased(i), contStack.Pop())
		Next

		dim contStack2 As LongStack = @arrayStack
		For i = LBound(numArray) To UBound(numArray)
			CU_ASSERT_EQUAL(numArray(i), contStack2.Pop())
		Next

		Dim fromEmptyContainerStack As LongStack = @newEmptyStack
		CU_ASSERT_EQUAL(fromEmptyContainerStack.Count, 0)
	END_TEST
	
	TEST(Push)
		dim singleItemStack As LongStack
		singleItemStack.Push(78)
		CU_ASSERT_EQUAL(singleItemStack.Top, 78)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		singleItemStack.Push(-78)
		singleItemStack.Push(35)
		singleItemStack.Push(-87)
		CU_ASSERT_EQUAL(singleItemStack.Count, 4)
		CU_ASSERT_EQUAL(singleItemStack.Top, -87)
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Top, 35)
		singleItemStack.Push(123456)
		CU_ASSERT_EQUAL(singleItemStack.Top, 123456)
		CU_ASSERT_EQUAL(singleItemStack.Pop(), 123456)
		CU_ASSERT_EQUAL(singleItemStack.Pop(), 35)
		CU_ASSERT_EQUAL(singleItemStack.Pop(), -78)
		CU_ASSERT_EQUAL(singleItemStack.Pop(), 78)
		singleItemStack.Clear()
		singleItemStack += 19
		CU_ASSERT_EQUAL(singleItemStack.Top, 19)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		singleItemStack += 99
		CU_ASSERT_EQUAL(singleItemStack.Top, 99)
		CU_ASSERT_EQUAL(singleItemStack.Count, 2)
		CU_ASSERT_EQUAL(singleItemStack.Pop(), 99)
		CU_ASSERT_EQUAL(singleItemStack.Pop(), 19)
	END_TEST
	
	TEST(Pop)
		dim singleItemStack As LongStack
		singleItemStack.Push(78)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		CU_ASSERT_EQUAL(singleItemStack.Pop(), 78)
		CU_ASSERT_EQUAL(singleItemStack.Count, 0)
		
		singleItemStack.Push(-78)
		singleItemStack.Push(35)
		singleItemStack.Push(-87)
		Dim poppedVal As Long = singleItemStack.Pop()
		CU_ASSERT_EQUAL(poppedVal, -87)
		CU_ASSERT(singleItemStack.Top <> -87)
		CU_ASSERT_EQUAL(singleItemStack.Count, 2)
		poppedVal = singleItemStack.Pop()
		CU_ASSERT_EQUAL(poppedVal, 35)
		CU_ASSERT(singleItemStack.Top <> 35)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		poppedVal = singleItemStack.Pop()
		CU_ASSERT_EQUAL(poppedVal, -78)
		CU_ASSERT(singleItemStack.Top <> -78)
		CU_ASSERT_EQUAL(singleItemStack.Count, 0)
		Err = 0
		On Local Error Goto nextTest
		poppedVal = singleItemStack.Pop() '' Pop with no elements is an error
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6)
	nextTest:
		On Local Error Goto 0
	END_TEST
	
	TEST(Top)
		dim singleItemStack As LongStack
		singleItemStack.Push(78)
		CU_ASSERT_EQUAL(singleItemStack.Top, 78)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		
		singleItemStack.Push(-78)
		CU_ASSERT_EQUAL(singleItemStack.Top, -78)
		singleItemStack.Push(35)
		CU_ASSERT_EQUAL(singleItemStack.Top, 35)
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Top, -78)
		singleItemStack.Push(-87)
		CU_ASSERT_EQUAL(singleItemStack.Top, -87)
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Top, -78)
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Top, 78)
		singleItemStack.Pop()
		singleItemStack.Push(123456)
		CU_ASSERT_EQUAL(singleItemStack.Top, 123456)
		singleItemStack.Pop()
		Err = 0
		On Local Error Goto nextTest
		dim poppedVal As Long = singleItemStack.Top '' Top with no elements is an error
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6)
	nextTest:
		On Local Error Goto 0
	END_TEST
	
	TEST(Clear)
		dim singleItemStack As LongStack
		singleItemStack.Push(78)
		singleItemStack.Push(-78)
		dim stackSize As Long = singleItemStack.Count
		singleItemStack.Clear()
		CU_ASSERT_EQUAL(singleItemStack.Count, 0)
		CU_ASSERT(singleItemStack.Count <> stackSize)
		stackSize = singleItemStack.Count
		singleItemStack.Clear()
		CU_ASSERT_EQUAL(singleItemStack.Count, 0)
		CU_ASSERT_EQUAL(singleItemStack.Count, stackSize)
		dim stack2 As LongStack	
		stack2.Clear()
		CU_ASSERT_EQUAL(stack2.Count, 0)
	END_TEST
	
	TEST(Contains)
		dim haystack As LongStack
		dim needle As Long = 78
		dim result As Boolean
		result = haystack.Contains(0)
		CU_ASSERT_EQUAL(result, False)
		haystack.Push(needle)
		haystack.Push(-needle)
		haystack.Push(52)
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, True)
		result = haystack.Contains(52)
		CU_ASSERT_EQUAL(result, True)
		haystack.Pop()
		result = haystack.Contains(52)
		CU_ASSERT_EQUAL(result, False)
		haystack.Pop()
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, True)
		result = haystack.Contains(-needle)
		CU_ASSERT_EQUAL(result, False)
		Dim generate100 As SequentialLongGenerator = Type(100, 100)
		dim secondHaystack As LongStack = @generate100
		result = secondHaystack.Contains(157)
		CU_ASSERT_EQUAL(result, True)
	END_TEST
	
	TEST(CopyTo)
		dim singleItemStack As LongStack
		dim i As Long
		singleItemStack.Push(78)
		singleItemStack.Push(-78)
		singleItemStack.Push(8537536)
		'' Undimmed arrays are redimmed to be the size of the container, from 0 To n-1
		dim undimmedArr(Any) As Long
		singleItemStack.CopyTo(undimmedArr())
		dim arrUBound As Long = UBound(undimmedArr)
		dim arrLBound As Long = LBound(undimmedArr)
		dim numElems As Long = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, singleItemStack.Count)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		Dim itemStackCopy As LongStack = singleItemStack
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedArr(i), itemStackCopy.Pop())
		Next
		
		'' Except in empty lists, where nothing happens
		'' If container debug is defined, this calls Error
		dim emptyStack As LongStack
		dim emptyArr(Any) As Long
		On Local Error Goto nextTest1
		dim localErr As Long
		Err = 0
		emptyStack.CopyTo(emptyArr())
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)

	nextTest1:
		On Local Error Goto 0
		'' already sized arrays copy the number of items in the stack or the size of the array
		'' whichever is smaller
		dim largerThanContArr(10 To 14) As Long
		For i = 10 To 14
			largerThanContArr(i) = i
		Next
		singleItemStack.CopyTo(largerThanContArr())
		arrUBound = UBound(largerThanContArr)
		arrLBound = LBound(largerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 5)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 10)
		CU_ASSERT_EQUAL(arrUBound, 14)
		itemStackCopy = singleItemStack
		For i = 10 To 14
			CU_ASSERT_EQUAL(largerThanContArr(i), IIf(i <= 12, itemStackCopy.Pop(), i))
		Next
		
		dim smallerThanContArr(21 To 22) As Long
		For i = 21 To 22
			smallerThanContArr(i) = i
		Next
		singleItemStack.Push(4)
		singleItemStack.CopyTo(smallerThanContArr())
		arrUBound = UBound(smallerThanContArr)
		arrLBound = LBound(smallerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 2)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 22)
		For i = 21 To 22
			CU_ASSERT_EQUAL(smallerThanContArr(i), singleItemStack.Pop())
		Next
	END_TEST
	
	TEST(GetIterator)
		dim stack As LongStack
		dim pListIter As FB_IIterator(Long) Ptr = stack.GetIterator()
		CU_ASSERT(pListIter <> 0)
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
		pListIter = 0
		stack.Push(7)
		pListIter = stack.GetIterator()
		dim pListIter2 As FB_IIterator(Long) Ptr = stack.GetIterator()
		CU_ASSERT(pListIter <> 0)
		CU_ASSERT(pListIter2 <> 0)
		CU_ASSERT(pListIter <> pListIter2)
		CU_ASSERT(pListIter->Advance() = True)
		CU_ASSERT_EQUAL(pListIter->Item(), 7)
		CU_ASSERT(pListIter2->Advance() = True)
		CU_ASSERT_EQUAL(pListIter->Item(), 7)
		CU_ASSERT_EQUAL(pListIter2->Item(), 7)
		Delete pListIter
		Delete pListIter2
		pListIter = 0
		pListIter2 = 0
		stack.Clear()
		Dim i As Long
		For i = 0 To 6
			stack.Push(i)
		Next
		pListIter = stack.GetIterator()
		CU_ASSERT(pListIter <> 0)
		For i = 6 To 0 Step -1
			CU_ASSERT(pListIter->Advance() = True)
			CU_ASSERT_EQUAL(pListIter->Item(), i)
		Next
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
	END_TEST
	
	TEST(LenTest)
		dim singleItemStack As LongStack
		singleItemStack.Push(78)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
		singleItemStack.Push(-78)
		singleItemStack.Push(35)
		singleItemStack.Push(-87)
		CU_ASSERT_EQUAL(singleItemStack.Count, 4)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Count, 3)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Count, 2)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
		singleItemStack.Pop()
		singleItemStack.Clear()
		singleItemStack += 19
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
		singleItemStack += 99
		CU_ASSERT_EQUAL(singleItemStack.Count, 2)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Count, 0)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
	END_TEST

	TEST(Empty)
		dim singleItemStack As LongStack
		CU_ASSERT_EQUAL(singleItemStack.Empty(), True)
		singleItemStack.Push(78)
		CU_ASSERT_EQUAL(singleItemStack.Empty(), False)
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Empty(), True)
		Dim arr(0 To 1) As Long
		dim otherStack As LongStack = arr()
		CU_ASSERT_EQUAL(otherStack.Empty(), False)
		otherStack.Pop()
		CU_ASSERT_EQUAL(otherStack.Empty(), False)
		otherStack.Clear()
		CU_ASSERT_EQUAL(otherStack.Empty(), True)
	END_TEST
END_SUITE
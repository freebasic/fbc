''#define FB_CONTAINER_DEBUG 1
#include "../../inc/containers/stack.bi"
#include "ContainerTestPrereqs.bi"
#include "fbcunit.bi"

FBCont_DefineStackOf(One, Two, IntegerHolder)
Type IntegerHolderStack As FB_Stack(One, Two, IntegerHolder)

Private Sub CheckStackAgainstArray(Byref stack As IntegerHolderStack, arr() As One.Two.IntegerHolder)
    Dim stackCopy As IntegerHolderStack = stack
    Dim As Long arrLBound, arrUBound, numElems, i
    arrLBound = LBound(arr)
    arrUBound = UBound(arr)
    numElems = (arrUBound - arrLBound) + 1
    CU_ASSERT_EQUAL(numElems, Len(stack))
    For i = arrUBound To arrLBound Step -1
        CU_ASSERT_EQUAL(arr(i), stackCopy.Pop())
    Next
End Sub

SUITE(fbc_tests.containers.stacks.udt)
	TEST(ConstructorTest)
		dim emptyStack As IntegerHolderStack
		CU_ASSERT_EQUAL(emptyStack.Count, 0)
		dim emptyIterator As SequentialIntegerHolderGenerator = Type(0, 1)

		Dim zt1NumToGenerate As Long = 15
		Dim zt1StartNum As Long = 0
		Dim i As Long
		Dim zeroTo14Iterator As SequentialIntegerHolderGenerator = Type(zt1NumToGenerate, zt1StartNum)
		Dim tt2NumToGenerate As Long = 7
		Dim tt2StartNum As Long = 203
		Dim twoHundred3To210Iterator As SequentialIntegerHolderGenerator = Type(tt2NumToGenerate, tt2StartNum)

		'' Iterator constructor
		Dim zt1Stack As IntegerHolderStack = zeroTo14Iterator
		Dim zt1StackCopy As IntegerHolderStack = zt1Stack
		CU_ASSERT_EQUAL(zt1Stack.Count, zt1NumToGenerate)
		For i = (zt1NumToGenerate - 1) To 0 Step -1
			CU_ASSERT_EQUAL(zt1Stack.Pop().num, zt1StartNum + i)
		Next
		zt1Stack = zt1StackCopy
		
		Dim tt2Stack As IntegerHolderStack = twoHundred3To210Iterator
		Dim tt2StackCopy As IntegerHolderStack = tt2Stack
		CU_ASSERT_EQUAL(tt2Stack.Count, tt2NumToGenerate)
		For i = (tt2NumToGenerate - 1) To 0 Step -1
			CU_ASSERT_EQUAL(tt2Stack.Pop().num, tt2StartNum + i)
		Next
		tt2Stack = tt2StackCopy
		zeroTo14Iterator.Reset()

		Dim zt1Stack2 As IntegerHolderStack = @zeroTo14Iterator
		Dim zt1Stack2Copy As IntegerHolderStack = zt1Stack2
		CU_ASSERT_EQUAL(zt1Stack.Count, zt1Stack2.Count)
		For i = (zt1NumToGenerate - 1) To 0 Step -1
			CU_ASSERT_EQUAL(zt1Stack2.Pop(), zt1Stack.Pop())
		Next		
		zt1Stack2 = zt1Stack2Copy
		twoHundred3To210Iterator.Reset()

		Dim tt2Stack2 As IntegerHolderStack = @twoHundred3To210Iterator
		Dim tt2StackCopy2 As IntegerHolderStack = tt2Stack2
		CU_ASSERT_EQUAL(tt2Stack2.Count, tt2Stack.Count)
		For i = (tt2NumToGenerate - 1) To 0 Step -1
			CU_ASSERT_EQUAL(tt2Stack.Pop().num, tt2StartNum + i)
		Next
		tt2Stack2 = tt2StackCopy2
		
		dim newEmptyStack As IntegerHolderStack = emptyIterator
		CU_ASSERT_EQUAL(newEmptyStack.Count, 0)
		emptyIterator.Reset()

		'' Copy Constructors
		Dim zt1Temp As IntegerHolderStack = zt1Stack
		CU_ASSERT_EQUAL(zt1Temp.Count, zt1Stack.Count)
		For i = 0 To zt1Stack.Count - 1
			CU_ASSERT_EQUAL(zt1Temp.Pop(), zt1Stack.Pop())
		Next

		Dim tt2Temp As IntegerHolderStack = tt2Stack
		CU_ASSERT_EQUAL(tt2Temp.Count, tt2Stack.Count)
		For i = 0 To tt2Stack.Count - 1
			CU_ASSERT_EQUAL(tt2Temp.Pop(), tt2Stack.Pop())
		Next
		
		dim numArray(7) As One.Two.IntegerHolder
		dim numArrayLBound As Long = LBound(numArray)
		dim numArrayUBound As Long = UBound(numArray)
		For i = numArrayLBound To numArrayUBound
			numArray(i).num = i
		Next
		
		Dim arrayStack As IntegerHolderStack = numArray()
		CheckStackAgainstArray(arrayStack, numArray())
		
		dim numArrayBased(5 To 9) As One.Two.IntegerHolder
		numArrayLBound = LBound(numArrayBased)
		numArrayUBound = UBound(numArrayBased)
		For i = numArrayLBound To numArrayUBound
			numArrayBased(i).num = i
		Next
		
		Dim arrayStackBased As IntegerHolderStack = numArrayBased()
		CheckStackAgainstArray(arrayStackBased, numArrayBased())
		
		dim undimmedArray(Any) As One.Two.IntegerHolder
		dim anyArrayStack As IntegerHolderStack = undimmedArray()
		CU_ASSERT_EQUAL(anyArrayStack.Count, 0)

		'' Container constructors
		'' The stack iterator goes from top to bottom so the contents
		'' of a stack created from that will be in reverse order
		dim contStack As IntegerHolderStack = @arrayStackBased
		For i = numArrayLBound To numArrayUBound
			CU_ASSERT_EQUAL(numArrayBased(i), contStack.Pop())
		Next

		dim contStack2 As IntegerHolderStack = @arrayStack
		For i = LBound(numArray) To UBound(numArray)
			CU_ASSERT_EQUAL(numArray(i), contStack2.Pop())
		Next

		Dim fromEmptyContainerStack As IntegerHolderStack = @newEmptyStack
		CU_ASSERT_EQUAL(fromEmptyContainerStack.Count, 0)

	END_TEST
	
	TEST(Push)
		dim singleItemStack As IntegerHolderStack
		dim temp As One.Two.IntegerHolder = (78)
		singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Top, temp)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		temp.num = -78 : singleItemStack.Push(temp)
		temp.num = 35 : singleItemStack.Push(temp)
		temp.num = -87 : singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Count, 4)
		CU_ASSERT_EQUAL(singleItemStack.Top, temp)
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Top.num, 35)
		temp.num = 123456 : singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Top.num, 123456)
		CU_ASSERT_EQUAL(singleItemStack.Pop().num, 123456)
		CU_ASSERT_EQUAL(singleItemStack.Pop().num, 35)
		CU_ASSERT_EQUAL(singleItemStack.Pop().num, -78)
		CU_ASSERT_EQUAL(singleItemStack.Pop().num, 78)
		singleItemStack.Clear()
		temp.num = 19
		singleItemStack += temp
		CU_ASSERT_EQUAL(singleItemStack.Top, temp)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		temp.num = 99 : singleItemStack += temp
		CU_ASSERT_EQUAL(singleItemStack.Top, temp)
		CU_ASSERT_EQUAL(singleItemStack.Count, 2)
		CU_ASSERT_EQUAL(singleItemStack.Pop(), temp)
		CU_ASSERT_EQUAL(singleItemStack.Pop().num, 19)
	END_TEST
	
	TEST(Pop)
		dim singleItemStack As IntegerHolderStack
		dim temp As One.Two.IntegerHolder = (78)
		singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		CU_ASSERT_EQUAL(singleItemStack.Pop(), temp)
		CU_ASSERT_EQUAL(singleItemStack.Count, 0)
		
		temp.num = -78 : singleItemStack.Push(temp)
		temp.num = 35 : singleItemStack.Push(temp)
		temp.num = -87 : singleItemStack.Push(temp)
		Dim poppedVal As One.Two.IntegerHolder = singleItemStack.Pop()
		CU_ASSERT_EQUAL(poppedVal, temp)
		CU_ASSERT(singleItemStack.Top.num <> -87)
		CU_ASSERT_EQUAL(singleItemStack.Count, 2)
		poppedVal = singleItemStack.Pop()
		CU_ASSERT_EQUAL(poppedVal.num, 35)
		CU_ASSERT(singleItemStack.Top.num <> 35)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		poppedVal = singleItemStack.Pop()
		CU_ASSERT_EQUAL(poppedVal.num, -78)
		CU_ASSERT(singleItemStack.Top.num <> -78)
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
		dim singleItemStack As IntegerHolderStack
		dim temp As One.Two.IntegerHolder = (78)
		singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Top, temp)
		
		temp.num = -78 : singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Top, temp)
		CU_ASSERT_EQUAL(singleItemStack.Top.num, -78)
		temp.num = 35 : singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Top, temp)
		CU_ASSERT_EQUAL(singleItemStack.Top.num, 35)
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Top.num, -78)
		temp.num = -87 : singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Top, temp)
		CU_ASSERT_EQUAL(singleItemStack.Top.num, -87)
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Top.num, -78)
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Top.num, 78)
		singleItemStack.Pop()
		temp.num = 123456 : singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Top, temp)
		singleItemStack.Pop()
		Err = 0
		On Local Error Goto nextTest
		temp = singleItemStack.Top '' Top with no elements is an error
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6)
	nextTest:
		On Local Error Goto 0
	END_TEST
	
	TEST(Clear)
		dim singleItemStack As IntegerHolderStack
		dim temp As One.Two.IntegerHolder = (78)
		singleItemStack.Push(temp)
		temp.num = -78 : singleItemStack.Push(temp)
		dim stackSize As Long = singleItemStack.Count
		singleItemStack.Clear()
		CU_ASSERT_EQUAL(singleItemStack.Count, 0)
		CU_ASSERT(singleItemStack.Count <> stackSize)
		stackSize = singleItemStack.Count
		singleItemStack.Clear()
		CU_ASSERT_EQUAL(singleItemStack.Count, 0)
		CU_ASSERT_EQUAL(singleItemStack.Count, stackSize)
		dim stack2 As IntegerHolderStack	
		stack2.Clear()
		CU_ASSERT_EQUAL(stack2.Count, 0)
	END_TEST
	
	TEST(Contains)
		dim haystack As IntegerHolderStack
		dim needle As One.Two.IntegerHolder = (78)
		dim temp As One.Two.IntegerHolder = (0)
		dim result As Boolean
		result = haystack.Contains(temp)
		CU_ASSERT_EQUAL(result, False)
		haystack.Push(needle)
		temp.num = -needle.num : haystack.Push(temp)
		temp.num = 52 : haystack.Push(temp)
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, True)
		result = haystack.Contains(temp)
		CU_ASSERT_EQUAL(result, True)
		haystack.Pop()
		result = haystack.Contains(temp)
		CU_ASSERT_EQUAL(result, False)
		haystack.Pop()
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, True)
		temp.num = -needle.num : result = haystack.Contains(temp)
		CU_ASSERT_EQUAL(result, False)
		Dim generate100 As SequentialIntegerHolderGenerator = Type(100, 100)
		dim secondHaystack As IntegerHolderStack = @generate100
		temp.num = 157 : result = secondHaystack.Contains(temp)
		CU_ASSERT_EQUAL(result, True)
	END_TEST
	
	TEST(CopyTo)
		dim singleItemStack As IntegerHolderStack
		dim i As Long
		dim temp As One.Two.IntegerHolder = (78)
		singleItemStack.Push(temp)
		temp.num = -78 : singleItemStack.Push(temp)
		temp.num = 8537536 : singleItemStack.Push(temp)
		'' Undimmed arrays are redimmed to be the size of the container, from 0 To n-1
		dim undimmedArr(Any) As One.Two.IntegerHolder
		singleItemStack.CopyTo(undimmedArr())
		dim arrUBound As Long = UBound(undimmedArr)
		dim arrLBound As Long = LBound(undimmedArr)
		dim numElems As Long = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, singleItemStack.Count)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		Dim itemStackCopy As IntegerHolderStack = singleItemStack
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedArr(i), itemStackCopy.Pop())
		Next
		
		'' Except in empty lists, where nothing happens
		'' If container debug is defined, this calls Error
		dim emptyStack As IntegerHolderStack
		dim emptyArr(Any) As One.Two.IntegerHolder
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
		dim largerThanContArr(10 To 14) As One.Two.IntegerHolder
		For i = 10 To 14
			largerThanContArr(i).num = i
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
			temp.num = i
			CU_ASSERT_EQUAL(largerThanContArr(i), IIf(i <= 12, itemStackCopy.Pop(), temp))
		Next
		
		dim smallerThanContArr(21 To 22) As One.Two.IntegerHolder
		For i = 21 To 22
			smallerThanContArr(i).num = i
		Next
		temp.num = 4 : singleItemStack.Push(temp)
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
		dim stack As IntegerHolderStack
		dim pListIter As FB_IIterator(One, Two, IntegerHolder) Ptr = stack.GetIterator()
		CU_ASSERT(pListIter <> 0)
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
		pListIter = 0
		Dim temp As One.Two.IntegerHolder = (7)
		stack.Push(temp)
		pListIter = stack.GetIterator()
		dim pListIter2 As FB_IIterator(One, Two, IntegerHolder) Ptr = stack.GetIterator()
		CU_ASSERT(pListIter <> 0)
		CU_ASSERT(pListIter2 <> 0)
		CU_ASSERT(pListIter <> pListIter2)
		CU_ASSERT(pListIter->Advance() = True)
		CU_ASSERT_EQUAL(pListIter->Item(), temp)
		CU_ASSERT(pListIter2->Advance() = True)
		CU_ASSERT_EQUAL(pListIter->Item(), temp)
		CU_ASSERT_EQUAL(pListIter2->Item(), temp)
		Delete pListIter
		Delete pListIter2
		pListIter = 0
		pListIter2 = 0
		stack.Clear()
		Dim i As Long
		For i = 0 To 6
			temp.num = i
			stack.Push(temp)
		Next
		pListIter = stack.GetIterator()
		CU_ASSERT(pListIter <> 0)
		For i = 6 To 0 Step -1
			temp.num = i
			CU_ASSERT(pListIter->Advance() = True)
			CU_ASSERT_EQUAL(pListIter->Item(), temp)
		Next
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
	END_TEST
	
	TEST(LenTest)
		dim singleItemStack As IntegerHolderStack
		dim temp As One.Two.IntegerHolder = (78)
		singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
		temp.num = -78 : singleItemStack.Push(temp)
		temp.num = 35 : singleItemStack.Push(temp)
		temp.num = -87 : singleItemStack.Push(temp)
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
		temp.num = 19
		singleItemStack += temp
		CU_ASSERT_EQUAL(singleItemStack.Count, 1)
		CU_ASSERT_EQUAL(singleItemStack.Count, Len(singleItemStack))
		temp.num = 99 : singleItemStack += temp
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
		dim singleItemStack As IntegerHolderStack
		dim temp As One.Two.IntegerHolder = (78)
		CU_ASSERT_EQUAL(singleItemStack.Empty(), True)
		singleItemStack.Push(temp)
		CU_ASSERT_EQUAL(singleItemStack.Empty(), False)
		singleItemStack.Pop()
		CU_ASSERT_EQUAL(singleItemStack.Empty(), True)
		Dim arr(0 To 1) As One.Two.IntegerHolder
		dim otherStack As IntegerHolderStack = arr()
		CU_ASSERT_EQUAL(otherStack.Empty(), False)
		otherStack.Pop()
		CU_ASSERT_EQUAL(otherStack.Empty(), False)
		otherStack.Clear()
		CU_ASSERT_EQUAL(otherStack.Empty(), True)
	END_TEST
END_SUITE
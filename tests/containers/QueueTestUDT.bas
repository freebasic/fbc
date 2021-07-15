''#define FB_CONTAINER_DEBUG 1
#include "../../inc/containers/queue.bi"
#include "ContainerTestPrereqs.bi"
#include "fbcunit.bi"

FBCont_DefineQueueOf(One, Two, IntegerHolder)
Type IntegerHolderQueue As FB_Queue(One, Two, IntegerHolder)

Private Sub CheckQueueAgainstArray(Byref queue As IntegerHolderQueue, arr() As One.Two.IntegerHolder)
    Dim queueCopy As IntegerHolderQueue = queue
    Dim As Long arrLBound, arrUBound, numElems, i
    arrLBound = LBound(arr)
    arrUBound = UBound(arr)
    numElems = (arrUBound - arrLBound) + 1
    CU_ASSERT_EQUAL(numElems, Len(queue))
    For i = arrLBound To arrUBound
        CU_ASSERT_EQUAL(arr(i), queueCopy.Pop())
    Next
End Sub

SUITE(fbc_tests.containers.queues.udt)
	TEST(ConstructorTest)
		dim emptyQueue As IntegerHolderQueue
		CU_ASSERT_EQUAL(emptyQueue.Count, 0)
		dim emptyIterator As SequentialIntegerHolderGenerator = Type(0, 1)

		Dim zt1NumToGenerate As Long = 15
		Dim zt1StartNum As Long = 0
		Dim i As Long
		Dim zeroTo14Iterator As SequentialIntegerHolderGenerator = Type(zt1NumToGenerate, zt1StartNum)
		Dim tt2NumToGenerate As Long = 7
		Dim tt2StartNum As Long = 203
		Dim twoHundred3To210Iterator As SequentialIntegerHolderGenerator = Type(tt2NumToGenerate, tt2StartNum)

		'' Iterator constructor
		Dim zt1Queue As IntegerHolderQueue = zeroTo14Iterator
		Dim zt1QueueCopy As IntegerHolderQueue = zt1Queue
		CU_ASSERT_EQUAL(zt1Queue.Count, zt1NumToGenerate)
		For i = 0 To (zt1NumToGenerate - 1)
			CU_ASSERT_EQUAL(zt1Queue.Pop().num, zt1StartNum + i)
		Next
		zt1Queue = zt1QueueCopy
		
		Dim tt2Queue As IntegerHolderQueue = twoHundred3To210Iterator
		Dim tt2QueueCopy As IntegerHolderQueue = tt2Queue
		CU_ASSERT_EQUAL(tt2Queue.Count, tt2NumToGenerate)
		For i = 0 To (tt2NumToGenerate - 1)
			CU_ASSERT_EQUAL(tt2Queue.Pop().num, tt2StartNum + i)
		Next
		tt2Queue = tt2QueueCopy
		zeroTo14Iterator.Reset()

		Dim zt1Queue2 As IntegerHolderQueue = @zeroTo14Iterator
		Dim zt1Queue2Copy As IntegerHolderQueue = zt1Queue2
		CU_ASSERT_EQUAL(zt1Queue.Count, zt1Queue2.Count)
		For i = 0 To (zt1NumToGenerate - 1)
			CU_ASSERT_EQUAL(zt1Queue2.Pop(), zt1Queue.Pop())
		Next		
		zt1Queue2 = zt1Queue2Copy
		twoHundred3To210Iterator.Reset()

		Dim tt2Queue2 As IntegerHolderQueue = @twoHundred3To210Iterator
		Dim tt2QueueCopy2 As IntegerHolderQueue = tt2Queue2
		CU_ASSERT_EQUAL(tt2Queue2.Count, tt2Queue.Count)
		For i = 0 To (tt2NumToGenerate - 1)
			CU_ASSERT_EQUAL(tt2Queue.Pop().num, tt2StartNum + i)
		Next
		tt2Queue2 = tt2QueueCopy2
		
		dim newEmptyQueue As IntegerHolderQueue = emptyIterator
		CU_ASSERT_EQUAL(newEmptyQueue.Count, 0)
		emptyIterator.Reset()

		'' Copy Constructors
		Dim zt1Temp As IntegerHolderQueue = zt1Queue
		CU_ASSERT_EQUAL(zt1Temp.Count, zt1Queue.Count)
		For i = 0 To zt1Queue.Count - 1
			CU_ASSERT_EQUAL(zt1Temp.Pop(), zt1Queue.Pop())
		Next

		Dim tt2Temp As IntegerHolderQueue = tt2Queue
		CU_ASSERT_EQUAL(tt2Temp.Count, tt2Queue.Count)
		For i = 0 To tt2Queue.Count - 1
			CU_ASSERT_EQUAL(tt2Temp.Pop(), tt2Queue.Pop())
		Next
		
		dim numArray(7) As One.Two.IntegerHolder
		dim numArrayLBound As Long = LBound(numArray)
		dim numArrayUBound As Long = UBound(numArray)
		For i = numArrayLBound To numArrayUBound
			numArray(i).num = i
		Next
		
		Dim arrayQueue As IntegerHolderQueue = numArray()
		CheckQueueAgainstArray(arrayQueue, numArray())
		
		dim numArrayBased(5 To 9) As One.Two.IntegerHolder
		numArrayLBound = LBound(numArrayBased)
		numArrayUBound = UBound(numArrayBased)
		For i = numArrayLBound To numArrayUBound
			numArrayBased(i).num = i
		Next
		
		Dim arrayQueueBased As IntegerHolderQueue = numArrayBased()
		CheckQueueAgainstArray(arrayQueueBased, numArrayBased())
		
		dim undimmedArray(Any) As One.Two.IntegerHolder
		dim anyArrayQueue As IntegerHolderQueue = undimmedArray()
		CU_ASSERT_EQUAL(anyArrayQueue.Count, 0)

		'' Container constructors
		dim contQueue As IntegerHolderQueue = @arrayQueueBased
		For i = numArrayLBound To numArrayUBound
			CU_ASSERT_EQUAL(numArrayBased(i), contQueue.Pop())
		Next

		dim contQueue2 As IntegerHolderQueue = @arrayQueue
		For i = LBound(numArray) To UBound(numArray)
			CU_ASSERT_EQUAL(numArray(i), contQueue2.Pop())
		Next

		Dim fromEmptyContainerQueue As IntegerHolderQueue = @newEmptyQueue
		CU_ASSERT_EQUAL(fromEmptyContainerQueue.Count, 0)

	END_TEST
	
	TEST(Push)
		dim singleItemQueue As IntegerHolderQueue
		dim temp As One.Two.IntegerHolder = (78)
		singleItemQueue.Push(temp)
		CU_ASSERT_EQUAL(singleItemQueue.Front, temp)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 1)
		temp.num = -78 : singleItemQueue.Push(temp)
		temp.num = 35 : singleItemQueue.Push(temp)
		temp.num = -87 : singleItemQueue.Push(temp)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 4)
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, 78)
		singleItemQueue.Pop()
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, -78)
		temp.num = 123456 : singleItemQueue.Push(temp)
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, -78)
		CU_ASSERT_EQUAL(singleItemQueue.Pop().num, -78)
		CU_ASSERT_EQUAL(singleItemQueue.Pop().num, 35)
		CU_ASSERT_EQUAL(singleItemQueue.Pop().num, -87)
		CU_ASSERT_EQUAL(singleItemQueue.Pop().num, 123456)
		singleItemQueue.Clear()
		temp.num = 19 : singleItemQueue += temp
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, 19)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 1)
		temp.num = 99 : singleItemQueue += temp
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, 19)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 2)
		CU_ASSERT_EQUAL(singleItemQueue.Pop().num, 19)
		CU_ASSERT_EQUAL(singleItemQueue.Pop().num, 99)
	END_TEST
	
	TEST(Pop)
		dim singleItemQueue As IntegerHolderQueue
		dim temp As One.Two.IntegerHolder = (78)
		singleItemQueue.Push(temp)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 1)
		CU_ASSERT_EQUAL(singleItemQueue.Pop(), temp)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 0)
		
		temp.num = -78 : singleItemQueue.Push(temp)
		temp.num = 35 : singleItemQueue.Push(temp)
		temp.num = -87 : singleItemQueue.Push(temp)
		Dim poppedVal As One.Two.IntegerHolder = singleItemQueue.Pop()
		CU_ASSERT_EQUAL(poppedVal.num, -78)
		CU_ASSERT(singleItemQueue.Front.num <> -78)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 2)
		poppedVal = singleItemQueue.Pop()
		CU_ASSERT_EQUAL(poppedVal.num, 35)
		CU_ASSERT(singleItemQueue.Front.num <> 35)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 1)
		poppedVal = singleItemQueue.Pop()
		CU_ASSERT_EQUAL(poppedVal.num, -87)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 0)
#ifdef FB_CONTAINER_DEBUG
		'' Pop on an empty Queue will crash since the underlying queue is empty
		'' so this is guarded otherwise it'll always crash the tests
		Err = 0
		On Local Error Goto nextTest
		poppedVal = singleItemQueue.Pop() '' Pop with no elements is an error
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6)
	nextTest:
		On Local Error Goto 0
#endif
	END_TEST
	
	TEST(Front)
		dim singleItemQueue As IntegerHolderQueue
		dim temp As One.Two.IntegerHolder = (78)
		singleItemQueue.Push(temp)
		CU_ASSERT_EQUAL(singleItemQueue.Front, temp)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 1)
		
		temp.num = -78 : singleItemQueue.Push(temp)
		CU_ASSERT(singleItemQueue.Front.num <> -78)
		temp.num = 35 : singleItemQueue.Push(temp)
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, 78)
		singleItemQueue.Pop()
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, -78)
		temp.num = -87 : singleItemQueue.Push(temp)
		CU_ASSERT(singleItemQueue.Front.num <> -87)
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, -78)
		singleItemQueue.Pop()
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, 35)
		singleItemQueue.Pop()
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, -87)
		singleItemQueue.Pop()
		temp.num = 123456 : singleItemQueue.Push(temp)
		CU_ASSERT_EQUAL(singleItemQueue.Front.num, 123456)

#ifdef FB_CONTAINER_DEBUG
		'' See comment in above test
		singleItemQueue.Pop()
		Err = 0
		On Local Error Goto nextTest
		dim poppedVal As One.Two.IntegerHolder = singleItemQueue.Front '' Front with no elements is an error
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6)
	nextTest:
		On Local Error Goto 0
#endif
	END_TEST
	
	TEST(Clear)
		dim singleItemQueue As IntegerHolderQueue
		dim temp As One.Two.IntegerHolder = (78)
		singleItemQueue.Push(temp)
		temp.num = -78 : singleItemQueue.Push(temp)
		dim queueSize As Long = singleItemQueue.Count
		singleItemQueue.Clear()
		CU_ASSERT_EQUAL(singleItemQueue.Count, 0)
		CU_ASSERT(singleItemQueue.Count <> queueSize)
		queueSize = singleItemQueue.Count
		singleItemQueue.Clear()
		CU_ASSERT_EQUAL(singleItemQueue.Count, 0)
		CU_ASSERT_EQUAL(singleItemQueue.Count, queueSize)
		dim queue2 As IntegerHolderQueue	
		queue2.Clear()
		CU_ASSERT_EQUAL(queue2.Count, 0)
	END_TEST
	
	TEST(Contains)
		dim haystack As IntegerHolderQueue
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
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, False)
		haystack.Pop()
		result = haystack.Contains(temp)
		CU_ASSERT_EQUAL(result, True)
		temp.num = -needle.num : result = haystack.Contains(temp)
		CU_ASSERT_EQUAL(result, False)
		temp.num = 52 : result = haystack.Contains(temp)
		CU_ASSERT_EQUAL(result, True)
		Dim generate100 As SequentialIntegerHolderGenerator = Type(100, 100)
		dim secondHaystack As IntegerHolderQueue = @generate100
		temp.num = 157 : result = secondHaystack.Contains(temp)
		CU_ASSERT_EQUAL(result, True)
	END_TEST
	
	TEST(CopyTo)
		dim singleItemQueue As IntegerHolderQueue
		dim i As Long
		dim temp As One.Two.IntegerHolder = (78)
		singleItemQueue.Push(temp)
		temp.num = -78 : singleItemQueue.Push(temp)
		temp.num = 8537536 : singleItemQueue.Push(temp)
		'' Undimmed arrays are redimmed to be the size of the container, from 0 To n-1
		dim undimmedArr(Any) As One.Two.IntegerHolder
		singleItemQueue.CopyTo(undimmedArr())

		dim arrUBound As Long = UBound(undimmedArr)
		dim arrLBound As Long = LBound(undimmedArr)
		dim numElems As Long = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, singleItemQueue.Count)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		Dim itemQueueCopy As IntegerHolderQueue = singleItemQueue
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedArr(i), itemQueueCopy.Pop())
		Next

		'' Except in empty lists, where nothing happens
		'' If container debug is defined, this calls Error
		dim emptyQueue As IntegerHolderQueue
		dim emptyArr(Any) As One.Two.IntegerHolder
		On Local Error Goto nextTest1
		dim localErr As Long
		Err = 0
		emptyQueue.CopyTo(emptyArr())
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)

	nextTest1:
		On Local Error Goto 0
		'' already sized arrays copy the number of items in the queue or the size of the array
		'' whichever is smaller
		dim largerThanContArr(10 To 14) As One.Two.IntegerHolder
		For i = 10 To 14
			largerThanContArr(i).num = i
		Next

		singleItemQueue.CopyTo(largerThanContArr())
		arrUBound = UBound(largerThanContArr)
		arrLBound = LBound(largerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 5)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 10)
		CU_ASSERT_EQUAL(arrUBound, 14)
		itemQueueCopy = singleItemQueue
		For i = 10 To 14
			temp.num = i
			CU_ASSERT_EQUAL(largerThanContArr(i), IIf(i <= 12, itemQueueCopy.Pop(), temp))
		Next
		dim smallerThanContArr(21 To 22) As One.Two.IntegerHolder
		For i = 21 To 22
			smallerThanContArr(i).num = i
		Next
		temp.num = 4 : singleItemQueue.Push(temp)
		singleItemQueue.CopyTo(smallerThanContArr())
		arrUBound = UBound(smallerThanContArr)
		arrLBound = LBound(smallerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 2)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 22)
		For i = 21 To 22
			CU_ASSERT_EQUAL(smallerThanContArr(i), singleItemQueue.Pop())
		Next
	END_TEST
	
	TEST(GetIterator)
		dim queue As IntegerHolderQueue
		dim pListIter As FB_IIterator(One, Two, IntegerHolder) Ptr = queue.GetIterator()
		CU_ASSERT(pListIter <> 0)
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
		pListIter = 0

		Dim temp As One.Two.IntegerHolder = (7)
		queue.Push(temp)
		pListIter = queue.GetIterator()
		dim pListIter2 As FB_IIterator(One, Two, IntegerHolder) Ptr = queue.GetIterator()
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
		queue.Clear()

		Dim i As Long
		For i = 0 To 6
			temp.num = i
			queue.Push(temp)
		Next
		pListIter = queue.GetIterator()
		CU_ASSERT(pListIter <> 0)
		For i = 0 To 6
			temp.num = i
			CU_ASSERT(pListIter->Advance() = True)
			CU_ASSERT_EQUAL(pListIter->Item(), temp)
		Next
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
	END_TEST
	
	TEST(LenTest)
		dim singleItemQueue As IntegerHolderQueue
		dim temp As One.Two.IntegerHolder = (78)
		singleItemQueue.Push(temp)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 1)
		CU_ASSERT_EQUAL(singleItemQueue.Count, Len(singleItemQueue))
		temp.num = -78 : singleItemQueue.Push(temp)
		temp.num = 35 : singleItemQueue.Push(temp)
		temp.num = -87 : singleItemQueue.Push(temp)
		CU_ASSERT_EQUAL(singleItemQueue.Count, 4)
		CU_ASSERT_EQUAL(singleItemQueue.Count, Len(singleItemQueue))
		singleItemQueue.Pop()
		CU_ASSERT_EQUAL(singleItemQueue.Count, 3)
		CU_ASSERT_EQUAL(singleItemQueue.Count, Len(singleItemQueue))
		singleItemQueue.Pop()
		CU_ASSERT_EQUAL(singleItemQueue.Count, 2)
		CU_ASSERT_EQUAL(singleItemQueue.Count, Len(singleItemQueue))
		singleItemQueue.Pop()
		CU_ASSERT_EQUAL(singleItemQueue.Count, 1)
		CU_ASSERT_EQUAL(singleItemQueue.Count, Len(singleItemQueue))
		singleItemQueue.Pop()
		singleItemQueue.Clear()

		temp.num = 19
		singleItemQueue += temp
		CU_ASSERT_EQUAL(singleItemQueue.Count, 1)
		CU_ASSERT_EQUAL(singleItemQueue.Count, Len(singleItemQueue))
		temp.num = 99 : singleItemQueue += temp
		CU_ASSERT_EQUAL(singleItemQueue.Count, 2)
		CU_ASSERT_EQUAL(singleItemQueue.Count, Len(singleItemQueue))
		singleItemQueue.Pop()
		CU_ASSERT_EQUAL(singleItemQueue.Count, 1)
		CU_ASSERT_EQUAL(singleItemQueue.Count, Len(singleItemQueue))
		singleItemQueue.Pop()
		CU_ASSERT_EQUAL(singleItemQueue.Count, 0)
		CU_ASSERT_EQUAL(singleItemQueue.Count, Len(singleItemQueue))
	END_TEST

	TEST(Empty)
		dim singleItemQueue As IntegerHolderQueue
		dim temp As One.Two.IntegerHolder = (78)
		CU_ASSERT_EQUAL(singleItemQueue.Empty(), True)
		singleItemQueue.Push(temp)
		CU_ASSERT_EQUAL(singleItemQueue.Empty(), False)
		singleItemQueue.Pop()
		CU_ASSERT_EQUAL(singleItemQueue.Empty(), True)
		Dim arr(0 To 1) As One.Two.IntegerHolder
		dim otherQueue As IntegerHolderQueue = arr()
		CU_ASSERT_EQUAL(otherQueue.Empty(), False)
		otherQueue.Pop()
		CU_ASSERT_EQUAL(otherQueue.Empty(), False)
		otherQueue.Clear()
		CU_ASSERT_EQUAL(otherQueue.Empty(), True)
	END_TEST
END_SUITE
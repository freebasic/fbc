'' #define FB_CONTAINER_DEBUG 1
#include "../../inc/containers/linkedlist.bi"
#include "ContainerTestPrereqs.bi"
#include "fbcunit.bi"

FBCont_DefineLinkedListOf(Long)
Type LongLinkedList As FB_LinkedList(Long)
Type LongLLNode As FB_LinkedListNode(Long)

Private Sub CheckListAgainstArray(Byref list As LongLinkedList, arr() As Long)
    Dim As LongLLNode pHead = list.Head, pIter = pHead
    Dim As Long arrLBound, arrUBound, numElems, i
    arrLBound = LBound(arr)
    arrUBound = UBound(arr)
    numElems = (arrUBound - arrLBound) + 1
    CU_ASSERT_EQUAL(numElems, Len(list))
    For i = arrLBound To arrUBound
        CU_ASSERT_EQUAL(arr(i), pIter->Data)
        pIter = pIter->Forward
        If i <> arrUBound Then CU_ASSERT(pIter <> pHead)
    Next
End Sub

SUITE(fbc_tests.containers.linkedlists.primitive)
	TEST(ConstructorTest)
		dim emptyQueue As LongLinkedList
		CU_ASSERT_EQUAL(emptyQueue.Count, 0)
		dim emptyIterator As SequentialLongGenerator = Type(0, 1)

		Dim zt1NumToGenerate As Long = 15
		Dim zt1StartNum As Long = 0
		Dim i As Long
		Dim zeroTo14Iterator As SequentialLongGenerator = Type(zt1NumToGenerate, zt1StartNum)
		Dim tt2NumToGenerate As Long = 7
		Dim tt2StartNum As Long = 203
		Dim twoHundred3To210Iterator As SequentialLongGenerator = Type(tt2NumToGenerate, tt2StartNum)

		'' Iterator constructor
		Dim zt1List As LongLinkedList = zeroTo14Iterator
		Dim As LongLLNode zt1ListHead = zt1List.Head, zt1ListIter = zt1ListHead
		CU_ASSERT_EQUAL(zt1List.Count, zt1NumToGenerate)
		For i = 0 To (zt1NumToGenerate - 1)
			CU_ASSERT_EQUAL(zt1ListIter->Data, zt1StartNum + i)
			If i > 0 Then
				CU_ASSERT(zt1ListHead <> zt1ListIter)
			End If
			zt1ListIter = zt1ListIter->Forward
		Next
		
		Dim tt2List As LongLinkedList = twoHundred3To210Iterator
		Dim As LongLLNode tt2ListHead = tt2List.Head, tt2ListIter = tt2ListHead
		CU_ASSERT_EQUAL(tt2List.Count, tt2NumToGenerate)
		For i = 0 To (tt2NumToGenerate - 1)
			CU_ASSERT_EQUAL(tt2ListIter->Data, tt2StartNum + i)
			If i > 0 Then
				CU_ASSERT(tt2ListHead <> tt2ListIter)
			End If
			tt2ListIter = tt2ListIter->Forward
		Next
		zeroTo14Iterator.Reset()

		Dim zt1List2 As LongLinkedList = @zeroTo14Iterator
		Dim As LongLLNode zt1List2Head = zt1List2.Head, zt1List2Iter = zt1List2Head
		CU_ASSERT_EQUAL(zt1List.Count, zt1List2.Count)
		For i = 0 To (zt1NumToGenerate - 1)
			CU_ASSERT_EQUAL(zt1List2Iter->Data, zt1ListIter->Data)
			If i > 0 Then
				CU_ASSERT(zt1List2Head <> zt1List2Iter)
			End If
			zt1List2Iter = zt1List2Iter->Forward
			zt1ListIter = zt1ListIter->Forward
		Next		
		twoHundred3To210Iterator.Reset()

		Dim tt2List2 As LongLinkedList = @twoHundred3To210Iterator
		Dim As LongLLNode tt2List2Head = tt2List2.Head, tt2List2Iter = tt2List2Head
		CU_ASSERT_EQUAL(tt2List2.Count, tt2List.Count)
		For i = 0 To (tt2NumToGenerate - 1)
			CU_ASSERT_EQUAL(tt2List2Iter->Data, tt2ListIter->Data)
			If i > 0 Then
				CU_ASSERT(tt2List2Head <> tt2List2Iter)
			End If
			tt2List2Iter = tt2List2Iter->Forward
			tt2ListIter = tt2ListIter->Forward
		Next
		
		dim newEmptyList As LongLinkedList = emptyIterator
		CU_ASSERT_EQUAL(newEmptyList.Count, 0)
		emptyIterator.Reset()
		
		dim numArray(7) As Long
		dim numArrayLBound As Long = LBound(numArray)
		dim numArrayUBound As Long = UBound(numArray)
		For i = numArrayLBound To numArrayUBound
			numArray(i) = i
		Next
		
		Dim arrayList As LongLinkedList = numArray()
		CheckListAgainstArray(arrayList, numArray())
		
		dim numArrayBased(5 To 9) As Long
		numArrayLBound = LBound(numArrayBased)
		numArrayUBound = UBound(numArrayBased)
		For i = numArrayLBound To numArrayUBound
			numArrayBased(i) = i
		Next
		
		Dim arrayListBased As LongLinkedList = numArrayBased()
		CheckListAgainstArray(arrayListBased, numArrayBased())
		
		dim undimmedArray(Any) As Long
		dim anyArrayList As LongLinkedList = undimmedArray()
		CU_ASSERT_EQUAL(anyArrayList.Count, 0)

		'' Container constructors
		dim contList As LongLinkedList = @arrayListBased
		Dim As LongLLNode contListHead = contList.Head, contListIter = contListHead
		For i = numArrayLBound To numArrayUBound
			CU_ASSERT_EQUAL(numArrayBased(i), contListIter->Data)
			contListIter = contListIter->Forward
		Next

		dim contList2 As LongLinkedList = @arrayList
		Dim As LongLLNode contList2Head = contList2.Head, contList2Iter = contList2Head
		For i = LBound(numArray) To UBound(numArray)
			CU_ASSERT_EQUAL(numArray(i), contList2Iter->Data)
			contList2Iter = contList2Iter->Forward
		Next

		Dim fromEmptyContainerList As LongLinkedList = @newEmptyList
		CU_ASSERT_EQUAL(fromEmptyContainerList.Count, 0)
	END_TEST
	
	TEST(AddHead)
		dim singleItemList As LongLinkedList
		dim As LongLLNode pPrevHead = singleItemList.AddHead(78), pNewHead, pFirstNode = pPrevHead
		CU_ASSERT_EQUAL(singleItemList.Head->Data, 78)
		CU_ASSERT_EQUAL(pPrevHead, singleItemList.Head)
		'' circular list with one node points to itself
		CU_ASSERT_EQUAL(pPrevHead->Forward, pPrevHead)
		CU_ASSERT_EQUAL(pPrevHead->Back, pPrevHead)
		CU_ASSERT_EQUAL(singleItemList.Count, 1)
		
		pNewHead = singleItemList.AddHead(-78)
		CU_ASSERT_EQUAL(singleItemList.Head->Data, -78)
		CU_ASSERT_EQUAL(pNewHead->Forward, pPrevHead)
		CU_ASSERT_EQUAL(pNewHead->Back, pFirstNode)
		CU_ASSERT_EQUAL(pPrevHead->Back, pNewHead)
		CU_ASSERT_EQUAL(pNewHead, singleItemList.Head)
		CU_ASSERT_EQUAL(pFirstNode->Forward, pNewHead)
		pPrevHead = pNewHead
		
		pNewHead = singleItemList.AddHead(35)
		CU_ASSERT_EQUAL(singleItemList.Head->Data, 35)
		CU_ASSERT_EQUAL(pNewHead->Forward, pPrevHead)
		CU_ASSERT_EQUAL(pNewHead->Back, pFirstNode)
		CU_ASSERT_EQUAL(pPrevHead->Back, pNewHead)
		CU_ASSERT_EQUAL(pNewHead, singleItemList.Head)
		CU_ASSERT_EQUAL(pFirstNode->Forward, pNewHead)
		pPrevHead = pNewHead
		
		pNewHead = singleItemList.AddHead(-87)
		CU_ASSERT_EQUAL(singleItemList.Head->Data, -87)
		CU_ASSERT_EQUAL(pNewHead->Forward, pPrevHead)
		CU_ASSERT_EQUAL(pNewHead->Back, pFirstNode)
		CU_ASSERT_EQUAL(pPrevHead->Back, pNewHead)
		CU_ASSERT_EQUAL(pNewHead, singleItemList.Head)
		CU_ASSERT_EQUAL(pFirstNode->Forward, pNewHead)
		CU_ASSERT_EQUAL(singleItemList.Count, 4)
		CU_ASSERT_EQUAL(pNewHead, singleItemList.Head)
		
		singleItemList.RemoveNode(pNewHead)
		CU_ASSERT_EQUAL(singleItemList.Head->Data, 35)
		CU_ASSERT_EQUAL(singleItemList.Head, pPrevHead)		
		
		pNewHead = singleItemList.AddHead(123456)
		CU_ASSERT_EQUAL(singleItemList.Head->Data, 123456)
		CU_ASSERT_EQUAL(pNewHead->Forward, pPrevHead)
		CU_ASSERT_EQUAL(pNewHead->Back, pFirstNode)
		CU_ASSERT_EQUAL(pPrevHead->Back, pNewHead)
		CU_ASSERT_EQUAL(pNewHead, singleItemList.Head)
		CU_ASSERT_EQUAL(pFirstNode->Forward, pNewHead)
		
		singleItemList.RemoveNode(singleItemList.Head)
		CU_ASSERT_EQUAL(singleItemList.Head->Data, 35)
		singleItemList.RemoveNode(singleItemList.Head)
		CU_ASSERT_EQUAL(singleItemList.Head->Data, -78)
		singleItemList.RemoveNode(singleItemList.Head)
		singleItemList.Clear()
		
		singleItemList += 19
		CU_ASSERT_EQUAL(singleItemList.Head->Data, 19)
		CU_ASSERT_EQUAL(singleItemList.Count, 1)
		singleItemList += 99
		CU_ASSERT_EQUAL(singleItemList.Head->Data, 19)
		CU_ASSERT_EQUAL(singleItemList.Count, 2)
		singleItemList.RemoveNode(singleItemList.Head)
		CU_ASSERT_EQUAL(singleItemList.Head->Data, 99)
	END_TEST
	
	TEST(AddTail)
		dim singleItemList As LongLinkedList
		dim As LongLLNode pPrevTail = singleItemList.AddTail(78), pNewTail, pFirstNode = pPrevTail
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, 78)
		CU_ASSERT_EQUAL(pPrevTail, singleItemList.Tail)
		'' circular list with one node points to itself
		CU_ASSERT_EQUAL(pPrevTail->Forward, pPrevTail)
		CU_ASSERT_EQUAL(pPrevTail->Back, pPrevTail)
		CU_ASSERT_EQUAL(singleItemList.Count, 1)
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, 78)
		
		pNewTail = singleItemList.AddTail(-78)
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, -78)
		CU_ASSERT_EQUAL(pNewTail->Back, pPrevTail)
		CU_ASSERT_EQUAL(pNewTail->Forward, pFirstNode)
		CU_ASSERT_EQUAL(pPrevTail->Forward, pNewTail)
		CU_ASSERT_EQUAL(pNewTail, singleItemList.Tail)
		CU_ASSERT_EQUAL(pFirstNode->Back, pNewTail)
		pPrevTail = pNewTail
		
		pNewTail = singleItemList.AddTail(35)
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, 35)
		CU_ASSERT_EQUAL(pNewTail->Back, pPrevTail)
		CU_ASSERT_EQUAL(pNewTail->Forward, pFirstNode)
		CU_ASSERT_EQUAL(pPrevTail->Forward, pNewTail)
		CU_ASSERT_EQUAL(pNewTail, singleItemList.Tail)
		CU_ASSERT_EQUAL(pFirstNode->Back, pNewTail)
		pPrevTail = pNewTail
		
		pNewTail = singleItemList.AddTail(-87)
		CU_ASSERT_EQUAL(pNewTail->Back, pPrevTail)
		CU_ASSERT_EQUAL(pNewTail->Forward, pFirstNode)
		CU_ASSERT_EQUAL(pPrevTail->Forward, pNewTail)
		CU_ASSERT_EQUAL(pNewTail, singleItemList.Tail)
		CU_ASSERT_EQUAL(pFirstNode->Back, pNewTail)
		CU_ASSERT_EQUAL(singleItemList.Count, 4)
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, -87)
		CU_ASSERT_EQUAL(pNewTail, singleItemList.Tail)
		
		singleItemList.RemoveNode(pNewTail)
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, 35)
		CU_ASSERT_EQUAL(singleItemList.Tail, pPrevTail)		
		
		pNewTail = singleItemList.AddTail(123456)
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, 123456)
		CU_ASSERT_EQUAL(pNewTail->Back, pPrevTail)
		CU_ASSERT_EQUAL(pNewTail->Forward, pFirstNode)
		CU_ASSERT_EQUAL(pPrevTail->Forward, pNewTail)
		CU_ASSERT_EQUAL(pNewTail, singleItemList.Tail)
		CU_ASSERT_EQUAL(pFirstNode->Back, pNewTail)
		
		singleItemList.RemoveNode(singleItemList.Tail)
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, 35)
		singleItemList.RemoveNode(singleItemList.Tail)
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, -78)
		singleItemList.RemoveNode(singleItemList.Tail)
		singleItemList.Clear()
		
		singleItemList += 19
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, 19)
		CU_ASSERT_EQUAL(singleItemList.Count, 1)
		singleItemList += 99
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, 99)
		CU_ASSERT_EQUAL(singleItemList.Count, 2)
		singleItemList.RemoveNode(singleItemList.Tail)
		CU_ASSERT_EQUAL(singleItemList.Tail->Data, 19)
	END_TEST
	
	TEST(AddAfter)
		dim singleItemList As LongLinkedList
		Dim i As Long
		dim values(7 To 11) As Long
		dim arrLBound As Long = LBound(values)
		dim arrUBound As Long = UBound(values)
		For i = arrLBound To arrUBound
			values(i) = i * 2
		Next
		dim pPrevNode As LongLLNode = 0
		dim numAdded As Long = 0
		For i = arrLBound to arrUBound
			dim pNewNode As LongLLNode = singleItemList.AddAfter(values(i), pPrevNode)
			numAdded += 1
			CU_ASSERT_EQUAL(singleItemList.Count, numAdded)
			If i > arrLBound Then
				CU_ASSERT_EQUAL(pNewNode->Back, pPrevNode)
				CU_ASSERT_EQUAL(pNewNode->Forward, singleItemList.Head)
				CU_ASSERT_EQUAL(pPrevNode->Forward, pNewNode)
			Else
				CU_ASSERT_EQUAL(pNewNode->Back, pNewNode)
				CU_ASSERT_EQUAL(pNewNode->Forward, singleItemList.Head)
				CU_ASSERT_EQUAL(pNewNode->Forward, pNewNode)
				CU_ASSERT_EQUAL(pNewNode, singleItemList.Head)
				CU_ASSERT_EQUAL(pNewNode, singleItemList.Tail)
			End If
			dim pRevIter As LongLLNode = pNewNode
			For j As Long = i To arrLBound Step -1
				CU_ASSERT_EQUAL(pRevIter->Data, j * 2)
				pRevIter = pRevIter->Back
			Next
			pPrevNode = pNewNode
		Next
		'' Trying to add after a node that belongs to a different list is an error
		'' (since it could then be the head of one list and a node in a different list
		'' which would eventually be deleted twice)
		dim tempList As LongLinkedList
		dim As LongLLNode tempNode = tempList.AddHead(47575), errNode
		On Local Error Goto nextTest
		dim localErr As Long
		Err = 0
		errNode = singleItemList.AddAfter(87, tempNode)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)
		CU_ASSERT_EQUAL(errNode, 0)
	nextTest:
		On Local Error Goto 0
		singleItemList.Clear()
		
		dim pNode(0 To 3) As LongLLNode
		dim toInsert(0 To 3) As Long
		pNode(0) = singleItemList.AddHead(5437)
		pNode(1) = singleItemList.AddTail(96437)
		pNode(2) = singleItemList.AddAfter(1, pNode(1))
		pNode(3) = singleItemList.Tail
		CU_ASSERT_EQUAL(pNode(2)->Back, pNode(1))
		CU_ASSERT_EQUAL(pNode(2)->Forward, pNode(0))
		CU_ASSERT_EQUAL(pNode(1)->Forward, pNode(2))
		
		For i = LBound(pNode) to UBound(pNode)
			toInsert(i) = 9 + i
		Next
		dim pInsert As LongLLNode
		For i = LBound(pNode) to UBound(pNode)
			pInsert = singleItemList.AddAfter(toInsert(i), pNode(i))
			CU_ASSERT_EQUAL(pNode(i)->Forward, pInsert)
			CU_ASSERT_EQUAL(pInsert->Back, pNode(i))
		Next
		
		'' AddAfter Null adds to the Head (ie it's not after anything)
		pInsert = singleItemList.AddAfter(89, 0)
		CU_ASSERT_EQUAL(singleItemList.Head, pInsert)
		CU_ASSERT_EQUAL(singleItemList.Tail, pInsert->Back)
		CU_ASSERT_EQUAL(pNode(0)->Back, pInsert)
		CU_ASSERT_EQUAL(pNode(0), pInsert->Forward)
		
		dim pIter As LongLLNode = singleItemList.Head
		dim listSize As Long = singleItemList.Count
		dim listData(0 to listSize - 1) As Long
		listData(0) = 89
		listData(1) = 5437
		listData(2) = 9
		listData(3) = 96437
		listData(4) = 10
		listData(5) = 1
		listData(6) = 12
		listData(7) = 11
		For i = 0 to listSize - 1
			CU_ASSERT_EQUAL(pIter->Data, listData(i))
			pIter = pIter->Forward
		Next
	END_TEST
	
	TEST(AddBefore)
		dim singleItemList As LongLinkedList
		Dim i As Long
		dim values(7 To 11) As Long
		dim arrLBound As Long = LBound(values)
		dim arrUBound As Long = UBound(values)
		For i = arrLBound To arrUBound
			values(i) = i * 2
		Next
		dim pPrevNode As LongLLNode = 0
		dim numAdded As Long = 0
		For i = arrLBound to arrUBound
			dim pNewNode As LongLLNode = singleItemList.AddBefore(values(i), pPrevNode)
			numAdded += 1
			CU_ASSERT_EQUAL(singleItemList.Count, numAdded)
			If i > arrLBound Then
				CU_ASSERT_EQUAL(pNewNode->Back, singleItemList.Tail)
				CU_ASSERT_EQUAL(pNewNode->Forward, pPrevNode)
				CU_ASSERT_EQUAL(pPrevNode->Back, pNewNode)
			Else
				CU_ASSERT_EQUAL(pNewNode->Back, pNewNode)
				CU_ASSERT_EQUAL(pNewNode->Forward, singleItemList.Head)
				CU_ASSERT_EQUAL(pNewNode->Forward, pNewNode)
				CU_ASSERT_EQUAL(pNewNode, singleItemList.Head)
				CU_ASSERT_EQUAL(pNewNode, singleItemList.Tail)
			End If
			dim pRevIter As LongLLNode = pNewNode
			For j As Long = i To arrLBound Step -1
				CU_ASSERT_EQUAL(pRevIter->Data, j * 2)
				pRevIter = pRevIter->Forward
			Next
			pPrevNode = pNewNode
		Next
		'' Trying to add after a node that belongs to a different list is an error
		'' (since it could then be the head of one list and a node in a different list
		'' which would eventually be deleted twice)
		dim tempList As LongLinkedList
		dim As LongLLNode tempNode = tempList.AddHead(47575), errNode
		On Local Error Goto nextTest
		dim localErr As Long
		Err = 0
		errNode = singleItemList.AddBefore(87, tempNode)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)
		CU_ASSERT_EQUAL(errNode, 0)
	nextTest:
		On Local Error Goto 0
		singleItemList.Clear()

		dim pNode(0 To 3) As LongLLNode
		dim toInsert(0 To 3) As Long
		pNode(1) = singleItemList.AddHead(5437)
		pNode(2) = singleItemList.AddTail(96437)
		pNode(3) = singleItemList.AddAfter(1, pNode(1))
		pNode(0) = singleItemList.Head
		CU_ASSERT_EQUAL(pNode(2)->Back, pNode(3))
		CU_ASSERT_EQUAL(pNode(2)->Forward, pNode(0))
		CU_ASSERT_EQUAL(pNode(1)->Forward, pNode(3))
		
		For i = LBound(pNode) to UBound(pNode)
			toInsert(i) = 9 + i
		Next
		dim pInsert As LongLLNode
		For i = LBound(pNode) to UBound(pNode)
			pInsert = singleItemList.AddBefore(toInsert(i), pNode(i))
			CU_ASSERT_EQUAL(pNode(i)->Back, pInsert)
			CU_ASSERT_EQUAL(pInsert->Forward, pNode(i))
		Next

		'' AddBefore Null adds to the Tail (ie it's not before anything)
		pInsert = singleItemList.AddBefore(89, 0)
		CU_ASSERT_EQUAL(singleItemList.Tail, pInsert)
		CU_ASSERT_EQUAL(singleItemList.Head, pInsert->Forward)
		CU_ASSERT_EQUAL(pNode(2)->Forward, pInsert)
		CU_ASSERT_EQUAL(pNode(2), pInsert->Back)

		dim pIter As LongLLNode = singleItemList.Head
		dim listSize As Long = singleItemList.Count
		dim listData(0 to listSize - 1) As Long
		listData(0) = 9
		listData(1) = 10
		listData(2) = 5437
		listData(3) = 12
		listData(4) = 1
		listData(5) = 11
		listData(6) = 96437
		listData(7) = 89
		For i = 0 to listSize - 1
			CU_ASSERT_EQUAL(pIter->Data, listData(i))
			pIter = pIter->Forward
		Next
	END_TEST
	
	TEST(Clear)
		dim singleItemList As LongLinkedList
		singleItemList.AddHead(78)
		singleItemList.AddTail(-78)
		dim listSize As Long = singleItemList.Count
		singleItemList.Clear()
		CU_ASSERT_EQUAL(singleItemList.Count, 0)
		CU_ASSERT(singleItemList.Count <> listSize)
		listSize = singleItemList.Count
		singleItemList.Clear()
		CU_ASSERT_EQUAL(singleItemList.Count, 0)
		CU_ASSERT_EQUAL(singleItemList.Count, listSize)
		dim list2 As LongLinkedList	
		list2.Clear()
		CU_ASSERT_EQUAL(list2.Count, 0)
	END_TEST
	
	TEST(Contains)
		dim haystack As LongLinkedList
		dim needle As Long = 78
		dim As LongLLNode needleNode, node52
		dim result As Boolean
		result = haystack.Contains(0)
		CU_ASSERT_EQUAL(result, False)
		needleNode = haystack.AddHead(needle)
		haystack.AddTail(-needle)
		node52 = haystack.AddTail(52)
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, True)
		result = haystack.Contains(52)
		CU_ASSERT_EQUAL(result, True)
		haystack.RemoveNode(needleNode)
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, False)
		haystack.RemoveNode(haystack.Head)
		result = haystack.Contains(52)
		CU_ASSERT_EQUAL(result, True)
		haystack.RemoveNode(node52)
		result = haystack.Contains(52)
		CU_ASSERT_EQUAL(result, False)
		Dim generate100 As SequentialLongGenerator = Type(100, 100)
		dim secondHaystack As LongLinkedList = @generate100
		result = secondHaystack.Contains(157)
		CU_ASSERT_EQUAL(result, True)
	END_TEST
	
	TEST(CopyTo)
		dim singleItemList As LongLinkedList
		dim i As Long
		singleItemList.AddTail(78)
		singleItemList.AddTail(-78)
		singleItemList.AddTail(8537536)
		'' Undimmed arrays are redimmed to be the size of the container, from 0 To n-1
		dim undimmedArr(Any) As Long
		singleItemList.CopyTo(undimmedArr())
		dim arrUBound As Long = UBound(undimmedArr)
		dim arrLBound As Long = LBound(undimmedArr)
		dim numElems As Long = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, singleItemList.Count)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		Dim pIter As LongLLNode = singleItemList.Head
		For i = 0 To arrUBound
			CU_ASSERT_EQUAL(undimmedArr(i), pIter->Data)
			pIter = pIter->Forward
		Next
		
		'' Except in empty lists, where nothing happens
		'' If container debug is defined, this calls Error
		dim emptyQueue As LongLinkedList
		dim emptyArr(Any) As Long
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
		dim largerThanContArr(10 To 14) As Long
		For i = 10 To 14
			largerThanContArr(i) = i
		Next
		singleItemList.CopyTo(largerThanContArr())
		arrUBound = UBound(largerThanContArr)
		arrLBound = LBound(largerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 5)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 10)
		CU_ASSERT_EQUAL(arrUBound, 14)
		pIter = singleItemList.Head
		For i = 10 To 14
			dim value As Long = i
			If i <= 12 Then
				value = pIter->Data
				pIter = pIter->Forward
			End If
			CU_ASSERT_EQUAL(largerThanContArr(i), value)
		Next
		
		dim smallerThanContArr(21 To 22) As Long
		For i = 21 To 22
			smallerThanContArr(i) = i
		Next
		singleItemList.AddTail(4)
		singleItemList.CopyTo(smallerThanContArr())
		arrUBound = UBound(smallerThanContArr)
		arrLBound = LBound(smallerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 2)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 22)
		pIter = singleItemList.Head
		For i = 21 To 22
			CU_ASSERT_EQUAL(smallerThanContArr(i), pIter->Data)
			pIter = pIter->Forward
		Next
	END_TEST
	
	TEST(FindTest)
		dim As LongLinkedList singleItemList, otherList
		dim As LongLLNode findRet, findRet2
		dim i As Long
		singleItemList.AddTail(78)
		singleItemList.AddTail(-78)
		singleItemList.AddTail(8537536)
		findRet = singleItemList.Find(-78, 0)
		CU_ASSERT(findRet <> 0)
		CU_ASSERT_EQUAL(findRet->Data, -78)
		findRet2 = singleItemList.Find(-78, findRet)
		CU_ASSERT(findRet2 <> 0)
		CU_ASSERT_EQUAL(findRet2->Data, -78)
		CU_ASSERT_EQUAL(findRet2, findRet)
		singleItemList.RemoveNode(findRet)
		findRet2 = singleItemList.Find(-78, 0)
		CU_ASSERT_EQUAL(findRet2, 0)
		
		findRet = otherList.Find(0, 0)
		CU_ASSERT_EQUAL(findRet, 0)
		
		findRet2 = singleItemList.Head
		otherList.AddHead(987655)
		Dim localErr As Long
		On Local Error Goto nextTest
		Err = 0
		'' finding using a foreign list node is an error
		findRet = otherList.Find(987655, findRet2)
		localErr = Err
		CU_ASSERT_EQUAL(findRet, 0)
		CU_ASSERT_EQUAL(localErr, 1)
	nextTest:
		On Local Error Goto 0
		dim As LongLLNode startNode = singleItemList.Head, iterNode = startNode
		For i = 0 To singleItemList.Count - 1
			findRet = singleItemList.Find(iterNode->Data, startNode)
			CU_ASSERT_EQUAL(findRet, iterNode)
			CU_ASSERT_EQUAL(findRet->Data, iterNode->Data)
			iterNode = iterNode->Forward
		Next
		startNode = singleItemList.Tail
		iterNode = singleItemList.Head
		For i = 0 To singleItemList.Count - 1
			findRet = singleItemList.Find(iterNode->Data, startNode)
			CU_ASSERT_EQUAL(findRet, iterNode)
			CU_ASSERT_EQUAL(findRet->Data, iterNode->Data)
			iterNode = iterNode->Forward
		Next
		
		findRet = singleItemList.Find(-937537, 0)
		CU_ASSERT_EQUAL(findRet, 0)
	END_TEST
	
	Private Sub TestContainerIter(ByRef list As LongLinkedList)
		dim pListIter As FB_IIterator(Long) Ptr = list.GetIterator()
		dim As LongLLNode pHead = list.Head, pNode = pHead
		While pListIter->Advance()
			CU_ASSERT_EQUAL(pNode->Data, pListIter->Item())
			pNode = pNode->Forward
		Wend
		CU_ASSERT_EQUAL(pNode, pHead)
		Delete pListIter
	End Sub
	
	TEST(GetIterator)
		dim list As LongLinkedList
		dim pListIter As FB_IIterator(Long) Ptr = list.GetIterator()
		CU_ASSERT(pListIter <> 0)
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
		pListIter = 0
		list.AddTail(7)
		pListIter = list.GetIterator()
		dim pListIter2 As FB_IIterator(Long) Ptr = list.GetIterator()
		CU_ASSERT(pListIter <> 0)
		CU_ASSERT(pListIter2 <> 0)
		CU_ASSERT(pListIter <> pListIter2)
		CU_ASSERT(pListIter->Advance() = True)
		CU_ASSERT_EQUAL(pListIter->Item(), 7)
		CU_ASSERT(pListIter2->Advance() = True)
		CU_ASSERT_EQUAL(pListIter->Item(), 7)
		CU_ASSERT_EQUAL(pListIter2->Item(), 7)
		pListIter->Reset()
		TestContainerIter(pListIter)
		pListIter2->Reset()
		TestContainerIter(pListIter2)
		Delete pListIter
		Delete pListIter2
		pListIter = 0
		pListIter2 = 0
		list.Clear()
		Dim i As Long
		For i = 0 To 6
			list.AddHead(i)
		Next
		pListIter = list.GetIterator()
		CU_ASSERT(pListIter <> 0)
		For i = 6 To 0 Step -1
			CU_ASSERT(pListIter->Advance() = True)
			CU_ASSERT_EQUAL(pListIter->Item(), i)
		Next
		CU_ASSERT(pListIter->Advance() = False)
		pListIter->Reset()
		TestContainerIter(pListIter)
		Delete pListIter
	END_TEST
	
	Private Function DoesNodeExist(Byref list As LongLinkedList, ByVal pNode As LongLLNode) As Boolean
		dim As LongLLNode pHead = list.Head, pIter = pHead
		dim found As Boolean
		If pHead <> 0 Then
			Do
				found = (pIter = pNode)
				pIter = pIter->Forward
			Loop While (pIter <> pHead) AndAlso (found = False)
		End If
		Return found
	End Function
	
	TEST(RemoveNode)
		dim singleItemList As LongLinkedList
		dim pNodes(0 To 2) As LongLLNode
		dim i As Long
		pNodes(0) = singleItemList.AddTail(78)
		pNodes(1) = singleItemList.AddTail(-78)
		pNodes(2) = singleItemList.AddTail(8537536)
		dim listSize As Long = singleItemList.Count
		
		CU_ASSERT_EQUAL(pNodes(2)->Forward, pNodes(0))
		CU_ASSERT_EQUAL(pNodes(1)->Back, pNodes(0))
		singleItemList.RemoveNode(pNodes(0))
		CU_ASSERT_EQUAL(singleItemList.Count, listSize - 1)
		CU_ASSERT_EQUAL(DoesNodeExist(singleItemList, pNodes(0)), False)
		CU_ASSERT_EQUAL(DoesNodeExist(singleItemList, pNodes(1)), True)
		CU_ASSERT_EQUAL(DoesNodeExist(singleItemList, pNodes(2)), True)
		CU_ASSERT(pNodes(2)->Forward <> pNodes(0))
		CU_ASSERT(pNodes(1)->Back <> pNodes(0))
		
		CU_ASSERT(pNodes(2)->Forward = pNodes(1))
		CU_ASSERT(pNodes(2)->Back = pNodes(1))
		singleItemList.RemoveNode(pNodes(1))
		CU_ASSERT_EQUAL(singleItemList.Count, listSize - 2)
		CU_ASSERT_EQUAL(DoesNodeExist(singleItemList, pNodes(0)), False)
		CU_ASSERT_EQUAL(DoesNodeExist(singleItemList, pNodes(1)), False)
		CU_ASSERT_EQUAL(DoesNodeExist(singleItemList, pNodes(2)), True)
		CU_ASSERT(pNodes(2)->Forward <> pNodes(1))
		CU_ASSERT(pNodes(2)->Back <> pNodes(1))
		
		CU_ASSERT(pNodes(2)->Forward = pNodes(2))
		CU_ASSERT(pNodes(2)->Back = pNodes(2))
		singleItemList.RemoveNode(pNodes(2))
		CU_ASSERT_EQUAL(singleItemList.Count, 0)
		CU_ASSERT_EQUAL(DoesNodeExist(singleItemList, pNodes(0)), False)
		CU_ASSERT_EQUAL(DoesNodeExist(singleItemList, pNodes(1)), False)
		CU_ASSERT_EQUAL(DoesNodeExist(singleItemList, pNodes(2)), False)
		CU_ASSERT(singleItemList.Head = 0)
		
		pNodes(0) = singleItemList.AddTail(78)
		pNodes(1) = singleItemList.AddTail(-78)
		pNodes(2) = singleItemList.AddTail(8537536)
		dim otherList As LongLinkedList
		dim As LongLLNode otherListNode = otherList.AddHead(0), removeRet
		'' trying to remove a node that belongs to a different list
		'' is an error
		On Local Error Goto nextTest
		dim localErr As Long
		Err = 0
		removeRet = singleItemList.RemoveNode(otherListNode)
		localErr = Err
		CU_ASSERT_EQUAL(removeRet, 0)
		CU_ASSERT_EQUAL(localErr, 1)
	nextTest:
		On Local Error Goto 0
	
		removeRet = singleItemList.RemoveNode(pNodes(0))
		CU_ASSERT_EQUAL(removeRet, pNodes(1))
		CU_ASSERT_EQUAL(removeRet, singleItemList.Head)
		listSize = singleItemList.Count
		
		'' RemoveNode 0 does nothing
		removeRet = singleItemList.RemoveNode(0)
		CU_ASSERT_EQUAL(removeRet, 0)
		CU_ASSERT_EQUAL(listSize, singleItemList.Count)
		
		removeRet = singleItemList.RemoveNode(pNodes(1))
		CU_ASSERT_EQUAL(removeRet, pNodes(2))
		CU_ASSERT_EQUAL(removeRet, singleItemList.Head)
		CU_ASSERT_EQUAL(listSize - 1, singleItemList.Count)
		CU_ASSERT_EQUAL(1, singleItemList.Count)
		
		removeRet = singleItemList.RemoveNode(pNodes(2))
		CU_ASSERT_EQUAL(removeRet, 0)
		CU_ASSERT_EQUAL(removeRet, singleItemList.Head)
		CU_ASSERT_EQUAL(singleItemList.Empty(), True)
	END_TEST
	
	TEST(LenTest)
		dim singleItemList As LongLinkedList
		singleItemList.AddHead(78)
		CU_ASSERT_EQUAL(singleItemList.Count, 1)
		CU_ASSERT_EQUAL(singleItemList.Count, Len(singleItemList))
		singleItemList.AddTail(-78)
		singleItemList.AddTail(35)
		singleItemList.AddHead(-87)
		CU_ASSERT_EQUAL(singleItemList.Count, 4)
		CU_ASSERT_EQUAL(singleItemList.Count, Len(singleItemList))
		singleItemList.RemoveNode(singleItemList.Head)
		CU_ASSERT_EQUAL(singleItemList.Count, 3)
		CU_ASSERT_EQUAL(singleItemList.Count, Len(singleItemList))
		singleItemList.RemoveNode(singleItemList.Tail)
		CU_ASSERT_EQUAL(singleItemList.Count, 2)
		CU_ASSERT_EQUAL(singleItemList.Count, Len(singleItemList))
		singleItemList.RemoveNode(singleItemList.Head)
		CU_ASSERT_EQUAL(singleItemList.Count, 1)
		CU_ASSERT_EQUAL(singleItemList.Count, Len(singleItemList))
		singleItemList.RemoveNode(singleItemList.Tail)
		singleItemList.Clear()
		singleItemList += 19
		CU_ASSERT_EQUAL(singleItemList.Count, 1)
		CU_ASSERT_EQUAL(singleItemList.Count, Len(singleItemList))
		singleItemList += 99
		CU_ASSERT_EQUAL(singleItemList.Count, 2)
		CU_ASSERT_EQUAL(singleItemList.Count, Len(singleItemList))
		singleItemList.RemoveNode(singleItemList.Head)
		CU_ASSERT_EQUAL(singleItemList.Count, 1)
		CU_ASSERT_EQUAL(singleItemList.Count, Len(singleItemList))
		singleItemList.RemoveNode(singleItemList.Tail)
		CU_ASSERT_EQUAL(singleItemList.Count, 0)
		CU_ASSERT_EQUAL(singleItemList.Count, Len(singleItemList))
	END_TEST

	TEST(Empty)
		dim singleItemList As LongLinkedList
		CU_ASSERT_EQUAL(singleItemList.Empty(), True)
		singleItemList.AddHead(78)
		CU_ASSERT_EQUAL(singleItemList.Empty(), False)
		singleItemList.RemoveNode(singleItemList.Head)
		CU_ASSERT_EQUAL(singleItemList.Empty(), True)
		Dim arr(0 To 1) As Long
		dim otherQueue As LongLinkedList = arr()
		CU_ASSERT_EQUAL(otherQueue.Empty(), False)
		dim pHead As LongLLNode = singleItemList.Head
		singleItemList.AddAfter(30, pHead)
		CU_ASSERT_EQUAL(otherQueue.Empty(), False)
		otherQueue.Clear()
		CU_ASSERT_EQUAL(otherQueue.Empty(), True)
	END_TEST
	
	TEST(LetTest)
		dim As LongLinkedList list1, list2
		list1.AddTail(8586)
		list1.AddTail(2)
		CU_ASSERT(list1.Count <> list2.Count)
		list2 = list1
		CU_ASSERT_EQUAL(list1.Count, list2.Count) 
		CU_ASSERT_EQUAL(list1.Head->Data, list2.Head->Data)
		CU_ASSERT_EQUAL(list1.Tail->Data, list2.Tail->Data)
		list2.Clear()
		CU_ASSERT(list1.Count <> list2.Count)
		CU_ASSERT(list1.Head <> 0)
		CU_ASSERT(list2.Head = 0)
		list1 = list2
		CU_ASSERT_EQUAL(list1.Count, list2.Count)
		CU_ASSERT_EQUAL(list1.Head, 0)
		CU_ASSERT_EQUAL(list2.Head, 0)
		list2.AddHead(9485)
		CU_ASSERT(list1.Count <> list2.Count)
		CU_ASSERT(list2.Head <> 0)
		CU_ASSERT(list1.Head = 0)
		list1 = list2
		CU_ASSERT_EQUAL(list1.Count, list2.Count)
		CU_ASSERT(list1.Head <> 0)
		CU_ASSERT(list2.Head <> 0)
		CU_ASSERT(list1.Head <> list2.Head)
		CU_ASSERT_EQUAL(list1.Head->Data, list2.Head->Data)
	END_TEST
END_SUITE
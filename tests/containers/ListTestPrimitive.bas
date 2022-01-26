''#define FB_CONTAINER_DEBUG 1
#include "../../inc/containers/list.bi"
#include "ContainerTestPrereqs.bi"
#include "fbcunit.bi"

FBCont_DefineListOf(Long)
Type LongList As FB_List(Long)

SUITE(fbc_tests.containers.lists.primitive)
	TEST(ConstructorTest)
		dim emptyList As LongList
		CU_ASSERT_EQUAL(emptyList.Count, 0)
		dim emptyIterator As SequentialLongGenerator = Type(0, 1)

		Dim zt1NumToGenerate As Long = 15
		Dim zt1StartNum As Long = 0
		Dim i As Long
		Dim zeroTo14Iterator As SequentialLongGenerator = Type(zt1NumToGenerate, zt1StartNum)
		Dim tt2NumToGenerate As Long = 7
		Dim tt2StartNum As Long = 203
		Dim twoHundred3To210Iterator As SequentialLongGenerator = Type(tt2NumToGenerate, tt2StartNum)

		'' Iterator constructor
		Dim zt1List As LongList = zeroTo14Iterator
		For i = 0 To zt1NumToGenerate - 1
			CU_ASSERT_EQUAL(zt1List[i], zt1StartNum + i)
		Next
		CU_ASSERT_EQUAL(zt1List.Count, zt1NumToGenerate)
		
		Dim tt2List As LongList = twoHundred3To210Iterator
		For i = 0 To tt2NumToGenerate - 1
			CU_ASSERT_EQUAL(tt2List[i], tt2StartNum + i)
		Next
		CU_ASSERT_EQUAL(tt2List.Count, tt2NumToGenerate)
		
		zeroTo14Iterator.Reset()
		Dim zt1List2 As LongList = zeroTo14Iterator
		For i = 0 To zt1NumToGenerate - 1
			CU_ASSERT_EQUAL(zt1List2[i], zt1List[i])
		Next
		CU_ASSERT_EQUAL(zt1List.Count, zt1List2.Count)
		
		twoHundred3To210Iterator.Reset()
		Dim tt2List2 As LongList = twoHundred3To210Iterator
		For i = 0 To tt2NumToGenerate - 1
			CU_ASSERT_EQUAL(tt2List[i], tt2StartNum + i)
		Next
		CU_ASSERT_EQUAL(tt2List2.Count, tt2List.Count)
		
		dim newEmptyList As LongList = emptyIterator
		CU_ASSERT_EQUAL(newEmptyList.Count, 0)
		emptyIterator.Reset()
		
		'' Container Constructor
		Dim zt1ListCopy As LongList = zt1List
		For i = 0 To zt1List.Count - 1
			CU_ASSERT_EQUAL(zt1ListCopy[i], zt1List[i])
		Next
		CU_ASSERT_EQUAL(zt1ListCopy.Count, zt1List.Count)
		
		Dim tt2ListCopy As LongList = tt2List
		For i = 0 To tt2List.Count - 1
			CU_ASSERT_EQUAL(tt2ListCopy[i], tt2List[i])
		Next
		CU_ASSERT_EQUAL(tt2ListCopy.Count, tt2List.Count)
		
		Dim fromEmptyContainerList As LongList = @newEmptyList
		CU_ASSERT_EQUAL(fromEmptyContainerList.Count, 0)
		
		dim numArray(7) As Long
		dim numArrayLBound As Long = LBound(numArray)
		dim numArrayUBound As Long = UBound(numArray)
		dim arraySize As Long = numArrayUBound - numArrayLBound + 1
		For i = numArrayLBound To numArrayUBound
			numArray(i) = i
		Next
		
		Dim arrayList As LongList = numArray()
		For i = 0 To arraySize - 1
			CU_ASSERT_EQUAL(arrayList[i], numArray(numArrayLBound + i))
		Next
		CU_ASSERT_EQUAL(arrayList.Count, arraySize)
		
		
		dim numArrayBased(5 To 9) As Long
		numArrayLBound = LBound(numArrayBased)
		numArrayUBound = UBound(numArrayBased)
		arraySize = numArrayUBound - numArrayLBound + 1
		For i = numArrayLBound To numArrayUBound
			numArrayBased(i) = i
		Next
		
		Dim arrayListBased As LongList = numArrayBased()
		For i = 0 To arraySize - 1
			CU_ASSERT_EQUAL(arrayListBased[i], numArrayBased(numArrayLBound + i))
		Next
		CU_ASSERT_EQUAL(arrayListBased.Count, arraySize)
		
		dim undimmedArray(Any) As Long
		dim anyArrayList As LongList = undimmedArray()
		CU_ASSERT_EQUAL(anyArrayList.Count, 0)
		
	END_TEST
	
	TEST(Add)
	
		'' single item
		dim i As Long
		dim singleItemList As LongList
		singleItemList.Add(78)
		singleItemList.Add(-78)
		CU_ASSERT_EQUAL(singleItemList.Count, 2)
		CU_ASSERT_EQUAL(singleItemList[0], 78)
		CU_ASSERT_EQUAL(singleItemList[1], -78)
		singleItemList.Remove(78)
		singleItemList.Add(123456)
		CU_ASSERT_EQUAL(singleItemList[0], -78)
		CU_ASSERT_EQUAL(singleItemList[1], 123456)
		
		'' Whole Array Add
		dim emptyArray() As Long
		dim addArray(0 to 9) As Long
		dim As LongList emptyList, arrayList
		'' undimmed arrays do nothing
		emptyList.Add(emptyArray())
		CU_ASSERT_EQUAL(emptyList.Count, 0)
		For i = 0 To 9
			addArray(i) = i
		Next
		arrayList.Add(addArray())
		CU_ASSERT_EQUAL(arrayList.Count, 10)
		For i = 0 To 9
			CU_ASSERT_EQUAL(arrayList[i], addArray(i))
		Next
		arrayList.Add(emptyArray())
		CU_ASSERT_EQUAL(arrayList.Count, 10)
		For i = 0 To 9
			CU_ASSERT_EQUAL(arrayList[i], addArray(i))
		Next
		arrayList.Add(addArray())
		CU_ASSERT_EQUAL(arrayList.Count, 20)
		For i = 0 To 19
			CU_ASSERT_EQUAL(arrayList[i], addArray(i Mod 10))
		Next
		
		''Partial Array Add
		
		'' again undimmed arrays do nothing
		arrayList.Add(emptyArray(), 4, 2)
		CU_ASSERT_EQUAL(arrayList.Count, 20)
		
		'' Trying to add things outside the bounds of the array
		'' are constrained to the array
		''
		'' This should add addArray(9) then stop, since there aren't 14 more elements after that
		arrayList.Add(addArray(), 9, 15)
		CU_ASSERT_EQUAL(arrayList.Count, 21)
		For i = 0 To 19
			CU_ASSERT_EQUAL(arrayList[i], addArray(i Mod 10))
		Next
		CU_ASSERT_EQUAL(arrayList[20], addArray(9))
		
		'' This shouldn't add anything, since the start point is outside the bounds
		arrayList.Add(addArray(), 15, 2)
		CU_ASSERT_EQUAL(arrayList.Count, 21)
		
		arrayList.Add(addArray(), 3, 2)
		CU_ASSERT_EQUAL(arrayList.Count, 23)
		For i = 0 To 19
			CU_ASSERT_EQUAL(arrayList[i], addArray(i Mod 10))
		Next
		CU_ASSERT_EQUAL(arrayList[20], addArray(9))
		CU_ASSERT_EQUAL(arrayList[21], addArray(3))
		CU_ASSERT_EQUAL(arrayList[22], addArray(4))
		
		arrayList.Add(addArray(), 0, 8)
		CU_ASSERT_EQUAL(arrayList.Count, 31)
		For i = 0 To 7
			CU_ASSERT_EQUAL(arrayList[23 + i], addArray(i))
		Next
		
		'' Negative start points should also do nothing
		arrayList.Add(addArray(), -2, 6)
		CU_ASSERT_EQUAL(arrayList.Count, 31)
		
		'' Container Add
		''
		dim anotherList As LongList
		dim invalidListPtr As LongList Ptr = 0
		anotherList.Add(emptyList)
		CU_ASSERT_EQUAL(anotherList.Count, emptyList.Count)
		anotherList.Add(@arrayList)
		For i = 0 to arrayList.Count - 1
			CU_ASSERT_EQUAL(anotherList[i], arrayList[i])
		Next
		dim anotherListCount As Long = anotherList.Count
		CU_ASSERT_EQUAL(anotherListCount, arrayList.Count)
		'' null pointers shouldn't do anything, passing 0 directly
		'' will use the Add(Long) overload
		'' If we're compiling with -exx though, it will raise an error
		'' so we need to catch that 
		On Local Error Goto afterTest1
		anotherList.Add(invalidListPtr)
		CU_ASSERT_EQUAL(anotherListCount, anotherList.Count)
	afterTest1:
		
		'' Iterator Add
		dim emptyIterator As SequentialLongGenerator = Type(0, 1)
		dim nullIterator As SequentialLongGenerator Ptr = 0
		emptyList.Add(emptyIterator)
		CU_ASSERT_EQUAL(emptyList.Count, 0)
		
		'' If we're compiling with -exx, it will raise an error
		'' so we need to catch that 
		On Local Error Goto afterTest2
		emptyList.Add(nullIterator)
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 1)
		CU_ASSERT_EQUAL(emptyList.Count, 0)
	afterTest2:
		On Local Error Goto 0

		Dim zt1NumToGenerate As Long = 15
		Dim zt1StartNum As Long = 0
		Dim zeroTo14Iterator As SequentialLongGenerator = Type(zt1NumToGenerate, zt1StartNum)
		Dim tt2NumToGenerate As Long = 7
		Dim tt2StartNum As Long = 203
		Dim twoHundred3To210Iterator As SequentialLongGenerator = Type(tt2NumToGenerate, tt2StartNum)

		Dim zt1List As LongList
		zt1List.Add(zeroTo14Iterator)
		For i = 0 To zt1NumToGenerate - 1
			CU_ASSERT_EQUAL(zt1List[i], zt1StartNum + i)
		Next
		CU_ASSERT_EQUAL(zt1List.Count, zt1NumToGenerate)
		
		Dim tt2List As LongList
		tt2List.Add(@twoHundred3To210Iterator)
		For i = 0 To tt2NumToGenerate - 1
			CU_ASSERT_EQUAL(tt2List[i], tt2StartNum + i)
		Next
		CU_ASSERT_EQUAL(tt2List.Count, tt2NumToGenerate)
		
		zeroTo14Iterator.Reset()
		Dim zt1List2 As LongList
		zt1List2.Add(@zeroTo14Iterator)
		For i = 0 To zt1NumToGenerate - 1
			CU_ASSERT_EQUAL(zt1List2[i], zt1List[i])
		Next
		CU_ASSERT_EQUAL(zt1List.Count, zt1List2.Count)
		
		twoHundred3To210Iterator.Reset()
		Dim tt2List2 As LongList
		tt2List2.Add(twoHundred3To210Iterator)
		For i = 0 To tt2NumToGenerate - 1
			CU_ASSERT_EQUAL(tt2List[i], tt2StartNum + i)
		Next
		CU_ASSERT_EQUAL(tt2List2.Count, tt2List.Count)
		
		dim newEmptyList As LongList
		newEmptyList.Add(emptyIterator)
		CU_ASSERT_EQUAL(newEmptyList.Count, 0)
	
	END_TEST
	
	TEST(Clear)
		dim singleItemList As LongList
		singleItemList.Add(78)
		singleItemList.Add(-78)
		singleItemList.Clear()
		CU_ASSERT_EQUAL(singleItemList.Count, 0)
		singleItemList.Clear()
		CU_ASSERT_EQUAL(singleItemList.Count, 0)
		dim list2 As LongList	
		list2.Clear()
		CU_ASSERT_EQUAL(list2.Count, 0)
	END_TEST
	
	TEST(Contains)
		dim haystack As LongList
		dim needle As Long = 78
		dim result As Boolean
		result = haystack.Contains(0)
		CU_ASSERT_EQUAL(result, False)
		haystack.Add(needle)
		haystack.Add(-needle)
		haystack.Add(52)
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, True)
		haystack.Remove(needle)
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, False)
		Dim generate100 As SequentialLongGenerator = Type(100, 100)
		haystack.Add(@generate100)
		result = haystack.Contains(157)
		CU_ASSERT_EQUAL(result, True)
	END_TEST
	
	Private Sub CopyToOOBTest(ByRef list As LongList, ByVal startPoint As Long)
		Dim i As Long
		Dim arr(30 To 36) As Long
		For i = 30 To 36
			arr(i) = i
		Next
		
		'' It should be invalid
		Assert((startPoint >= list.Count) OrElse (startPoint < 0))
		
		Err = 0
		'' Will call Error if FB_CONTAINER_DEBUG is defined
		On Local Error Goto nextTest
		list.CopyTo(arr(), startPoint, list.Count, 0)
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 1)
		For i = 30 To 36
			CU_ASSERT_EQUAL(arr(i), i)
		Next
		
		nextTest:
		On Local Error Goto 0
	End Sub
	
	Private Sub CopyToArrTest(_
		ByRef list As LongList, _
		ByVal listStart As Long, _
		ByVal listCount As Long, _
		ByVal arrayStart As Long, _
		ByVal useDimmedArr As Boolean, _
		ByVal arrLDim As Long, _
		ByVal arrUDim As Long _
	)
		dim iterArr(Any) As Long
		dim listSize As Long = list.Count
		dim hadError As Boolean = False
		dim i As Long
		dim calcListCount As Long = IIf(listCount = -1, listSize, listCount)
		dim maxListToCopy As Long = listSize - listStart
		maxListToCopy = IIf(maxListToCopy > calcListCount, calcListCount, maxListToCopy)
		dim arrSize As Long = (arrUDim - arrLDim) + 1
		dim maxArrToCopy As Long = IIf(useDimmedArr, arrSize - (arrayStart - arrLDim), maxListToCopy)
		dim maxToCopy As Long = IIf(maxArrToCopy < maxListToCopy, maxArrToCopy, maxListToCopy)

		If useDimmedArr Then
			Redim iterArr(arrLDim To arrUDim)
			For i = arrLDim To arrUDim
				iterArr(i) = i
			Next
		End If

		On Local Error Goto setError
		Err = 0
		list.CopyTo(iterArr(), listStart, listCount, arrayStart)
		hadError = Err <> 0
	testElems:
		If useDimmedArr = False Then arrayStart = 0
		dim arrUBound As Long = UBound(iterArr)
		dim arrLBound As Long = LBound(iterArr)
		dim numElems As Long = (arrUBound - arrLBound) + 1

		If useDimmedArr Then

			CU_ASSERT_EQUAL(arrUBound, arrUDim)
			CU_ASSERT_EQUAL(arrLBound, arrLDim)
			CU_ASSERT_EQUAL(numElems, (arrUDim - arrLDim) + 1)
		Else
			If hadError Then

				CU_ASSERT_EQUAL(arrUBound, -1)
				CU_ASSERT_EQUAL(arrLBound, 0)
				CU_ASSERT_EQUAL(numElems, 0)
			Else
				CU_ASSERT_EQUAL(arrUBound, maxListToCopy - 1)
				CU_ASSERT_EQUAL(arrLBound, 0)
				CU_ASSERT_EQUAL(numElems, maxListToCopy)
			End If
		End If
		If hadError AndAlso useDimmedArr Then
			'' unchanged
			For i = 0 To numElems - 1
				CU_ASSERT_EQUAL(iterArr(arrLBound + i), arrLBound + i)
			Next
		Else
			If hadError = False Then
				'' unchanged contents from arrLBound to arrayStart, 
				'' list contents from arrayStart to maxToCopy
				'' unchanged contents above that
				Dim listIter As Long = listStart
				Dim arrIndex As Long = arrLBound
				For i = arrLBound To arrUBound
					If (i < arrayStart) OrElse (i > (arrayStart + maxToCopy)) Then
						CU_ASSERT_EQUAL(iterArr(i), arrIndex)
						arrIndex += 1
					Else
						CU_ASSERT_EQUAL(iterArr(i), list[listIter])
						listIter += 1
					End If
				Next
			Endif '' hadError And useDimmedArr = false is an empty array that's already been tested above
		End If
		Exit Sub
setError:
		On Local Error Goto 0
		hadError = True
		Goto testElems
	End Sub
	
	TEST(CopyTo)
		dim singleItemList As LongList
		dim i As Long
		singleItemList.Add(78)
		singleItemList.Add(-78)
		singleItemList.Add(8537536)
		'' Undimmed arrays are redimmed to be the size of the container, from 0 To n-1
		dim undimmedArr(Any) As Long
		singleItemList.CopyTo(undimmedArr())
		dim arrUBound As Long = UBound(undimmedArr)
		dim arrLBound As Long = LBound(undimmedArr)
		dim numElems As Long = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, singleItemList.Count)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 0)
		For i = 0 To singleItemList.Count - 1
			CU_ASSERT_EQUAL(undimmedArr(i), singleItemList[i])
		Next
		
		'' Except in empty lists, where nothing happens
		'' If container debug is defined, this calls Error
		dim emptyList As LongList
		dim emptyArr(Any) As Long
		On Local Error Goto nextTest1
		Dim localErr As Long
		Err = 0
		emptyList.CopyTo(emptyArr())
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)

	nextTest1:
		On Local Error Goto 0
		'' already sized arrays copy the number of items in the list or the size of the array
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
		For i = 10 To 14
			CU_ASSERT_EQUAL(largerThanContArr(i), IIf(i <= 12, singleItemList[i - 10], i))
		Next
		
		dim smallerThanContArr(21 To 22) As Long
		For i = 21 To 22
			smallerThanContArr(i) = i
		Next
		singleItemList.Add(4)
		singleItemList.CopyTo(smallerThanContArr())
		arrUBound = UBound(smallerThanContArr)
		arrLBound = LBound(smallerThanContArr)
		numElems = (arrUBound - arrLBound) + 1
		CU_ASSERT_EQUAL(numElems, 2)
		CU_ASSERT(arrUBound > arrLBound)
		CU_ASSERT_EQUAL(arrLBound, 21)
		CU_ASSERT_EQUAL(arrUBound, 22)
		For i = 21 To 22
			CU_ASSERT_EQUAL(smallerThanContArr(i), singleItemList[i - 21])
		Next
		
		'' Then the partial copyto
		dim slg As SequentialLongGenerator = Type(100, 15)
		dim iterList As LongList = slg
		dim iterArr(Any) As Long
		'' negative or or out of range start points don't do anything
		'' and call Error if the FB_CONTAINER_DEBUG is defined
		CopyToOOBTest(iterList, -6)
		CopyToOOBTest(iterList, iterList.Count + 5)
		
		'' standard normal all good copy
		''' Again, undimmed arrays are redimmed to hold all required elements
		''' With undimmed arrays, the array is dimmed from 0 To n, so the last argument is ignored
		CopyToArrTest(iterList, 5, 5, 0, False, 0, 0)
		
		'' 'listCount too big' test, check it constrains to list size
		CopyToArrTest(iterList, 2, 15, 0, False, 0, 0)
		
		'' 'All too big' test. Copying 15 elements from position 9
		'' should constrain to 6. Which should then be further constrained
		'' to 3 since we want to start copying to the array at 19 of 21 spaces
		CopyToArrTest(iterList, 9, 15, 19, True, 15, 21)
		
		'' 'Array too small, in bounds' test. Copying 7 elements from position 4
		'' should copy 7. Excep that the array is only 4 elements big
		CopyToArrTest(iterList, 4, 7, 32, True, 32, 35)
		
		'' '-1 all good' test. Copying all elements from position 4 should copy 11
		CopyToArrTest(iterList, 4, -1, 0, False, 32, 35)
	END_TEST
	
	TEST(Empty)
		dim list As LongList
		CU_ASSERT_EQUAL(list.Empty(), True)
		list.Add(7)
		CU_ASSERT_EQUAL(list.Empty(), False)
		list.RemoveAt(0)
		CU_ASSERT_EQUAL(list.Empty(), True)
		Dim arr(0 To 1) As Long
		list.Insert(0, arr())
		CU_ASSERT_EQUAL(list.Empty(), False)
		list.RemoveAt(0)
		CU_ASSERT_EQUAL(list.Empty(), False)
		list.Clear()
		CU_ASSERT_EQUAL(list.Empty(), True)
	END_TEST
	
	TEST(FirstTest)
		dim list As LongList
		'' Out of bounds calls Error with FB_CONTAINER_DEBUG
		On Local Error Goto afterError
		dim first As Long = list.First()
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6) '' out of bounds
	afterError:
		list.Add(7)
		CU_ASSERT_EQUAL(list.First(), 7)
		list.Add(9)
		CU_ASSERT_EQUAL(list.First(), 7)
		list.RemoveAt(0)
		CU_ASSERT_EQUAL(list.First(), 9)
		Dim arr(0 To 1) As Long
		list.Insert(0, arr())
		CU_ASSERT_EQUAL(list.First(), 0)
		list.RemoveAt(1)
		CU_ASSERT_EQUAL(list.First(), 0)
		list.Clear()
		Err = 0
		On Local Error Goto afterError2
		first = list.First()
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6) '' out of bounds
	afterError2:
		On Local Error Goto 0
	END_TEST
	
	TEST(GetIterator)
		dim list As LongList
		dim pListIter As FB_IIterator(Long) Ptr = list.GetIterator()
		CU_ASSERT(pListIter <> 0)
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
		pListIter = 0
		list.Add(7)
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
		Delete pListIter
		Delete pListIter2
		pListIter = 0
		pListIter2 = 0
		list.Clear()
		Dim arr(0 To 6) As Long
		Dim i As Long
		For i = 0 To 6
			arr(i) = i
		Next
		list.Add(arr())
		pListIter = list.GetIterator()
		CU_ASSERT(pListIter <> 0)
		For i = 0 To 6
			CU_ASSERT(pListIter->Advance() = True)
			CU_ASSERT_EQUAL(pListIter->Item(), i)
		Next
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
	END_TEST
	
	TEST(IndexOf)
		dim list As LongList
		dim i As Long
		CU_ASSERT_EQUAL(list.IndexOf(0), -1)
		list.Add(65) '' 0
		list.Add(65) '' 1
		list.Add(0) '' 2
		list.Add(85) '' 3
		list.Add(69) '' 4
		For i = 0 to list.Count - 1
			If i <> 1 Then
				CU_ASSERT_EQUAL(list.IndexOf(list[i]), i)
			Else
				CU_ASSERT_EQUAL(list.IndexOf(list[i]), 0)
			End If
		Next
		list.RemoveAt(0)
		For i = 0 to list.Count - 1
			CU_ASSERT_EQUAL(list.IndexOf(list[i]), i)
		Next
		CU_ASSERT_EQUAL(list.IndexOf(list.First()), 0)
		CU_ASSERT_EQUAL(list.IndexOf(list.Last()), list.Count - 1)
		list.Add(65)
		CU_ASSERT_EQUAL(list.IndexOf(65), 0)
		CU_ASSERT_EQUAL(list.IndexOf(58), -1)
	END_TEST
	
	Private Sub InsertArrTest(ByRef theList As LongList, byVal where As Long, arr() As Long, ByVal arrStartPoint As Long, ByVal howMany As Long, byVal useSimpler As Boolean)
		dim i As Long
		dim originalListCopy As LongList = theList
		dim origIter As Long = 0
		dim localErr As Long
		dim curSize As Long = theList.Count
		dim arrLBound As Long = LBound(arr)
		dim arrUBound As Long = UBound(arr)
		dim numElems As Long = (arrUBound - arrLBound) + 1
		
		On Local Error Goto commonError
		Err = 0
		If useSimpler Then
			theList.Insert(where, arr())
			arrStartPoint = arrLBound
			howMany = numElems
		Else
			theList.Insert(where, arr(), arrStartPoint, howMany)
			dim maxToInsert As Long = (arrUBound - arrStartPoint) + 1
			howMany = Iif(howMany < maxToInsert, howMany, maxToInsert)
		End If
		localErr = Err
		If localErr <> 0 Then
			CU_ASSERT_EQUAL(localErr, IIf(numElems = 0, 1, 6))
			CU_ASSERT_EQUAL(theList.Count, originalListCopy.Count)
			goto commonError
		End If
	testElements:
		'' make the calculations easier now these values have been used in the Insert
		If where = -1 Then where = originalListCopy.Count
		dim newCount As Long = theList.Count
		dim arrIter As Long = 0
		For i = 0 To newCount - 1
			If (i < where) OrElse (i >= (where + howMany)) Then
				CU_ASSERT_EQUAL(theList[i], originalListCopy[origIter])
				origIter += 1
			Else
				dim arrIndex As Long = arrStartPoint + arrIter
				CU_ASSERT_EQUAL(theList[i], arr(arrIndex))
				arrIter += 1
			End If
		Next
		Exit Sub
	commonError:
		On Local Error Goto 0
		howMany = 0
		'' ensure we aways go in the first If in the check loop
		'' as the list isn't modified on error
		where = theList.Count
		Goto testElements
	End Sub
	
	Private Sub TestInsertSingle()
		dim theList As LongList
		dim count As Long = theList.Count
		theList.Insert(-1, 50) '' 50
		CU_ASSERT(theList.Count > count)
		CU_ASSERT_EQUAL(theList.Count, 1)
		theList.Insert(0, 51) '' 51, 50
		CU_ASSERT_EQUAL(theList.Count, 2)
		CU_ASSERT_EQUAL(theList[0], 51)
		CU_ASSERT_EQUAL(theList.Last(), 50)
		theList.Insert(1, 52) '' 51, 52, 50
		CU_ASSERT_EQUAL(theList.Count, 3)
		CU_ASSERT_EQUAL(theList[0], 51)
		CU_ASSERT_EQUAL(theList[2], 50)
		CU_ASSERT_EQUAL(theList.Last(), 50)
		On Local Error Goto afterTest1
		Err = 0
		'' out of bounds insert position (except for -1 or Count) causes Error() in -exx builds
		theList.Insert(43, 43)
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(theList.Count, 3)
		CU_ASSERT_EQUAL(theList[0], 51)
		CU_ASSERT_EQUAL(theList[2], 50)
		CU_ASSERT_EQUAL(theList.Last(), 50)
	afterTest1:
		On Local Error Goto 0
		theList.Insert(-1, 53) '' 53, 51, 52, 50
		theList.Insert(0, 53) '' 53, 51, 52, 50, 53
		CU_ASSERT_EQUAL(theList.Count, 5)
		CU_ASSERT_EQUAL(theList.First(), 53)
		CU_ASSERT_EQUAL(theList[1], 51)
		CU_ASSERT_EQUAL(theList[2], 52)
		CU_ASSERT_EQUAL(theList[3], 50)
		CU_ASSERT_EQUAL(theList.Last(), 53)
	End Sub
	
	Private Sub InsertContainerTest(Byref list As LongList, ByRef secondList As LongList, ByVal insertPos As Long, ByVal byPtr As Boolean)
		dim origCount As Long = list.Count
		dim originalListCopy As LongList = list
		dim secondListCopy As LongList = secondList
		dim newCount As Long = secondList.Count
		dim localErr As Long
		dim i As Long
		
		Err = 0
		On Local Error Goto commonError
		If byPtr Then
			list.Insert(insertPos, @secondList)
		Else
			list.Insert(insertPos, secondList)
		End If
		localErr = Err

		'' check out of bounds causes the proper error
		'' -1 and .Count out of bounds are allowed to signal append
		If (insertPos > origCount) OrElse (insertPos < -1) Then
			CU_ASSERT_EQUAL(localErr, 6)
			goto commonError
		End If
	testElems:
		if insertPos = -1 Then insertPos = origCount '' fix for calculation below
		dim newSize As Long = newCount + origCount
		CU_ASSERT_EQUAL(list.Count, newSize)
		CU_ASSERT_EQUAL(secondList.Count, secondListCopy.Count)
		dim origIter As Long = 0
		dim secondIter As Long = 0
		For i = 0 to newSize - 1
			If (i < insertPos) OrElse (i >= (insertPos + newCount)) Then
				CU_ASSERT_EQUAL(list[i], originalListCopy[origIter])
				origIter += 1
			Else
				CU_ASSERT_EQUAL(list[i], secondListCopy[secondIter])
				secondIter += 1
			End If
		Next
		'' check inserted list isn't changed
		For i = 0 To secondListCopy.Count - 1
			CU_ASSERT_EQUAL(secondList[i], secondListCopy[i])
		Next
		'' reset for next test
		list = originalListCopy
		secondList = secondListCopy
		Exit Sub
	commonError:
		On Local Error Goto 0
		newCount = 0 '' didn't add any
		Goto testElems
	End Sub
	
	Private Sub InsertIteratorTest(Byref list As LongList, ByRef iterator As SequentialLongGenerator, ByVal insertPos As Long, ByVal byPtr As Boolean)
		dim origCount As Long = list.Count
		dim originalListCopy As LongList = list
		dim localErr As Long
		dim iterCount As Long = 0
		dim i As Long
		
		While(iterator.Advance())
			iterCount += 1
		Wend
		iterator.Reset()
		
		Err = 0
		On Local Error Goto commonError
		If byPtr Then
			list.Insert(insertPos, @iterator)
		Else
			list.Insert(insertPos, iterator)
		End If
		localErr = Err
		'' check out of bounds causes the proper error
		If (insertPos > origCount) OrElse (insertPos < -1) Then
			CU_ASSERT_EQUAL(localErr, 6)
			goto commonError
		End If		
	testElems:
		if insertPos = -1 Then insertPos = origCount '' fix for calculation below
		dim newSize As Long = origCount + iterCount
		CU_ASSERT_EQUAL(list.Count, newSize)
		CU_ASSERT_EQUAL((newSize - origCount), iterCount)
		iterator.Reset()
		iterator.Advance()
		dim origIter As Long = 0
		For i = 0 to newSize - 1
			If (i < insertPos) OrElse (i >= (insertPos + iterCount)) Then
				CU_ASSERT_EQUAL(list[i], originalListCopy[origIter])
				origIter += 1
			Else
				CU_ASSERT_EQUAL(list[i], iterator.Item())
				iterator.Advance()
			End If
		Next
		'' reset for next test
		list = originalListCopy
		iterator.Reset()
		Exit Sub
	commonError:
		On Local Error Goto 0
		iterCount = 0 '' didn't add any
		Goto testElems
	End Sub
	
	TEST(Insert)
		TestInsertSingle()
		dim theList As LongList
		dim emptyArray(Any) As Long
		dim dynArray(Any) As Long
		Dim goodArray(50 To 54) As Long
		Dim i As Long
		dim localErr As Long
		For i = 50 To 54
			goodArray(i) = i
		Next
		Redim dynArray(0 To 4)
		'' insert whole array into empty list
		InsertArrTest(theList, theList.Count, goodArray(), 0, 0, True)
		'' insert whole array into non-empty list at position 2
		InsertArrTest(theList, 2, goodArray(), 0, 0, True)
		'' insert whole array into non-empty list at position 0
		InsertArrTest(theList, 0, goodArray(), 0, 0, True)
		'' insert bad array into non-empty list at position 0 (no-op)
		InsertArrTest(theList, 0, emptyArray(), 0, 0, True)
		'' insert zero array into non-empty list at end
		InsertArrTest(theList, -1, dynArray(), 0, 0, True)
		'' insert zero array into non-empty list out of bounds (no-op)
		InsertArrTest(theList, 454, dynArray(), 0, 0, True)
		InsertArrTest(theList, 454, dynArray(), 0, 0, True)
		theList.Clear()
		'' insert good array after clear
		InsertArrTest(theList, 0, goodArray(), 0, 0, True)
		theList.Clear()
		theList.Add(6)
		theList.Add(60)
		'' insert one element of an the dyn array at the beginning
		InsertArrTest(theList, 0, dynArray(), 2, 1, False)
		'' try insert too many items from the goodArray (will add only as many as available from startPoint to end of array)
		InsertArrTest(theList, 2, goodArray(), 51, 12, False)
		'' try insert out of bounds (no-op)
		InsertArrTest(theList, 13, goodArray(), 52, 2, False)
		'' try insert undimmed array (no-op)
		InsertArrTest(theList, -1, emptyArray(), 0, 0, False)
		'' insert first three elements of array at end
		InsertArrTest(theList, -1, goodArray(), 50, 3, False)
		'' insert last element at end
		InsertArrTest(theList, theList.Count, goodArray(), 54, 1, False)
		theList.Clear()
		'' make sure it still works after a clear
		InsertArrTest(theList, theList.Count, goodArray(), 53, 1, False)
		theList.Clear()
		dim secondList As LongList
		dim thirdList As LongList
		secondList.Add(goodArray())
		thirdList.Add(75475)
		thirdList.Add(924384)
		'' oob, do nothing
		InsertContainerTest(secondList, thirdList, 67, True)
		'' insert at position three
		InsertContainerTest(secondList, thirdList, 3, True)
		'' insert empty list (no fail, but does nothing)
		InsertContainerTest(secondList, theList, 3, True)
		'' insert good list at end
		InsertContainerTest(secondList, thirdList, -1, True)
		'' insert good list at end
		InsertContainerTest(secondList, thirdList, secondList.Count, True)
		dim nullCont As LongList Ptr = 0
		Err = 0
		On Local Error Goto continueTest1
		secondList.Insert(0, nullCont)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)		
	continueTest1:
		'' byref inserts
		'' oob, do nothing
		InsertContainerTest(secondList, thirdList, 67, False)
		'' insert at position three
		InsertContainerTest(secondList, thirdList, 3, False)
		'' insert empty list (no fail, but does nothing)
		InsertContainerTest(secondList, theList, 3, False)
		'' insert good list at end
		InsertContainerTest(secondList, thirdList, -1, False)
		'' insert good list at end
		InsertContainerTest(secondList, thirdList, secondList.Count, False)
		dim slg As SequentialLongGenerator = Type(8, 678)
		dim emptyGen As SequentialLongGenerator = Type(0, 123)
		'' oob, do nothing
		InsertIteratorTest(secondList, slg, 67, True)
		'' insert at position three
		InsertIteratorTest(secondList, slg, 3, True)
		'' insert empty list (no fail, but does nothing)
		InsertIteratorTest(secondList, emptyGen, 3, True)
		'' insert good list at end
		InsertIteratorTest(secondList, slg, -1, True)
		'' insert good list at end
		InsertIteratorTest(secondList, slg, secondList.Count, True)
		dim nullIter As FB_IIterator(Long) Ptr = 0
		Err = 0
		localErr = 0
		On Local Error Goto continueTest2
		secondList.Insert(0, nullIter)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)		
	continueTest2:
		'' byref inserts
		'' oob, do nothing
		InsertIteratorTest(secondList, slg, 67, False)
		'' insert at position three
		InsertIteratorTest(secondList, slg, 3, False)
		'' insert empty list (no fail, but does nothing)
		InsertIteratorTest(secondList, emptyGen, 3, False)
		'' insert good list at end
		InsertIteratorTest(secondList, slg, -1, False)
		'' insert good list at end
		InsertIteratorTest(secondList, slg, secondList.Count, False)
		On Local Error Goto 0
	END_TEST
	
	TEST(LastTest)
		dim list As LongList
		'' Out of bounds calls Error with FB_CONTAINER_DEBUG
		On Local Error Goto afterError
		Err = 0
		dim last As Long = list.Last()
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6) '' out of bounds
	afterError:
		list.Add(7)
		CU_ASSERT_EQUAL(list.Last(), 7)
		list.Add(9)
		CU_ASSERT_EQUAL(list.Last(), 9)
		list.RemoveAt(0)
		CU_ASSERT_EQUAL(list.Last(), 9)
		Dim arr(0 To 1) As Long
		list.Insert(-1, arr())
		CU_ASSERT_EQUAL(list.Last(), 0)
		list.RemoveAt(list.Count - 1)
		CU_ASSERT_EQUAL(list.Last(), 0)
		list.Clear()
		Err = 0
		On Local Error Goto afterError2
		dim first As Long = list.Last()
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6) '' out of bounds
	afterError2:
		On Local Error Goto 0
	END_TEST
	
	TEST(LastIndexOf)
		dim list As LongList
		dim i As Long
		CU_ASSERT_EQUAL(list.LastIndexOf(0), -1)
		list.Add(65) '' 0
		list.Add(65) '' 1
		list.Add(0) '' 2
		list.Add(85) '' 3
		list.Add(65) '' 4
		list.Add(69) '' 5
		For i = 0 to list.Count - 1
			If i > 1 Then
				CU_ASSERT_EQUAL(list.LastIndexOf(list[i]), i)
			Else
				CU_ASSERT_EQUAL(list.LastIndexOf(list[i]), 4)
			End If
		Next
		list.RemoveAt(0)
		For i = 0 to list.Count - 1
			If i > 0 Then
				CU_ASSERT_EQUAL(list.LastIndexOf(list[i]), i)
			Else
				CU_ASSERT_EQUAL(list.LastIndexOf(list[i]), 3)
			End If
		Next
		CU_ASSERT_EQUAL(list.LastIndexOf(list.Last()), list.Count - 1)
		CU_ASSERT_EQUAL(list.LastIndexOf(list[1]), 1)
		list.Add(65)
		CU_ASSERT_EQUAL(list.LastIndexOf(65), list.Count - 1)
		CU_ASSERT_EQUAL(list.LastIndexOf(58), -1)
	END_TEST
	
	TEST(Remove)
		dim list As LongList
		list.Add(65) '' 0
		list.Add(0) '' 1
		list.Add(85) '' 2
		list.Add(65) '' 3
		list.Add(69) '' 4
		
		'' remove a duplicate
		list.Remove(65)
		CU_ASSERT_EQUAL(list.Count, 4)
		CU_ASSERT(list[0] <> 65)
		CU_ASSERT_EQUAL(list.Contains(65), True) '' because there were two, and remove only removes the first
		'' remove a single
		list.Remove(65)
		CU_ASSERT_EQUAL(list.Count, 3)
		CU_ASSERT(list[0] <> 65)
		CU_ASSERT(list[2] <> 65)
		CU_ASSERT_EQUAL(list.Contains(65), False) '' because there was one, and now there isn't
		'' remove a non-existant
		list.Remove(65) '' this shouldn't do anything
		CU_ASSERT_EQUAL(list.Count, 3)
		CU_ASSERT_EQUAL(list.Contains(65), False)
		
		dim emptyList As LongList
		emptyList.Remove(0)
		CU_ASSERT_EQUAL(emptyList.Empty(), True)
	END_TEST
	
	TEST(RemoveAt)
		dim list As LongList
		dim arrItems(10 To 20) As Long
		dim i As Long
		dim localErr As Long
		For i = 10 To 20
			arrItems(i) = i
		Next
		list.Add(arrItems())
		list.RemoveAt(0)
		CU_ASSERT_EQUAL(list.Count, 10)
		For i = 0 To list.Count - 1
			CU_ASSERT_EQUAL(list[i], arrItems(i + 11))
		Next
		list.RemoveAt(list.Count - 1)
		CU_ASSERT_EQUAL(list.Count, 9)
		For i = 0 To list.Count - 1
			CU_ASSERT_EQUAL(list[i], arrItems(i + 11))
		Next
		
		On Local Error Goto resumeTests
		Err = 0
		list.RemoveAt(19)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(list.Count, 9)
	resumeTests:
		On Local Error Goto resumeTests2
		Err = 0
		list.RemoveAt(-1)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(list.Count, 9)
	resumeTests2:
		list.RemoveAt(5)
		For i = 0 to 4
			CU_ASSERT_EQUAL(list[i], arrItems(i + 11))
		Next
		For i = 5 to list.Count - 1
			CU_ASSERT_EQUAL(list[i], arrItems(i + 12))
		Next
		CU_ASSERT_EQUAL(list.Count, 8)
		dim emptyList As LongList
		On Local Error Goto resumeTests3
		Err = 0
		emptyList.RemoveAt(0)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(emptyList.Count, 0)
	resumeTests3:
		On Local Error Goto 0
	END_TEST
	
	TEST(RemoveSpan)
		dim slg As SequentialLongGenerator = Type(100, 55)
		dim list As LongList = slg
		dim toRemove As Long = 10
		dim i As Long
		dim localErr As Long
		list.RemoveSpan(0, toRemove)
		CU_ASSERT_EQUAL(list.Count, 90)
		slg.Reset()
		slg.Skip(toRemove)
		For i = 0 To list.Count - 1
			slg.Advance()
			CU_ASSERT_EQUAL(list[i], slg.Item())
		Next		
		On Local Error Goto resumeTests
		Err = 0
		list.RemoveSpan(-5, 15)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(list.Count, 90)
	resumeTests:
		'' added 100, removed 10, this will remove 5 from 85-89
		list.RemoveSpan(85, 15)
		CU_ASSERT_EQUAL(list.Count, 85)
		slg.Reset()
		slg.Skip(toRemove)
		For i = 0 To list.Count - 1
			slg.Advance()
			CU_ASSERT_EQUAL(list[i], slg.Item())
		Next
		list.RemoveSpan(0, list.Count)
		CU_ASSERT_EQUAL(list.Empty(), True)
		On Local Error Goto resumeTests2
		Err = 0
		list.RemoveSpan(0, 10)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(list.Count, 0)
	resumeTests2:
		On Local Error Goto 0
	END_TEST
	
	TEST(Resize)
		dim i As Long
		dim list As LongList
		dim localErr As Long
		CU_ASSERT_EQUAL(list.Count, 0)
		list.Resize(6)
		CU_ASSERT_EQUAL(list.Count, 6)
		For i = 0 To list.Count - 1
			CU_ASSERT_EQUAL(list[i], 0)
		Next
		list.Resize(3)
		CU_ASSERT_EQUAL(list.Count, 3)
		For i = 0 To list.Count - 1
			CU_ASSERT_EQUAL(list[i], 0)
		Next
		On Local Error Goto resumeTests
		Err = 0
		list.Resize(-6)
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 1)
		CU_ASSERT_EQUAL(list.Count, 3)
	resumeTests:
		On Local Error Goto 0
		list.Resize(10)
		CU_ASSERT_EQUAL(list.Count, 10)
		For i = 0 To list.Count - 1
			CU_ASSERT_EQUAL(list[i], 0)
			list[i] = i
		Next
		list.Resize(20)
		For i = 0 To list.Count - 1
			CU_ASSERT_EQUAL(list[i], IIf(i < 10, i, 0))
		Next		
	END_TEST
	
	TEST(ReserveCapacity)
		dim list As LongList
		dim curCapacity As Long
		dim i As Long
		CU_ASSERT(list.Capacity > 0)
		CU_ASSERT_EQUAL(list.Count, 0)
		list.Reserve(30)
		CU_ASSERT_EQUAL(list.Capacity, 30)
		CU_ASSERT_EQUAL(list.Count, 0)
		'' Clear trims the unused space 
		list.Clear()
		CU_ASSERT((list.Capacity < 30) AndAlso (list.Capacity > 0))
		CU_ASSERT_EQUAL(list.Count, 0)
		list.Resize(60)
		curCapacity = list.Capacity
		CU_ASSERT_EQUAL(list.Count, 60)
		CU_ASSERT(curCapacity > 60)
		'' can't reserve down
		list.Reserve(30)
		CU_ASSERT_EQUAL(list.Count, 60)
		CU_ASSERT_EQUAL(list.Capacity, curCapacity)
		list.Reserve(-6)
		CU_ASSERT_EQUAL(list.Count, 60)
		CU_ASSERT_EQUAL(list.Capacity, curCapacity)
		list.Clear()
		curCapacity = list.Capacity
		For i = 0 To curCapacity - 1
			list.Add(i)
		Next
		CU_ASSERT_EQUAL(list.Capacity, list.Count)
		list.Add(89)
		CU_ASSERT((list.Capacity - list.Count) > 1)
	END_TEST
	
	TEST(Operators)
		dim list As LongList
		dim As Long first = 17525, second = 7854, third = 12
		CU_ASSERT_EQUAL(Len(list), list.Count)
		list += first
		CU_ASSERT_EQUAL(Len(list), list.Count)
		CU_ASSERT_EQUAL(Len(list), 1)
		CU_ASSERT_EQUAL(list[0], first)
		list += second
		CU_ASSERT_EQUAL(Len(list), list.Count)
		CU_ASSERT_EQUAL(Len(list), 2)
		CU_ASSERT_EQUAL(list[0], first)
		CU_ASSERT_EQUAL(list[1], second)
		list.Clear()
		CU_ASSERT_EQUAL(Len(list), list.Count)
		CU_ASSERT_EQUAL(Len(list), 0)
		list += third
		CU_ASSERT_EQUAL(Len(list), list.Count)
		CU_ASSERT_EQUAL(Len(list), 1)
		CU_ASSERT_EQUAL(list[0], third)
	END_TEST
	'' Don't forget to test that those added are independent variables
	'' not 'attached' to any added variables

END_SUITE

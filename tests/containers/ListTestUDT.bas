''#define FB_CONTAINER_DEBUG 1
#include "../../inc/containers/list.bi"
#include "ContainerTestPrereqs.bi"
#include "fbcunit.bi"

FBCont_DefineListOf(One, Two, IntegerHolder)
Type IntegerHolderList As FB_List(One, Two, IntegerHolder)

SUITE(fbc_tests.containers.lists.udt)
	TEST(ConstructorTest)
		'' check that these can compare equal, it's important
		Dim test as One.Two.IntegerHolder = Type(45)
		CU_ASSERT_EQUAL(test, test)
		
		dim i As Long
		dim emptyList As IntegerHolderList
		CU_ASSERT_EQUAL(emptyList.Count, 0)
		dim emptyIterator As SequentialIntegerHolderGenerator = Type(0, 1)

		Dim zt1NumToGenerate As Long = 21
		Dim zt1StartNum As Long = 0
		Dim zeroTo14Iterator As SequentialIntegerHolderGenerator = Type(zt1NumToGenerate, zt1StartNum)
		Dim tt2NumToGenerate As Long = 12
		Dim tt2StartNum As Long = 636369
		Dim twoHundred3To210Iterator As SequentialIntegerHolderGenerator = Type(tt2NumToGenerate, tt2StartNum)

		'' Iterator constructor
		Dim zt1List As IntegerHolderList = zeroTo14Iterator
		For i = 0 To zt1NumToGenerate - 1
			CU_ASSERT_EQUAL(zt1List[i].num, zt1StartNum + i)
		Next
		CU_ASSERT_EQUAL(zt1List.Count, zt1NumToGenerate)
		
		Dim tt2List As IntegerHolderList = twoHundred3To210Iterator
		For i = 0 To tt2NumToGenerate - 1
			CU_ASSERT_EQUAL(tt2List[i].num, tt2StartNum + i)
		Next
		CU_ASSERT_EQUAL(tt2List.Count, tt2NumToGenerate)
		
		zeroTo14Iterator.Reset()
		Dim zt1List2 As IntegerHolderList = zeroTo14Iterator
		For i = 0 To zt1NumToGenerate - 1
			CU_ASSERT_EQUAL(zt1List2[i].num, zt1List[i].num)
		Next
		CU_ASSERT_EQUAL(zt1List.Count, zt1List2.Count)
		
		twoHundred3To210Iterator.Reset()
		Dim tt2List2 As IntegerHolderList = twoHundred3To210Iterator
		For i = 0 To tt2NumToGenerate - 1
			CU_ASSERT_EQUAL(tt2List[i].num, tt2StartNum + i)
		Next
		CU_ASSERT_EQUAL(tt2List2.Count, tt2List.Count)
		
		dim newEmptyList As IntegerHolderList = emptyIterator
		CU_ASSERT_EQUAL(newEmptyList.Count, 0)
		emptyIterator.Reset()
		
		'' Container Constructor
		Dim zt1ListCopy As IntegerHolderList = zt1List
		For i = 0 To zt1List.Count - 1
			CU_ASSERT_EQUAL(zt1ListCopy[i].num, zt1List[i].num)
		Next
		CU_ASSERT_EQUAL(zt1ListCopy.Count, zt1List.Count)
		
		Dim tt2ListCopy As IntegerHolderList = tt2List
		For i = 0 To tt2List.Count - 1
			CU_ASSERT_EQUAL(tt2ListCopy[i].num, tt2List[i].num)
		Next
		CU_ASSERT_EQUAL(tt2ListCopy.Count, tt2List.Count)
		
		Dim fromEmptyContainerList As IntegerHolderList = @newEmptyList
		CU_ASSERT_EQUAL(fromEmptyContainerList.Count, 0)
		
		
		
		dim numArray(7) As One.Two.IntegerHolder
		dim numArrayLBound As Long = LBound(numArray)
		dim numArrayUBound As Long = UBound(numArray)
		dim arraySize As Long = numArrayUBound - numArrayLBound + 1
		For i = numArrayLBound To numArrayUBound
			numArray(i).num = i
		Next
		
		Dim arrayList As IntegerHolderList = numArray()
		For i = 0 To arraySize - 1
			CU_ASSERT_EQUAL(arrayList[i].num, numArray(numArrayLBound + i).num)
		Next
		CU_ASSERT_EQUAL(arrayList.Count, arraySize)
		
		
		dim numArrayBased(5 To 9) As One.Two.IntegerHolder
		numArrayLBound = LBound(numArrayBased)
		numArrayUBound = UBound(numArrayBased)
		arraySize = numArrayUBound - numArrayLBound + 1
		For i = numArrayLBound To numArrayUBound
			numArrayBased(i).num = i
		Next
		
		Dim arrayListBased As IntegerHolderList = numArrayBased()
		For i = 0 To arraySize - 1
			CU_ASSERT_EQUAL(arrayListBased[i].num, numArrayBased(numArrayLBound + i).num)
		Next
		CU_ASSERT_EQUAL(arrayListBased.Count, arraySize)
		
		dim undimmedArray(Any) As One.Two.IntegerHolder
		dim anyArrayList As IntegerHolderList = undimmedArray()
		CU_ASSERT_EQUAL(anyArrayList.Count, 0)

	END_TEST
	
	TEST(Add)
	
		'' single item
		dim i As Long
		dim singleItemList As IntegerHolderList
		dim holder1 As One.Two.IntegerHolder = (78)
		dim holder2 As One.Two.IntegerHolder = (-78)
		dim holder3 As One.Two.IntegerHolder = (123456)
		singleItemList.Add(holder1)
		singleItemList.Add(holder2)
		CU_ASSERT_EQUAL(singleItemList.Count, 2)
		CU_ASSERT_EQUAL(singleItemList[0], holder1)
		CU_ASSERT_EQUAL(singleItemList[1], holder2)
		singleItemList.Remove(holder1)
		singleItemList.Add(holder3)
		CU_ASSERT_EQUAL(singleItemList[0], holder2)
		CU_ASSERT_EQUAL(singleItemList[1], holder3)
		
		'' Whole Array Add
		dim emptyArray() As One.Two.IntegerHolder
		dim addArray(0 to 9) As One.Two.IntegerHolder
		dim As IntegerHolderList emptyList, arrayList
		'' undimmed arrays do nothing
		emptyList.Add(emptyArray())
		CU_ASSERT_EQUAL(emptyList.Count, 0)
		For i = 0 To 9
			addArray(i).num = i
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
		dim anotherList As IntegerHolderList
		dim invalidListPtr As IntegerHolderList Ptr = 0
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
		On Local Error Goto afterTest3
		anotherList.Add(invalidListPtr)
		CU_ASSERT_EQUAL(anotherListCount, anotherList.Count)
	afterTest3:
		
		'' Iterator Add
		dim emptyIterator As SequentialIntegerHolderGenerator = Type(0, 1)
		dim nullIterator As SequentialIntegerHolderGenerator Ptr = 0		
		emptyList.Add(emptyIterator)
		CU_ASSERT_EQUAL(emptyList.Count, 0)
		'' If we're compiling with -exx, it will raise an error
		'' so we need to catch that 
		On Local Error Goto afterTest4
		emptyList.Add(nullIterator)
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 1)
		CU_ASSERT_EQUAL(emptyList.Count, 0)
	afterTest4:
		On Local Error Goto 0

		Dim zt1NumToGenerate As Long = 15
		Dim zt1StartNum As Long = 0
		Dim zeroTo14Iterator As SequentialIntegerHolderGenerator = Type(zt1NumToGenerate, zt1StartNum)
		Dim tt2NumToGenerate As Long = 7
		Dim tt2StartNum As Long = 203
		Dim twoHundred3To210Iterator As SequentialIntegerHolderGenerator = Type(tt2NumToGenerate, tt2StartNum)

		Dim zt1List As IntegerHolderList
		zt1List.Add(zeroTo14Iterator)
		For i = 0 To zt1NumToGenerate - 1
			CU_ASSERT_EQUAL(zt1List[i].num, zt1StartNum + i)
		Next
		CU_ASSERT_EQUAL(zt1List.Count, zt1NumToGenerate)
		
		Dim tt2List As IntegerHolderList
		tt2List.Add(@twoHundred3To210Iterator)
		For i = 0 To tt2NumToGenerate - 1
			CU_ASSERT_EQUAL(tt2List[i].num, tt2StartNum + i)
		Next
		CU_ASSERT_EQUAL(tt2List.Count, tt2NumToGenerate)
		
		zeroTo14Iterator.Reset()
		Dim zt1List2 As IntegerHolderList
		zt1List2.Add(@zeroTo14Iterator)
		For i = 0 To zt1NumToGenerate - 1
			CU_ASSERT_EQUAL(zt1List2[i], zt1List[i])
		Next
		CU_ASSERT_EQUAL(zt1List.Count, zt1List2.Count)
		
		twoHundred3To210Iterator.Reset()
		Dim tt2List2 As IntegerHolderList
		tt2List2.Add(twoHundred3To210Iterator)
		For i = 0 To tt2NumToGenerate - 1
			CU_ASSERT_EQUAL(tt2List[i].num, tt2StartNum + i)
		Next
		CU_ASSERT_EQUAL(tt2List2.Count, tt2List.Count)
		
		dim newEmptyList As IntegerHolderList
		newEmptyList.Add(emptyIterator)
		CU_ASSERT_EQUAL(newEmptyList.Count, 0)
	
	END_TEST
	
	TEST(Clear)
		dim singleItemList As IntegerHolderList
		dim holder1 As One.Two.IntegerHolder = (78)
		dim holder2 As One.Two.IntegerHolder = (-78)
		singleItemList.Add(holder1)
		singleItemList.Add(holder2)
		singleItemList.Clear()
		CU_ASSERT_EQUAL(singleItemList.Count, 0)
		singleItemList.Clear()
		CU_ASSERT_EQUAL(singleItemList.Count, 0)
		dim list2 As IntegerHolderList	
		list2.Clear()
		CU_ASSERT_EQUAL(list2.Count, 0)
	END_TEST
	
	TEST(Contains)
		dim haystack As IntegerHolderList
		dim temp As One.Two.IntegerHolder
		dim needle As One.Two.IntegerHolder = (78)
		dim negativeNeedle As One.Two.IntegerHolder = (-needle.num)
		dim result As Boolean
		result = haystack.Contains(Type(0))
		CU_ASSERT_EQUAL(result, False)
		haystack.Add(needle)
		haystack.Add(negativeNeedle)
		temp.num = 52
		haystack.Add(temp)
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, True)
		haystack.Remove(needle)
		result = haystack.Contains(needle)
		CU_ASSERT_EQUAL(result, False)
		Dim generate100 As SequentialIntegerHolderGenerator = Type(100, 100)
		haystack.Add(@generate100)
		temp.num = 157
		result = haystack.Contains(temp)
		CU_ASSERT_EQUAL(result, True)
	END_TEST
	
	Private Sub CopyToOOBTest(ByRef list As IntegerHolderList, ByVal startPoint As Long)
		Dim i As Integer
		Dim arr(30 To 36) As One.Two.IntegerHolder
		For i = 30 To 36
			arr(i).num = i
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
			CU_ASSERT_EQUAL(arr(i).num, i)
		Next
		
		nextTest:
		On Local Error Goto 0
	End Sub
	
	Private Sub CopyToArrTest(_
		ByRef list As IntegerHolderList, _
		ByVal listStart As Long, _
		ByVal listCount As Long, _
		ByVal arrayStart As Long, _
		ByVal useDimmedArr As Boolean, _
		ByVal arrLDim As Long, _
		ByVal arrUDim As Long _
	)
		dim iterArr(Any) As One.Two.IntegerHolder
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
				iterArr(i).num = i
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
				CU_ASSERT_EQUAL(iterArr(arrLBound + i).num, arrLBound + i)
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
						CU_ASSERT_EQUAL(iterArr(i).num, arrIndex)
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
		dim singleItemList As IntegerHolderList
		dim i As Long
		dim temp As One.Two.IntegerHolder = (78)
		singleItemList.Add(temp)
		temp.num = -78
		singleItemList.Add(temp)
		temp.num = 8537536
		singleItemList.Add(temp)
		'' Undimmed arrays are redimmed to be the size of the container, from 0 To n-1
		dim undimmedArr(Any) As One.Two.IntegerHolder
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
		dim emptyList As IntegerHolderList
		dim emptyArr(Any) As One.Two.IntegerHolder
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
		dim largerThanContArr(10 To 14) As One.Two.IntegerHolder
		For i = 10 To 14
			largerThanContArr(i).num = i
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
			CU_ASSERT_EQUAL(largerThanContArr(i).num, IIf(i <= 12, singleItemList[i - 10].num, i))
		Next

		dim smallerThanContArr(21 To 22) As One.Two.IntegerHolder
		For i = 21 To 22
			smallerThanContArr(i).num = i
		Next
		temp.num = 4
		singleItemList.Add(temp)
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
		dim sihg As SequentialIntegerHolderGenerator = Type(100, 15)
		dim iterList As IntegerHolderList = sihg
		dim iterArr(Any) As One.Two.IntegerHolder
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
		dim list As IntegerHolderList
		dim temp As One.Two.IntegerHolder = (7)
		CU_ASSERT_EQUAL(list.Empty(), True)
		list.Add(temp)
		CU_ASSERT_EQUAL(list.Empty(), False)
		list.RemoveAt(0)
		CU_ASSERT_EQUAL(list.Empty(), True)
		Dim arr(0 To 1) As One.Two.IntegerHolder
		list.Insert(0, arr())
		CU_ASSERT_EQUAL(list.Empty(), False)
		list.RemoveAt(0)
		CU_ASSERT_EQUAL(list.Empty(), False)
		list.Clear()
		CU_ASSERT_EQUAL(list.Empty(), True)
	END_TEST
	
	TEST(FirstTest)
		dim list As IntegerHolderList
		dim temp As One.Two.IntegerHolder
		'' Out of bounds calls Error with FB_CONTAINER_DEBUG
		On Local Error Goto afterError
		dim first As One.Two.IntegerHolder = list.First()
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6) '' out of bounds
	afterError:
		temp.num = 7
		list.Add(temp)
		CU_ASSERT_EQUAL(list.First().num, 7)
		temp.num = 9
		list.Add(temp)
		CU_ASSERT_EQUAL(list.First().num, 7)
		list.RemoveAt(0)
		CU_ASSERT_EQUAL(list.First().num, 9)
		Dim arr(0 To 1) As One.Two.IntegerHolder
		list.Insert(0, arr())
		CU_ASSERT_EQUAL(list.First().num, 0)
		list.RemoveAt(1)
		CU_ASSERT_EQUAL(list.First().num, 0)
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
		dim list As IntegerHolderList
		dim temp As One.Two.IntegerHolder = (7)
		dim pListIter As FB_IIterator(One, Two, IntegerHolder) Ptr = list.GetIterator()
		CU_ASSERT(pListIter <> 0)
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
		pListIter = 0
		list.Add(temp)
		pListIter = list.GetIterator()
		dim pListIter2 As FB_IIterator(One, Two, IntegerHolder) Ptr = list.GetIterator()
		CU_ASSERT(pListIter <> 0)
		CU_ASSERT(pListIter2 <> 0)
		CU_ASSERT(pListIter <> pListIter2)
		CU_ASSERT(pListIter->Advance() = True)
		CU_ASSERT_EQUAL(pListIter->Item().num, 7)
		CU_ASSERT(pListIter2->Advance() = True)
		CU_ASSERT_EQUAL(pListIter->Item().num, 7)
		CU_ASSERT_EQUAL(pListIter2->Item().num, 7)
		Delete pListIter
		Delete pListIter2
		pListIter = 0
		pListIter2 = 0
		list.Clear()
		Dim arr(0 To 6) As One.Two.IntegerHolder
		Dim i As Long
		For i = 0 To 6
			arr(i).num = i
		Next
		list.Add(arr())
		pListIter = list.GetIterator()
		CU_ASSERT(pListIter <> 0)
		For i = 0 To 6
			CU_ASSERT(pListIter->Advance() = True)
			CU_ASSERT_EQUAL(pListIter->Item().num, i)
		Next
		CU_ASSERT(pListIter->Advance() = False)
		Delete pListIter
	END_TEST
	
	TEST(IndexOf)
		dim list As IntegerHolderList
		dim temp As One.Two.IntegerHolder = (65)
		dim i As Long
		CU_ASSERT_EQUAL(list.IndexOf(Type(0)), -1)
		list.Add(temp) '' 0
		temp.num = 65 : list.Add(temp) '' 1
		temp.num = 0 : list.Add(temp) '' 2
		temp.num = 85 : list.Add(temp) '' 3
		temp.num = 69 : list.Add(temp) '' 4
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
		temp.num = 65 : list.Add(temp)
		CU_ASSERT_EQUAL(list.IndexOf(Type(65)), 0)
		CU_ASSERT_EQUAL(list.IndexOf(Type(58)), -1)
	END_TEST
	
	Private Sub InsertArrTest(ByRef theList As IntegerHolderList, byVal where As Long, arr() As One.Two.IntegerHolder, ByVal arrStartPoint As Long, ByVal howMany As Long, byVal useSimpler As Boolean)
		dim i As Long
		dim originalListCopy As IntegerHolderList = theList
		dim origIter As Long = 0
		dim localErr As Long
		dim curSize As Long = theList.Count
		dim arrLBound As Long = LBound(arr)
		dim arrUBound As Long = UBound(arr)
		dim numElems As Long = (arrUBound - arrLBound) + 1
		'' InsertArrTest(theList, theList.Count, goodArray(), 53, 1, False)
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
			CU_ASSERT_EQUAL(localErr, Iif(numElems = 0, 1, 6))
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
		dim theList As IntegerHolderList
		dim temp As One.Two.IntegerHolder = (50)
		dim count As Long = theList.Count
		theList.Insert(-1, temp) '' 50
		CU_ASSERT(theList.Count > count)
		CU_ASSERT_EQUAL(theList.Count, 1)
		temp.num = 51 : theList.Insert(0, temp) '' 51, 50
		CU_ASSERT_EQUAL(theList.Count, 2)
		CU_ASSERT_EQUAL(theList[0].num, 51)
		CU_ASSERT_EQUAL(theList.Last().num, 50)
		temp.num = 52 : theList.Insert(1, temp) '' 51, 52, 50
		CU_ASSERT_EQUAL(theList.Count, 3)
		CU_ASSERT_EQUAL(theList[1], temp)
		temp.num = 50
		CU_ASSERT_EQUAL(theList[2], temp)
		CU_ASSERT_EQUAL(theList.Last().num, 50)
		On Local Error Goto afterTest1
		Err = 0
		'' out of bounds insert position (except for -1 or Count) causes Error() in -exx builds
		temp.num = 43 : theList.Insert(43, temp)
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6)
		CU_ASSERT_EQUAL(theList.Count, 3)
		CU_ASSERT_EQUAL(theList[0].num, 51)
		CU_ASSERT_EQUAL(theList[2].num, 50)
		CU_ASSERT_EQUAL(theList.Last().num, 50)
	afterTest1:
		On Local Error Goto 0
		temp.num = 53 : theList.Insert(-1, temp) '' 51, 52, 50, 53
		theList.Insert(0, temp) '' 53, 51, 52, 50, 53
		CU_ASSERT_EQUAL(theList.Count, 5)
		CU_ASSERT_EQUAL(theList.First(), temp)
		CU_ASSERT_EQUAL(theList[1].num, 51)
		CU_ASSERT_EQUAL(theList[2].num, 52)
		CU_ASSERT_EQUAL(theList[3].num, 50)
		CU_ASSERT_EQUAL(theList.Last(), temp)
	End Sub
	
	Private Sub InsertContainerTest(Byref list As IntegerHolderList, ByRef secondList As IntegerHolderList, ByVal insertPos As Long, ByVal byPtr As Boolean)
		dim origCount As Long = list.Count
		dim originalListCopy As IntegerHolderList = list
		dim secondListCopy As IntegerHolderList = secondList
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
	
	Private Sub InsertIteratorTest(Byref list As IntegerHolderList, ByRef iterator As SequentialIntegerHolderGenerator, ByVal insertPos As Long, ByVal byPtr As Boolean)
		dim origCount As Long = list.Count
		dim originalListCopy As IntegerHolderList = list
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
			goto commonError '' didn't insert any
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
		dim theList As IntegerHolderList
		dim emptyArray(Any) As One.Two.IntegerHolder
		dim dynArray(Any) As One.Two.IntegerHolder
		Dim goodArray(50 To 54) As One.Two.IntegerHolder
		Dim i As Long
		For i = 50 To 54
			goodArray(i).num = i
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
		theList.Clear()
		'' insert good array after clear
		InsertArrTest(theList, 0, goodArray(), 0, 0, True)
		theList.Clear()
		dim temp As One.Two.IntegerHolder = (6)
		theList.Add(temp)
		temp.num = 60 : theList.Add(temp)
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
		dim secondList As IntegerHolderList
		dim thirdList As IntegerHolderList
		secondList.Add(goodArray())
		temp.num = 75475 : thirdList.Add(temp)
		temp.num = 924384 : thirdList.Add(temp)
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
		dim nullCont As IntegerHolderList Ptr = 0
		Err = 0
		On Local Error Goto continueTest1
		secondList.Insert(0, nullCont)
		dim localErr As Long = Err
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
		dim slg As SequentialIntegerHolderGenerator = Type(8, 678)
		dim emptyGen As SequentialIntegerHolderGenerator = Type(0, 123)
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
		dim nullIter As FB_IIterator(One, Two, IntegerHolder) Ptr = 0
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
		dim list As IntegerHolderList
		dim temp As One.Two.IntegerHolder
		'' Out of bounds calls Error with FB_CONTAINER_DEBUG
		On Local Error Goto afterError
		Err = 0
		dim last As One.Two.IntegerHolder = list.Last()
		dim localErr As Long = Err
		CU_ASSERT_EQUAL(localErr, 6) '' out of bounds
	afterError:
		temp.num = 7 : list.Add(temp)
		CU_ASSERT_EQUAL(list.Last().num, 7)
		temp.num = 9 : list.Add(temp)
		CU_ASSERT_EQUAL(list.Last().num, 9)
		list.RemoveAt(0)
		CU_ASSERT_EQUAL(list.Last().num, 9)
		Dim arr(0 To 1) As One.Two.IntegerHolder
		list.Insert(-1, arr())
		CU_ASSERT_EQUAL(list.Last().num, 0)
		list.RemoveAt(list.Count - 1)
		CU_ASSERT_EQUAL(list.Last().num, 0)
		list.Clear()
		Err = 0
		On Local Error Goto afterError2
		dim first As One.Two.IntegerHolder = list.Last()
		localErr = Err
		CU_ASSERT_EQUAL(localErr, 6) '' out of bounds
	afterError2:
		On Local Error Goto 0
	END_TEST
	
	TEST(LastIndexOf)
		dim list As IntegerHolderList
		dim i As Long
		dim temp As One.Two.IntegerHolder = (0)
		CU_ASSERT_EQUAL(list.LastIndexOf(temp), -1)
		temp.num = 65 : list.Add(temp) '' 0
		list.Add(temp) '' 1
		temp.num = 0 : list.Add(temp) '' 2
		temp.num = 85 : list.Add(temp) '' 3
		temp.num = 65 : list.Add(temp) '' 4
		temp.num = 69 : list.Add(temp) '' 5
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
		temp.num = 65 : list.Add(temp)
		CU_ASSERT_EQUAL(list.LastIndexOf(temp), list.Count - 1)
		temp.num = 58 : CU_ASSERT_EQUAL(list.LastIndexOf(temp), -1)
	END_TEST
	
	TEST(Remove)
		dim list As IntegerHolderList
		dim sixtyFive As One.Two.IntegerHolder = (65)
		dim temp As One.Two.IntegerHolder
		list.Add(sixtyFive) '' 0
		temp.num = 0 : list.Add(temp) '' 1
		temp.num = 85 : list.Add(temp) '' 2
		list.Add(sixtyFive) '' 3
		temp.num = 69 : list.Add(temp) '' 4
		
		'' remove a duplicate
		temp.num = 65 : list.Remove(temp)
		CU_ASSERT_EQUAL(list.Count, 4)
		CU_ASSERT(list[0].num <> 65)
		CU_ASSERT_EQUAL(list.Contains(sixtyFive), True) '' because there were two, and remove only removes the first
		'' remove a single
		list.Remove(sixtyFive)
		CU_ASSERT_EQUAL(list.Count, 3)
		CU_ASSERT(list[0].num <> 65)
		CU_ASSERT(list[2].num <> 65)
		CU_ASSERT_EQUAL(list.Contains(sixtyFive), False) '' because there was one, and now there isn't
		'' remove a non-existant
		list.Remove(sixtyFive) '' this shouldn't do anything
		CU_ASSERT_EQUAL(list.Count, 3)
		CU_ASSERT_EQUAL(list.Contains(sixtyFive), False)
		
		dim emptyList As IntegerHolderList
		temp.num = 0 : emptyList.Remove(temp)
		CU_ASSERT_EQUAL(emptyList.Empty(), True)
	END_TEST
	
	TEST(RemoveAt)
		dim list As IntegerHolderList
		dim arrItems(10 To 20) As One.Two.IntegerHolder
		dim i As Long
		dim localErr As Long
		For i = 10 To 20
			arrItems(i).num = i
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
		dim emptyList As IntegerHolderList
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
		dim slg As SequentialIntegerHolderGenerator = Type(100, 55)
		dim list As IntegerHolderList = slg
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
		dim list As IntegerHolderList
		dim localErr As Long
		CU_ASSERT_EQUAL(list.Count, 0)
		list.Resize(6)
		CU_ASSERT_EQUAL(list.Count, 6)
		For i = 0 To list.Count - 1
			CU_ASSERT_EQUAL(list[i].num, 0)
		Next
		list.Resize(3)
		CU_ASSERT_EQUAL(list.Count, 3)
		For i = 0 To list.Count - 1
			CU_ASSERT_EQUAL(list[i].num, 0)
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
			CU_ASSERT_EQUAL(list[i].num, 0)
			list[i].num = i
		Next
		list.Resize(20)
		For i = 0 To list.Count - 1
			CU_ASSERT_EQUAL(list[i].num, IIf(i < 10, i, 0))
		Next		
	END_TEST
	
	TEST(ReserveCapacity)
		dim list As IntegerHolderList
		dim temp As One.Two.IntegerHolder
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
			temp.num = i
			list.Add(temp)
		Next
		CU_ASSERT_EQUAL(list.Capacity, list.Count)
		temp.num = 89 : list.Add(temp)
		CU_ASSERT((list.Capacity - list.Count) > 1)
	END_TEST
	
	TEST(Operators)
		dim list As IntegerHolderList
		dim As One.Two.IntegerHolder first = (17525), second = (7854), third = (12)
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
	
	'' This asserts that the items in the list are copies
	'' and not linked to the added variable
	TEST(Independence)
		dim list As IntegerHolderList
		dim As One.Two.IntegerHolder first = (17525), second = (7854), third = (12)
		list.Add(first)
		CU_ASSERT_EQUAL(list[0], first)
		first.num = 1
		CU_ASSERT(list[0].num <> first.num)
		list[0].num = 98
		CU_ASSERT(first.num <> 98)
		list.Add(second)
		dim oldSecond As One.Two.IntegerHolder = second
		CU_ASSERT_EQUAL(list[1], second)
		list.Clear()
		CU_ASSERT_EQUAL(second, oldSecond)
	END_TEST

END_SUITE

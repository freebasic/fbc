#include "fbcunit.bi"
#include "..\..\inc\fbthread.bi"

#ifndef ENABLE_CHECK_BUGS
#define ENABLE_CHECK_BUGS 0
#endif

SUITE( fbc_tests.threads.self )

	'' Tests whether ThreadSelf in a created thread is equal to the 
	'' return of ThreadCreate, which it should
	TEST_GROUP( idBasic )
		const NUM_THREADS = 100

		declare sub cb( byval ta as any ptr )

		sub test_proc
			dim htb(0 to NUM_THREADS-1) as any ptr
			dim selfThreadIds(0 to NUM_THREADS-1) as any ptr
			dim i as integer

			for i = 0 to NUM_THREADS-1
				htb(i) = threadcreate( @cb, @selfThreadIds(i) )
				if( htb(i) = 0 ) then
					CU_FAIL_FATAL( "ThreadSelf test error launching thread:" & i )
					end
				end if
			next i

			for i = 0 to NUM_THREADS-1
				threadwait( htb(i) )
				CU_ASSERT_EQUAL(htb(i), selfThreadIds(i))
			next
		end sub

		sub cb( byval ta as any ptr )
			Dim selfIdPtr As Any Ptr Ptr = ta
			*selfIdPtr = ThreadSelf()
		end sub

		TEST( idsMatch )
			test_proc
		END_TEST

		TEST( mainHasId )
			CU_ASSERT_NOT_EQUAL(threadself(), 0)
		END_TEST

	END_TEST_GROUP

'' Dos doesn't have detach
#ifndef __FB_DOS__
	'' Test that detached threads still have a self that
	'' is valid
	TEST_GROUP( idsDetach )
		const NUM_THREADS = 100
		dim shared g_incrementMutex As Any Ptr
		dim shared g_threadsFinished As Integer
		dim shared g_waitForDetachMutex As Any Ptr

		declare sub cb( byval ta as any ptr )

		sub test_proc2
			dim htb(0 to NUM_THREADS-1) as any ptr
			dim selfThreadIds(0 to NUM_THREADS-1) as any ptr
			dim i as integer
			dim finished as integer = 0

			g_incrementMutex = MutexCreate()
			g_waitForDetachMutex = MutexCreate()
			g_threadsFinished = 0

			MutexLock(g_waitForDetachMutex)

			for i = 0 to NUM_THREADS-1
				htb(i) = threadcreate( @cb, @selfThreadIds(i) )
				if( htb(i) = 0 ) then
					CU_FAIL_FATAL( "ThreadSelf test error launching thread:" & i )
					end
				end if
				ThreadDetach(htb(i))
			next i

			MutexUnlock(g_waitForDetachMutex)
			
			while (finished < NUM_THREADS)
				Sleep 1000
				MutexLock(g_incrementMutex)
				finished = g_threadsFinished
				MutexUnlock(g_incrementMutex)
			Wend

			for i = 0 to NUM_THREADS-1
				CU_ASSERT_EQUAL(htb(i), selfThreadIds(i))
			next

			MutexDestroy(g_waitForDetachMutex)
			MutexDestroy(g_incrementMutex)
		end sub

		sub cb( byval ta as any ptr )
			Dim selfIdPtr As Any Ptr Ptr = ta
			MutexLock(g_waitForDetachMutex)
			MutexUnlock(g_waitForDetachMutex)
			*selfIdPtr = ThreadSelf()
			MutexLock(g_incrementMutex)
			g_threadsFinished += 1
			MutexUnlock(g_incrementMutex)
		end sub

		TEST(detachThreads)
			test_proc2
		END_TEST

'' - don't check ThreadDetach on main thread in the debug version
'' - debug asserts in libfbrt will throw an error if the caller tries to detach the main thread
'' - the test-suite can't recover from this type of failure so must be disabled
'' - maybe in future if ON ERROR is made to work, we can catch the debug assert
#if (not defined( __FB_DEBUG__ )) or (ENABLE_CHECK_BUGS<>0)
		'' Waiting/detaching the main thread shouldn't do anything
		TEST(mainThreadDetach)
			Dim tid as Any Ptr = ThreadSelf()
			ThreadDetach(tid)
			Dim tid2 As Any Ptr = ThreadSelf()
			CU_ASSERT_EQUAL(tid, tid2)
		END_TEST

		TEST(mainThreadWait)
			Dim tid as Any Ptr = ThreadSelf()
			CU_PRINT( "ThreadSelf test waiting for main thread, if success message isn't printed below, this test failed" )
			ThreadWait(tid)
			CU_PRINT( "ThreadSelf test success" )
			Dim tid2 As Any Ptr = ThreadSelf()
			CU_ASSERT_EQUAL(tid, tid2)
		END_TEST

		'' Make sure nothing weird happens with doing them both whichever way round
		TEST(mainThreadDetachWait)
			Dim tid as Any Ptr = ThreadSelf()
			ThreadDetach(tid)
			ThreadWait(tid)
			Dim tid2 As Any Ptr = ThreadSelf()
			CU_ASSERT_EQUAL(tid, tid2)
		END_TEST

		TEST(mainThreadWaitDetach)
			Dim tid as Any Ptr = ThreadSelf()
			ThreadWait(tid)
			ThreadDetach(tid)
			Dim tid2 As Any Ptr = ThreadSelf()
			CU_ASSERT_EQUAL(tid, tid2)
		END_TEST
#endif

	END_TEST_GROUP
#endif '' FB_DOS

	'' These test that ThreadDetach/Wait still work after the
	'' threads have actually exited
	TEST_GROUP( DetachWaitAfterExit )
		const NUM_THREADS = 100
		dim shared g_incrementMutex As Any Ptr
		dim shared g_threadsFinished As Integer
		dim shared g_waitForDetachMutex As Any Ptr

		declare sub cb( byval ta as any ptr )

		sub test_proc3 ( ByVal threadEnder As Sub (ByVal tid As Any Ptr) )
			dim htb(0 to NUM_THREADS-1) as any ptr
			dim i as integer
			dim finished as integer = 0

			g_incrementMutex = MutexCreate()
			g_threadsFinished = 0

			for i = 0 to NUM_THREADS-1
				htb(i) = threadcreate( @cb )
				if( htb(i) = 0 ) then
					CU_FAIL_FATAL( "ThreadSelf test error launching thread:" & i )
					While i >= 0
						ThreadWait(htb(i))
						i -= 1
					Wend
					end
				end if
			next i
			
			while (finished < NUM_THREADS)
				Sleep 1000
				MutexLock(g_incrementMutex)
				finished = g_threadsFinished
				MutexUnlock(g_incrementMutex)
			Wend

			MutexDestroy(g_incrementMutex)

			Sleep 1000 '' simple attempt to try and ensure the threads have truly exited

			for i = 0 to NUM_THREADS-1
				threadEnder(htb(i))
			next
		end sub

		sub cb( byval ta as any ptr )
			MutexLock(g_incrementMutex)
			g_threadsFinished += 1
			MutexUnlock(g_incrementMutex)
		end sub

#ifndef __FB_DOS__
		TEST(detachThreads)
			test_proc3(@ThreadDetach)
		END_TEST
#endif

		TEST(WaitThreads)
			test_proc3(@ThreadWait)
		END_TEST
	END_TEST_GROUP
END_SUITE

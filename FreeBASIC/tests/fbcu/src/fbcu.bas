/'::

	fbcu.bas : implementation of user interface

::'/

# include once "fbcu-common.bi"
# include once "fbcu-impl.bi"

namespace fbcu

	':: add_suite

	sub add_suite(byref sname as string, byval init as CU_InitializeFunc = 0, byval cleanup as CU_CleanupFunc = 0)
	
	# if not defined (FBCU_CONFIG_COMPILEONLY)
		check_fbcu_initialization()
		
		dim result as CU_pSuite = CU_add_suite(sname, init, cleanup)
		if (NULL = result) then
			fbcu_ctx.status_ = fbcu_error
			fbcu_ctx.errorCond_ = fbcu_err_addingSuite
			return
		end if
		
		fbcu_ctx.regSuite_ = result
	# endif
	
	end sub
	
	':: add_test

	sub add_test(byref sname as string, byval test as CU_TestFunc)

	# if not defined (FBCU_CONFIG_COMPILEONLY)
		check_fbcu_initialization()
		
		if (fbcu_ctx.status_ <> fbcu_ready) then
			':: TODO: debugging
		end if
		
		dim result as CU_pTest = CU_add_test(fbcu_ctx.regSuite_, sname, test)
		if (NULL = result) then
			fbcu_ctx.status_ = fbcu_error
			fbcu_ctx.errorCond_ = fbcu_err_addingTest
			return
		end if
	# endif

	end sub

end namespace

		':: main entry point
# if not defined (FBCU_CONFIG_COMPILEONLY)
		fbcu.run_tests()
# endif

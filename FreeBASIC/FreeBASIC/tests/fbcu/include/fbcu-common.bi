'// fbcu-common.bi : write me
'//
'// this is an internal header used by fbcu,
'// and should not be included directly

# ifndef FB_CU_COMMON_BI
# define FB_CU_COMMON_BI

# include once "CUnit/CUnit.bi"
# include once "CUnit/Automated.bi"
# include once "CUnit/Basic.bi"
# include once "CUnit/Console.bi"

# include once "fbcu-config.bi"

namespace fbcu

	enum fbcu_ErrorCode
		fbcu_err_noError
		fbcu_err_memoryAllocationFailed
		fbcu_err_regInitFailed
		fbcu_err_addingSuite
		fbcu_err_addingTest
	end enum
	
	enum fbcu_Status
		fbcu_uninitialized
		fbcu_initializing
		fbcu_ready
		fbcu_testing
		fbcu_error
	end enum
	
	type fbcu_Context
		errorCond_		as fbcu_ErrorCode
		status_			as fbcu_Status
		
		regSuite_		as CU_pSuite
	end type

	extern fbcu_ctx as fbcu_Context

end namespace

# endif	'## include guard

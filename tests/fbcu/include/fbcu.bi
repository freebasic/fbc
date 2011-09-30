'// fbcu.bi : end-user interface
'//
'// include this file with your programs

# include "fbcu-common.bi"

namespace fbcu

	declare sub add_suite (byref as string, byval as CU_InitializeFunc = 0, byval as CU_CleanupFunc = 0)
	declare sub add_test (byref as string, byval as CU_TestFunc)

end namespace

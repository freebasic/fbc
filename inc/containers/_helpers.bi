#include once "../fbc-int/array.bi"
#pragma once

Namespace __CONT_Internals

	Private Function GetArrayInfo(ByVal pArrData As FBC.FBARRAY Ptr, Byref arrLBound As Long, Byref arrUBound As Long) As Long
		dim pFirstDim As FBC.FBARRAYDIM Ptr = @pArrData->dimTb(0)
		arrLBound = pFirstDim->lbound
		arrUBound = pFirstDim->ubound
		Return pFirstDim->elements

	End Function
	
	Private Function IsValidArray(ByVal pArrData As FBC.FBARRAY Ptr) As Boolean

		Return pArrData->dimTb(0).elements > 0

	End Function
	
'' This is a define so that in the unhandled Error case
'' the line and file name printed when the Error is unhandled 
'' are the statement in the appropriate container bi & function
'' rather than just _helpers.bi which wouldn't be particularly helpful
#ifdef FB_CONTAINER_DEBUG
#define __CONT_Internals_SetError(errNum) Error (err)
#else
#define __CONT_Internals_SetError(errNum) Err = errNum
#endif
	
#ifdef FB_CONTAINER_DEBUG
	Dim Shared g_stopRecursiveLoggingFlag As Boolean = False
#endif

End Namespace

#define __CONT_GetArrayInfo(array, lBoundOut, uBoundOut) __CONT_Internals.GetArrayInfo(FBC.ArrayDescriptorPtr(array()), lBoundOut, uBoundOut)
#define __CONT_IsValidArray(array) __CONT_Internals.IsValidArray(FBC.ArrayDescriptorPtr(array()))

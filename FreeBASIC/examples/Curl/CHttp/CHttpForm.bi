#ifndef __CHTTPFORM_BI__
#define __CHTTPFORM_BI__

type CHttpForm as CHttpForm_


declare function 	CHttpForm_New				( _
												  byval _this as CHttpForm ptr = NULL _
												) as CHttpForm ptr

declare sub 		CHttpForm_Delete			( _
												  byval _this as CHttpForm ptr, _
											  	  byval isstatic as integer = FALSE _
											  	)
											  	  
declare function 	CHttpForm_Add 				overload ( _
												  byval _this as CHttpForm ptr, _
												  byval name_ as zstring ptr, _
												  byval value as zstring ptr, _
												  byval _type as zstring ptr = NULL _
												) as integer

declare function 	CHttpForm_Add 				( _
												  byval _this as CHttpForm ptr, _
												  byval name_ as zstring ptr, _
												  byval value as integer _
												) as integer

declare function 	CHttpForm_GetHandle 		( _
												  byval _this as CHttpForm ptr _
												) as any ptr

#endif
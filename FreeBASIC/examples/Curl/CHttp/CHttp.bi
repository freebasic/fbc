#ifndef __CHTTP_BI__
#define __CHTTP_BI__

#ifndef NULL
#define NULL 0
#endif

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

#inclib "CHttp"
#inclib "curl"

type CHttp as CHttp_

#include once "CHttpStream.bi"
#include once "CHttpForm.bi"


declare function 	CHttp_New					( _
												  byval _this as CHttp ptr = NULL _
												) as CHttp ptr

declare sub 		CHttp_Delete				( _
												  byval _this as CHttp ptr, _
											  	  byval isstatic as integer = FALSE _
												)
										  
declare function 	CHttp_Post					( _
												  byval _this as CHttp ptr, _
												  byval url as zstring ptr, _
												  byval form as CHttpForm ptr _
												) as string

declare function 	CHttp_GetHandle 			( _
												  byval _this as CHttp ptr _
												) as any ptr


#endif
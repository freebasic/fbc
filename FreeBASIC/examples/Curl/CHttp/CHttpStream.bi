#ifndef __CHTTPSTREAM_BI__
#define __CHTTPSTREAM_BI__

type CHttpStream as CHttpStream_


declare function 	CHttpStream_New				( _
												  byval http as CHttp ptr = NULL, _
												  byval _this as CHttpStream ptr = NULL _
												) as CHttpStream ptr

declare sub 		CHttpStream_Delete			( _
												  byval _this as CHttpStream ptr, _
											  	  byval isstatic as integer = FALSE _
												)
										  
declare function 	CHttpStream_Receive 		( _
												  byval _this as CHttpStream ptr, _
												  byval url as zstring ptr, _
												  byval doreset as integer = TRUE _
											    ) as integer


declare function 	CHttpStream_Read 			( _
												  byval _this as CHttpStream ptr _
												) as string

declare function 	CHttpStream_Send 			( _
												  byval _this as CHttpStream ptr, _
												  byval url as zstring ptr, _
												  byval data_ as any ptr, _
												  byval bytes as integer, _
												  byval doreset as integer = TRUE _
											    ) as integer

#endif
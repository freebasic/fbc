#ifndef __utf_conv_bi__
#define __utf_conv_bi__

enum UTF_ENCOD
	UTF_ENCOD_ASCII
	UTF_ENCOD_UTF8
	UTF_ENCOD_UTF16
	UTF_ENCOD_UTF32
end enum

declare function CharToUTF cdecl alias "fb_CharToUTF" 		( byval encod as UTF_ENCOD, _
															  byval src as zstring ptr, _
															  byval chars as integer, _
															  byval dst as any ptr, _
															  byval bytes as integer ptr ) as any ptr

declare function WCharToUTF cdecl alias "fb_WCharToUTF" 	( byval encod as UTF_ENCOD, _
															  byval src as wstring ptr, _
															  byval chars as integer, _
															  byval dst as any ptr, _
															  byval bytes as integer ptr ) as any ptr
					
declare function UTFToChar cdecl alias "fb_UTFToChar" 		( byval encod as UTF_ENCOD, _
															  byval src as any ptr, _
															  byval dst as zstring ptr, _
															  byval chars as integer ptr ) as zstring ptr

declare function UTFToWChar cdecl alias "fb_UTFToWChar" 	( byval encod as UTF_ENCOD, _
															  byval src as any ptr, _
															  byval dst as wstring ptr, _
															  byval chars as integer ptr ) as wstring ptr



#endif '' __utf_conv_bi__
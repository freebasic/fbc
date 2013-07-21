#pragma once

enum UTF_ENCOD
	UTF_ENCOD_ASCII
	UTF_ENCOD_UTF8
	UTF_ENCOD_UTF16
	UTF_ENCOD_UTF32
end enum

extern "C"

declare function CharToUTF alias "fb_CharToUTF" _
	( _
		byval encod as long, _ '' UTF_ENCOD
		byval src as zstring ptr, _
		byval chars as integer, _
		byval dst as any ptr, _
		byval bytes as integer ptr _
	) as any ptr

declare function WCharToUTF alias "fb_WCharToUTF" _
	( _
		byval encod as long, _ '' UTF_ENCOD
		byval src as wstring ptr, _
		byval chars as integer, _
		byval dst as any ptr, _
		byval bytes as integer ptr _
	) as any ptr

declare function UTFToChar alias "fb_UTFToChar" _
	( _
		byval encod as long, _ '' UTF_ENCOD
		byval src as any ptr, _
		byval dst as zstring ptr, _
		byval chars as integer ptr _
	) as zstring ptr

declare function UTFToWChar alias "fb_UTFToWChar" _
	( _
		byval encod as long, _ '' UTF_ENCOD
		byval src as any ptr, _
		byval dst as wstring ptr, _
		byval chars as integer ptr _
	) as wstring ptr

end extern

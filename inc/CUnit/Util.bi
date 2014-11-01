#pragma once

#include once "CUnit.bi"

extern "C"

#define CUNIT_UTIL_H_SEEN
#define CUNIT_MAX_ENTITY_LEN 5

declare function CU_translate_special_characters(byval szSrc as const zstring ptr, byval szDest as zstring ptr, byval maxlen as uinteger) as uinteger
declare function CU_translated_strlen(byval szSrc as const zstring ptr) as uinteger
declare function CU_compare_strings(byval szSrc as const zstring ptr, byval szDest as const zstring ptr) as long
declare sub CU_trim_left(byval szString as zstring ptr)
declare sub CU_trim_right(byval szString as zstring ptr)
declare sub CU_trim(byval szString as zstring ptr)
declare function CU_number_width(byval number as long) as uinteger

end extern

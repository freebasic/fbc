#ifndef __COMMON_BI__
#define __COMMON_BI__

#ifndef NULL
#define NULL 0
#endif

#ifndef FALSE
const FALSE = 0
#endif

#ifndef TRUE
const TRUE = not FALSE
#endif

type rect_t
	x as integer
	y as integer
	w as integer
	h as integer
end type

declare function FixPath( byval filename as zstring ptr ) as string

#endif

#ifndef __COMMON_BI__
#define __COMMON_BI__

#define NULL 0

type rect_t
	x as integer
	y as integer
	w as integer
	h as integer
end type

declare function FixPath( byval filename as zstring ptr ) as string

#endif

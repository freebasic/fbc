#ifdef BOOLEAN
'' fbc sources do not use the boolean datatype and therefore
'' probably shouldn't use the intrinsic false/true constants,
'' so undef the built-in false/true constants and #define
'' the values expected (jeffm - july 2015)
#undef FALSE
#undef TRUE
#endif
#define FALSE 0
#define TRUE (-1)
#define NULL 0
declare function xallocate(byval as long) as any ptr
declare function xcallocate(byval as long) as any ptr
declare function xreallocate(byval as any ptr, byval as long) as any ptr

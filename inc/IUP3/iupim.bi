/'** \file
 * \brief Utilities using IM
 *
 * See Copyright Notice in "iup.bi"
 *'/

#ifndef __iupim_bi__
#define __iupim_bi__

#inclib "im"

extern "C"

declare function IupLoadImage (byval file_name as zstring ptr) as Ihandle ptr
declare function IupSaveImage (byval ih as Ihandle ptr, byval file_name as zstring ptr, byval format as zstring ptr) as integer


#ifdef __IM_IMAGE_BI
declare function IupGetNativeHandleImage(byval handle as any ptr) as imImage ptr
declare function IupGetImageNativeHandle(byval image as imImage ptr) as any ptr
#endif

end extern

#endif

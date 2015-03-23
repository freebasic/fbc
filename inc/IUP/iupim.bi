#pragma once

extern "C"

#define __IUPIM_H
declare function IupLoadImage(byval file_name as const zstring ptr) as Ihandle ptr
declare function IupSaveImage(byval ih as Ihandle ptr, byval file_name as const zstring ptr, byval format as const zstring ptr) as long

#ifdef __IM_IMAGE_H
	declare function IupGetNativeHandleImage(byval handle as any ptr) as imImage ptr
	declare function IupGetImageNativeHandle(byval image as const imImage ptr) as any ptr
	declare function IupImageFromImImage(byval image as const imImage ptr) as Ihandle ptr
#endif

end extern

''
''
'' atkimage -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkimage_bi__
#define __atkimage_bi__

#include once "gtk/atk/atkobject.bi"
#include once "gtk/atk/atkutil.bi"

type AtkImage as _AtkImage
type AtkImageIface as _AtkImageIface

type _AtkImageIface
	parent as GTypeInterface
	get_image_position as sub cdecl(byval as AtkImage ptr, byval as gint ptr, byval as gint ptr, byval as AtkCoordType)
	get_image_description as function cdecl(byval as AtkImage ptr) as gchar
	get_image_size as sub cdecl(byval as AtkImage ptr, byval as gint ptr, byval as gint ptr)
	set_image_description as function cdecl(byval as AtkImage ptr, byval as string) as gboolean
	pad1 as AtkFunction
	pad2 as AtkFunction
end type

declare function atk_image_get_type cdecl alias "atk_image_get_type" () as GType
declare function atk_image_get_image_description cdecl alias "atk_image_get_image_description" (byval image as AtkImage ptr) as zstring ptr
declare sub atk_image_get_image_size cdecl alias "atk_image_get_image_size" (byval image as AtkImage ptr, byval width as gint ptr, byval height as gint ptr)
declare function atk_image_set_image_description cdecl alias "atk_image_set_image_description" (byval image as AtkImage ptr, byval description as string) as gboolean
declare sub atk_image_get_image_position cdecl alias "atk_image_get_image_position" (byval image as AtkImage ptr, byval x as gint ptr, byval y as gint ptr, byval coord_type as AtkCoordType)

#endif

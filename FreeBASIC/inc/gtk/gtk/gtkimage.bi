''
''
'' gtkimage -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkimage_bi__
#define __gtkimage_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkmisc.bi"

type GtkImage as _GtkImage
type GtkImageClass as _GtkImageClass
type GtkImagePixmapData as _GtkImagePixmapData
type GtkImageImageData as _GtkImageImageData
type GtkImagePixbufData as _GtkImagePixbufData
type GtkImageStockData as _GtkImageStockData
type GtkImageIconSetData as _GtkImageIconSetData
type GtkImageAnimationData as _GtkImageAnimationData
type GtkImageIconNameData as _GtkImageIconNameData

type _GtkImagePixmapData
	pixmap as GdkPixmap ptr
end type

type _GtkImageImageData
	image as GdkImage ptr
end type

type _GtkImagePixbufData
	pixbuf as GdkPixbuf ptr
end type

type _GtkImageStockData
	stock_id as gchar ptr
end type

type _GtkImageIconSetData
	icon_set as GtkIconSet ptr
end type

type _GtkImageAnimationData
	anim as GdkPixbufAnimation ptr
	iter as GdkPixbufAnimationIter ptr
	frame_timeout as guint
end type

type _GtkImageIconNameData
	icon_name as gchar ptr
	pixbuf as GdkPixbuf ptr
	theme_change_id as guint
end type

enum GtkImageType
	GTK_IMAGE_EMPTY
	GTK_IMAGE_PIXMAP
	GTK_IMAGE_IMAGE
	GTK_IMAGE_PIXBUF
	GTK_IMAGE_STOCK
	GTK_IMAGE_ICON_SET
	GTK_IMAGE_ANIMATION
	GTK_IMAGE_ICON_NAME
end enum


union _GtkImage_data
	pixmap as GtkImagePixmapData
	image as GtkImageImageData
	pixbuf as GtkImagePixbufData
	stock as GtkImageStockData
	icon_set as GtkImageIconSetData
	anim as GtkImageAnimationData
	name as GtkImageIconNameData
end union

type _GtkImage
	misc as GtkMisc
	storage_type as GtkImageType
	mask as GdkBitmap ptr
	icon_size as GtkIconSize
	data as _GtkImage_data
end type

type _GtkImageClass
	parent_class as GtkMiscClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_image_get_type cdecl alias "gtk_image_get_type" () as GType
declare function gtk_image_new cdecl alias "gtk_image_new" () as GtkWidget ptr
declare function gtk_image_new_from_pixmap cdecl alias "gtk_image_new_from_pixmap" (byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr) as GtkWidget ptr
declare function gtk_image_new_from_image cdecl alias "gtk_image_new_from_image" (byval image as GdkImage ptr, byval mask as GdkBitmap ptr) as GtkWidget ptr
declare function gtk_image_new_from_file cdecl alias "gtk_image_new_from_file" (byval filename as gchar ptr) as GtkWidget ptr
declare function gtk_image_new_from_pixbuf cdecl alias "gtk_image_new_from_pixbuf" (byval pixbuf as GdkPixbuf ptr) as GtkWidget ptr
declare function gtk_image_new_from_stock cdecl alias "gtk_image_new_from_stock" (byval stock_id as gchar ptr, byval size as GtkIconSize) as GtkWidget ptr
declare function gtk_image_new_from_icon_set cdecl alias "gtk_image_new_from_icon_set" (byval icon_set as GtkIconSet ptr, byval size as GtkIconSize) as GtkWidget ptr
declare function gtk_image_new_from_animation cdecl alias "gtk_image_new_from_animation" (byval animation as GdkPixbufAnimation ptr) as GtkWidget ptr
declare function gtk_image_new_from_icon_name cdecl alias "gtk_image_new_from_icon_name" (byval icon_name as gchar ptr, byval size as GtkIconSize) as GtkWidget ptr
declare sub gtk_image_set_from_pixmap cdecl alias "gtk_image_set_from_pixmap" (byval image as GtkImage ptr, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gtk_image_set_from_image cdecl alias "gtk_image_set_from_image" (byval image as GtkImage ptr, byval gdk_image as GdkImage ptr, byval mask as GdkBitmap ptr)
declare sub gtk_image_set_from_file cdecl alias "gtk_image_set_from_file" (byval image as GtkImage ptr, byval filename as gchar ptr)
declare sub gtk_image_set_from_pixbuf cdecl alias "gtk_image_set_from_pixbuf" (byval image as GtkImage ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_image_set_from_stock cdecl alias "gtk_image_set_from_stock" (byval image as GtkImage ptr, byval stock_id as gchar ptr, byval size as GtkIconSize)
declare sub gtk_image_set_from_icon_set cdecl alias "gtk_image_set_from_icon_set" (byval image as GtkImage ptr, byval icon_set as GtkIconSet ptr, byval size as GtkIconSize)
declare sub gtk_image_set_from_animation cdecl alias "gtk_image_set_from_animation" (byval image as GtkImage ptr, byval animation as GdkPixbufAnimation ptr)
declare sub gtk_image_set_from_icon_name cdecl alias "gtk_image_set_from_icon_name" (byval image as GtkImage ptr, byval icon_name as gchar ptr, byval size as GtkIconSize)
declare sub gtk_image_set_pixel_size cdecl alias "gtk_image_set_pixel_size" (byval image as GtkImage ptr, byval pixel_size as gint)
declare function gtk_image_get_storage_type cdecl alias "gtk_image_get_storage_type" (byval image as GtkImage ptr) as GtkImageType
declare sub gtk_image_get_pixmap cdecl alias "gtk_image_get_pixmap" (byval image as GtkImage ptr, byval pixmap as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr)
declare sub gtk_image_get_image cdecl alias "gtk_image_get_image" (byval image as GtkImage ptr, byval gdk_image as GdkImage ptr ptr, byval mask as GdkBitmap ptr ptr)
declare function gtk_image_get_pixbuf cdecl alias "gtk_image_get_pixbuf" (byval image as GtkImage ptr) as GdkPixbuf ptr
declare sub gtk_image_get_stock cdecl alias "gtk_image_get_stock" (byval image as GtkImage ptr, byval stock_id as gchar ptr ptr, byval size as GtkIconSize ptr)
declare sub gtk_image_get_icon_set cdecl alias "gtk_image_get_icon_set" (byval image as GtkImage ptr, byval icon_set as GtkIconSet ptr ptr, byval size as GtkIconSize ptr)
declare function gtk_image_get_animation cdecl alias "gtk_image_get_animation" (byval image as GtkImage ptr) as GdkPixbufAnimation ptr
declare sub gtk_image_get_icon_name cdecl alias "gtk_image_get_icon_name" (byval image as GtkImage ptr, byval icon_name as gchar ptr ptr, byval size as GtkIconSize ptr)
declare function gtk_image_get_pixel_size cdecl alias "gtk_image_get_pixel_size" (byval image as GtkImage ptr) as gint
declare sub gtk_image_set cdecl alias "gtk_image_set" (byval image as GtkImage ptr, byval val as GdkImage ptr, byval mask as GdkBitmap ptr)
declare sub gtk_image_get cdecl alias "gtk_image_get" (byval image as GtkImage ptr, byval val as GdkImage ptr ptr, byval mask as GdkBitmap ptr ptr)

#endif

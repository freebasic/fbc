'' FreeBASIC binding for gdk4
''
'' based on the C header files:
''   GDK - The GIMP Drawing Kit
''   Copyright (C) 1995-1997 Peter Mattis, Spencer Kimball and Josh MacDonald
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library. If not, see <http:
''
'' translated to FreeBASIC by:
''   Ahmad Khalifa

#pragma once

#inclib "gtk-4"

extern "C"
#include once "cairo/cairo.bi"
#include once "gdk-pixbuf/gdk-pixbuf.bi"
#include once "gio/gio.bi"
#include once "glib.bi"
#include once "glib-object.bi"
#include once "pango/pango.bi"
#include once "pango/pangocairo.bi"


Enum GdkGLAPI_
	GDK_GL_API_GL = 1  SHL 0
	GDK_GL_API_GLES = 1  SHL 1
End Enum
Type AS LONG GdkGLAPI

Enum GdkGravity_
	GDK_GRAVITY_NORTH_WEST = 1
	GDK_GRAVITY_NORTH
	GDK_GRAVITY_NORTH_EAST
	GDK_GRAVITY_WEST
	GDK_GRAVITY_CENTER
	GDK_GRAVITY_EAST
	GDK_GRAVITY_SOUTH_WEST
	GDK_GRAVITY_SOUTH
	GDK_GRAVITY_SOUTH_EAST
	GDK_GRAVITY_STATIC
End Enum
Type AS LONG GdkGravity

Enum GdkModifierType_
	GDK_NO_MODIFIER_MASK = 0
	GDK_SHIFT_MASK = 1  SHL 0
	GDK_LOCK_MASK = 1  SHL 1
	GDK_CONTROL_MASK = 1  SHL 2
	GDK_ALT_MASK = 1  SHL 3
	GDK_BUTTON1_MASK = 1  SHL 8
	GDK_BUTTON2_MASK = 1  SHL 9
	GDK_BUTTON3_MASK = 1  SHL 10
	GDK_BUTTON4_MASK = 1  SHL 11
	GDK_BUTTON5_MASK = 1  SHL 12
	GDK_SUPER_MASK = 1  SHL 26
	GDK_HYPER_MASK = 1  SHL 27
	GDK_META_MASK = 1  SHL 28
End Enum
Type AS LONG GdkModifierType

#DEFINE GDK_MODIFIER_MASK (GDK_SHIFT_MASKGDK_LOCK_MASKGDK_CONTROL_MASK _
                           GDK_ALT_MASKGDK_SUPER_MASKGDK_HYPER_MASKGDK_META_MASK _
                           GDK_BUTTON1_MASKGDK_BUTTON2_MASKGDK_BUTTON3_MASK _
                           GDK_BUTTON4_MASKGDK_BUTTON5_MASK)

Enum GdkDmabufError_
	GDK_DMABUF_ERROR_NOT_AVAILABLE
	GDK_DMABUF_ERROR_UNSUPPORTED_FORMAT
	GDK_DMABUF_ERROR_CREATION_FAILED
End Enum
Type AS LONG GdkDmabufError

Enum GdkGLError_
	GDK_GL_ERROR_NOT_AVAILABLE
	GDK_GL_ERROR_UNSUPPORTED_FORMAT
	GDK_GL_ERROR_UNSUPPORTED_PROFILE
	GDK_GL_ERROR_COMPILATION_FAILED
	GDK_GL_ERROR_LINK_FAILED
End Enum
Type AS LONG GdkGLError

Enum GdkVulkanError_
	GDK_VULKAN_ERROR_UNSUPPORTED
	GDK_VULKAN_ERROR_NOT_AVAILABLE
End Enum
Type AS LONG GdkVulkanError

Enum GdkAxisUse_
	GDK_AXIS_IGNORE
	GDK_AXIS_X
	GDK_AXIS_Y
	GDK_AXIS_DELTA_X
	GDK_AXIS_DELTA_Y
	GDK_AXIS_PRESSURE
	GDK_AXIS_XTILT
	GDK_AXIS_YTILT
	GDK_AXIS_WHEEL
	GDK_AXIS_DISTANCE
	GDK_AXIS_ROTATION
	GDK_AXIS_SLIDER
	GDK_AXIS_LAST
End Enum
Type AS LONG GdkAxisUse

Enum GdkAxisFlags_
	GDK_AXIS_FLAG_X = 1  SHL GDK_AXIS_X
	GDK_AXIS_FLAG_Y = 1  SHL GDK_AXIS_Y
	GDK_AXIS_FLAG_DELTA_X = 1  SHL GDK_AXIS_DELTA_X
	GDK_AXIS_FLAG_DELTA_Y = 1  SHL GDK_AXIS_DELTA_Y
	GDK_AXIS_FLAG_PRESSURE = 1  SHL GDK_AXIS_PRESSURE
	GDK_AXIS_FLAG_XTILT = 1  SHL GDK_AXIS_XTILT
	GDK_AXIS_FLAG_YTILT = 1  SHL GDK_AXIS_YTILT
	GDK_AXIS_FLAG_WHEEL = 1  SHL GDK_AXIS_WHEEL
	GDK_AXIS_FLAG_DISTANCE = 1  SHL GDK_AXIS_DISTANCE
	GDK_AXIS_FLAG_ROTATION = 1  SHL GDK_AXIS_ROTATION
	GDK_AXIS_FLAG_SLIDER = 1  SHL GDK_AXIS_SLIDER
End Enum
Type AS LONG GdkAxisFlags

Enum GdkDragAction_
	GDK_ACTION_COPY = 1  SHL 0
	GDK_ACTION_MOVE = 1  SHL 1
	GDK_ACTION_LINK = 1  SHL 2
	GDK_ACTION_ASK = 1  SHL 3
End Enum
Type AS LONG GdkDragAction

#DEFINE GDK_ACTION_ALL (GDK_ACTION_COPY  OR  GDK_ACTION_MOVE  OR  GDK_ACTION_LINK)

Enum GdkMemoryFormat_
	GDK_MEMORY_B8G8R8A8_PREMULTIPLIED
	GDK_MEMORY_A8R8G8B8_PREMULTIPLIED
	GDK_MEMORY_R8G8B8A8_PREMULTIPLIED
	GDK_MEMORY_B8G8R8A8
	GDK_MEMORY_A8R8G8B8
	GDK_MEMORY_R8G8B8A8
	GDK_MEMORY_A8B8G8R8
	GDK_MEMORY_R8G8B8
	GDK_MEMORY_B8G8R8
	GDK_MEMORY_R16G16B16
	GDK_MEMORY_R16G16B16A16_PREMULTIPLIED
	GDK_MEMORY_R16G16B16A16
	GDK_MEMORY_R16G16B16_FLOAT
	GDK_MEMORY_R16G16B16A16_FLOAT_PREMULTIPLIED
	GDK_MEMORY_R16G16B16A16_FLOAT
	GDK_MEMORY_R32G32B32_FLOAT
	GDK_MEMORY_R32G32B32A32_FLOAT_PREMULTIPLIED
	GDK_MEMORY_R32G32B32A32_FLOAT
	GDK_MEMORY_G8A8_PREMULTIPLIED
	GDK_MEMORY_G8A8
	GDK_MEMORY_G8
	GDK_MEMORY_G16A16_PREMULTIPLIED
	GDK_MEMORY_G16A16
	GDK_MEMORY_G16
	GDK_MEMORY_A8
	GDK_MEMORY_A16
	GDK_MEMORY_A16_FLOAT
	GDK_MEMORY_A32_FLOAT
	GDK_MEMORY_A8B8G8R8_PREMULTIPLIED
	GDK_MEMORY_B8G8R8X8
	GDK_MEMORY_X8R8G8B8
	GDK_MEMORY_R8G8B8X8
	GDK_MEMORY_X8B8G8R8
	GDK_MEMORY_N_FORMATS
End Enum
Type AS LONG GdkMemoryFormat

#DEFINE GDK_CURRENT_TIME 0L

Type _GdkRectangle
	AS LONG x, y
	AS LONG width, height
End Type

Type GdkRectangle AS _GdkRectangle


Type GdkRGBA AS _GdkRGBA
Type GdkCicpParams AS _GdkCicpParams
Type GdkColorState AS _GdkColorState
Type GdkContentFormats AS _GdkContentFormats
Type GdkContentProvider AS _GdkContentProvider
Type GdkCursor AS _GdkCursor
Type GdkTexture AS _GdkTexture
Type GdkTextureDownloader AS _GdkTextureDownloader
Type GdkDevice AS _GdkDevice
Type GdkDrag AS _GdkDrag
Type GdkDrop AS _GdkDrop
Type GdkClipboard AS _GdkClipboard
Type GdkDisplayManager AS _GdkDisplayManager
Type GdkDisplay AS _GdkDisplay
Type GdkSurface AS _GdkSurface
Type GdkAppLaunchContext AS _GdkAppLaunchContext
Type GdkSeat AS _GdkSeat
Type GdkSnapshot AS _GdkSnapshot
Type GdkDrawContext AS _GdkDrawContext
Type GdkCairoContext AS _GdkCairoContext
Type GdkGLContext AS _GdkGLContext
Type GdkVulkanContext AS _GdkVulkanContext
Type GdkDmabufFormats AS _GdkDmabufFormats
Type GdkDmabufTexture AS _GdkDmabufTexture

Type GdkKeymapKey AS _GdkKeymapKey

Type _GdkKeymapKey
	AS guint keycode
	AS LONG group
	AS LONG level
End Type


#DEFINE GDK_TYPE_APP_LAUNCH_CONTEXT (gdk_app_launch_context_get_type ())
#DEFINE GDK_APP_LAUNCH_CONTEXT(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GDK_TYPE_APP_LAUNCH_CONTEXT, GdkAppLaunchContext))
#DEFINE GDK_IS_APP_LAUNCH_CONTEXT(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_APP_LAUNCH_CONTEXT))

Declare Function gdk_app_launch_context_get_type CDECL() AS GType
Declare Function gdk_app_launch_context_get_display CDECL(BYVAL AS GdkAppLaunchContext Ptr) AS GdkDisplay Ptr
Declare Sub gdk_app_launch_context_set_desktop CDECL(BYVAL AS GdkAppLaunchContext Ptr, BYVAL AS LONG)
Declare Sub gdk_app_launch_context_set_timestamp CDECL(BYVAL AS GdkAppLaunchContext Ptr, BYVAL AS guint32)
Declare Sub gdk_app_launch_context_set_icon CDECL(BYVAL AS GdkAppLaunchContext Ptr, BYVAL AS GIcon Ptr)
Declare Sub gdk_app_launch_context_set_icon_name CDECL(BYVAL AS GdkAppLaunchContext Ptr, BYVAL AS Const ZSTRING Ptr)

Declare Sub gdk_cairo_set_source_rgba CDECL(BYVAL AS cairo_t Ptr, BYVAL AS Const GdkRGBA Ptr)
Declare Sub gdk_cairo_set_source_pixbuf CDECL(BYVAL AS cairo_t Ptr, BYVAL AS Const GdkPixbuf Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare Sub gdk_cairo_rectangle CDECL(BYVAL AS cairo_t Ptr, BYVAL AS Const GdkRectangle Ptr)
Declare Sub gdk_cairo_region CDECL(BYVAL AS cairo_t Ptr, BYVAL AS Const cairo_region_t Ptr)
Declare Function gdk_cairo_region_create_from_surface CDECL(BYVAL AS cairo_surface_t Ptr) AS cairo_region_t Ptr

#DEFINE GDK_TYPE_CAIRO_CONTEXT (gdk_cairo_context_get_type ())
#DEFINE GDK_CAIRO_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_CAIRO_CONTEXT, GdkCairoContext))
#DEFINE GDK_IS_CAIRO_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_CAIRO_CONTEXT))
#DEFINE GDK_CAIRO_ERROR (gdk_cairo_error_quark ())

Declare Function gdk_cairo_context_get_type CDECL() AS GType
Declare Function gdk_cairo_context_cairo_create CDECL(BYVAL AS GdkCairoContext Ptr) AS cairo_t Ptr

#DEFINE GDK_TYPE_CICP_PARAMS (gdk_cicp_params_get_type ())

Type GdkCicpParams AS _GdkCicpParams
Declare Function gdk_cicp_params_new CDECL() AS GdkCicpParams Ptr
Declare Function gdk_cicp_params_get_color_primaries CDECL(BYVAL AS GdkCicpParams Ptr) AS guint
Declare Sub gdk_cicp_params_set_color_primaries CDECL(BYVAL AS GdkCicpParams Ptr, BYVAL AS guint)
Declare Function gdk_cicp_params_get_transfer_function CDECL(BYVAL AS GdkCicpParams Ptr) AS guint
Declare Sub gdk_cicp_params_set_transfer_function CDECL(BYVAL AS GdkCicpParams Ptr, BYVAL AS guint)
Declare Function gdk_cicp_params_get_matrix_coefficients CDECL(BYVAL AS GdkCicpParams Ptr) AS guint
Declare Sub gdk_cicp_params_set_matrix_coefficients CDECL(BYVAL AS GdkCicpParams Ptr, BYVAL AS guint)

Enum GdkCicpRange_
	GDK_CICP_RANGE_NARROW
	GDK_CICP_RANGE_FULL
End Enum
Type AS LONG GdkCicpRange

Declare Function gdk_cicp_params_get_range CDECL(BYVAL AS GdkCicpParams Ptr) AS GdkCicpRange
Declare Sub gdk_cicp_params_set_range CDECL(BYVAL AS GdkCicpParams Ptr, BYVAL AS GdkCicpRange)
Declare Function gdk_cicp_params_build_color_state CDECL(BYVAL AS GdkCicpParams Ptr, BYVAL AS GError Ptr Ptr) AS GdkColorState Ptr

#DEFINE GDK_TYPE_CLIPBOARD (gdk_clipboard_get_type ())
#DEFINE GDK_CLIPBOARD(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_CLIPBOARD, GdkClipboard))
#DEFINE GDK_IS_CLIPBOARD(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_CLIPBOARD))

Declare Function gdk_clipboard_get_type CDECL() AS GType
Declare Function gdk_clipboard_get_display CDECL(BYVAL AS GdkClipboard Ptr) AS GdkDisplay Ptr
Declare Function gdk_clipboard_get_formats CDECL(BYVAL AS GdkClipboard Ptr) AS GdkContentFormats Ptr
Declare Function gdk_clipboard_is_local CDECL(BYVAL AS GdkClipboard Ptr) AS gboolean
Declare Function gdk_clipboard_get_content CDECL(BYVAL AS GdkClipboard Ptr) AS GdkContentProvider Ptr
Declare Sub gdk_clipboard_store_async CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS LONG, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gdk_clipboard_store_finish CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Sub gdk_clipboard_read_async CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS LONG, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gdk_clipboard_read_finish CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS GError Ptr Ptr) AS GInputStream Ptr
Declare Sub gdk_clipboard_read_value_async CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GType, BYVAL AS LONG, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gdk_clipboard_read_value_finish CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS Const GValue Ptr
Declare Sub gdk_clipboard_read_texture_async CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gdk_clipboard_read_texture_finish CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS GdkTexture Ptr
Declare Sub gdk_clipboard_read_text_async CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gdk_clipboard_read_text_finish CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS ZSTRING Ptr
Declare Function gdk_clipboard_set_content CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GdkContentProvider Ptr) AS gboolean
Declare Sub gdk_clipboard_set CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GType, ...)
Declare Sub gdk_clipboard_set_valist CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GType, BYVAL AS va_list)
Declare Sub gdk_clipboard_set_value CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS Const GValue Ptr)
Declare Sub gdk_clipboard_set_text CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Sub gdk_clipboard_set_texture CDECL(BYVAL AS GdkClipboard Ptr, BYVAL AS GdkTexture Ptr)

#DEFINE GDK_TYPE_COLOR_STATE (gdk_color_state_get_type ())

Declare Function gdk_color_state_get_type CDECL() AS GType
Declare Function gdk_color_state_ref CDECL(BYVAL AS GdkColorState Ptr) AS GdkColorState Ptr
Declare Sub gdk_color_state_unref CDECL(BYVAL AS GdkColorState Ptr)
Declare Function gdk_color_state_get_srgb CDECL() AS GdkColorState Ptr
Declare Function gdk_color_state_get_srgb_linear CDECL() AS GdkColorState Ptr
Declare Function gdk_color_state_get_rec2100_pq CDECL() AS GdkColorState Ptr
Declare Function gdk_color_state_get_rec2100_linear CDECL() AS GdkColorState Ptr
Declare Function gdk_color_state_get_oklab CDECL() AS GdkColorState Ptr
Declare Function gdk_color_state_get_oklch CDECL() AS GdkColorState Ptr
Declare Function gdk_color_state_equal CDECL(BYVAL AS GdkColorState Ptr, BYVAL AS GdkColorState Ptr) AS gboolean
Declare Function gdk_color_state_create_cicp_params CDECL(BYVAL AS GdkColorState Ptr) AS GdkCicpParams Ptr

#DEFINE GDK_TYPE_CONTENT_DESERIALIZER (gdk_content_deserializer_get_type ())
#DEFINE GDK_CONTENT_DESERIALIZER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GDK_TYPE_CONTENT_DESERIALIZER, GdkContentDeserializer))
#DEFINE GDK_IS_CONTENT_DESERIALIZER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_CONTENT_DESERIALIZER))

Type GdkContentDeserializer AS _GdkContentDeserializer
Type GdkContentDeserializeFunc AS SUB CDECL(BYVAL AS GdkContentDeserializer Ptr)

Declare Function gdk_content_deserializer_get_type CDECL() AS GType
Declare Function gdk_content_deserializer_get_mime_type CDECL(BYVAL AS GdkContentDeserializer Ptr) AS Const ZSTRING Ptr
Declare Function gdk_content_deserializer_get_gtype CDECL(BYVAL AS GdkContentDeserializer Ptr) AS GType
Declare Function gdk_content_deserializer_get_value CDECL(BYVAL AS GdkContentDeserializer Ptr) AS GValue Ptr
Declare Function gdk_content_deserializer_get_input_stream CDECL(BYVAL AS GdkContentDeserializer Ptr) AS GInputStream Ptr
Declare Function gdk_content_deserializer_get_priority CDECL(BYVAL AS GdkContentDeserializer Ptr) AS LONG
Declare Function gdk_content_deserializer_get_cancellable CDECL(BYVAL AS GdkContentDeserializer Ptr) AS GCancellable Ptr
Declare Function gdk_content_deserializer_get_user_data CDECL(BYVAL AS GdkContentDeserializer Ptr) AS gpointer
Declare Sub gdk_content_deserializer_set_task_data CDECL(BYVAL AS GdkContentDeserializer Ptr, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare Function gdk_content_deserializer_get_task_data CDECL(BYVAL AS GdkContentDeserializer Ptr) AS gpointer
Declare Sub gdk_content_deserializer_return_success CDECL(BYVAL AS GdkContentDeserializer Ptr)
Declare Sub gdk_content_deserializer_return_error CDECL(BYVAL AS GdkContentDeserializer Ptr, BYVAL AS GError Ptr)
Declare Function gdk_content_formats_union_deserialize_gtypes CDECL(BYVAL AS GdkContentFormats Ptr) AS GdkContentFormats Ptr
Declare Function gdk_content_formats_union_deserialize_mime_types CDECL(BYVAL AS GdkContentFormats Ptr) AS GdkContentFormats Ptr
Declare Sub gdk_content_register_deserializer CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS GType, BYVAL AS GdkContentDeserializeFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare Sub gdk_content_deserialize_async CDECL(BYVAL AS GInputStream Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GType, BYVAL AS LONG, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gdk_content_deserialize_finish CDECL(BYVAL AS GAsyncResult Ptr, BYVAL AS GValue Ptr, BYVAL AS GError Ptr Ptr) AS gboolean

#DEFINE GDK_TYPE_CONTENT_FORMATS (gdk_content_formats_get_type ())

Declare Function gdk_intern_mime_type CDECL(BYVAL AS Const ZSTRING Ptr) AS Const ZSTRING Ptr
Declare Function gdk_content_formats_get_type CDECL() AS GType
Declare Function gdk_content_formats_new CDECL(BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS guint) AS GdkContentFormats Ptr
Declare Function gdk_content_formats_new_for_gtype CDECL(BYVAL AS GType) AS GdkContentFormats Ptr
Declare Function gdk_content_formats_parse CDECL(BYVAL AS Const ZSTRING Ptr) AS GdkContentFormats Ptr
Declare Function gdk_content_formats_ref CDECL(BYVAL AS GdkContentFormats Ptr) AS GdkContentFormats Ptr
Declare Sub gdk_content_formats_unref CDECL(BYVAL AS GdkContentFormats Ptr)
Declare Sub gdk_content_formats_print CDECL(BYVAL AS GdkContentFormats Ptr, BYVAL AS GString Ptr)
Declare Function gdk_content_formats_to_string CDECL(BYVAL AS GdkContentFormats Ptr) AS ZSTRING Ptr
Declare Function gdk_content_formats_get_gtypes CDECL(BYVAL AS Const GdkContentFormats Ptr, BYVAL AS gsize Ptr) AS Const GType Ptr
Declare Function gdk_content_formats_get_mime_types CDECL(BYVAL AS Const GdkContentFormats Ptr, BYVAL AS gsize Ptr) AS Const ZSTRING Const Ptr Ptr
Declare Function gdk_content_formats_union CDECL(BYVAL AS GdkContentFormats Ptr, BYVAL AS Const GdkContentFormats Ptr) AS GdkContentFormats Ptr
Declare Function gdk_content_formats_match CDECL(BYVAL AS Const GdkContentFormats Ptr, BYVAL AS Const GdkContentFormats Ptr) AS gboolean
Declare Function gdk_content_formats_match_gtype CDECL(BYVAL AS Const GdkContentFormats Ptr, BYVAL AS Const GdkContentFormats Ptr) AS GType
Declare Function gdk_content_formats_match_mime_type CDECL(BYVAL AS Const GdkContentFormats Ptr, BYVAL AS Const GdkContentFormats Ptr) AS Const ZSTRING Ptr
Declare Function gdk_content_formats_contain_gtype CDECL(BYVAL AS Const GdkContentFormats Ptr, BYVAL AS GType) AS gboolean
Declare Function gdk_content_formats_contain_mime_type CDECL(BYVAL AS Const GdkContentFormats Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gdk_content_formats_is_empty CDECL(BYVAL AS GdkContentFormats Ptr) AS gboolean

#DEFINE GDK_TYPE_CONTENT_FORMATS_BUILDER (gdk_content_formats_builder_get_type ())

Type GdkContentFormatsBuilder AS _GdkContentFormatsBuilder

Declare Function gdk_content_formats_builder_get_type CDECL() AS GType
Declare Function gdk_content_formats_builder_new CDECL() AS GdkContentFormatsBuilder Ptr
Declare Function gdk_content_formats_builder_ref CDECL(BYVAL AS GdkContentFormatsBuilder Ptr) AS GdkContentFormatsBuilder Ptr
Declare Sub gdk_content_formats_builder_unref CDECL(BYVAL AS GdkContentFormatsBuilder Ptr)
Declare Function gdk_content_formats_builder_free_to_formats CDECL(BYVAL AS GdkContentFormatsBuilder Ptr) AS GdkContentFormats Ptr
Declare Function gdk_content_formats_builder_to_formats CDECL(BYVAL AS GdkContentFormatsBuilder Ptr) AS GdkContentFormats Ptr
Declare Sub gdk_content_formats_builder_add_formats CDECL(BYVAL AS GdkContentFormatsBuilder Ptr, BYVAL AS Const GdkContentFormats Ptr)
Declare Sub gdk_content_formats_builder_add_mime_type CDECL(BYVAL AS GdkContentFormatsBuilder Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Sub gdk_content_formats_builder_add_gtype CDECL(BYVAL AS GdkContentFormatsBuilder Ptr, BYVAL AS GType)

#DEFINE GDK_TYPE_FILE_LIST (gdk_file_list_get_type ())

Declare Function gdk_file_list_get_type CDECL() AS GType

Type GdkFileList AS _GdkFileList

Declare Function gdk_file_list_get_files CDECL(BYVAL AS GdkFileList Ptr) AS GSList Ptr
Declare Function gdk_file_list_new_from_list CDECL(BYVAL AS GSList Ptr) AS GdkFileList Ptr
Declare Function gdk_file_list_new_from_array CDECL(BYVAL AS GFile Ptr Ptr, BYVAL AS gsize) AS GdkFileList Ptr

#DEFINE GDK_TYPE_CONTENT_PROVIDER (gdk_content_provider_get_type ())
#DEFINE GDK_CONTENT_PROVIDER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_CONTENT_PROVIDER, GdkContentProvider))
#DEFINE GDK_IS_CONTENT_PROVIDER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_CONTENT_PROVIDER))
#DEFINE GDK_CONTENT_PROVIDER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_CONTENT_PROVIDER, GdkContentProviderClass))
#DEFINE GDK_IS_CONTENT_PROVIDER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_CONTENT_PROVIDER))
#DEFINE GDK_CONTENT_PROVIDER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_CONTENT_PROVIDER, GdkContentProviderClass))

Type GdkContentProviderClass AS _GdkContentProviderClass

Type _GdkContentProvider
	AS GObject parent
End Type

Type _GdkContentProviderClass
	AS GObjectClass parent_class
	content_changed AS SUB CDECL(BYVAL AS GdkContentProvider Ptr)
	attach_clipboard AS SUB CDECL(BYVAL AS GdkContentProvider Ptr, BYVAL AS GdkClipboard Ptr)
	detach_clipboard AS SUB CDECL(BYVAL AS GdkContentProvider Ptr, BYVAL AS GdkClipboard Ptr)
	ref_formats AS Function CDECL(BYVAL AS GdkContentProvider Ptr) AS GdkContentFormats Ptr
	ref_storable_formats AS Function CDECL(BYVAL AS GdkContentProvider Ptr) AS GdkContentFormats Ptr
	write_mime_type_async AS SUB CDECL(BYVAL AS GdkContentProvider Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GOutputStream Ptr, BYVAL AS LONG, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
	write_mime_type_finish AS Function CDECL(BYVAL AS GdkContentProvider Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
	get_value AS Function CDECL(BYVAL AS GdkContentProvider Ptr, BYVAL AS GValue Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
	AS gpointer padding(0 TO 8-1)
End Type

Declare Function gdk_content_provider_get_type CDECL() AS GType
Declare Function gdk_content_provider_ref_formats CDECL(BYVAL AS GdkContentProvider Ptr) AS GdkContentFormats Ptr
Declare Function gdk_content_provider_ref_storable_formats CDECL(BYVAL AS GdkContentProvider Ptr) AS GdkContentFormats Ptr
Declare Sub gdk_content_provider_content_changed CDECL(BYVAL AS GdkContentProvider Ptr)
Declare Sub gdk_content_provider_write_mime_type_async CDECL(BYVAL AS GdkContentProvider Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GOutputStream Ptr, BYVAL AS LONG, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gdk_content_provider_write_mime_type_finish CDECL(BYVAL AS GdkContentProvider Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gdk_content_provider_get_value CDECL(BYVAL AS GdkContentProvider Ptr, BYVAL AS GValue Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gdk_content_provider_new_for_value CDECL(BYVAL AS Const GValue Ptr) AS GdkContentProvider Ptr
Declare Function gdk_content_provider_new_typed CDECL(BYVAL AS GType, ...) AS GdkContentProvider Ptr
Declare Function gdk_content_provider_new_union CDECL(BYVAL AS GdkContentProvider Ptr Ptr, BYVAL AS gsize) AS GdkContentProvider Ptr
Declare Function gdk_content_provider_new_for_bytes CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS GBytes Ptr) AS GdkContentProvider Ptr


#DEFINE GDK_TYPE_CONTENT_SERIALIZER (gdk_content_serializer_get_type ())
#DEFINE GDK_CONTENT_SERIALIZER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GDK_TYPE_CONTENT_SERIALIZER, GdkContentSerializer))
#DEFINE GDK_IS_CONTENT_SERIALIZER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_CONTENT_SERIALIZER))

Type GdkContentSerializer AS _GdkContentSerializer
Type GdkContentSerializeFunc AS SUB CDECL(BYVAL AS GdkContentSerializer Ptr)

Declare Function gdk_content_serializer_get_type CDECL() AS GType
Declare Function gdk_content_serializer_get_mime_type CDECL(BYVAL AS GdkContentSerializer Ptr) AS Const ZSTRING Ptr
Declare Function gdk_content_serializer_get_gtype CDECL(BYVAL AS GdkContentSerializer Ptr) AS GType
Declare Function gdk_content_serializer_get_value CDECL(BYVAL AS GdkContentSerializer Ptr) AS Const GValue Ptr
Declare Function gdk_content_serializer_get_output_stream CDECL(BYVAL AS GdkContentSerializer Ptr) AS GOutputStream Ptr
Declare Function gdk_content_serializer_get_priority CDECL(BYVAL AS GdkContentSerializer Ptr) AS LONG
Declare Function gdk_content_serializer_get_cancellable CDECL(BYVAL AS GdkContentSerializer Ptr) AS GCancellable Ptr
Declare Function gdk_content_serializer_get_user_data CDECL(BYVAL AS GdkContentSerializer Ptr) AS gpointer
Declare Sub gdk_content_serializer_set_task_data CDECL(BYVAL AS GdkContentSerializer Ptr, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare Function gdk_content_serializer_get_task_data CDECL(BYVAL AS GdkContentSerializer Ptr) AS gpointer
Declare Sub gdk_content_serializer_return_success CDECL(BYVAL AS GdkContentSerializer Ptr)
Declare Sub gdk_content_serializer_return_error CDECL(BYVAL AS GdkContentSerializer Ptr, BYVAL AS GError Ptr)
Declare Function gdk_content_formats_union_serialize_gtypes CDECL(BYVAL AS GdkContentFormats Ptr) AS GdkContentFormats Ptr
Declare Function gdk_content_formats_union_serialize_mime_types CDECL(BYVAL AS GdkContentFormats Ptr) AS GdkContentFormats Ptr
Declare Sub gdk_content_register_serializer CDECL(BYVAL AS GType, BYVAL AS Const ZSTRING Ptr, BYVAL AS GdkContentSerializeFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare Sub gdk_content_serialize_async CDECL(BYVAL AS GOutputStream Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const GValue Ptr, BYVAL AS LONG, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gdk_content_serialize_finish CDECL(BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS gboolean

#DEFINE GDK_TYPE_CURSOR (gdk_cursor_get_type ())
#DEFINE GDK_CURSOR(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_CURSOR, GdkCursor))
#DEFINE GDK_IS_CURSOR(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_CURSOR))

Declare Function gdk_cursor_get_type CDECL() AS GType
Declare Function gdk_cursor_new_from_texture CDECL(BYVAL AS GdkTexture Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS GdkCursor Ptr) AS GdkCursor Ptr
Declare Function gdk_cursor_new_from_name CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS GdkCursor Ptr) AS GdkCursor Ptr

Type GdkCursorGetTextureCallback AS Function CDECL(BYVAL AS GdkCursor Ptr, BYVAL AS LONG, BYVAL AS DOUBLE, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS gpointer) AS GdkTexture Ptr

Declare Function gdk_cursor_new_from_callback CDECL(BYVAL AS GdkCursorGetTextureCallback, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS GdkCursor Ptr) AS GdkCursor Ptr
Declare Function gdk_cursor_get_fallback CDECL(BYVAL AS GdkCursor Ptr) AS GdkCursor Ptr
Declare Function gdk_cursor_get_name CDECL(BYVAL AS GdkCursor Ptr) AS Const ZSTRING Ptr
Declare Function gdk_cursor_get_texture CDECL(BYVAL AS GdkCursor Ptr) AS GdkTexture Ptr
Declare Function gdk_cursor_get_hotspot_x CDECL(BYVAL AS GdkCursor Ptr) AS LONG
Declare Function gdk_cursor_get_hotspot_y CDECL(BYVAL AS GdkCursor Ptr) AS LONG

#DEFINE GDK_TYPE_DEVICE_TOOL (gdk_device_tool_get_type ())
#DEFINE GDK_DEVICE_TOOL(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GDK_TYPE_DEVICE_TOOL, GdkDeviceTool))
#DEFINE GDK_IS_DEVICE_TOOL(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_DEVICE_TOOL))

Type GdkDeviceTool AS _GdkDeviceTool

Enum GdkDeviceToolType_
	GDK_DEVICE_TOOL_TYPE_UNKNOWN
	GDK_DEVICE_TOOL_TYPE_PEN
	GDK_DEVICE_TOOL_TYPE_ERASER
	GDK_DEVICE_TOOL_TYPE_BRUSH
	GDK_DEVICE_TOOL_TYPE_PENCIL
	GDK_DEVICE_TOOL_TYPE_AIRBRUSH
	GDK_DEVICE_TOOL_TYPE_MOUSE
	GDK_DEVICE_TOOL_TYPE_LENS
End Enum
Type AS LONG GdkDeviceToolType

Declare Function gdk_device_tool_get_type CDECL() AS GType
Declare Function gdk_device_tool_get_serial CDECL(BYVAL AS GdkDeviceTool Ptr) AS guint64
Declare Function gdk_device_tool_get_hardware_id CDECL(BYVAL AS GdkDeviceTool Ptr) AS guint64
Declare Function gdk_device_tool_get_tool_type CDECL(BYVAL AS GdkDeviceTool Ptr) AS GdkDeviceToolType
Declare Function gdk_device_tool_get_axes CDECL(BYVAL AS GdkDeviceTool Ptr) AS GdkAxisFlags

#DEFINE GDK_TYPE_DEVICE (gdk_device_get_type ())
#DEFINE GDK_DEVICE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GDK_TYPE_DEVICE, GdkDevice))
#DEFINE GDK_IS_DEVICE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_DEVICE))

Type GdkTimeCoord AS _GdkTimeCoord

Enum GdkInputSource_
	GDK_SOURCE_MOUSE
	GDK_SOURCE_PEN
	GDK_SOURCE_KEYBOARD
	GDK_SOURCE_TOUCHSCREEN
	GDK_SOURCE_TOUCHPAD
	GDK_SOURCE_TRACKPOINT
	GDK_SOURCE_TABLET_PAD
End Enum
Type AS LONG GdkInputSource

Type _GdkTimeCoord
	AS guint32 time
	AS GdkAxisFlags flags
	AS DOUBLE axes(0 TO GDK_AXIS_LAST-1)
End Type

Declare Function gdk_device_get_type CDECL() AS GType
Declare Function gdk_device_get_name CDECL(BYVAL AS GdkDevice Ptr) AS Const ZSTRING Ptr
Declare Function gdk_device_get_vendor_id CDECL(BYVAL AS GdkDevice Ptr) AS Const ZSTRING Ptr
Declare Function gdk_device_get_product_id CDECL(BYVAL AS GdkDevice Ptr) AS Const ZSTRING Ptr
Declare Function gdk_device_get_display CDECL(BYVAL AS GdkDevice Ptr) AS GdkDisplay Ptr
Declare Function gdk_device_get_seat CDECL(BYVAL AS GdkDevice Ptr) AS GdkSeat Ptr
Declare Function gdk_device_get_device_tool CDECL(BYVAL AS GdkDevice Ptr) AS GdkDeviceTool Ptr
Declare Function gdk_device_get_source CDECL(BYVAL AS GdkDevice Ptr) AS GdkInputSource
Declare Function gdk_device_get_has_cursor CDECL(BYVAL AS GdkDevice Ptr) AS gboolean
Declare Function gdk_device_get_num_touches CDECL(BYVAL AS GdkDevice Ptr) AS guint
Declare Function gdk_device_get_modifier_state CDECL(BYVAL AS GdkDevice Ptr) AS GdkModifierType
Declare Function gdk_device_get_direction CDECL(BYVAL AS GdkDevice Ptr) AS PangoDirection
Declare Function gdk_device_has_bidi_layouts CDECL(BYVAL AS GdkDevice Ptr) AS gboolean
Declare Function gdk_device_get_caps_lock_state CDECL(BYVAL AS GdkDevice Ptr) AS gboolean
Declare Function gdk_device_get_num_lock_state CDECL(BYVAL AS GdkDevice Ptr) AS gboolean
Declare Function gdk_device_get_scroll_lock_state CDECL(BYVAL AS GdkDevice Ptr) AS gboolean
Declare Function gdk_device_get_surface_at_position CDECL(BYVAL AS GdkDevice Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr) AS GdkSurface Ptr
Declare Function gdk_device_get_timestamp CDECL(BYVAL AS GdkDevice Ptr) AS guint32
Declare Function gdk_device_get_active_layout_index CDECL(BYVAL AS GdkDevice Ptr) AS gint
Declare Function gdk_device_get_layout_names CDECL(BYVAL AS GdkDevice Ptr) AS gchar Ptr Ptr

#DEFINE GDK_TYPE_DEVICE_PAD (gdk_device_pad_get_type ())
#DEFINE GDK_DEVICE_PAD(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GDK_TYPE_DEVICE_PAD, GdkDevicePad))
#DEFINE GDK_IS_DEVICE_PAD(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_DEVICE_PAD))

Type GdkDevicePad AS _GdkDevicePad
Type GdkDevicePadInterface AS _GdkDevicePadInterface

Enum GdkDevicePadFeature_
	GDK_DEVICE_PAD_FEATURE_BUTTON
	GDK_DEVICE_PAD_FEATURE_RING
	GDK_DEVICE_PAD_FEATURE_STRIP
End Enum
Type AS LONG GdkDevicePadFeature

Declare Function gdk_device_pad_get_type CDECL() AS GType
Declare Function gdk_device_pad_get_n_groups CDECL(BYVAL AS GdkDevicePad Ptr) AS LONG
Declare Function gdk_device_pad_get_group_n_modes CDECL(BYVAL AS GdkDevicePad Ptr, BYVAL AS LONG) AS LONG
Declare Function gdk_device_pad_get_n_features CDECL(BYVAL AS GdkDevicePad Ptr, BYVAL AS GdkDevicePadFeature) AS LONG
Declare Function gdk_device_pad_get_feature_group CDECL(BYVAL AS GdkDevicePad Ptr, BYVAL AS GdkDevicePadFeature, BYVAL AS LONG) AS LONG


#DEFINE GDK_TYPE_DRAG (gdk_drag_get_type ())
#DEFINE GDK_DRAG(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DRAG, GdkDrag))
#DEFINE GDK_IS_DRAG(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DRAG))

Enum GdkDragCancelReason_
	GDK_DRAG_CANCEL_NO_TARGET
	GDK_DRAG_CANCEL_USER_CANCELLED
	GDK_DRAG_CANCEL_ERROR
End Enum
Type AS LONG GdkDragCancelReason

Declare Function gdk_drag_get_type CDECL() AS GType
Declare Function gdk_drag_get_display CDECL(BYVAL AS GdkDrag Ptr) AS GdkDisplay Ptr
Declare Function gdk_drag_get_device CDECL(BYVAL AS GdkDrag Ptr) AS GdkDevice Ptr
Declare Function gdk_drag_get_formats CDECL(BYVAL AS GdkDrag Ptr) AS GdkContentFormats Ptr
Declare Function gdk_drag_get_actions CDECL(BYVAL AS GdkDrag Ptr) AS GdkDragAction
Declare Function gdk_drag_get_selected_action CDECL(BYVAL AS GdkDrag Ptr) AS GdkDragAction
Declare Function gdk_drag_action_is_unique CDECL(BYVAL AS GdkDragAction) AS gboolean
Declare Function gdk_drag_begin CDECL(BYVAL AS GdkSurface Ptr, BYVAL AS GdkDevice Ptr, BYVAL AS GdkContentProvider Ptr, BYVAL AS GdkDragAction, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS GdkDrag Ptr
Declare Sub gdk_drag_drop_done CDECL(BYVAL AS GdkDrag Ptr, BYVAL AS gboolean)
Declare Function gdk_drag_get_drag_surface CDECL(BYVAL AS GdkDrag Ptr) AS GdkSurface Ptr
Declare Sub gdk_drag_set_hotspot CDECL(BYVAL AS GdkDrag Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare Function gdk_drag_get_content CDECL(BYVAL AS GdkDrag Ptr) AS GdkContentProvider Ptr
Declare Function gdk_drag_get_surface CDECL(BYVAL AS GdkDrag Ptr) AS GdkSurface Ptr


#DEFINE GDK_TYPE_EVENT (gdk_event_get_type ())
#DEFINE GDK_TYPE_EVENT_SEQUENCE (gdk_event_sequence_get_type ())
#DEFINE GDK_IS_EVENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_EVENT))
#DEFINE GDK_EVENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_EVENT, GdkEvent))
#DEFINE GDK_IS_EVENT_TYPE(event, type) (gdk_event_get_event_type ((event)) (type))
#DEFINE GDK_PRIORITY_EVENTS (G_PRIORITY_DEFAULT)
#DEFINE GDK_PRIORITY_REDRAW (G_PRIORITY_HIGH_IDLE + 20)
#DEFINE GDK_EVENT_PROPAGATE (FALSE)
#DEFINE GDK_EVENT_STOP (TRUE)
#DEFINE GDK_BUTTON_PRIMARY (1)
#DEFINE GDK_BUTTON_MIDDLE (2)
#DEFINE GDK_BUTTON_SECONDARY (3)

Type GdkEventSequence AS _GdkEventSequence
Type GdkEvent AS _GdkEvent

#DEFINE GDK_TYPE_BUTTON_EVENT (gdk_button_event_get_type())
#DEFINE GDK_TYPE_CROSSING_EVENT (gdk_crossing_event_get_type())
#DEFINE GDK_TYPE_DELETE_EVENT (gdk_delete_event_get_type())
#DEFINE GDK_TYPE_DND_EVENT (gdk_dnd_event_get_type())
#DEFINE GDK_TYPE_FOCUS_EVENT (gdk_focus_event_get_type())
#DEFINE GDK_TYPE_GRAB_BROKEN_EVENT (gdk_grab_broken_event_get_type())
#DEFINE GDK_TYPE_KEY_EVENT (gdk_key_event_get_type())
#DEFINE GDK_TYPE_MOTION_EVENT (gdk_motion_event_get_type())
#DEFINE GDK_TYPE_PAD_EVENT (gdk_pad_event_get_type())
#DEFINE GDK_TYPE_PROXIMITY_EVENT (gdk_proximity_event_get_type())
#DEFINE GDK_TYPE_SCROLL_EVENT (gdk_scroll_event_get_type())
#DEFINE GDK_TYPE_TOUCH_EVENT (gdk_touch_event_get_type())
#DEFINE GDK_TYPE_TOUCHPAD_EVENT (gdk_touchpad_event_get_type())

Type GdkButtonEvent AS _GdkButtonEvent
Type GdkCrossingEvent AS _GdkCrossingEvent
Type GdkDeleteEvent AS _GdkDeleteEvent
Type GdkDNDEvent AS _GdkDNDEvent
Type GdkFocusEvent AS _GdkFocusEvent
Type GdkGrabBrokenEvent AS _GdkGrabBrokenEvent
Type GdkKeyEvent AS _GdkKeyEvent
Type GdkMotionEvent AS _GdkMotionEvent
Type GdkPadEvent AS _GdkPadEvent
Type GdkProximityEvent AS _GdkProximityEvent
Type GdkScrollEvent AS _GdkScrollEvent
Type GdkTouchEvent AS _GdkTouchEvent
Type GdkTouchpadEvent AS _GdkTouchpadEvent

Enum GdkEventType_
	GDK_DELETE
	GDK_MOTION_NOTIFY
	GDK_BUTTON_PRESS
	GDK_BUTTON_RELEASE
	GDK_KEY_PRESS
	GDK_KEY_RELEASE
	GDK_ENTER_NOTIFY
	GDK_LEAVE_NOTIFY
	GDK_FOCUS_CHANGE
	GDK_PROXIMITY_IN
	GDK_PROXIMITY_OUT
	GDK_DRAG_ENTER
	GDK_DRAG_LEAVE
	GDK_DRAG_MOTION
	GDK_DROP_START
	GDK_SCROLL
	GDK_GRAB_BROKEN
	GDK_TOUCH_BEGIN
	GDK_TOUCH_UPDATE
	GDK_TOUCH_END
	GDK_TOUCH_CANCEL
	GDK_TOUCHPAD_SWIPE
	GDK_TOUCHPAD_PINCH
	GDK_PAD_BUTTON_PRESS
	GDK_PAD_BUTTON_RELEASE
	GDK_PAD_RING
	GDK_PAD_STRIP
	GDK_PAD_GROUP_MODE
	GDK_TOUCHPAD_HOLD
	GDK_EVENT_LAST
End Enum
Type AS LONG GdkEventType

Enum GdkTouchpadGesturePhase_
	GDK_TOUCHPAD_GESTURE_PHASE_BEGIN
	GDK_TOUCHPAD_GESTURE_PHASE_UPDATE
	GDK_TOUCHPAD_GESTURE_PHASE_END
	GDK_TOUCHPAD_GESTURE_PHASE_CANCEL
End Enum
Type AS LONG GdkTouchpadGesturePhase

Enum GdkScrollDirection_
	GDK_SCROLL_UP
	GDK_SCROLL_DOWN
	GDK_SCROLL_LEFT
	GDK_SCROLL_RIGHT
	GDK_SCROLL_SMOOTH
End Enum
Type AS LONG GdkScrollDirection

Enum GdkScrollUnit_
	GDK_SCROLL_UNIT_WHEEL
	GDK_SCROLL_UNIT_SURFACE
End Enum
Type AS LONG GdkScrollUnit

Enum GdkNotifyType_
	GDK_NOTIFY_ANCESTOR = 0
	GDK_NOTIFY_VIRTUAL = 1
	GDK_NOTIFY_INFERIOR = 2
	GDK_NOTIFY_NONLINEAR = 3
	GDK_NOTIFY_NONLINEAR_VIRTUAL = 4
	GDK_NOTIFY_UNKNOWN = 5
End Enum
Type AS LONG GdkNotifyType

Enum GdkCrossingMode_
	GDK_CROSSING_NORMAL
	GDK_CROSSING_GRAB
	GDK_CROSSING_UNGRAB
	GDK_CROSSING_GTK_GRAB
	GDK_CROSSING_GTK_UNGRAB
	GDK_CROSSING_STATE_CHANGED
	GDK_CROSSING_TOUCH_BEGIN
	GDK_CROSSING_TOUCH_END
	GDK_CROSSING_DEVICE_SWITCH
End Enum
Type AS LONG GdkCrossingMode

Declare Function gdk_event_get_type CDECL() AS GType
Declare Function gdk_event_sequence_get_type CDECL() AS GType
Declare Function gdk_event_ref CDECL(BYVAL AS GdkEvent Ptr) AS GdkEvent Ptr
Declare Sub gdk_event_unref CDECL(BYVAL AS GdkEvent Ptr)
Declare Function gdk_event_get_event_type CDECL(BYVAL AS GdkEvent Ptr) AS GdkEventType
Declare Function gdk_event_get_surface CDECL(BYVAL AS GdkEvent Ptr) AS GdkSurface Ptr
Declare Function gdk_event_get_seat CDECL(BYVAL AS GdkEvent Ptr) AS GdkSeat Ptr
Declare Function gdk_event_get_device CDECL(BYVAL AS GdkEvent Ptr) AS GdkDevice Ptr
Declare Function gdk_event_get_device_tool CDECL(BYVAL AS GdkEvent Ptr) AS GdkDeviceTool Ptr
Declare Function gdk_event_get_time CDECL(BYVAL AS GdkEvent Ptr) AS guint32
Declare Function gdk_event_get_display CDECL(BYVAL AS GdkEvent Ptr) AS GdkDisplay Ptr
Declare Function gdk_event_get_event_sequence CDECL(BYVAL AS GdkEvent Ptr) AS GdkEventSequence Ptr
Declare Function gdk_event_get_modifier_state CDECL(BYVAL AS GdkEvent Ptr) AS GdkModifierType
Declare Function gdk_event_get_position CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr) AS gboolean
Declare Function gdk_event_get_axes CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS DOUBLE Ptr Ptr, BYVAL AS guint Ptr) AS gboolean
Declare Function gdk_event_get_axis CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS GdkAxisUse, BYVAL AS DOUBLE Ptr) AS gboolean
Declare Function gdk_event_get_history CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS guint Ptr) AS GdkTimeCoord Ptr
Declare Function gdk_event_get_pointer_emulated CDECL(BYVAL AS GdkEvent Ptr) AS gboolean
Declare Function gdk_button_event_get_type CDECL() AS GType
Declare Function gdk_button_event_get_button CDECL(BYVAL AS GdkEvent Ptr) AS guint
Declare Function gdk_scroll_event_get_type CDECL() AS GType
Declare Function gdk_scroll_event_get_direction CDECL(BYVAL AS GdkEvent Ptr) AS GdkScrollDirection
Declare Sub gdk_scroll_event_get_deltas CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr)
Declare Function gdk_scroll_event_get_unit CDECL(BYVAL AS GdkEvent Ptr) AS GdkScrollUnit
Declare Function gdk_scroll_event_is_stop CDECL(BYVAL AS GdkEvent Ptr) AS gboolean
Declare Function gdk_key_event_get_type CDECL() AS GType
Declare Function gdk_key_event_get_keyval CDECL(BYVAL AS GdkEvent Ptr) AS guint
Declare Function gdk_key_event_get_keycode CDECL(BYVAL AS GdkEvent Ptr) AS guint
Declare Function gdk_key_event_get_consumed_modifiers CDECL(BYVAL AS GdkEvent Ptr) AS GdkModifierType
Declare Function gdk_key_event_get_layout CDECL(BYVAL AS GdkEvent Ptr) AS guint
Declare Function gdk_key_event_get_level CDECL(BYVAL AS GdkEvent Ptr) AS guint
Declare Function gdk_key_event_is_modifier CDECL(BYVAL AS GdkEvent Ptr) AS gboolean
Declare Function gdk_focus_event_get_type CDECL() AS GType
Declare Function gdk_focus_event_get_in CDECL(BYVAL AS GdkEvent Ptr) AS gboolean
Declare Function gdk_touch_event_get_type CDECL() AS GType
Declare Function gdk_touch_event_get_emulating_pointer CDECL(BYVAL AS GdkEvent Ptr) AS gboolean
Declare Function gdk_crossing_event_get_type CDECL() AS GType
Declare Function gdk_crossing_event_get_mode CDECL(BYVAL AS GdkEvent Ptr) AS GdkCrossingMode
Declare Function gdk_crossing_event_get_detail CDECL(BYVAL AS GdkEvent Ptr) AS GdkNotifyType
Declare Function gdk_crossing_event_get_focus CDECL(BYVAL AS GdkEvent Ptr) AS gboolean
Declare Function gdk_touchpad_event_get_type CDECL() AS GType
Declare Function gdk_touchpad_event_get_gesture_phase CDECL(BYVAL AS GdkEvent Ptr) AS GdkTouchpadGesturePhase
Declare Function gdk_touchpad_event_get_n_fingers CDECL(BYVAL AS GdkEvent Ptr) AS guint
Declare Sub gdk_touchpad_event_get_deltas CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr)
Declare Function gdk_touchpad_event_get_pinch_angle_delta CDECL(BYVAL AS GdkEvent Ptr) AS DOUBLE
Declare Function gdk_touchpad_event_get_pinch_scale CDECL(BYVAL AS GdkEvent Ptr) AS DOUBLE
Declare Function gdk_pad_event_get_type CDECL() AS GType
Declare Function gdk_pad_event_get_button CDECL(BYVAL AS GdkEvent Ptr) AS guint
Declare Sub gdk_pad_event_get_axis_value CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS guint Ptr, BYVAL AS DOUBLE Ptr)
Declare Sub gdk_pad_event_get_group_mode CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS guint Ptr, BYVAL AS guint Ptr)
Declare Function gdk_dnd_event_get_type CDECL() AS GType
Declare Function gdk_dnd_event_get_drop CDECL(BYVAL AS GdkEvent Ptr) AS GdkDrop Ptr
Declare Function gdk_grab_broken_event_get_type CDECL() AS GType
Declare Function gdk_grab_broken_event_get_grab_surface CDECL(BYVAL AS GdkEvent Ptr) AS GdkSurface Ptr
Declare Function gdk_grab_broken_event_get_implicit CDECL(BYVAL AS GdkEvent Ptr) AS gboolean
Declare Function gdk_motion_event_get_type CDECL() AS GType
Declare Function gdk_delete_event_get_type CDECL() AS GType
Declare Function gdk_proximity_event_get_type CDECL() AS GType
Declare Function gdk_event_triggers_context_menu CDECL(BYVAL AS GdkEvent Ptr) AS gboolean
Declare Function gdk_events_get_distance CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS GdkEvent Ptr, BYVAL AS DOUBLE Ptr) AS gboolean
Declare Function gdk_events_get_angle CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS GdkEvent Ptr, BYVAL AS DOUBLE Ptr) AS gboolean
Declare Function gdk_events_get_center CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS GdkEvent Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr) AS gboolean

Enum GdkKeyMatch_
	GDK_KEY_MATCH_NONE
	GDK_KEY_MATCH_PARTIAL
	GDK_KEY_MATCH_EXACT
End Enum
Type AS LONG GdkKeyMatch

Declare Function gdk_key_event_matches CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS guint, BYVAL AS GdkModifierType) AS GdkKeyMatch
Declare Function gdk_key_event_get_match CDECL(BYVAL AS GdkEvent Ptr, BYVAL AS guint Ptr, BYVAL AS GdkModifierType Ptr) AS gboolean

Type GdkFrameTimings AS _GdkFrameTimings

Declare Function gdk_frame_timings_get_type CDECL() AS GType
Declare Function gdk_frame_timings_ref CDECL(BYVAL AS GdkFrameTimings Ptr) AS GdkFrameTimings Ptr
Declare Sub gdk_frame_timings_unref CDECL(BYVAL AS GdkFrameTimings Ptr)
Declare Function gdk_frame_timings_get_frame_counter CDECL(BYVAL AS GdkFrameTimings Ptr) AS gint64
Declare Function gdk_frame_timings_get_complete CDECL(BYVAL AS GdkFrameTimings Ptr) AS gboolean
Declare Function gdk_frame_timings_get_frame_time CDECL(BYVAL AS GdkFrameTimings Ptr) AS gint64
Declare Function gdk_frame_timings_get_presentation_time CDECL(BYVAL AS GdkFrameTimings Ptr) AS gint64
Declare Function gdk_frame_timings_get_refresh_interval CDECL(BYVAL AS GdkFrameTimings Ptr) AS gint64
Declare Function gdk_frame_timings_get_predicted_presentation_time CDECL(BYVAL AS GdkFrameTimings Ptr) AS gint64


#DEFINE GDK_TYPE_FRAME_CLOCK (gdk_frame_clock_get_type ())
#DEFINE GDK_FRAME_CLOCK(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_FRAME_CLOCK, GdkFrameClock))
#DEFINE GDK_FRAME_CLOCK_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_FRAME_CLOCK, GdkFrameClockClass))
#DEFINE GDK_IS_FRAME_CLOCK(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_FRAME_CLOCK))
#DEFINE GDK_IS_FRAME_CLOCK_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_FRAME_CLOCK))
#DEFINE GDK_FRAME_CLOCK_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_FRAME_CLOCK, GdkFrameClockClass))

Type GdkFrameClock AS _GdkFrameClock
Type GdkFrameClockPrivate AS _GdkFrameClockPrivate
Type GdkFrameClockClass AS _GdkFrameClockClass

Enum GdkFrameClockPhase_
	GDK_FRAME_CLOCK_PHASE_NONE = 0
	GDK_FRAME_CLOCK_PHASE_FLUSH_EVENTS = 1  SHL 0
	GDK_FRAME_CLOCK_PHASE_BEFORE_PAINT = 1  SHL 1
	GDK_FRAME_CLOCK_PHASE_UPDATE = 1  SHL 2
	GDK_FRAME_CLOCK_PHASE_LAYOUT = 1  SHL 3
	GDK_FRAME_CLOCK_PHASE_PAINT = 1  SHL 4
	GDK_FRAME_CLOCK_PHASE_RESUME_EVENTS = 1  SHL 5
	GDK_FRAME_CLOCK_PHASE_AFTER_PAINT = 1  SHL 6
End Enum
Type AS LONG GdkFrameClockPhase

Declare Function gdk_frame_clock_get_type CDECL() AS GType
Declare Function gdk_frame_clock_get_frame_time CDECL(BYVAL AS GdkFrameClock Ptr) AS gint64
Declare Sub gdk_frame_clock_request_phase CDECL(BYVAL AS GdkFrameClock Ptr, BYVAL AS GdkFrameClockPhase)
Declare Sub gdk_frame_clock_begin_updating CDECL(BYVAL AS GdkFrameClock Ptr)
Declare Sub gdk_frame_clock_end_updating CDECL(BYVAL AS GdkFrameClock Ptr)
Declare Function gdk_frame_clock_get_frame_counter CDECL(BYVAL AS GdkFrameClock Ptr) AS gint64
Declare Function gdk_frame_clock_get_history_start CDECL(BYVAL AS GdkFrameClock Ptr) AS gint64
Declare Function gdk_frame_clock_get_timings CDECL(BYVAL AS GdkFrameClock Ptr, BYVAL AS gint64) AS GdkFrameTimings Ptr
Declare Function gdk_frame_clock_get_current_timings CDECL(BYVAL AS GdkFrameClock Ptr) AS GdkFrameTimings Ptr
Declare Sub gdk_frame_clock_get_refresh_info CDECL(BYVAL AS GdkFrameClock Ptr, BYVAL AS gint64, BYVAL AS gint64 Ptr, BYVAL AS gint64 Ptr)
Declare Function gdk_frame_clock_get_fps CDECL(BYVAL AS GdkFrameClock Ptr) AS DOUBLE

#DEFINE GDK_TYPE_MONITOR (gdk_monitor_get_type ())
#DEFINE GDK_MONITOR(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_MONITOR, GdkMonitor))
#DEFINE GDK_IS_MONITOR(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_MONITOR))

Type GdkMonitor AS _GdkMonitor
Type GdkMonitorClass AS _GdkMonitorClass

Enum GdkSubpixelLayout_
	GDK_SUBPIXEL_LAYOUT_UNKNOWN
	GDK_SUBPIXEL_LAYOUT_NONE
	GDK_SUBPIXEL_LAYOUT_HORIZONTAL_RGB
	GDK_SUBPIXEL_LAYOUT_HORIZONTAL_BGR
	GDK_SUBPIXEL_LAYOUT_VERTICAL_RGB
	GDK_SUBPIXEL_LAYOUT_VERTICAL_BGR
End Enum
Type AS LONG GdkSubpixelLayout

Declare Function gdk_monitor_get_type CDECL() AS GType
Declare Function gdk_monitor_get_display CDECL(BYVAL AS GdkMonitor Ptr) AS GdkDisplay Ptr
Declare Sub gdk_monitor_get_geometry CDECL(BYVAL AS GdkMonitor Ptr, BYVAL AS GdkRectangle Ptr)
Declare Function gdk_monitor_get_width_mm CDECL(BYVAL AS GdkMonitor Ptr) AS LONG
Declare Function gdk_monitor_get_height_mm CDECL(BYVAL AS GdkMonitor Ptr) AS LONG
Declare Function gdk_monitor_get_manufacturer CDECL(BYVAL AS GdkMonitor Ptr) AS Const ZSTRING Ptr
Declare Function gdk_monitor_get_model CDECL(BYVAL AS GdkMonitor Ptr) AS Const ZSTRING Ptr
Declare Function gdk_monitor_get_connector CDECL(BYVAL AS GdkMonitor Ptr) AS Const ZSTRING Ptr
Declare Function gdk_monitor_get_scale_factor CDECL(BYVAL AS GdkMonitor Ptr) AS LONG
Declare Function gdk_monitor_get_scale CDECL(BYVAL AS GdkMonitor Ptr) AS DOUBLE
Declare Function gdk_monitor_get_refresh_rate CDECL(BYVAL AS GdkMonitor Ptr) AS LONG
Declare Function gdk_monitor_get_subpixel_layout CDECL(BYVAL AS GdkMonitor Ptr) AS GdkSubpixelLayout
Declare Function gdk_monitor_is_valid CDECL(BYVAL AS GdkMonitor Ptr) AS gboolean
Declare Function gdk_monitor_get_description CDECL(BYVAL AS GdkMonitor Ptr) AS Const ZSTRING Ptr

Enum GdkAnchorHints_
	GDK_ANCHOR_FLIP_X = 1  SHL 0
	GDK_ANCHOR_FLIP_Y = 1  SHL 1
	GDK_ANCHOR_SLIDE_X = 1  SHL 2
	GDK_ANCHOR_SLIDE_Y = 1  SHL 3
	GDK_ANCHOR_RESIZE_X = 1  SHL 4
	GDK_ANCHOR_RESIZE_Y = 1  SHL 5
	GDK_ANCHOR_FLIP = GDK_ANCHOR_FLIP_X  OR  GDK_ANCHOR_FLIP_Y
	GDK_ANCHOR_SLIDE = GDK_ANCHOR_SLIDE_X  OR  GDK_ANCHOR_SLIDE_Y
	GDK_ANCHOR_RESIZE = GDK_ANCHOR_RESIZE_X  OR  GDK_ANCHOR_RESIZE_Y
End Enum
Type AS LONG GdkAnchorHints

Type GdkPopupLayout AS _GdkPopupLayout

#DEFINE GDK_TYPE_POPUP_LAYOUT (gdk_popup_layout_get_type ())

Declare Function gdk_popup_layout_get_type CDECL() AS GType
Declare Function gdk_popup_layout_new CDECL(BYVAL AS Const GdkRectangle Ptr, BYVAL AS GdkGravity, BYVAL AS GdkGravity) AS GdkPopupLayout Ptr
Declare Function gdk_popup_layout_ref CDECL(BYVAL AS GdkPopupLayout Ptr) AS GdkPopupLayout Ptr
Declare Sub gdk_popup_layout_unref CDECL(BYVAL AS GdkPopupLayout Ptr)
Declare Function gdk_popup_layout_copy CDECL(BYVAL AS GdkPopupLayout Ptr) AS GdkPopupLayout Ptr
Declare Function gdk_popup_layout_equal CDECL(BYVAL AS GdkPopupLayout Ptr, BYVAL AS GdkPopupLayout Ptr) AS gboolean
Declare Sub gdk_popup_layout_set_anchor_rect CDECL(BYVAL AS GdkPopupLayout Ptr, BYVAL AS Const GdkRectangle Ptr)
Declare Function gdk_popup_layout_get_anchor_rect CDECL(BYVAL AS GdkPopupLayout Ptr) AS Const GdkRectangle Ptr
Declare Sub gdk_popup_layout_set_rect_anchor CDECL(BYVAL AS GdkPopupLayout Ptr, BYVAL AS GdkGravity)
Declare Function gdk_popup_layout_get_rect_anchor CDECL(BYVAL AS GdkPopupLayout Ptr) AS GdkGravity
Declare Sub gdk_popup_layout_set_surface_anchor CDECL(BYVAL AS GdkPopupLayout Ptr, BYVAL AS GdkGravity)
Declare Function gdk_popup_layout_get_surface_anchor CDECL(BYVAL AS GdkPopupLayout Ptr) AS GdkGravity
Declare Sub gdk_popup_layout_set_anchor_hints CDECL(BYVAL AS GdkPopupLayout Ptr, BYVAL AS GdkAnchorHints)
Declare Function gdk_popup_layout_get_anchor_hints CDECL(BYVAL AS GdkPopupLayout Ptr) AS GdkAnchorHints
Declare Sub gdk_popup_layout_set_offset CDECL(BYVAL AS GdkPopupLayout Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare Sub gdk_popup_layout_get_offset CDECL(BYVAL AS GdkPopupLayout Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare Sub gdk_popup_layout_set_shadow_width CDECL(BYVAL AS GdkPopupLayout Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG)
Declare Sub gdk_popup_layout_get_shadow_width CDECL(BYVAL AS GdkPopupLayout Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)


Type GdkSurfaceClass AS _GdkSurfaceClass

#DEFINE GDK_TYPE_SURFACE (gdk_surface_get_type ())
#DEFINE GDK_SURFACE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_SURFACE, GdkSurface))
#DEFINE GDK_SURFACE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_SURFACE, GdkSurfaceClass))
#DEFINE GDK_IS_SURFACE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_SURFACE))
#DEFINE GDK_IS_SURFACE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_SURFACE))
#DEFINE GDK_SURFACE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_SURFACE, GdkSurfaceClass))

Declare Function gdk_surface_get_type CDECL() AS GType
Declare Function gdk_surface_new_toplevel CDECL(BYVAL AS GdkDisplay Ptr) AS GdkSurface Ptr
Declare Function gdk_surface_new_popup CDECL(BYVAL AS GdkSurface Ptr, BYVAL AS gboolean) AS GdkSurface Ptr
Declare Sub gdk_surface_destroy CDECL(BYVAL AS GdkSurface Ptr)
Declare Function gdk_surface_is_destroyed CDECL(BYVAL AS GdkSurface Ptr) AS gboolean
Declare Function gdk_surface_get_display CDECL(BYVAL AS GdkSurface Ptr) AS GdkDisplay Ptr
Declare Sub gdk_surface_hide CDECL(BYVAL AS GdkSurface Ptr)
Declare Sub gdk_surface_set_input_region CDECL(BYVAL AS GdkSurface Ptr, BYVAL AS cairo_region_t Ptr)
Declare Function gdk_surface_get_mapped CDECL(BYVAL AS GdkSurface Ptr) AS gboolean
Declare Sub gdk_surface_set_cursor CDECL(BYVAL AS GdkSurface Ptr, BYVAL AS GdkCursor Ptr)
Declare Function gdk_surface_get_cursor CDECL(BYVAL AS GdkSurface Ptr) AS GdkCursor Ptr
Declare Sub gdk_surface_set_device_cursor CDECL(BYVAL AS GdkSurface Ptr, BYVAL AS GdkDevice Ptr, BYVAL AS GdkCursor Ptr)
Declare Function gdk_surface_get_device_cursor CDECL(BYVAL AS GdkSurface Ptr, BYVAL AS GdkDevice Ptr) AS GdkCursor Ptr
Declare Function gdk_surface_get_width CDECL(BYVAL AS GdkSurface Ptr) AS LONG
Declare Function gdk_surface_get_height CDECL(BYVAL AS GdkSurface Ptr) AS LONG
Declare Function gdk_surface_translate_coordinates CDECL(BYVAL AS GdkSurface Ptr, BYVAL AS GdkSurface Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr) AS gboolean
Declare Function gdk_surface_get_scale_factor CDECL(BYVAL AS GdkSurface Ptr) AS LONG
Declare Function gdk_surface_get_scale CDECL(BYVAL AS GdkSurface Ptr) AS DOUBLE
Declare Function gdk_surface_get_device_position CDECL(BYVAL AS GdkSurface Ptr, BYVAL AS GdkDevice Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS GdkModifierType Ptr) AS gboolean
Declare Sub gdk_surface_beep CDECL(BYVAL AS GdkSurface Ptr)
Declare Sub gdk_surface_queue_render CDECL(BYVAL AS GdkSurface Ptr)
Declare Sub gdk_surface_request_layout CDECL(BYVAL AS GdkSurface Ptr)
Declare Function gdk_surface_get_frame_clock CDECL(BYVAL AS GdkSurface Ptr) AS GdkFrameClock Ptr
Declare Function gdk_surface_create_cairo_context CDECL(BYVAL AS GdkSurface Ptr) AS GdkCairoContext Ptr
Declare Function gdk_surface_create_gl_context CDECL(BYVAL AS GdkSurface Ptr, BYVAL AS GError Ptr Ptr) AS GdkGLContext Ptr

#DEFINE GDK_TYPE_SEAT (gdk_seat_get_type ())
#DEFINE GDK_SEAT(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GDK_TYPE_SEAT, GdkSeat))
#DEFINE GDK_IS_SEAT(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_SEAT))

Enum GdkSeatCapabilities_
	GDK_SEAT_CAPABILITY_NONE = 0
	GDK_SEAT_CAPABILITY_POINTER = 1  SHL 0
	GDK_SEAT_CAPABILITY_TOUCH = 1  SHL 1
	GDK_SEAT_CAPABILITY_TABLET_STYLUS = 1  SHL 2
	GDK_SEAT_CAPABILITY_KEYBOARD = 1  SHL 3
	GDK_SEAT_CAPABILITY_TABLET_PAD = 1  SHL 4
	GDK_SEAT_CAPABILITY_ALL_POINTING = (GDK_SEAT_CAPABILITY_POINTER  OR  GDK_SEAT_CAPABILITY_TOUCH  OR  GDK_SEAT_CAPABILITY_TABLET_STYLUS)
	GDK_SEAT_CAPABILITY_ALL = (GDK_SEAT_CAPABILITY_ALL_POINTING  OR  GDK_SEAT_CAPABILITY_KEYBOARD  OR  GDK_SEAT_CAPABILITY_TABLET_PAD)
End Enum
Type AS LONG GdkSeatCapabilities

Type _GdkSeat
	AS GObject parent_instance
End Type

Declare Function gdk_seat_get_type CDECL() AS GType
Declare Function gdk_seat_get_display CDECL(BYVAL AS GdkSeat Ptr) AS GdkDisplay Ptr
Declare Function gdk_seat_get_capabilities CDECL(BYVAL AS GdkSeat Ptr) AS GdkSeatCapabilities
Declare Function gdk_seat_get_devices CDECL(BYVAL AS GdkSeat Ptr, BYVAL AS GdkSeatCapabilities) AS GList Ptr
Declare Function gdk_seat_get_tools CDECL(BYVAL AS GdkSeat Ptr) AS GList Ptr
Declare Function gdk_seat_get_pointer CDECL(BYVAL AS GdkSeat Ptr) AS GdkDevice Ptr
Declare Function gdk_seat_get_keyboard CDECL(BYVAL AS GdkSeat Ptr) AS GdkDevice Ptr

#DEFINE GDK_TYPE_DISPLAY (gdk_display_get_type ())
#DEFINE GDK_DISPLAY(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DISPLAY, GdkDisplay))
#DEFINE GDK_IS_DISPLAY(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DISPLAY))

Declare Function gdk_display_get_type CDECL() AS GType
Declare Function gdk_display_open CDECL(BYVAL AS Const ZSTRING Ptr) AS GdkDisplay Ptr
Declare Function gdk_display_get_name CDECL(BYVAL AS GdkDisplay Ptr) AS Const ZSTRING Ptr
Declare Function gdk_display_device_is_grabbed CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS GdkDevice Ptr) AS gboolean
Declare Sub gdk_display_beep CDECL(BYVAL AS GdkDisplay Ptr)
Declare Sub gdk_display_sync CDECL(BYVAL AS GdkDisplay Ptr)
Declare Sub gdk_display_flush CDECL(BYVAL AS GdkDisplay Ptr)
Declare Sub gdk_display_close CDECL(BYVAL AS GdkDisplay Ptr)
Declare Function gdk_display_is_closed CDECL(BYVAL AS GdkDisplay Ptr) AS gboolean
Declare Function gdk_display_is_composited CDECL(BYVAL AS GdkDisplay Ptr) AS gboolean
Declare Function gdk_display_is_rgba CDECL(BYVAL AS GdkDisplay Ptr) AS gboolean
Declare Function gdk_display_supports_shadow_width CDECL(BYVAL AS GdkDisplay Ptr) AS gboolean
Declare Function gdk_display_supports_input_shapes CDECL(BYVAL AS GdkDisplay Ptr) AS gboolean
Declare Function gdk_display_prepare_gl CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gdk_display_create_gl_context CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS GError Ptr Ptr) AS GdkGLContext Ptr
Declare Function gdk_display_get_default CDECL() AS GdkDisplay Ptr
Declare Function gdk_display_get_clipboard CDECL(BYVAL AS GdkDisplay Ptr) AS GdkClipboard Ptr
Declare Function gdk_display_get_primary_clipboard CDECL(BYVAL AS GdkDisplay Ptr) AS GdkClipboard Ptr
Declare Function gdk_display_get_app_launch_context CDECL(BYVAL AS GdkDisplay Ptr) AS GdkAppLaunchContext Ptr
Declare Function gdk_display_get_default_seat CDECL(BYVAL AS GdkDisplay Ptr) AS GdkSeat Ptr
Declare Function gdk_display_list_seats CDECL(BYVAL AS GdkDisplay Ptr) AS GList Ptr
Declare Function gdk_display_get_monitors CDECL(BYVAL AS GdkDisplay Ptr) AS GListModel Ptr
Declare Function gdk_display_get_monitor_at_surface CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS GdkSurface Ptr) AS GdkMonitor Ptr
Declare Function gdk_display_map_keyval CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS guint, BYVAL AS GdkKeymapKey Ptr Ptr, BYVAL AS LONG Ptr) AS gboolean
Declare Function gdk_display_map_keycode CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS guint, BYVAL AS GdkKeymapKey Ptr Ptr, BYVAL AS guint Ptr Ptr, BYVAL AS LONG Ptr) AS gboolean
Declare Function gdk_display_translate_key CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS LONG, BYVAL AS guint Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS GdkModifierType Ptr) AS gboolean
Declare Function gdk_display_get_setting CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GValue Ptr) AS gboolean
Declare Function gdk_display_get_dmabuf_formats CDECL(BYVAL AS GdkDisplay Ptr) AS GdkDmabufFormats Ptr

#DEFINE GDK_TYPE_DISPLAY_MANAGER (gdk_display_manager_get_type ())
#DEFINE GDK_DISPLAY_MANAGER(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManager))
#DEFINE GDK_IS_DISPLAY_MANAGER(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DISPLAY_MANAGER))

Declare Function gdk_display_manager_get_type CDECL() AS GType
Declare Function gdk_display_manager_get CDECL() AS GdkDisplayManager Ptr
Declare Function gdk_display_manager_get_default_display CDECL(BYVAL AS GdkDisplayManager Ptr) AS GdkDisplay Ptr
Declare Sub gdk_display_manager_set_default_display CDECL(BYVAL AS GdkDisplayManager Ptr, BYVAL AS GdkDisplay Ptr)
Declare Function gdk_display_manager_list_displays CDECL(BYVAL AS GdkDisplayManager Ptr) AS GSList Ptr
Declare Function gdk_display_manager_open_display CDECL(BYVAL AS GdkDisplayManager Ptr, BYVAL AS Const ZSTRING Ptr) AS GdkDisplay Ptr
Declare Sub gdk_set_allowed_backends CDECL(BYVAL AS Const ZSTRING Ptr)


#DEFINE GDK_TYPE_DMABUF_FORMATS (gdk_dmabuf_formats_get_type ())

Declare Function gdk_dmabuf_formats_get_type CDECL() AS GType
Declare Function gdk_dmabuf_formats_ref CDECL(BYVAL AS GdkDmabufFormats Ptr) AS GdkDmabufFormats Ptr
Declare Sub gdk_dmabuf_formats_unref CDECL(BYVAL AS GdkDmabufFormats Ptr)
Declare Function gdk_dmabuf_formats_get_n_formats CDECL(BYVAL AS GdkDmabufFormats Ptr) AS gsize
Declare Sub gdk_dmabuf_formats_get_format CDECL(BYVAL AS GdkDmabufFormats Ptr, BYVAL AS gsize, BYVAL AS guint32 Ptr, BYVAL AS guint64 Ptr)
Declare Function gdk_dmabuf_formats_contains CDECL(BYVAL AS GdkDmabufFormats Ptr, BYVAL AS guint32, BYVAL AS guint64) AS gboolean
Declare Function gdk_dmabuf_formats_equal CDECL(BYVAL AS Const GdkDmabufFormats Ptr, BYVAL AS Const GdkDmabufFormats Ptr) AS gboolean


#DEFINE GDK_TYPE_TEXTURE (gdk_texture_get_type ())
#DEFINE GDK_TEXTURE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_TEXTURE, GdkTexture))
#DEFINE GDK_IS_TEXTURE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_TEXTURE))

Type GdkTextureClass AS _GdkTextureClass

#DEFINE GDK_TEXTURE_ERROR (gdk_texture_error_quark ())

Declare Function gdk_texture_error_quark CDECL() AS GQuark

Enum GdkTextureError_
	GDK_TEXTURE_ERROR_TOO_LARGE
	GDK_TEXTURE_ERROR_CORRUPT_IMAGE
	GDK_TEXTURE_ERROR_UNSUPPORTED_CONTENT
	GDK_TEXTURE_ERROR_UNSUPPORTED_FORMAT
End Enum
Type AS LONG GdkTextureError

Declare Function gdk_texture_get_type CDECL() AS GType
Declare Function gdk_texture_new_for_pixbuf CDECL(BYVAL AS GdkPixbuf Ptr) AS GdkTexture Ptr
Declare Function gdk_texture_new_from_resource CDECL(BYVAL AS Const ZSTRING Ptr) AS GdkTexture Ptr
Declare Function gdk_texture_new_from_file CDECL(BYVAL AS GFile Ptr, BYVAL AS GError Ptr Ptr) AS GdkTexture Ptr
Declare Function gdk_texture_new_from_filename CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS GdkTexture Ptr
Declare Function gdk_texture_new_from_bytes CDECL(BYVAL AS GBytes Ptr, BYVAL AS GError Ptr Ptr) AS GdkTexture Ptr
Declare Function gdk_texture_get_width CDECL(BYVAL AS GdkTexture Ptr) AS LONG
Declare Function gdk_texture_get_height CDECL(BYVAL AS GdkTexture Ptr) AS LONG
Declare Function gdk_texture_get_format CDECL(BYVAL AS GdkTexture Ptr) AS GdkMemoryFormat
Declare Function gdk_texture_get_color_state CDECL(BYVAL AS GdkTexture Ptr) AS GdkColorState Ptr
Declare Sub gdk_texture_download CDECL(BYVAL AS GdkTexture Ptr, BYVAL AS guchar Ptr, BYVAL AS gsize)
Declare Function gdk_texture_save_to_png CDECL(BYVAL AS GdkTexture Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gdk_texture_save_to_png_bytes CDECL(BYVAL AS GdkTexture Ptr) AS GBytes Ptr
Declare Function gdk_texture_save_to_tiff CDECL(BYVAL AS GdkTexture Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gdk_texture_save_to_tiff_bytes CDECL(BYVAL AS GdkTexture Ptr) AS GBytes Ptr


#DEFINE GDK_TYPE_DMABUF_TEXTURE (gdk_dmabuf_texture_get_type ())
#DEFINE GDK_DMABUF_TEXTURE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_DMABUF_TEXTURE, GdkDmabufTexture))
#DEFINE GDK_IS_DMABUF_TEXTURE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_DMABUF_TEXTURE))
#DEFINE GDK_DMABUF_ERROR (gdk_dmabuf_error_quark ())

Type GdkDmabufTextureClass AS _GdkDmabufTextureClass

Declare Function gdk_dmabuf_texture_get_type CDECL() AS GType
Declare Function gdk_dmabuf_error_quark CDECL() AS GQuark


#DEFINE GDK_TYPE_DMABUF_TEXTURE_BUILDER (gdk_dmabuf_texture_builder_get_type ())

Type GdkDmabufTextureBuilder AS _GdkDmabufTextureBuilder
Declare Function gdk_dmabuf_texture_builder_new CDECL() AS GdkDmabufTextureBuilder Ptr
Declare Function gdk_dmabuf_texture_builder_get_display CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr) AS GdkDisplay Ptr
Declare Sub gdk_dmabuf_texture_builder_set_display CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS GdkDisplay Ptr)
Declare Function gdk_dmabuf_texture_builder_get_width CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr) AS ULONG
Declare Sub gdk_dmabuf_texture_builder_set_width CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS ULONG)
Declare Function gdk_dmabuf_texture_builder_get_height CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr) AS ULONG
Declare Sub gdk_dmabuf_texture_builder_set_height CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS ULONG)
Declare Function gdk_dmabuf_texture_builder_get_fourcc CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr) AS guint32
Declare Sub gdk_dmabuf_texture_builder_set_fourcc CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS guint32)
Declare Function gdk_dmabuf_texture_builder_get_modifier CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr) AS guint64
Declare Sub gdk_dmabuf_texture_builder_set_modifier CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS guint64)
Declare Function gdk_dmabuf_texture_builder_get_premultiplied CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr) AS gboolean
Declare Sub gdk_dmabuf_texture_builder_set_premultiplied CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS gboolean)
Declare Function gdk_dmabuf_texture_builder_get_n_planes CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr) AS ULONG
Declare Sub gdk_dmabuf_texture_builder_set_n_planes CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS ULONG)
Declare Function gdk_dmabuf_texture_builder_get_fd CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS ULONG) AS LONG
Declare Sub gdk_dmabuf_texture_builder_set_fd CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS ULONG, BYVAL AS LONG)
Declare Function gdk_dmabuf_texture_builder_get_stride CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS ULONG) AS ULONG
Declare Sub gdk_dmabuf_texture_builder_set_stride CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS ULONG, BYVAL AS ULONG)
Declare Function gdk_dmabuf_texture_builder_get_offset CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS ULONG) AS ULONG
Declare Sub gdk_dmabuf_texture_builder_set_offset CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS ULONG, BYVAL AS ULONG)
Declare Function gdk_dmabuf_texture_builder_get_color_state CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr) AS GdkColorState Ptr
Declare Sub gdk_dmabuf_texture_builder_set_color_state CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS GdkColorState Ptr)
Declare Function gdk_dmabuf_texture_builder_get_update_texture CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr) AS GdkTexture Ptr
Declare Sub gdk_dmabuf_texture_builder_set_update_texture CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS GdkTexture Ptr)
Declare Function gdk_dmabuf_texture_builder_get_update_region CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr) AS cairo_region_t Ptr
Declare Sub gdk_dmabuf_texture_builder_set_update_region CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS cairo_region_t Ptr)
Declare Function gdk_dmabuf_texture_builder_build CDECL(BYVAL AS GdkDmabufTextureBuilder Ptr, BYVAL AS GDestroyNotify, BYVAL AS gpointer, BYVAL AS GError Ptr Ptr) AS GdkTexture Ptr


#DEFINE GDK_TYPE_DRAG_SURFACE (gdk_drag_surface_get_type ())

Type GdkDragSurface AS _GdkDragSurface
Declare Function gdk_drag_surface_present CDECL(BYVAL AS GdkDragSurface Ptr, BYVAL AS LONG, BYVAL AS LONG) AS gboolean


Type GdkDragSurfaceSize AS _GdkDragSurfaceSize

#DEFINE GDK_TYPE_DRAG_SURFACE_SIZE (gdk_drag_surface_size_get_type ())

Declare Function gdk_drag_surface_size_get_type CDECL() AS GType
Declare Sub gdk_drag_surface_size_set_size CDECL(BYVAL AS GdkDragSurfaceSize Ptr, BYVAL AS LONG, BYVAL AS LONG)


#DEFINE GDK_TYPE_DRAW_CONTEXT (gdk_draw_context_get_type ())
#DEFINE GDK_DRAW_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_DRAW_CONTEXT, GdkDrawContext))
#DEFINE GDK_IS_DRAW_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_DRAW_CONTEXT))

Declare Function gdk_draw_context_get_type CDECL() AS GType
Declare Function gdk_draw_context_get_display CDECL(BYVAL AS GdkDrawContext Ptr) AS GdkDisplay Ptr
Declare Function gdk_draw_context_get_surface CDECL(BYVAL AS GdkDrawContext Ptr) AS GdkSurface Ptr


#DEFINE GDK_TYPE_DROP (gdk_drop_get_type ())
#DEFINE GDK_DROP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DROP, GdkDrop))
#DEFINE GDK_IS_DROP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DROP))

Declare Function gdk_drop_get_type CDECL() AS GType
Declare Function gdk_drop_get_display CDECL(BYVAL AS GdkDrop Ptr) AS GdkDisplay Ptr
Declare Function gdk_drop_get_device CDECL(BYVAL AS GdkDrop Ptr) AS GdkDevice Ptr
Declare Function gdk_drop_get_surface CDECL(BYVAL AS GdkDrop Ptr) AS GdkSurface Ptr
Declare Function gdk_drop_get_formats CDECL(BYVAL AS GdkDrop Ptr) AS GdkContentFormats Ptr
Declare Function gdk_drop_get_actions CDECL(BYVAL AS GdkDrop Ptr) AS GdkDragAction
Declare Function gdk_drop_get_drag CDECL(BYVAL AS GdkDrop Ptr) AS GdkDrag Ptr
Declare Sub gdk_drop_status CDECL(BYVAL AS GdkDrop Ptr, BYVAL AS GdkDragAction, BYVAL AS GdkDragAction)
Declare Sub gdk_drop_finish CDECL(BYVAL AS GdkDrop Ptr, BYVAL AS GdkDragAction)
Declare Sub gdk_drop_read_async CDECL(BYVAL AS GdkDrop Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS LONG, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gdk_drop_read_finish CDECL(BYVAL AS GdkDrop Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS GError Ptr Ptr) AS GInputStream Ptr
Declare Sub gdk_drop_read_value_async CDECL(BYVAL AS GdkDrop Ptr, BYVAL AS GType, BYVAL AS LONG, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gdk_drop_read_value_finish CDECL(BYVAL AS GdkDrop Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS Const GValue Ptr


Declare Function gdk_cicp_range_get_type CDECL() AS GType
#DEFINE GDK_TYPE_CICP_RANGE (gdk_cicp_range_get_type())
Declare Function gdk_input_source_get_type CDECL() AS GType
#DEFINE GDK_TYPE_INPUT_SOURCE (gdk_input_source_get_type())
Declare Function gdk_device_pad_feature_get_type CDECL() AS GType
#DEFINE GDK_TYPE_DEVICE_PAD_FEATURE (gdk_device_pad_feature_get_type())
Declare Function gdk_device_tool_type_get_type CDECL() AS GType
#DEFINE GDK_TYPE_DEVICE_TOOL_TYPE (gdk_device_tool_type_get_type())
Declare Function gdk_drag_cancel_reason_get_type CDECL() AS GType
#DEFINE GDK_TYPE_DRAG_CANCEL_REASON (gdk_drag_cancel_reason_get_type())
Declare Function gdk_gl_api_get_type CDECL() AS GType
#DEFINE GDK_TYPE_GL_API (gdk_gl_api_get_type())
Declare Function gdk_gravity_get_type CDECL() AS GType
#DEFINE GDK_TYPE_GRAVITY (gdk_gravity_get_type())
Declare Function gdk_modifier_type_get_type CDECL() AS GType
#DEFINE GDK_TYPE_MODIFIER_TYPE (gdk_modifier_type_get_type())
Declare Function gdk_dmabuf_error_get_type CDECL() AS GType
#DEFINE GDK_TYPE_DMABUF_ERROR (gdk_dmabuf_error_get_type())
Declare Function gdk_gl_error_get_type CDECL() AS GType
#DEFINE GDK_TYPE_GL_ERROR (gdk_gl_error_get_type())
Declare Function gdk_vulkan_error_get_type CDECL() AS GType
#DEFINE GDK_TYPE_VULKAN_ERROR (gdk_vulkan_error_get_type())
Declare Function gdk_axis_use_get_type CDECL() AS GType
#DEFINE GDK_TYPE_AXIS_USE (gdk_axis_use_get_type())
Declare Function gdk_axis_flags_get_type CDECL() AS GType
#DEFINE GDK_TYPE_AXIS_FLAGS (gdk_axis_flags_get_type())
Declare Function gdk_drag_action_get_type CDECL() AS GType
#DEFINE GDK_TYPE_DRAG_ACTION (gdk_drag_action_get_type())
Declare Function gdk_memory_format_get_type CDECL() AS GType
#DEFINE GDK_TYPE_MEMORY_FORMAT (gdk_memory_format_get_type())
Declare Function gdk_event_type_get_type CDECL() AS GType
#DEFINE GDK_TYPE_EVENT_TYPE (gdk_event_type_get_type())
Declare Function gdk_touchpad_gesture_phase_get_type CDECL() AS GType
#DEFINE GDK_TYPE_TOUCHPAD_GESTURE_PHASE (gdk_touchpad_gesture_phase_get_type())
Declare Function gdk_scroll_direction_get_type CDECL() AS GType
#DEFINE GDK_TYPE_SCROLL_DIRECTION (gdk_scroll_direction_get_type())
Declare Function gdk_scroll_unit_get_type CDECL() AS GType
#DEFINE GDK_TYPE_SCROLL_UNIT (gdk_scroll_unit_get_type())
Declare Function gdk_notify_type_get_type CDECL() AS GType
#DEFINE GDK_TYPE_NOTIFY_TYPE (gdk_notify_type_get_type())
Declare Function gdk_crossing_mode_get_type CDECL() AS GType
#DEFINE GDK_TYPE_CROSSING_MODE (gdk_crossing_mode_get_type())
Declare Function gdk_key_match_get_type CDECL() AS GType
#DEFINE GDK_TYPE_KEY_MATCH (gdk_key_match_get_type())
Declare Function gdk_frame_clock_phase_get_type CDECL() AS GType
#DEFINE GDK_TYPE_FRAME_CLOCK_PHASE (gdk_frame_clock_phase_get_type())
Declare Function gdk_subpixel_layout_get_type CDECL() AS GType
#DEFINE GDK_TYPE_SUBPIXEL_LAYOUT (gdk_subpixel_layout_get_type())
Declare Function gdk_paintable_flags_get_type CDECL() AS GType
#DEFINE GDK_TYPE_PAINTABLE_FLAGS (gdk_paintable_flags_get_type())
Declare Function gdk_anchor_hints_get_type CDECL() AS GType
#DEFINE GDK_TYPE_ANCHOR_HINTS (gdk_anchor_hints_get_type())
Declare Function gdk_seat_capabilities_get_type CDECL() AS GType
#DEFINE GDK_TYPE_SEAT_CAPABILITIES (gdk_seat_capabilities_get_type())
Declare Function gdk_texture_error_get_type CDECL() AS GType
#DEFINE GDK_TYPE_TEXTURE_ERROR (gdk_texture_error_get_type())
Declare Function gdk_surface_edge_get_type CDECL() AS GType
#DEFINE GDK_TYPE_SURFACE_EDGE (gdk_surface_edge_get_type())
Declare Function gdk_fullscreen_mode_get_type CDECL() AS GType
#DEFINE GDK_TYPE_FULLSCREEN_MODE (gdk_fullscreen_mode_get_type())
Declare Function gdk_toplevel_state_get_type CDECL() AS GType
#DEFINE GDK_TYPE_TOPLEVEL_STATE (gdk_toplevel_state_get_type())
Declare Function gdk_titlebar_gesture_get_type CDECL() AS GType
#DEFINE GDK_TYPE_TITLEBAR_GESTURE (gdk_titlebar_gesture_get_type())

#DEFINE GDK_TYPE_GL_CONTEXT (gdk_gl_context_get_type ())
#DEFINE GDK_GL_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_GL_CONTEXT, GdkGLContext))
#DEFINE GDK_IS_GL_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_GL_CONTEXT))
#DEFINE GDK_GL_ERROR (gdk_gl_error_quark ())

Declare Function gdk_gl_error_quark CDECL() AS GQuark
Declare Function gdk_gl_context_get_type CDECL() AS GType
Declare Function gdk_gl_context_get_display CDECL(BYVAL AS GdkGLContext Ptr) AS GdkDisplay Ptr
Declare Function gdk_gl_context_get_surface CDECL(BYVAL AS GdkGLContext Ptr) AS GdkSurface Ptr

Declare Sub gdk_gl_context_get_version CDECL(BYVAL AS GdkGLContext Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare Function gdk_gl_context_is_legacy CDECL(BYVAL AS GdkGLContext Ptr) AS gboolean
Declare Function gdk_gl_context_is_shared CDECL(BYVAL AS GdkGLContext Ptr, BYVAL AS GdkGLContext Ptr) AS gboolean
Declare Sub gdk_gl_context_set_required_version CDECL(BYVAL AS GdkGLContext Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare Sub gdk_gl_context_get_required_version CDECL(BYVAL AS GdkGLContext Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare Sub gdk_gl_context_set_debug_enabled CDECL(BYVAL AS GdkGLContext Ptr, BYVAL AS gboolean)
Declare Function gdk_gl_context_get_debug_enabled CDECL(BYVAL AS GdkGLContext Ptr) AS gboolean
Declare Sub gdk_gl_context_set_forward_compatible CDECL(BYVAL AS GdkGLContext Ptr, BYVAL AS gboolean)
Declare Function gdk_gl_context_get_forward_compatible CDECL(BYVAL AS GdkGLContext Ptr) AS gboolean
Declare Sub gdk_gl_context_set_allowed_apis CDECL(BYVAL AS GdkGLContext Ptr, BYVAL AS GdkGLAPI)
Declare Function gdk_gl_context_get_allowed_apis CDECL(BYVAL AS GdkGLContext Ptr) AS GdkGLAPI
Declare Function gdk_gl_context_get_api CDECL(BYVAL AS GdkGLContext Ptr) AS GdkGLAPI
Declare Function gdk_gl_context_get_use_es CDECL(BYVAL AS GdkGLContext Ptr) AS gboolean
Declare Function gdk_gl_context_realize CDECL(BYVAL AS GdkGLContext Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Sub gdk_gl_context_make_current CDECL(BYVAL AS GdkGLContext Ptr)
Declare Function gdk_gl_context_get_current CDECL() AS GdkGLContext Ptr
Declare Sub gdk_gl_context_clear_current CDECL()


#DEFINE GDK_TYPE_GL_TEXTURE (gdk_gl_texture_get_type ())
#DEFINE GDK_GL_TEXTURE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_GL_TEXTURE, GdkGLTexture))
#DEFINE GDK_IS_GL_TEXTURE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_GL_TEXTURE))

Type GdkGLTexture AS _GdkGLTexture
Type GdkGLTextureClass AS _GdkGLTextureClass

Declare Function gdk_gl_texture_get_type CDECL() AS GType
Declare Sub gdk_gl_texture_release CDECL(BYVAL AS GdkGLTexture Ptr)


#DEFINE GDK_TYPE_GL_TEXTURE_BUILDER (gdk_gl_texture_builder_get_type ())

Type GdkGLTextureBuilder AS _GdkGLTextureBuilder
Declare Function gdk_gl_texture_builder_new CDECL() AS GdkGLTextureBuilder Ptr
Declare Function gdk_gl_texture_builder_get_context CDECL(BYVAL AS GdkGLTextureBuilder Ptr) AS GdkGLContext Ptr
Declare Sub gdk_gl_texture_builder_set_context CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS GdkGLContext Ptr)
Declare Function gdk_gl_texture_builder_get_id CDECL(BYVAL AS GdkGLTextureBuilder Ptr) AS guint
Declare Sub gdk_gl_texture_builder_set_id CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS guint)
Declare Function gdk_gl_texture_builder_get_width CDECL(BYVAL AS GdkGLTextureBuilder Ptr) AS LONG
Declare Sub gdk_gl_texture_builder_set_width CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS LONG)
Declare Function gdk_gl_texture_builder_get_height CDECL(BYVAL AS GdkGLTextureBuilder Ptr) AS LONG
Declare Sub gdk_gl_texture_builder_set_height CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS LONG)
Declare Function gdk_gl_texture_builder_get_format CDECL(BYVAL AS GdkGLTextureBuilder Ptr) AS GdkMemoryFormat
Declare Sub gdk_gl_texture_builder_set_format CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS GdkMemoryFormat)
Declare Function gdk_gl_texture_builder_get_has_mipmap CDECL(BYVAL AS GdkGLTextureBuilder Ptr) AS gboolean
Declare Sub gdk_gl_texture_builder_set_has_mipmap CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS gboolean)
Declare Function gdk_gl_texture_builder_get_sync CDECL(BYVAL AS GdkGLTextureBuilder Ptr) AS gpointer
Declare Sub gdk_gl_texture_builder_set_sync CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS gpointer)
Declare Function gdk_gl_texture_builder_get_color_state CDECL(BYVAL AS GdkGLTextureBuilder Ptr) AS GdkColorState Ptr
Declare Sub gdk_gl_texture_builder_set_color_state CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS GdkColorState Ptr)
Declare Function gdk_gl_texture_builder_get_update_texture CDECL(BYVAL AS GdkGLTextureBuilder Ptr) AS GdkTexture Ptr
Declare Sub gdk_gl_texture_builder_set_update_texture CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS GdkTexture Ptr)
Declare Function gdk_gl_texture_builder_get_update_region CDECL(BYVAL AS GdkGLTextureBuilder Ptr) AS cairo_region_t Ptr
Declare Sub gdk_gl_texture_builder_set_update_region CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS cairo_region_t Ptr)
Declare Function gdk_gl_texture_builder_build CDECL(BYVAL AS GdkGLTextureBuilder Ptr, BYVAL AS GDestroyNotify, BYVAL AS gpointer) AS GdkTexture Ptr


Declare Function gdk_keyval_name CDECL(BYVAL AS guint) AS Const ZSTRING Ptr
Declare Function gdk_keyval_from_name CDECL(BYVAL AS Const ZSTRING Ptr) AS guint
Declare Sub gdk_keyval_convert_case CDECL(BYVAL AS guint, BYVAL AS guint Ptr, BYVAL AS guint Ptr)
Declare Function gdk_keyval_to_upper CDECL(BYVAL AS guint) AS guint
Declare Function gdk_keyval_to_lower CDECL(BYVAL AS guint) AS guint
Declare Function gdk_keyval_is_upper CDECL(BYVAL AS guint) AS gboolean
Declare Function gdk_keyval_is_lower CDECL(BYVAL AS guint) AS gboolean
Declare Function gdk_keyval_to_unicode CDECL(BYVAL AS guint) AS guint32
Declare Function gdk_unicode_to_keyval CDECL(BYVAL AS guint32) AS guint

#DEFINE GDK_TYPE_MEMORY_TEXTURE (gdk_memory_texture_get_type ())
#DEFINE GDK_MEMORY_TEXTURE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_MEMORY_TEXTURE, GdkMemoryTexture))
#DEFINE GDK_IS_MEMORY_TEXTURE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_MEMORY_TEXTURE))

Type GdkMemoryTexture AS _GdkMemoryTexture
Type GdkMemoryTextureClass AS _GdkMemoryTextureClass

Declare Function gdk_memory_texture_get_type CDECL() AS GType
Declare Function gdk_memory_texture_new CDECL(BYVAL AS LONG, BYVAL AS LONG, BYVAL AS GdkMemoryFormat, BYVAL AS GBytes Ptr, BYVAL AS gsize) AS GdkTexture Ptr

#DEFINE GDK_TYPE_MEMORY_TEXTURE_BUILDER (gdk_memory_texture_builder_get_type ())

Type GdkMemoryTextureBuilder AS _GdkMemoryTextureBuilder
Declare Function gdk_memory_texture_builder_new CDECL() AS GdkMemoryTextureBuilder Ptr
Declare Function gdk_memory_texture_builder_get_bytes CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr) AS GBytes Ptr
Declare Sub gdk_memory_texture_builder_set_bytes CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr, BYVAL AS GBytes Ptr)
Declare Function gdk_memory_texture_builder_get_stride CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr) AS gsize
Declare Sub gdk_memory_texture_builder_set_stride CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr, BYVAL AS gsize)
Declare Function gdk_memory_texture_builder_get_width CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr) AS LONG
Declare Sub gdk_memory_texture_builder_set_width CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr, BYVAL AS LONG)
Declare Function gdk_memory_texture_builder_get_height CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr) AS LONG
Declare Sub gdk_memory_texture_builder_set_height CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr, BYVAL AS LONG)
Declare Function gdk_memory_texture_builder_get_format CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr) AS GdkMemoryFormat
Declare Sub gdk_memory_texture_builder_set_format CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr, BYVAL AS GdkMemoryFormat)
Declare Function gdk_memory_texture_builder_get_color_state CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr) AS GdkColorState Ptr
Declare Sub gdk_memory_texture_builder_set_color_state CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr, BYVAL AS GdkColorState Ptr)
Declare Function gdk_memory_texture_builder_get_update_texture CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr) AS GdkTexture Ptr
Declare Sub gdk_memory_texture_builder_set_update_texture CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr, BYVAL AS GdkTexture Ptr)
Declare Function gdk_memory_texture_builder_get_update_region CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr) AS cairo_region_t Ptr
Declare Sub gdk_memory_texture_builder_set_update_region CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr, BYVAL AS cairo_region_t Ptr)
Declare Function gdk_memory_texture_builder_build CDECL(BYVAL AS GdkMemoryTextureBuilder Ptr) AS GdkTexture Ptr

#DEFINE GDK_TYPE_PAINTABLE (gdk_paintable_get_type ())

Type GdkPaintable AS _GdkPaintable

Enum GdkPaintableFlags_
	GDK_PAINTABLE_STATIC_SIZE = 1  SHL 0
	GDK_PAINTABLE_STATIC_CONTENTS = 1  SHL 1
End Enum
Type AS LONG GdkPaintableFlags

Type _GdkPaintableInterface
	AS GTypeInterface g_iface
	snapshot AS SUB CDECL(BYVAL AS GdkPaintable Ptr, BYVAL AS GdkSnapshot Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
	get_current_image AS Function CDECL(BYVAL AS GdkPaintable Ptr) AS GdkPaintable Ptr
	get_flags AS Function CDECL(BYVAL AS GdkPaintable Ptr) AS GdkPaintableFlags
	get_intrinsic_width AS Function CDECL(BYVAL AS GdkPaintable Ptr) AS LONG
	get_intrinsic_height AS Function CDECL(BYVAL AS GdkPaintable Ptr) AS LONG
	get_intrinsic_aspect_ratio AS Function CDECL(BYVAL AS GdkPaintable Ptr) AS DOUBLE
End Type

Declare Sub gdk_paintable_snapshot CDECL(BYVAL AS GdkPaintable Ptr, BYVAL AS GdkSnapshot Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare Function gdk_paintable_get_current_image CDECL(BYVAL AS GdkPaintable Ptr) AS GdkPaintable Ptr
Declare Function gdk_paintable_get_flags CDECL(BYVAL AS GdkPaintable Ptr) AS GdkPaintableFlags
Declare Function gdk_paintable_get_intrinsic_width CDECL(BYVAL AS GdkPaintable Ptr) AS LONG
Declare Function gdk_paintable_get_intrinsic_height CDECL(BYVAL AS GdkPaintable Ptr) AS LONG
Declare Function gdk_paintable_get_intrinsic_aspect_ratio CDECL(BYVAL AS GdkPaintable Ptr) AS DOUBLE
Declare Sub gdk_paintable_compute_concrete_size CDECL(BYVAL AS GdkPaintable Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr)
Declare Sub gdk_paintable_invalidate_contents CDECL(BYVAL AS GdkPaintable Ptr)
Declare Sub gdk_paintable_invalidate_size CDECL(BYVAL AS GdkPaintable Ptr)
Declare Function gdk_paintable_new_empty CDECL(BYVAL AS LONG, BYVAL AS LONG) AS GdkPaintable Ptr

Declare Function gdk_pango_layout_line_get_clip_region CDECL(BYVAL AS PangoLayoutLine Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS Const LONG Ptr, BYVAL AS LONG) AS cairo_region_t Ptr
Declare Function gdk_pango_layout_get_clip_region CDECL(BYVAL AS PangoLayout Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS Const LONG Ptr, BYVAL AS LONG) AS cairo_region_t Ptr

#DEFINE GDK_TYPE_POPUP (gdk_popup_get_type ())

Type GdkPopup AS _GdkPopup
Declare Function gdk_popup_present CDECL(BYVAL AS GdkPopup Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS GdkPopupLayout Ptr) AS gboolean
Declare Function gdk_popup_get_surface_anchor CDECL(BYVAL AS GdkPopup Ptr) AS GdkGravity
Declare Function gdk_popup_get_rect_anchor CDECL(BYVAL AS GdkPopup Ptr) AS GdkGravity
Declare Function gdk_popup_get_parent CDECL(BYVAL AS GdkPopup Ptr) AS GdkSurface Ptr
Declare Function gdk_popup_get_position_x CDECL(BYVAL AS GdkPopup Ptr) AS LONG
Declare Function gdk_popup_get_position_y CDECL(BYVAL AS GdkPopup Ptr) AS LONG
Declare Function gdk_popup_get_autohide CDECL(BYVAL AS GdkPopup Ptr) AS gboolean


Declare Function gdk_rectangle_intersect CDECL(BYVAL AS Const GdkRectangle Ptr, BYVAL AS Const GdkRectangle Ptr, BYVAL AS GdkRectangle Ptr) AS gboolean
Declare Sub gdk_rectangle_union CDECL(BYVAL AS Const GdkRectangle Ptr, BYVAL AS Const GdkRectangle Ptr, BYVAL AS GdkRectangle Ptr)
Declare Function gdk_rectangle_equal CDECL(BYVAL AS Const GdkRectangle Ptr, BYVAL AS Const GdkRectangle Ptr) AS gboolean
Declare Function gdk_rectangle_contains_point CDECL(BYVAL AS Const GdkRectangle Ptr, BYVAL AS LONG, BYVAL AS LONG) AS gboolean
Declare Function gdk_rectangle_get_type CDECL() AS GType

#DEFINE GDK_TYPE_RECTANGLE (gdk_rectangle_get_type ())

Type _GdkRGBA
	AS SINGLE red
	AS SINGLE green
	AS SINGLE blue
	AS SINGLE alpha
End Type

#DEFINE GDK_TYPE_RGBA (gdk_rgba_get_type ())

Declare Function gdk_rgba_get_type CDECL() AS GType
Declare Function gdk_rgba_copy CDECL(BYVAL AS Const GdkRGBA Ptr) AS GdkRGBA Ptr
Declare Sub gdk_rgba_free CDECL(BYVAL AS GdkRGBA Ptr)
Declare Function gdk_rgba_is_clear CDECL(BYVAL AS Const GdkRGBA Ptr) AS gboolean
Declare Function gdk_rgba_is_opaque CDECL(BYVAL AS Const GdkRGBA Ptr) AS gboolean
Declare Function gdk_rgba_hash CDECL(BYVAL AS gconstpointer) AS guint
Declare Function gdk_rgba_equal CDECL(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
Declare Function gdk_rgba_parse CDECL(BYVAL AS GdkRGBA Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gdk_rgba_to_string CDECL(BYVAL AS Const GdkRGBA Ptr) AS ZSTRING Ptr


Type GdkSnapshotClass AS _GdkSnapshotClass

#DEFINE GDK_TYPE_SNAPSHOT (gdk_snapshot_get_type ())
#DEFINE GDK_SNAPSHOT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_SNAPSHOT, GdkSnapshot))
#DEFINE GDK_IS_SNAPSHOT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_SNAPSHOT))

Declare Function gdk_snapshot_get_type CDECL() AS GType

#DEFINE GDK_TYPE_TEXTURE_DOWNLOADER (gdk_texture_downloader_get_type ())

Declare Function gdk_texture_downloader_get_type CDECL() AS GType
Declare Function gdk_texture_downloader_new CDECL(BYVAL AS GdkTexture Ptr) AS GdkTextureDownloader Ptr
Declare Function gdk_texture_downloader_copy CDECL(BYVAL AS Const GdkTextureDownloader Ptr) AS GdkTextureDownloader Ptr
Declare Sub gdk_texture_downloader_free CDECL(BYVAL AS GdkTextureDownloader Ptr)
Declare Sub gdk_texture_downloader_set_texture CDECL(BYVAL AS GdkTextureDownloader Ptr, BYVAL AS GdkTexture Ptr)
Declare Function gdk_texture_downloader_get_texture CDECL(BYVAL AS Const GdkTextureDownloader Ptr) AS GdkTexture Ptr
Declare Sub gdk_texture_downloader_set_format CDECL(BYVAL AS GdkTextureDownloader Ptr, BYVAL AS GdkMemoryFormat)
Declare Function gdk_texture_downloader_get_format CDECL(BYVAL AS Const GdkTextureDownloader Ptr) AS GdkMemoryFormat
Declare Sub gdk_texture_downloader_set_color_state CDECL(BYVAL AS GdkTextureDownloader Ptr, BYVAL AS GdkColorState Ptr)
Declare Function gdk_texture_downloader_get_color_state CDECL(BYVAL AS Const GdkTextureDownloader Ptr) AS GdkColorState Ptr
Declare Sub gdk_texture_downloader_download_into CDECL(BYVAL AS Const GdkTextureDownloader Ptr, BYVAL AS guchar Ptr, BYVAL AS gsize)
Declare Function gdk_texture_downloader_download_bytes CDECL(BYVAL AS Const GdkTextureDownloader Ptr, BYVAL AS gsize Ptr) AS GBytes Ptr

Type GdkToplevelLayout AS _GdkToplevelLayout

#DEFINE GDK_TYPE_TOPLEVEL_LAYOUT (gdk_toplevel_layout_get_type ())

Declare Function gdk_toplevel_layout_get_type CDECL() AS GType
Declare Function gdk_toplevel_layout_new CDECL() AS GdkToplevelLayout Ptr
Declare Function gdk_toplevel_layout_ref CDECL(BYVAL AS GdkToplevelLayout Ptr) AS GdkToplevelLayout Ptr
Declare Sub gdk_toplevel_layout_unref CDECL(BYVAL AS GdkToplevelLayout Ptr)
Declare Function gdk_toplevel_layout_copy CDECL(BYVAL AS GdkToplevelLayout Ptr) AS GdkToplevelLayout Ptr
Declare Function gdk_toplevel_layout_equal CDECL(BYVAL AS GdkToplevelLayout Ptr, BYVAL AS GdkToplevelLayout Ptr) AS gboolean
Declare Sub gdk_toplevel_layout_set_maximized CDECL(BYVAL AS GdkToplevelLayout Ptr, BYVAL AS gboolean)
Declare Sub gdk_toplevel_layout_set_fullscreen CDECL(BYVAL AS GdkToplevelLayout Ptr, BYVAL AS gboolean, BYVAL AS GdkMonitor Ptr)
Declare Function gdk_toplevel_layout_get_maximized CDECL(BYVAL AS GdkToplevelLayout Ptr, BYVAL AS gboolean Ptr) AS gboolean
Declare Function gdk_toplevel_layout_get_fullscreen CDECL(BYVAL AS GdkToplevelLayout Ptr, BYVAL AS gboolean Ptr) AS gboolean
Declare Function gdk_toplevel_layout_get_fullscreen_monitor CDECL(BYVAL AS GdkToplevelLayout Ptr) AS GdkMonitor Ptr
Declare Sub gdk_toplevel_layout_set_resizable CDECL(BYVAL AS GdkToplevelLayout Ptr, BYVAL AS gboolean)
Declare Function gdk_toplevel_layout_get_resizable CDECL(BYVAL AS GdkToplevelLayout Ptr) AS gboolean

Enum GdkSurfaceEdge_
	GDK_SURFACE_EDGE_NORTH_WEST
	GDK_SURFACE_EDGE_NORTH
	GDK_SURFACE_EDGE_NORTH_EAST
	GDK_SURFACE_EDGE_WEST
	GDK_SURFACE_EDGE_EAST
	GDK_SURFACE_EDGE_SOUTH_WEST
	GDK_SURFACE_EDGE_SOUTH
	GDK_SURFACE_EDGE_SOUTH_EAST
End Enum
Type AS LONG GdkSurfaceEdge

Enum GdkFullscreenMode_
	GDK_FULLSCREEN_ON_CURRENT_MONITOR
	GDK_FULLSCREEN_ON_ALL_MONITORS
End Enum
Type AS LONG GdkFullscreenMode

Enum GdkToplevelState_
	GDK_TOPLEVEL_STATE_MINIMIZED = 1  SHL 0
	GDK_TOPLEVEL_STATE_MAXIMIZED = 1  SHL 1
	GDK_TOPLEVEL_STATE_STICKY = 1  SHL 2
	GDK_TOPLEVEL_STATE_FULLSCREEN = 1  SHL 3
	GDK_TOPLEVEL_STATE_ABOVE = 1  SHL 4
	GDK_TOPLEVEL_STATE_BELOW = 1  SHL 5
	GDK_TOPLEVEL_STATE_FOCUSED = 1  SHL 6
	GDK_TOPLEVEL_STATE_TILED = 1  SHL 7
	GDK_TOPLEVEL_STATE_TOP_TILED = 1  SHL 8
	GDK_TOPLEVEL_STATE_TOP_RESIZABLE = 1  SHL 9
	GDK_TOPLEVEL_STATE_RIGHT_TILED = 1  SHL 10
	GDK_TOPLEVEL_STATE_RIGHT_RESIZABLE = 1  SHL 11
	GDK_TOPLEVEL_STATE_BOTTOM_TILED = 1  SHL 12
	GDK_TOPLEVEL_STATE_BOTTOM_RESIZABLE = 1  SHL 13
	GDK_TOPLEVEL_STATE_LEFT_TILED = 1  SHL 14
	GDK_TOPLEVEL_STATE_LEFT_RESIZABLE = 1  SHL 15
	GDK_TOPLEVEL_STATE_SUSPENDED = 1  SHL 16
End Enum
Type AS LONG GdkToplevelState

Enum GdkTitlebarGesture_
	GDK_TITLEBAR_GESTURE_DOUBLE_CLICK = 1
	GDK_TITLEBAR_GESTURE_RIGHT_CLICK = 2
	GDK_TITLEBAR_GESTURE_MIDDLE_CLICK = 3
End Enum
Type AS LONG GdkTitlebarGesture

#DEFINE GDK_TYPE_TOPLEVEL (gdk_toplevel_get_type ())

Type GdkToplevel AS _GdkToplevel
Declare Sub gdk_toplevel_present CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS GdkToplevelLayout Ptr)
Declare Function gdk_toplevel_minimize CDECL(BYVAL AS GdkToplevel Ptr) AS gboolean
Declare Function gdk_toplevel_lower CDECL(BYVAL AS GdkToplevel Ptr) AS gboolean
Declare Sub gdk_toplevel_focus CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS guint32)
Declare Function gdk_toplevel_get_state CDECL(BYVAL AS GdkToplevel Ptr) AS GdkToplevelState
Declare Sub gdk_toplevel_set_title CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Sub gdk_toplevel_set_startup_id CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Sub gdk_toplevel_set_transient_for CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS GdkSurface Ptr)
Declare Sub gdk_toplevel_set_modal CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS gboolean)
Declare Sub gdk_toplevel_set_icon_list CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS GList Ptr)
Declare Function gdk_toplevel_show_window_menu CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS GdkEvent Ptr) AS gboolean
Declare Sub gdk_toplevel_set_decorated CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS gboolean)
Declare Sub gdk_toplevel_set_deletable CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS gboolean)
Declare Function gdk_toplevel_supports_edge_constraints CDECL(BYVAL AS GdkToplevel Ptr) AS gboolean
Declare Sub gdk_toplevel_inhibit_system_shortcuts CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS GdkEvent Ptr)
Declare Sub gdk_toplevel_restore_system_shortcuts CDECL(BYVAL AS GdkToplevel Ptr)
Declare Sub gdk_toplevel_begin_resize CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS GdkSurfaceEdge, BYVAL AS GdkDevice Ptr, BYVAL AS LONG, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS guint32)
Declare Sub gdk_toplevel_begin_move CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS GdkDevice Ptr, BYVAL AS LONG, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS guint32)
Declare Function gdk_toplevel_titlebar_gesture CDECL(BYVAL AS GdkToplevel Ptr, BYVAL AS GdkTitlebarGesture) AS gboolean

Type GdkToplevelSize AS _GdkToplevelSize

#DEFINE GDK_TYPE_TOPLEVEL_SIZE (gdk_toplevel_size_get_type ())

Declare Function gdk_toplevel_size_get_type CDECL() AS GType
Declare Sub gdk_toplevel_size_get_bounds CDECL(BYVAL AS GdkToplevelSize Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare Sub gdk_toplevel_size_set_size CDECL(BYVAL AS GdkToplevelSize Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare Sub gdk_toplevel_size_set_min_size CDECL(BYVAL AS GdkToplevelSize Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare Sub gdk_toplevel_size_set_shadow_width CDECL(BYVAL AS GdkToplevelSize Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG)

#DEFINE GDK_TYPE_VULKAN_CONTEXT (gdk_vulkan_context_get_type ())
#DEFINE GDK_VULKAN_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_VULKAN_CONTEXT, GdkVulkanContext))
#DEFINE GDK_IS_VULKAN_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_VULKAN_CONTEXT))
#DEFINE GDK_VULKAN_ERROR (gdk_vulkan_error_quark ())

Declare Function gdk_vulkan_error_quark CDECL() AS GQuark
Declare Function gdk_vulkan_context_get_type CDECL() AS GType

end extern

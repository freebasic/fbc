''
''
'' gdkenumtypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkenumtypes_bi__
#define __gdkenumtypes_bi__

#include once "gtk/glib-object.bi"

#define GDK_TYPE_CURSOR_TYPE (gdk_cursor_type_get_type())
#define GDK_TYPE_DRAG_ACTION (gdk_drag_action_get_type())
#define GDK_TYPE_DRAG_PROTOCOL (gdk_drag_protocol_get_type())
#define GDK_TYPE_FILTER_RETURN (gdk_filter_return_get_type())
#define GDK_TYPE_EVENT_TYPE (gdk_event_type_get_type())
#define GDK_TYPE_EVENT_MASK (gdk_event_mask_get_type())
#define GDK_TYPE_VISIBILITY_STATE (gdk_visibility_state_get_type())
#define GDK_TYPE_SCROLL_DIRECTION (gdk_scroll_direction_get_type())
#define GDK_TYPE_NOTIFY_TYPE (gdk_notify_type_get_type())
#define GDK_TYPE_CROSSING_MODE (gdk_crossing_mode_get_type())
#define GDK_TYPE_PROPERTY_STATE (gdk_property_state_get_type())
#define GDK_TYPE_WINDOW_STATE (gdk_window_state_get_type())
#define GDK_TYPE_SETTING_ACTION (gdk_setting_action_get_type())
#define GDK_TYPE_OWNER_CHANGE (gdk_owner_change_get_type())
#define GDK_TYPE_FONT_TYPE (gdk_font_type_get_type())
#define GDK_TYPE_CAP_STYLE (gdk_cap_style_get_type())
#define GDK_TYPE_FILL (gdk_fill_get_type())
#define GDK_TYPE_FUNCTION (gdk_function_get_type())
#define GDK_TYPE_JOIN_STYLE (gdk_join_style_get_type())
#define GDK_TYPE_LINE_STYLE (gdk_line_style_get_type())
#define GDK_TYPE_SUBWINDOW_MODE (gdk_subwindow_mode_get_type())
#define GDK_TYPE_GC_VALUES_MASK (gdk_gc_values_mask_get_type())
#define GDK_TYPE_IMAGE_TYPE (gdk_image_type_get_type())
#define GDK_TYPE_EXTENSION_MODE (gdk_extension_mode_get_type())
#define GDK_TYPE_INPUT_SOURCE (gdk_input_source_get_type())
#define GDK_TYPE_INPUT_MODE (gdk_input_mode_get_type())
#define GDK_TYPE_AXIS_USE (gdk_axis_use_get_type())
#define GDK_TYPE_PROP_MODE (gdk_prop_mode_get_type())
#define GDK_TYPE_FILL_RULE (gdk_fill_rule_get_type())
#define GDK_TYPE_OVERLAP_TYPE (gdk_overlap_type_get_type())
#define GDK_TYPE_RGB_DITHER (gdk_rgb_dither_get_type())
#define GDK_TYPE_BYTE_ORDER (gdk_byte_order_get_type())
#define GDK_TYPE_MODIFIER_TYPE (gdk_modifier_type_get_type())
#define GDK_TYPE_INPUT_CONDITION (gdk_input_condition_get_type())
#define GDK_TYPE_STATUS (gdk_status_get_type())
#define GDK_TYPE_GRAB_STATUS (gdk_grab_status_get_type())
#define GDK_TYPE_VISUAL_TYPE (gdk_visual_type_get_type())
#define GDK_TYPE_WINDOW_CLASS (gdk_window_class_get_type())
#define GDK_TYPE_WINDOW_TYPE (gdk_window_type_get_type())
#define GDK_TYPE_WINDOW_ATTRIBUTES_TYPE (gdk_window_attributes_type_get_type())
#define GDK_TYPE_WINDOW_HINTS (gdk_window_hints_get_type())
#define GDK_TYPE_WINDOW_TYPE_HINT (gdk_window_type_hint_get_type())
#define GDK_TYPE_WM_DECORATION (gdk_wm_decoration_get_type())
#define GDK_TYPE_WM_FUNCTION (gdk_wm_function_get_type())
#define GDK_TYPE_GRAVITY (gdk_gravity_get_type())
#define GDK_TYPE_WINDOW_EDGE (gdk_window_edge_get_type())

declare function gdk_cursor_type_get_type () as GType
declare function gdk_drag_action_get_type () as GType
declare function gdk_drag_protocol_get_type () as GType
declare function gdk_filter_return_get_type () as GType
declare function gdk_event_type_get_type () as GType
declare function gdk_event_mask_get_type () as GType
declare function gdk_visibility_state_get_type () as GType
declare function gdk_scroll_direction_get_type () as GType
declare function gdk_notify_type_get_type () as GType
declare function gdk_crossing_mode_get_type () as GType
declare function gdk_property_state_get_type () as GType
declare function gdk_window_state_get_type () as GType
declare function gdk_setting_action_get_type () as GType
declare function gdk_owner_change_get_type () as GType
declare function gdk_font_type_get_type () as GType
declare function gdk_cap_style_get_type () as GType
declare function gdk_fill_get_type () as GType
declare function gdk_function_get_type () as GType
declare function gdk_join_style_get_type () as GType
declare function gdk_line_style_get_type () as GType
declare function gdk_subwindow_mode_get_type () as GType
declare function gdk_gc_values_mask_get_type () as GType
declare function gdk_image_type_get_type () as GType
declare function gdk_extension_mode_get_type () as GType
declare function gdk_input_source_get_type () as GType
declare function gdk_input_mode_get_type () as GType
declare function gdk_axis_use_get_type () as GType
declare function gdk_prop_mode_get_type () as GType
declare function gdk_fill_rule_get_type () as GType
declare function gdk_overlap_type_get_type () as GType
declare function gdk_rgb_dither_get_type () as GType
declare function gdk_byte_order_get_type () as GType
declare function gdk_modifier_type_get_type () as GType
declare function gdk_input_condition_get_type () as GType
declare function gdk_status_get_type () as GType
declare function gdk_grab_status_get_type () as GType
declare function gdk_visual_type_get_type () as GType
declare function gdk_window_class_get_type () as GType
declare function gdk_window_type_get_type () as GType
declare function gdk_window_attributes_type_get_type () as GType
declare function gdk_window_hints_get_type () as GType
declare function gdk_window_type_hint_get_type () as GType
declare function gdk_wm_decoration_get_type () as GType
declare function gdk_wm_function_get_type () as GType
declare function gdk_gravity_get_type () as GType
declare function gdk_window_edge_get_type () as GType

#endif

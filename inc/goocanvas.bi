' This is file goocanvas-2.0.0.bi
' (FreeBasic binding for goocanvas library version 2.0.0)
'
' (C) 2011-2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
' translated with help of h_2_bi.bas
' (http://www.freebasic-portal.de/downloads/ressourcencompiler/h2bi-bas-134.html)
'
' Licence:
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
'
' Original license text:
'/*
 '* GooCanvas. Copyright (C) 2005 Damon Chaplin.
 '* Released under the GNU LGPL license. See COPYING for details.
 '*/


#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#IFDEF __USE_GTK3__
#INCLIB "goocanvas-2.0"
#ELSE
#INCLIB "goocanvas"
#ENDIF

EXTERN "C" ' (h_2_bi -P_oCD option)

#IFNDEF __GOO_CANVAS_H__
#DEFINE __GOO_CANVAS_H__

#IF NOT DEFINED(__GTK_H__)
#INCLUDE ONCE "gtk/gtk.bi"
#ENDIF

#IFNDEF __GOO_CANVAS_ENUM_TYPES_H__
#DEFINE __GOO_CANVAS_ENUM_TYPES_H__

DECLARE FUNCTION goo_canvas_animate_type_get_type() AS GType
#DEFINE GOO_TYPE_CANVAS_ANIMATE_TYPE (goo_canvas_animate_type_get_type())
DECLARE FUNCTION goo_canvas_pointer_events_get_type() AS GType
#DEFINE GOO_TYPE_CANVAS_POINTER_EVENTS (goo_canvas_pointer_events_get_type())
DECLARE FUNCTION goo_canvas_item_visibility_get_type() AS GType
#DEFINE GOO_TYPE_CANVAS_ITEM_VISIBILITY (goo_canvas_item_visibility_get_type())
DECLARE FUNCTION goo_canvas_path_command_type_get_type() AS GType
#DEFINE GOO_TYPE_CANVAS_PATH_COMMAND_TYPE (goo_canvas_path_command_type_get_type())
DECLARE FUNCTION goo_canvas_anchor_type_get_type() AS GType

#DEFINE GOO_TYPE_CANVAS_ANCHOR_TYPE (goo_canvas_anchor_type_get_type())
#ENDIF ' __GOO_CANVAS_ENUM_TYPES_H__

#IFNDEF __GOO_CANVAS_ELLIPSE_H__
#DEFINE __GOO_CANVAS_ELLIPSE_H__

#IFNDEF __GOO_CANVAS_ITEM_SIMPLE_H__
#DEFINE __GOO_CANVAS_ITEM_SIMPLE_H__

#IFNDEF __GOO_CANVAS_ITEM_H__
#DEFINE __GOO_CANVAS_ITEM_H__

#IFNDEF __GOO_CANVAS_STYLE_H__
#DEFINE __GOO_CANVAS_STYLE_H__

EXTERN AS GQuark goo_canvas_style_stroke_pattern_id
EXTERN AS GQuark goo_canvas_style_fill_pattern_id
EXTERN AS GQuark goo_canvas_style_fill_rule_id
EXTERN AS GQuark goo_canvas_style_operator_id
EXTERN AS GQuark goo_canvas_style_antialias_id
EXTERN AS GQuark goo_canvas_style_line_width_id
EXTERN AS GQuark goo_canvas_style_line_cap_id
EXTERN AS GQuark goo_canvas_style_line_join_id
EXTERN AS GQuark goo_canvas_style_line_join_miter_limit_id
EXTERN AS GQuark goo_canvas_style_line_dash_id
EXTERN AS GQuark goo_canvas_style_font_desc_id
EXTERN AS GQuark goo_canvas_style_hint_metrics_id

TYPE GooCanvasStyleProperty AS _GooCanvasStyleProperty

TYPE _GooCanvasStyleProperty
  AS GQuark id
  AS GValue value
END TYPE

#DEFINE GOO_TYPE_CANVAS_STYLE (goo_canvas_style_get_type ())
#DEFINE GOO_CANVAS_STYLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_STYLE, GooCanvasStyle))
#DEFINE GOO_CANVAS_STYLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_STYLE, GooCanvasStyleClass))
#DEFINE GOO_IS_CANVAS_STYLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_STYLE))
#DEFINE GOO_IS_CANVAS_STYLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_STYLE))
#DEFINE GOO_CANVAS_STYLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_STYLE, GooCanvasStyleClass))

TYPE GooCanvasStyle AS _GooCanvasStyle
TYPE GooCanvasStyleClass AS _GooCanvasStyleClass

TYPE _GooCanvasStyle
  AS GObject parent_object
  AS GooCanvasStyle PTR parent
  AS GArray PTR properties
END TYPE

TYPE _GooCanvasStyleClass
  AS GObjectClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_style_get_type() AS GType
DECLARE FUNCTION goo_canvas_style_new() AS GooCanvasStyle PTR
DECLARE FUNCTION goo_canvas_style_copy(BYVAL AS GooCanvasStyle PTR) AS GooCanvasStyle PTR
DECLARE FUNCTION goo_canvas_style_get_parent(BYVAL AS GooCanvasStyle PTR) AS GooCanvasStyle PTR
DECLARE SUB goo_canvas_style_set_parent(BYVAL AS GooCanvasStyle PTR, BYVAL AS GooCanvasStyle PTR)
DECLARE FUNCTION goo_canvas_style_get_property(BYVAL AS GooCanvasStyle PTR, BYVAL AS GQuark) AS GValue PTR
DECLARE SUB goo_canvas_style_set_property(BYVAL AS GooCanvasStyle PTR, BYVAL AS GQuark, BYVAL AS CONST GValue PTR)
DECLARE FUNCTION goo_canvas_style_set_stroke_options(BYVAL AS GooCanvasStyle PTR, BYVAL AS cairo_t PTR) AS gboolean
DECLARE FUNCTION goo_canvas_style_set_fill_options(BYVAL AS GooCanvasStyle PTR, BYVAL AS cairo_t PTR) AS gboolean

#ENDIF ' __GOO_CANVAS_STYLE_H__

ENUM GooCanvasAnimateType
  GOO_CANVAS_ANIMATE_FREEZE
  GOO_CANVAS_ANIMATE_RESET
  GOO_CANVAS_ANIMATE_RESTART
  GOO_CANVAS_ANIMATE_BOUNCE
END ENUM

TYPE GooCanvasBounds AS _GooCanvasBounds

TYPE _GooCanvasBounds
  AS gdouble x1, y1, x2, y2
END TYPE

DECLARE FUNCTION goo_canvas_bounds_get_type() AS GType

#DEFINE GOO_TYPE_CANVAS_BOUNDS (goo_canvas_bounds_get_type ())
#DEFINE GOO_TYPE_CANVAS_ITEM (goo_canvas_item_get_type ())
#DEFINE GOO_CANVAS_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_ITEM, GooCanvasItem))
#DEFINE GOO_IS_CANVAS_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_ITEM))
#DEFINE GOO_CANVAS_ITEM_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GOO_TYPE_CANVAS_ITEM, GooCanvasItemIface))

TYPE GooCanvas AS _GooCanvas
TYPE GooCanvasItemModel AS _GooCanvasItemModel
TYPE GooCanvasItem AS _GooCanvasItem
TYPE GooCanvasItemIface AS _GooCanvasItemIface

TYPE _GooCanvasItemIface
  AS GTypeInterface base_iface
  get_canvas AS FUNCTION(BYVAL AS GooCanvasItem PTR) AS GooCanvas PTR
  set_canvas AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvas PTR)
  get_n_children AS FUNCTION(BYVAL AS GooCanvasItem PTR) AS gint
  get_child AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS gint) AS GooCanvasItem PTR
  request_update AS SUB(BYVAL AS GooCanvasItem PTR)
  add_child AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS gint)
  move_child AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS gint, BYVAL AS gint)
  remove_child AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS gint)
  get_child_property AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS guint, BYVAL AS GValue PTR, BYVAL AS GParamSpec PTR)
  set_child_property AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS GParamSpec PTR)
  get_transform_for_child AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_matrix_t PTR) AS gboolean
  get_parent AS FUNCTION(BYVAL AS GooCanvasItem PTR) AS GooCanvasItem PTR
  set_parent AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR)
  get_bounds AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasBounds PTR)
  get_items_at AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS cairo_t PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS GList PTR) AS GList PTR
  update AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS gboolean, BYVAL AS cairo_t PTR, BYVAL AS GooCanvasBounds PTR)
  paint AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_t PTR, BYVAL AS CONST GooCanvasBounds PTR, BYVAL AS gdouble)
  get_requested_area AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_t PTR, BYVAL AS GooCanvasBounds PTR) AS gboolean
  allocate_area AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_t PTR, BYVAL AS CONST GooCanvasBounds PTR, BYVAL AS CONST GooCanvasBounds PTR, BYVAL AS gdouble, BYVAL AS gdouble)
  get_transform AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_matrix_t PTR) AS gboolean
  set_transform AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS CONST cairo_matrix_t PTR)
  get_style AS FUNCTION(BYVAL AS GooCanvasItem PTR) AS GooCanvasStyle PTR
  set_style AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasStyle PTR)
  is_visible AS FUNCTION(BYVAL AS GooCanvasItem PTR) AS gboolean
  get_requested_height AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble) AS gdouble
  get_model AS FUNCTION(BYVAL AS GooCanvasItem PTR) AS GooCanvasItemModel PTR
  set_model AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItemModel PTR)
  enter_notify_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventCrossing PTR) AS gboolean
  leave_notify_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventCrossing PTR) AS gboolean
  motion_notify_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventMotion PTR) AS gboolean
  button_press_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventButton PTR) AS gboolean
  button_release_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventButton PTR) AS gboolean
  focus_in_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventFocus PTR) AS gboolean
  focus_out_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventFocus PTR) AS gboolean
  key_press_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventKey PTR) AS gboolean
  key_release_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventKey PTR) AS gboolean
  grab_broken_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventGrabBroken PTR) AS gboolean
  child_notify AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS GParamSpec PTR)
  query_tooltip AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gboolean, BYVAL AS GtkTooltip PTR) AS gboolean
  get_is_static AS FUNCTION(BYVAL AS GooCanvasItem PTR) AS gboolean
  set_is_static AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS gboolean)
  animation_finished AS SUB(BYVAL AS GooCanvasItem PTR, BYVAL AS gboolean)
  scroll_event AS FUNCTION(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventScroll PTR) AS gboolean
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_item_get_type() AS GType
DECLARE FUNCTION goo_canvas_item_get_n_children(BYVAL AS GooCanvasItem PTR) AS gint
DECLARE FUNCTION goo_canvas_item_get_child(BYVAL AS GooCanvasItem PTR, BYVAL AS gint) AS GooCanvasItem PTR
DECLARE FUNCTION goo_canvas_item_find_child(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR) AS gint
DECLARE SUB goo_canvas_item_add_child(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS gint)
DECLARE SUB goo_canvas_item_move_child(BYVAL AS GooCanvasItem PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB goo_canvas_item_remove_child(BYVAL AS GooCanvasItem PTR, BYVAL AS gint)
DECLARE SUB goo_canvas_item_get_child_property(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR)
DECLARE SUB goo_canvas_item_set_child_property(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GValue PTR)
DECLARE SUB goo_canvas_item_get_child_properties(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, ...)
DECLARE SUB goo_canvas_item_set_child_properties(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, ...)
DECLARE SUB goo_canvas_item_get_child_properties_valist(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS va_list)
DECLARE SUB goo_canvas_item_set_child_properties_valist(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS va_list)
DECLARE FUNCTION goo_canvas_item_get_transform_for_child(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_matrix_t PTR) AS gboolean
DECLARE FUNCTION goo_canvas_item_get_canvas(BYVAL AS GooCanvasItem PTR) AS GooCanvas PTR
DECLARE SUB goo_canvas_item_set_canvas(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvas PTR)
DECLARE FUNCTION goo_canvas_item_get_parent(BYVAL AS GooCanvasItem PTR) AS GooCanvasItem PTR
DECLARE SUB goo_canvas_item_set_parent(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR)
DECLARE SUB goo_canvas_item_remove(BYVAL AS GooCanvasItem PTR)
DECLARE FUNCTION goo_canvas_item_is_container(BYVAL AS GooCanvasItem PTR) AS gboolean
DECLARE SUB goo_canvas_item_raise(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR)
DECLARE SUB goo_canvas_item_lower(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItem PTR)
DECLARE FUNCTION goo_canvas_item_get_transform(BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_matrix_t PTR) AS gboolean
DECLARE SUB goo_canvas_item_set_transform(BYVAL AS GooCanvasItem PTR, BYVAL AS CONST cairo_matrix_t PTR)
DECLARE FUNCTION goo_canvas_item_get_simple_transform(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE SUB goo_canvas_item_set_simple_transform(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_item_translate(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_item_scale(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_item_rotate(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_item_skew_x(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_item_skew_y(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE FUNCTION goo_canvas_item_get_style(BYVAL AS GooCanvasItem PTR) AS GooCanvasStyle PTR
DECLARE SUB goo_canvas_item_set_style(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasStyle PTR)
DECLARE SUB goo_canvas_item_animate(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gboolean, BYVAL AS gint, BYVAL AS gint, BYVAL AS GooCanvasAnimateType)
DECLARE SUB goo_canvas_item_stop_animation(BYVAL AS GooCanvasItem PTR)
DECLARE SUB goo_canvas_item_get_bounds(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasBounds PTR)
DECLARE FUNCTION goo_canvas_item_get_items_at(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS cairo_t PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS GList PTR) AS GList PTR
DECLARE FUNCTION goo_canvas_item_is_visible(BYVAL AS GooCanvasItem PTR) AS gboolean
DECLARE FUNCTION goo_canvas_item_get_model(BYVAL AS GooCanvasItem PTR) AS GooCanvasItemModel PTR
DECLARE SUB goo_canvas_item_set_model(BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItemModel PTR)
DECLARE SUB goo_canvas_item_request_update(BYVAL AS GooCanvasItem PTR)
DECLARE SUB goo_canvas_item_ensure_updated(BYVAL AS GooCanvasItem PTR)
DECLARE SUB goo_canvas_item_update(BYVAL AS GooCanvasItem PTR, BYVAL AS gboolean, BYVAL AS cairo_t PTR, BYVAL AS GooCanvasBounds PTR)
DECLARE SUB goo_canvas_item_paint(BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_t PTR, BYVAL AS CONST GooCanvasBounds PTR, BYVAL AS gdouble)
DECLARE FUNCTION goo_canvas_item_get_requested_area(BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_t PTR, BYVAL AS GooCanvasBounds PTR) AS gboolean
DECLARE FUNCTION goo_canvas_item_get_requested_height(BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble) AS gdouble
DECLARE SUB goo_canvas_item_allocate_area(BYVAL AS GooCanvasItem PTR, BYVAL AS cairo_t PTR, BYVAL AS CONST GooCanvasBounds PTR, BYVAL AS CONST GooCanvasBounds PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE FUNCTION goo_canvas_item_get_is_static(BYVAL AS GooCanvasItem PTR) AS gboolean
DECLARE SUB goo_canvas_item_set_is_static(BYVAL AS GooCanvasItem PTR, BYVAL AS gboolean)
DECLARE SUB goo_canvas_item_class_install_child_property(BYVAL AS GObjectClass PTR, BYVAL AS guint, BYVAL AS GParamSpec PTR)
DECLARE FUNCTION goo_canvas_item_class_find_child_property(BYVAL AS GObjectClass PTR, BYVAL AS CONST gchar PTR) AS GParamSpec PTR
DECLARE FUNCTION goo_canvas_item_class_list_child_properties(BYVAL AS GObjectClass PTR, BYVAL AS guint PTR) AS GParamSpec PTR PTR

#ENDIF ' __GOO_CANVAS_ITEM_H__

#IFNDEF __GOO_CANVAS_ITEM_MODEL_H__
#DEFINE __GOO_CANVAS_ITEM_MODEL_H__

#DEFINE GOO_TYPE_CANVAS_ITEM_MODEL (goo_canvas_item_model_get_type ())
#DEFINE GOO_CANVAS_ITEM_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_ITEM_MODEL, GooCanvasItemModel))
#DEFINE GOO_IS_CANVAS_ITEM_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_ITEM_MODEL))
#DEFINE GOO_CANVAS_ITEM_MODEL_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GOO_TYPE_CANVAS_ITEM_MODEL, GooCanvasItemModelIface))

TYPE GooCanvasItemModelIface AS _GooCanvasItemModelIface

TYPE _GooCanvasItemModelIface
  AS GTypeInterface base_iface
  get_n_children AS FUNCTION(BYVAL AS GooCanvasItemModel PTR) AS gint
  get_child AS FUNCTION(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint) AS GooCanvasItemModel PTR
  add_child AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint)
  move_child AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint, BYVAL AS gint)
  remove_child AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint)
  get_child_property AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR, BYVAL AS guint, BYVAL AS GValue PTR, BYVAL AS GParamSpec PTR)
  set_child_property AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS GParamSpec PTR)
  get_parent AS FUNCTION(BYVAL AS GooCanvasItemModel PTR) AS GooCanvasItemModel PTR
  set_parent AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR)
  create_item AS FUNCTION(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvas PTR) AS GooCanvasItem PTR
  get_transform AS FUNCTION(BYVAL AS GooCanvasItemModel PTR, BYVAL AS cairo_matrix_t PTR) AS gboolean
  set_transform AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS CONST cairo_matrix_t PTR)
  get_style AS FUNCTION(BYVAL AS GooCanvasItemModel PTR) AS GooCanvasStyle PTR
  set_style AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasStyle PTR)
  child_added AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint)
  child_moved AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint, BYVAL AS gint)
  child_removed AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint)
  changed AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gboolean)
  child_notify AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GParamSpec PTR)
  animation_finished AS SUB(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gboolean)
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
  _goo_canvas_reserved5 AS SUB()
  _goo_canvas_reserved6 AS SUB()
  _goo_canvas_reserved7 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_item_model_get_type() AS GType
DECLARE FUNCTION goo_canvas_item_model_get_n_children(BYVAL AS GooCanvasItemModel PTR) AS gint
DECLARE FUNCTION goo_canvas_item_model_get_child(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint) AS GooCanvasItemModel PTR
DECLARE SUB goo_canvas_item_model_add_child(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint)
DECLARE SUB goo_canvas_item_model_move_child(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB goo_canvas_item_model_remove_child(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gint)
DECLARE FUNCTION goo_canvas_item_model_find_child(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR) AS gint
DECLARE SUB goo_canvas_item_model_get_child_property(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR)
DECLARE SUB goo_canvas_item_model_set_child_property(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GValue PTR)
DECLARE SUB goo_canvas_item_model_get_child_properties(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR, ...)
DECLARE SUB goo_canvas_item_model_set_child_properties(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR, ...)
DECLARE SUB goo_canvas_item_model_get_child_properties_valist(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR, BYVAL AS va_list)
DECLARE SUB goo_canvas_item_model_set_child_properties_valist(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR, BYVAL AS va_list)
DECLARE FUNCTION goo_canvas_item_model_get_parent(BYVAL AS GooCanvasItemModel PTR) AS GooCanvasItemModel PTR
DECLARE SUB goo_canvas_item_model_set_parent(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR)
DECLARE SUB goo_canvas_item_model_remove(BYVAL AS GooCanvasItemModel PTR)
DECLARE FUNCTION goo_canvas_item_model_is_container(BYVAL AS GooCanvasItemModel PTR) AS gboolean
DECLARE SUB goo_canvas_item_model_raise(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR)
DECLARE SUB goo_canvas_item_model_lower(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasItemModel PTR)
DECLARE FUNCTION goo_canvas_item_model_get_transform(BYVAL AS GooCanvasItemModel PTR, BYVAL AS cairo_matrix_t PTR) AS gboolean
DECLARE SUB goo_canvas_item_model_set_transform(BYVAL AS GooCanvasItemModel PTR, BYVAL AS CONST cairo_matrix_t PTR)
DECLARE FUNCTION goo_canvas_item_model_get_simple_transform(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE SUB goo_canvas_item_model_set_simple_transform(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_item_model_translate(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_item_model_scale(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_item_model_rotate(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_item_model_skew_x(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_item_model_skew_y(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE FUNCTION goo_canvas_item_model_get_style(BYVAL AS GooCanvasItemModel PTR) AS GooCanvasStyle PTR
DECLARE SUB goo_canvas_item_model_set_style(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GooCanvasStyle PTR)
DECLARE SUB goo_canvas_item_model_animate(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gboolean, BYVAL AS gint, BYVAL AS gint, BYVAL AS GooCanvasAnimateType)
DECLARE SUB goo_canvas_item_model_stop_animation(BYVAL AS GooCanvasItemModel PTR)
DECLARE SUB goo_canvas_item_model_class_install_child_property(BYVAL AS GObjectClass PTR, BYVAL AS guint, BYVAL AS GParamSpec PTR)
DECLARE FUNCTION goo_canvas_item_model_class_find_child_property(BYVAL AS GObjectClass PTR, BYVAL AS CONST gchar PTR) AS GParamSpec PTR
DECLARE FUNCTION goo_canvas_item_model_class_list_child_properties(BYVAL AS GObjectClass PTR, BYVAL AS guint PTR) AS GParamSpec PTR PTR

#ENDIF ' __GOO_CANVAS_ITEM_MODEL_H__

#IFNDEF __GOO_CANVAS_UTILS_H__
#DEFINE __GOO_CANVAS_UTILS_H__

ENUM GooCanvasPointerEvents
  GOO_CANVAS_EVENTS_VISIBLE_MASK = 1 SHL 0
  GOO_CANVAS_EVENTS_PAINTED_MASK = 1 SHL 1
  GOO_CANVAS_EVENTS_FILL_MASK = 1 SHL 2
  GOO_CANVAS_EVENTS_STROKE_MASK = 1 SHL 3
  GOO_CANVAS_EVENTS_NONE = 0
  GOO_CANVAS_EVENTS_VISIBLE_PAINTED = GOO_CANVAS_EVENTS_VISIBLE_MASK OR GOO_CANVAS_EVENTS_PAINTED_MASK OR GOO_CANVAS_EVENTS_FILL_MASK OR GOO_CANVAS_EVENTS_STROKE_MASK
  GOO_CANVAS_EVENTS_VISIBLE_FILL = GOO_CANVAS_EVENTS_VISIBLE_MASK OR GOO_CANVAS_EVENTS_FILL_MASK
  GOO_CANVAS_EVENTS_VISIBLE_STROKE = GOO_CANVAS_EVENTS_VISIBLE_MASK OR GOO_CANVAS_EVENTS_STROKE_MASK
  GOO_CANVAS_EVENTS_VISIBLE = GOO_CANVAS_EVENTS_VISIBLE_MASK OR GOO_CANVAS_EVENTS_FILL_MASK OR GOO_CANVAS_EVENTS_STROKE_MASK
  GOO_CANVAS_EVENTS_PAINTED = GOO_CANVAS_EVENTS_PAINTED_MASK OR GOO_CANVAS_EVENTS_FILL_MASK OR GOO_CANVAS_EVENTS_STROKE_MASK
  GOO_CANVAS_EVENTS_FILL = GOO_CANVAS_EVENTS_FILL_MASK
  GOO_CANVAS_EVENTS_STROKE = GOO_CANVAS_EVENTS_STROKE_MASK
  GOO_CANVAS_EVENTS_ALL = GOO_CANVAS_EVENTS_FILL_MASK OR GOO_CANVAS_EVENTS_STROKE_MASK
END ENUM

ENUM GooCanvasItemVisibility
  GOO_CANVAS_ITEM_HIDDEN = 0
  GOO_CANVAS_ITEM_INVISIBLE = 1
  GOO_CANVAS_ITEM_VISIBLE = 2
  GOO_CANVAS_ITEM_VISIBLE_ABOVE_THRESHOLD = 3
END ENUM

ENUM GooCanvasPathCommandType
  GOO_CANVAS_PATH_MOVE_TO
  GOO_CANVAS_PATH_CLOSE_PATH
  GOO_CANVAS_PATH_LINE_TO
  GOO_CANVAS_PATH_HORIZONTAL_LINE_TO
  GOO_CANVAS_PATH_VERTICAL_LINE_TO
  GOO_CANVAS_PATH_CURVE_TO
  GOO_CANVAS_PATH_SMOOTH_CURVE_TO
  GOO_CANVAS_PATH_QUADRATIC_CURVE_TO
  GOO_CANVAS_PATH_SMOOTH_QUADRATIC_CURVE_TO
  GOO_CANVAS_PATH_ELLIPTICAL_ARC
END ENUM

ENUM GooCanvasAnchorType
  GOO_CANVAS_ANCHOR_CENTER
  GOO_CANVAS_ANCHOR_NORTH
  GOO_CANVAS_ANCHOR_NORTH_WEST
  GOO_CANVAS_ANCHOR_NORTH_EAST
  GOO_CANVAS_ANCHOR_SOUTH
  GOO_CANVAS_ANCHOR_SOUTH_WEST
  GOO_CANVAS_ANCHOR_SOUTH_EAST
  GOO_CANVAS_ANCHOR_WEST
  GOO_CANVAS_ANCHOR_EAST
  GOO_CANVAS_ANCHOR_N = GOO_CANVAS_ANCHOR_NORTH
  GOO_CANVAS_ANCHOR_NW = GOO_CANVAS_ANCHOR_NORTH_WEST
  GOO_CANVAS_ANCHOR_NE = GOO_CANVAS_ANCHOR_NORTH_EAST
  GOO_CANVAS_ANCHOR_S = GOO_CANVAS_ANCHOR_SOUTH
  GOO_CANVAS_ANCHOR_SW = GOO_CANVAS_ANCHOR_SOUTH_WEST
  GOO_CANVAS_ANCHOR_SE = GOO_CANVAS_ANCHOR_SOUTH_EAST
  GOO_CANVAS_ANCHOR_W = GOO_CANVAS_ANCHOR_WEST
  GOO_CANVAS_ANCHOR_E = GOO_CANVAS_ANCHOR_EAST
END ENUM

TYPE GooCanvasPathCommand AS _GooCanvasPathCommand

TYPE _GooCanvasPathCommand_simple
  AS guint type : 5
  AS guint relative : 1
  AS gdouble x, y
END TYPE

TYPE _GooCanvasPathCommand_curve
  AS guint type : 5
  AS guint relative : 1
  AS gdouble x, y, x1, y1, x2, y2
END TYPE

TYPE _GooCanvasPathCommand_arc
  AS guint type : 5
  AS guint relative : 1
  AS guint large_arc_flag : 1
  AS guint sweep_flag : 1
  AS gdouble rx, ry, x_axis_rotation, x, y
END TYPE

UNION _GooCanvasPathCommand
  AS _GooCanvasPathCommand_simple simple
  AS _GooCanvasPathCommand_curve curve
  AS _GooCanvasPathCommand_arc arc
END UNION

DECLARE FUNCTION goo_canvas_parse_path_data(BYVAL AS CONST gchar PTR) AS GArray PTR
DECLARE SUB goo_canvas_create_path(BYVAL AS GArray PTR, BYVAL AS cairo_t PTR)

TYPE GooCanvasLineDash AS _GooCanvasLineDash

TYPE _GooCanvasLineDash
  AS INTEGER ref_count
  AS INTEGER num_dashes
  AS DOUBLE PTR dashes
  AS DOUBLE dash_offset
END TYPE

#IF 0

TYPE GooCairoAntialias AS cairo_antialias_t
TYPE GooCairoFillRule AS cairo_fill_rule_t
TYPE GooCairoHintMetrics AS cairo_hint_metrics_t
TYPE GooCairoLineCap AS cairo_line_cap_t
TYPE GooCairoLineJoin AS cairo_line_join_t
TYPE GooCairoOperator AS cairo_operator_t
TYPE GooCairoMatrix AS cairo_matrix_t
TYPE GooCairoPattern AS cairo_pattern_t

#ENDIF ' 0

#DEFINE GOO_TYPE_CANVAS_LINE_DASH (goo_canvas_line_dash_get_type ())

DECLARE FUNCTION goo_canvas_line_dash_get_type() AS GType
DECLARE FUNCTION goo_canvas_line_dash_new(BYVAL AS gint, ...) AS GooCanvasLineDash PTR
DECLARE FUNCTION goo_canvas_line_dash_newv(BYVAL AS gint, BYVAL AS DOUBLE PTR) AS GooCanvasLineDash PTR
DECLARE FUNCTION goo_canvas_line_dash_ref(BYVAL AS GooCanvasLineDash PTR) AS GooCanvasLineDash PTR
DECLARE SUB goo_canvas_line_dash_unref(BYVAL AS GooCanvasLineDash PTR)

#DEFINE GOO_TYPE_CAIRO_MATRIX (goo_cairo_matrix_get_type())

DECLARE FUNCTION goo_cairo_matrix_get_type() AS GType
DECLARE FUNCTION goo_cairo_matrix_copy(BYVAL AS CONST cairo_matrix_t PTR) AS cairo_matrix_t PTR
DECLARE SUB goo_cairo_matrix_free(BYVAL AS cairo_matrix_t PTR)

#DEFINE GOO_TYPE_CAIRO_PATTERN (goo_cairo_pattern_get_type ())
DECLARE FUNCTION goo_cairo_pattern_get_type() AS GType
#DEFINE GOO_TYPE_CAIRO_FILL_RULE (goo_cairo_fill_rule_get_type ())
DECLARE FUNCTION goo_cairo_fill_rule_get_type() AS GType
#DEFINE GOO_TYPE_CAIRO_OPERATOR (goo_cairo_operator_get_type())
DECLARE FUNCTION goo_cairo_operator_get_type() AS GType
#DEFINE GOO_TYPE_CAIRO_ANTIALIAS (goo_cairo_antialias_get_type())
DECLARE FUNCTION goo_cairo_antialias_get_type() AS GType
#DEFINE GOO_TYPE_CAIRO_LINE_CAP (goo_cairo_line_cap_get_type ())
DECLARE FUNCTION goo_cairo_line_cap_get_type() AS GType
#DEFINE GOO_TYPE_CAIRO_LINE_JOIN (goo_cairo_line_join_get_type ())
DECLARE FUNCTION goo_cairo_line_join_get_type() AS GType
#DEFINE GOO_TYPE_CAIRO_HINT_METRICS (goo_cairo_hint_metrics_get_type ())
DECLARE FUNCTION goo_cairo_hint_metrics_get_type() AS GType

#ENDIF ' __GOO_CANVAS_UTILS_H__

TYPE GooCanvasItemSimpleData AS _GooCanvasItemSimpleData

TYPE _GooCanvasItemSimpleData
  AS GooCanvasStyle PTR style
  AS cairo_matrix_t PTR transform
  AS GArray PTR clip_path_commands
  AS gchar PTR tooltip
  AS gdouble visibility_threshold
  AS guint visibility : 2
  AS guint pointer_events : 4
  AS guint can_focus : 1
  AS guint own_style : 1
  AS guint clip_fill_rule : 4
  AS guint is_static : 1
  AS guint cache_setting : 2
  AS guint has_tooltip : 1
END TYPE

#DEFINE GOO_TYPE_CANVAS_ITEM_SIMPLE (goo_canvas_item_simple_get_type ())
#DEFINE GOO_CANVAS_ITEM_SIMPLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_ITEM_SIMPLE, GooCanvasItemSimple))
#DEFINE GOO_CANVAS_ITEM_SIMPLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_ITEM_SIMPLE, GooCanvasItemSimpleClass))
#DEFINE GOO_IS_CANVAS_ITEM_SIMPLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_ITEM_SIMPLE))
#DEFINE GOO_IS_CANVAS_ITEM_SIMPLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_ITEM_SIMPLE))
#DEFINE GOO_CANVAS_ITEM_SIMPLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_ITEM_SIMPLE, GooCanvasItemSimpleClass))

TYPE GooCanvasItemSimple AS _GooCanvasItemSimple
TYPE GooCanvasItemSimpleClass AS _GooCanvasItemSimpleClass
TYPE GooCanvasItemModelSimple AS _GooCanvasItemModelSimple

TYPE _GooCanvasItemSimple
  AS GObject parent_object
  AS GooCanvas PTR canvas
  AS GooCanvasItem PTR parent
  AS GooCanvasItemModelSimple PTR model
  AS GooCanvasItemSimpleData PTR simple_data
  AS GooCanvasBounds bounds
  AS guint need_update : 1
  AS guint need_entire_subtree_update : 1
  AS gpointer priv
END TYPE

TYPE _GooCanvasItemSimpleClass
  AS GObjectClass parent_class
  simple_create_path AS SUB(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS cairo_t PTR)
  simple_update AS SUB(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS cairo_t PTR)
  simple_paint AS SUB(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS cairo_t PTR, BYVAL AS CONST GooCanvasBounds PTR)
  simple_is_item_at AS FUNCTION(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS cairo_t PTR, BYVAL AS gboolean) AS gboolean
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_item_simple_get_type() AS GType
DECLARE SUB goo_canvas_item_simple_get_path_bounds(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS cairo_t PTR, BYVAL AS GooCanvasBounds PTR)
DECLARE SUB goo_canvas_item_simple_user_bounds_to_device(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS cairo_t PTR, BYVAL AS GooCanvasBounds PTR)
DECLARE SUB goo_canvas_item_simple_user_bounds_to_parent(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS cairo_t PTR, BYVAL AS GooCanvasBounds PTR)
DECLARE FUNCTION goo_canvas_item_simple_check_in_path(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS cairo_t PTR, BYVAL AS GooCanvasPointerEvents) AS gboolean
DECLARE SUB goo_canvas_item_simple_paint_path(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS cairo_t PTR)
DECLARE SUB goo_canvas_item_simple_changed(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS gboolean)
DECLARE SUB goo_canvas_item_simple_check_style(BYVAL AS GooCanvasItemSimple PTR)
DECLARE FUNCTION goo_canvas_item_simple_get_line_width(BYVAL AS GooCanvasItemSimple PTR) AS gdouble
DECLARE SUB goo_canvas_item_simple_set_model(BYVAL AS GooCanvasItemSimple PTR, BYVAL AS GooCanvasItemModel PTR)

#DEFINE GOO_TYPE_CANVAS_ITEM_MODEL_SIMPLE (goo_canvas_item_model_simple_get_type ())
#DEFINE GOO_CANVAS_ITEM_MODEL_SIMPLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_ITEM_MODEL_SIMPLE, GooCanvasItemModelSimple))
#DEFINE GOO_CANVAS_ITEM_MODEL_SIMPLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_ITEM_MODEL_SIMPLE, GooCanvasItemModelSimpleClass))
#DEFINE GOO_IS_CANVAS_ITEM_MODEL_SIMPLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_ITEM_MODEL_SIMPLE))
#DEFINE GOO_IS_CANVAS_ITEM_MODEL_SIMPLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_ITEM_MODEL_SIMPLE))
#DEFINE GOO_CANVAS_ITEM_MODEL_SIMPLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_ITEM_MODEL_SIMPLE, GooCanvasItemModelSimpleClass))

TYPE GooCanvasItemModelSimpleClass AS _GooCanvasItemModelSimpleClass

TYPE _GooCanvasItemModelSimple
  AS GObject parent_object
  AS GooCanvasItemModel PTR parent
  AS GooCanvasItemSimpleData simple_data
  AS gchar PTR title
  AS gchar PTR description
END TYPE

TYPE _GooCanvasItemModelSimpleClass
  AS GObjectClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_item_model_simple_get_type() AS GType

#ENDIF ' __GOO_CANVAS_ITEM_SIMPLE_H__

TYPE GooCanvasEllipseData AS _GooCanvasEllipseData

TYPE _GooCanvasEllipseData
  AS gdouble center_x, center_y, radius_x, radius_y
END TYPE

#DEFINE GOO_TYPE_CANVAS_ELLIPSE (goo_canvas_ellipse_get_type ())
#DEFINE GOO_CANVAS_ELLIPSE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_ELLIPSE, GooCanvasEllipse))
#DEFINE GOO_CANVAS_ELLIPSE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_ELLIPSE, GooCanvasEllipseClass))
#DEFINE GOO_IS_CANVAS_ELLIPSE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_ELLIPSE))
#DEFINE GOO_IS_CANVAS_ELLIPSE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_ELLIPSE))
#DEFINE GOO_CANVAS_ELLIPSE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_ELLIPSE, GooCanvasEllipseClass))

TYPE GooCanvasEllipse AS _GooCanvasEllipse
TYPE GooCanvasEllipseClass AS _GooCanvasEllipseClass

TYPE _GooCanvasEllipse
  AS GooCanvasItemSimple parent_object
  AS GooCanvasEllipseData PTR ellipse_data
END TYPE

TYPE _GooCanvasEllipseClass
  AS GooCanvasItemSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_ellipse_get_type() AS GType
DECLARE FUNCTION goo_canvas_ellipse_new(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItem PTR

#DEFINE GOO_TYPE_CANVAS_ELLIPSE_MODEL (goo_canvas_ellipse_model_get_type ())
#DEFINE GOO_CANVAS_ELLIPSE_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_ELLIPSE_MODEL, GooCanvasEllipseModel))
#DEFINE GOO_CANVAS_ELLIPSE_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_ELLIPSE_MODEL, GooCanvasEllipseModelClass))
#DEFINE GOO_IS_CANVAS_ELLIPSE_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_ELLIPSE_MODEL))
#DEFINE GOO_IS_CANVAS_ELLIPSE_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_ELLIPSE_MODEL))
#DEFINE GOO_CANVAS_ELLIPSE_MODEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_ELLIPSE_MODEL, GooCanvasEllipseModelClass))

TYPE GooCanvasEllipseModel AS _GooCanvasEllipseModel
TYPE GooCanvasEllipseModelClass AS _GooCanvasEllipseModelClass

TYPE _GooCanvasEllipseModel
  AS GooCanvasItemModelSimple parent_object
  AS GooCanvasEllipseData ellipse_data
END TYPE

TYPE _GooCanvasEllipseModelClass
  AS GooCanvasItemModelSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_ellipse_model_get_type() AS GType
DECLARE FUNCTION goo_canvas_ellipse_model_new(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItemModel PTR

#ENDIF ' __GOO_CANVAS_ELLIPSE_H__

#IFNDEF __GOO_CANVAS_GRID_H__
#DEFINE __GOO_CANVAS_GRID_H__

TYPE GooCanvasGridData AS _GooCanvasGridData

TYPE _GooCanvasGridData
  AS gdouble x, y, width, height
  AS gdouble x_step, y_step
  AS gdouble x_offset, y_offset
  AS gdouble horz_grid_line_width, vert_grid_line_width
  AS cairo_pattern_t PTR horz_grid_line_pattern, vert_grid_line_pattern
  AS gdouble border_width
  AS cairo_pattern_t PTR border_pattern
  AS guint show_horz_grid_lines : 1
  AS guint show_vert_grid_lines : 1
  AS guint vert_grid_lines_on_top : 1
END TYPE

#DEFINE GOO_TYPE_CANVAS_GRID (goo_canvas_grid_get_type ())
#DEFINE GOO_CANVAS_GRID(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_GRID, GooCanvasGrid))
#DEFINE GOO_CANVAS_GRID_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_GRID, GooCanvasGridClass))
#DEFINE GOO_IS_CANVAS_GRID(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_GRID))
#DEFINE GOO_IS_CANVAS_GRID_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_GRID))
#DEFINE GOO_CANVAS_GRID_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_GRID, GooCanvasGridClass))

TYPE GooCanvasGrid AS _GooCanvasGrid
TYPE GooCanvasGridClass AS _GooCanvasGridClass

TYPE _GooCanvasGrid
  AS GooCanvasItemSimple parent_object
  AS GooCanvasGridData PTR grid_data
END TYPE

TYPE _GooCanvasGridClass
  AS GooCanvasItemSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_grid_get_type() AS GType
DECLARE FUNCTION goo_canvas_grid_new(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItem PTR

#DEFINE GOO_TYPE_CANVAS_GRID_MODEL (goo_canvas_grid_model_get_type ())
#DEFINE GOO_CANVAS_GRID_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_GRID_MODEL, GooCanvasGridModel))
#DEFINE GOO_CANVAS_GRID_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_GRID_MODEL, GooCanvasGridModelClass))
#DEFINE GOO_IS_CANVAS_GRID_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_GRID_MODEL))
#DEFINE GOO_IS_CANVAS_GRID_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_GRID_MODEL))
#DEFINE GOO_CANVAS_GRID_MODEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_GRID_MODEL, GooCanvasGridModelClass))

TYPE GooCanvasGridModel AS _GooCanvasGridModel
TYPE GooCanvasGridModelClass AS _GooCanvasGridModelClass

TYPE _GooCanvasGridModel
  AS GooCanvasItemModelSimple parent_object
  AS GooCanvasGridData grid_data
END TYPE

TYPE _GooCanvasGridModelClass
  AS GooCanvasItemModelSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_grid_model_get_type() AS GType
DECLARE FUNCTION goo_canvas_grid_model_new(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItemModel PTR

#ENDIF ' __GOO_CANVAS_GRID_H__

#IFNDEF __GOO_CANVAS_GROUP_H__
#DEFINE __GOO_CANVAS_GROUP_H__

#DEFINE GOO_TYPE_CANVAS_GROUP (goo_canvas_group_get_type ())
#DEFINE GOO_CANVAS_GROUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_GROUP, GooCanvasGroup))
#DEFINE GOO_CANVAS_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_GROUP, GooCanvasGroupClass))
#DEFINE GOO_IS_CANVAS_GROUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_GROUP))
#DEFINE GOO_IS_CANVAS_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_GROUP))
#DEFINE GOO_CANVAS_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_GROUP, GooCanvasGroupClass))

TYPE GooCanvasGroup AS _GooCanvasGroup
TYPE GooCanvasGroupClass AS _GooCanvasGroupClass
TYPE GooCanvasGroupModel AS _GooCanvasGroupModel
TYPE GooCanvasGroupModelClass AS _GooCanvasGroupModelClass

TYPE _GooCanvasGroup
  AS GooCanvasItemSimple parent_object
  AS GPtrArray PTR items
END TYPE

TYPE _GooCanvasGroupClass
  AS GooCanvasItemSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_group_get_type() AS GType
DECLARE FUNCTION goo_canvas_group_new(BYVAL AS GooCanvasItem PTR, ...) AS GooCanvasItem PTR

#DEFINE GOO_TYPE_CANVAS_GROUP_MODEL (goo_canvas_group_model_get_type ())
#DEFINE GOO_CANVAS_GROUP_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_GROUP_MODEL, GooCanvasGroupModel))
#DEFINE GOO_CANVAS_GROUP_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_GROUP_MODEL, GooCanvasGroupModelClass))
#DEFINE GOO_IS_CANVAS_GROUP_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_GROUP_MODEL))
#DEFINE GOO_IS_CANVAS_GROUP_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_GROUP_MODEL))
#DEFINE GOO_CANVAS_GROUP_MODEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_GROUP_MODEL, GooCanvasGroupModelClass))

TYPE _GooCanvasGroupModel
  AS GooCanvasItemModelSimple parent_object
  AS GPtrArray PTR children
END TYPE

TYPE _GooCanvasGroupModelClass
  AS GooCanvasItemModelSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_group_model_get_type() AS GType
DECLARE FUNCTION goo_canvas_group_model_new(BYVAL AS GooCanvasItemModel PTR, ...) AS GooCanvasItemModel PTR

#ENDIF ' __GOO_CANVAS_GROUP_H__

#IFNDEF __GOO_CANVAS_IMAGE_H__
#DEFINE __GOO_CANVAS_IMAGE_H__

TYPE GooCanvasImageData AS _GooCanvasImageData

TYPE _GooCanvasImageData
  AS cairo_pattern_t PTR pattern
  AS gdouble x, y, width, height
END TYPE

#DEFINE GOO_TYPE_CANVAS_IMAGE (goo_canvas_image_get_type ())
#DEFINE GOO_CANVAS_IMAGE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_IMAGE, GooCanvasImage))
#DEFINE GOO_CANVAS_IMAGE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_IMAGE, GooCanvasImageClass))
#DEFINE GOO_IS_CANVAS_IMAGE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_IMAGE))
#DEFINE GOO_IS_CANVAS_IMAGE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_IMAGE))
#DEFINE GOO_CANVAS_IMAGE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_IMAGE, GooCanvasImageClass))

TYPE GooCanvasImage AS _GooCanvasImage
TYPE GooCanvasImageClass AS _GooCanvasImageClass

TYPE _GooCanvasImage
  AS GooCanvasItemSimple parent_object
  AS GooCanvasImageData PTR image_data
END TYPE

TYPE _GooCanvasImageClass
  AS GooCanvasItemSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_image_get_type() AS GType
DECLARE FUNCTION goo_canvas_image_new(BYVAL AS GooCanvasItem PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItem PTR

#DEFINE GOO_TYPE_CANVAS_IMAGE_MODEL (goo_canvas_image_model_get_type ())
#DEFINE GOO_CANVAS_IMAGE_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_IMAGE_MODEL, GooCanvasImageModel))
#DEFINE GOO_CANVAS_IMAGE_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_IMAGE_MODEL, GooCanvasImageModelClass))
#DEFINE GOO_IS_CANVAS_IMAGE_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_IMAGE_MODEL))
#DEFINE GOO_IS_CANVAS_IMAGE_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_IMAGE_MODEL))
#DEFINE GOO_CANVAS_IMAGE_MODEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_IMAGE_MODEL, GooCanvasImageModelClass))

TYPE GooCanvasImageModel AS _GooCanvasImageModel
TYPE GooCanvasImageModelClass AS _GooCanvasImageModelClass

TYPE _GooCanvasImageModel
  AS GooCanvasItemModelSimple parent_object
  AS GooCanvasImageData image_data
END TYPE

TYPE _GooCanvasImageModelClass
  AS GooCanvasItemModelSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_image_model_get_type() AS GType
DECLARE FUNCTION goo_canvas_image_model_new(BYVAL AS GooCanvasItemModel PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItemModel PTR

#ENDIF ' __GOO_CANVAS_IMAGE_H__

#IFNDEF __GOO_CANVAS_PATH_H__
#DEFINE __GOO_CANVAS_PATH_H__

TYPE GooCanvasPathData AS _GooCanvasPathData

TYPE _GooCanvasPathData
  AS GArray PTR path_commands
END TYPE

#DEFINE GOO_TYPE_CANVAS_PATH (goo_canvas_path_get_type ())
#DEFINE GOO_CANVAS_PATH(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_PATH, GooCanvasPath))
#DEFINE GOO_CANVAS_PATH_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_PATH, GooCanvasPathClass))
#DEFINE GOO_IS_CANVAS_PATH(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_PATH))
#DEFINE GOO_IS_CANVAS_PATH_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_PATH))
#DEFINE GOO_CANVAS_PATH_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_PATH, GooCanvasPathClass))

TYPE GooCanvasPath AS _GooCanvasPath
TYPE GooCanvasPathClass AS _GooCanvasPathClass

TYPE _GooCanvasPath
  AS GooCanvasItemSimple parent
  AS GooCanvasPathData PTR path_data
END TYPE

TYPE _GooCanvasPathClass
  AS GooCanvasItemSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_path_get_type() AS GType
DECLARE FUNCTION goo_canvas_path_new(BYVAL AS GooCanvasItem PTR, BYVAL AS CONST gchar PTR, ...) AS GooCanvasItem PTR

#DEFINE GOO_TYPE_CANVAS_PATH_MODEL (goo_canvas_path_model_get_type ())
#DEFINE GOO_CANVAS_PATH_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_PATH_MODEL, GooCanvasPathModel))
#DEFINE GOO_CANVAS_PATH_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_PATH_MODEL, GooCanvasPathModelClass))
#DEFINE GOO_IS_CANVAS_PATH_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_PATH_MODEL))
#DEFINE GOO_IS_CANVAS_PATH_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_PATH_MODEL))
#DEFINE GOO_CANVAS_PATH_MODEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_PATH_MODEL, GooCanvasPathModelClass))

TYPE GooCanvasPathModel AS _GooCanvasPathModel
TYPE GooCanvasPathModelClass AS _GooCanvasPathModelClass

TYPE _GooCanvasPathModel
  AS GooCanvasItemModelSimple parent_object
  AS GooCanvasPathData path_data
END TYPE

TYPE _GooCanvasPathModelClass
  AS GooCanvasItemModelSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_path_model_get_type() AS GType
DECLARE FUNCTION goo_canvas_path_model_new(BYVAL AS GooCanvasItemModel PTR, BYVAL AS CONST gchar PTR, ...) AS GooCanvasItemModel PTR

#ENDIF ' __GOO_CANVAS_PATH_H__

#IFNDEF __GOO_CANVAS_POLYLINE_H__
#DEFINE __GOO_CANVAS_POLYLINE_H__

TYPE GooCanvasPoints AS _GooCanvasPoints

TYPE _GooCanvasPoints
  AS DOUBLE PTR coords
  AS INTEGER num_points
  AS INTEGER ref_count
END TYPE

#DEFINE GOO_TYPE_CANVAS_POINTS goo_canvas_points_get_type()

DECLARE FUNCTION goo_canvas_points_get_type() AS GType
DECLARE FUNCTION goo_canvas_points_new(BYVAL AS INTEGER) AS GooCanvasPoints PTR
DECLARE FUNCTION goo_canvas_points_ref(BYVAL AS GooCanvasPoints PTR) AS GooCanvasPoints PTR
DECLARE SUB goo_canvas_points_unref(BYVAL AS GooCanvasPoints PTR)

#DEFINE NUM_ARROW_POINTS 5

TYPE GooCanvasPolylineArrowData AS _GooCanvasPolylineArrowData

TYPE _GooCanvasPolylineArrowData
  AS gdouble arrow_width, arrow_length, arrow_tip_length
  AS gdouble line_start(1), line_end(1)
  AS gdouble start_arrow_coords(NUM_ARROW_POINTS * 2-1)
  AS gdouble end_arrow_coords(NUM_ARROW_POINTS * 2-1)
END TYPE

TYPE GooCanvasPolylineData AS _GooCanvasPolylineData

TYPE _GooCanvasPolylineData
  AS gdouble PTR coords
  AS GooCanvasPolylineArrowData PTR arrow_data
  AS guint num_points : 16
  AS guint close_path : 1
  AS guint start_arrow : 1
  AS guint end_arrow : 1
  AS guint reconfigure_arrows : 1
END TYPE

#DEFINE GOO_TYPE_CANVAS_POLYLINE (goo_canvas_polyline_get_type ())
#DEFINE GOO_CANVAS_POLYLINE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_POLYLINE, GooCanvasPolyline))
#DEFINE GOO_CANVAS_POLYLINE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_POLYLINE, GooCanvasPolylineClass))
#DEFINE GOO_IS_CANVAS_POLYLINE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_POLYLINE))
#DEFINE GOO_IS_CANVAS_POLYLINE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_POLYLINE))
#DEFINE GOO_CANVAS_POLYLINE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_POLYLINE, GooCanvasPolylineClass))

TYPE GooCanvasPolyline AS _GooCanvasPolyline
TYPE GooCanvasPolylineClass AS _GooCanvasPolylineClass

TYPE _GooCanvasPolyline
  AS GooCanvasItemSimple parent
  AS GooCanvasPolylineData PTR polyline_data
END TYPE

TYPE _GooCanvasPolylineClass
  AS GooCanvasItemSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_polyline_get_type() AS GType
DECLARE FUNCTION goo_canvas_polyline_new(BYVAL AS GooCanvasItem PTR, BYVAL AS gboolean, BYVAL AS gint, ...) AS GooCanvasItem PTR
DECLARE FUNCTION goo_canvas_polyline_new_line(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItem PTR

#DEFINE GOO_TYPE_CANVAS_POLYLINE_MODEL (goo_canvas_polyline_model_get_type ())
#DEFINE GOO_CANVAS_POLYLINE_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_POLYLINE_MODEL, GooCanvasPolylineModel))
#DEFINE GOO_CANVAS_POLYLINE_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_POLYLINE_MODEL, GooCanvasPolylineModelClass))
#DEFINE GOO_IS_CANVAS_POLYLINE_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_POLYLINE_MODEL))
#DEFINE GOO_IS_CANVAS_POLYLINE_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_POLYLINE_MODEL))
#DEFINE GOO_CANVAS_POLYLINE_MODEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_POLYLINE_MODEL, GooCanvasPolylineModelClass))

TYPE GooCanvasPolylineModel AS _GooCanvasPolylineModel
TYPE GooCanvasPolylineModelClass AS _GooCanvasPolylineModelClass

TYPE _GooCanvasPolylineModel
  AS GooCanvasItemModelSimple parent_object
  AS GooCanvasPolylineData polyline_data
END TYPE

TYPE _GooCanvasPolylineModelClass
  AS GooCanvasItemModelSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_polyline_model_get_type() AS GType
DECLARE FUNCTION goo_canvas_polyline_model_new(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gboolean, BYVAL AS gint, ...) AS GooCanvasItemModel PTR
DECLARE FUNCTION goo_canvas_polyline_model_new_line(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItemModel PTR

#ENDIF ' __GOO_CANVAS_POLYLINE_H__

#IFNDEF __GOO_CANVAS_RECT_H__
#DEFINE __GOO_CANVAS_RECT_H__

TYPE GooCanvasRectData AS _GooCanvasRectData

TYPE _GooCanvasRectData
  AS gdouble x, y, width, height, radius_x, radius_y
END TYPE

#DEFINE GOO_TYPE_CANVAS_RECT (goo_canvas_rect_get_type ())
#DEFINE GOO_CANVAS_RECT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_RECT, GooCanvasRect))
#DEFINE GOO_CANVAS_RECT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_RECT, GooCanvasRectClass))
#DEFINE GOO_IS_CANVAS_RECT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_RECT))
#DEFINE GOO_IS_CANVAS_RECT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_RECT))
#DEFINE GOO_CANVAS_RECT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_RECT, GooCanvasRectClass))

TYPE GooCanvasRect AS _GooCanvasRect
TYPE GooCanvasRectClass AS _GooCanvasRectClass

TYPE _GooCanvasRect
  AS GooCanvasItemSimple parent
  AS GooCanvasRectData PTR rect_data
END TYPE

TYPE _GooCanvasRectClass
  AS GooCanvasItemSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_rect_get_type() AS GType
DECLARE FUNCTION goo_canvas_rect_new(BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItem PTR

#DEFINE GOO_TYPE_CANVAS_RECT_MODEL (goo_canvas_rect_model_get_type ())
#DEFINE GOO_CANVAS_RECT_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_RECT_MODEL, GooCanvasRectModel))
#DEFINE GOO_CANVAS_RECT_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_RECT_MODEL, GooCanvasRectModelClass))
#DEFINE GOO_IS_CANVAS_RECT_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_RECT_MODEL))
#DEFINE GOO_IS_CANVAS_RECT_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_RECT_MODEL))
#DEFINE GOO_CANVAS_RECT_MODEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_RECT_MODEL, GooCanvasRectModelClass))

TYPE GooCanvasRectModel AS _GooCanvasRectModel
TYPE GooCanvasRectModelClass AS _GooCanvasRectModelClass

TYPE _GooCanvasRectModel
  AS GooCanvasItemModelSimple parent_object
  AS GooCanvasRectData rect_data
END TYPE

TYPE _GooCanvasRectModelClass
  AS GooCanvasItemModelSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_rect_model_get_type() AS GType
DECLARE FUNCTION goo_canvas_rect_model_new(BYVAL AS GooCanvasItemModel PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItemModel PTR

#ENDIF ' __GOO_CANVAS_RECT_H__

#IFNDEF __GOO_CANVAS_TABLE_H__
#DEFINE __GOO_CANVAS_TABLE_H__

TYPE GooCanvasTableDimension AS _GooCanvasTableDimension

TYPE _GooCanvasTableDimension
  AS gint size
  AS gdouble default_spacing
  AS gdouble PTR spacings
  AS guint homogeneous : 1
END TYPE

TYPE GooCanvasTableData AS _GooCanvasTableData
TYPE GooCanvasTableLayoutData AS _GooCanvasTableLayoutData

TYPE _GooCanvasTableData
  AS gdouble width, height
  AS GooCanvasTableDimension dimensions(1)
  AS gdouble border_width
  AS GArray PTR children
  AS GooCanvasTableLayoutData PTR layout_data
END TYPE

#DEFINE GOO_TYPE_CANVAS_TABLE (goo_canvas_table_get_type ())
#DEFINE GOO_CANVAS_TABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_TABLE, GooCanvasTable))
#DEFINE GOO_CANVAS_TABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_TABLE, GooCanvasTableClass))
#DEFINE GOO_IS_CANVAS_TABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_TABLE))
#DEFINE GOO_IS_CANVAS_TABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_TABLE))
#DEFINE GOO_CANVAS_TABLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_TABLE, GooCanvasTableClass))

TYPE GooCanvasTable AS _GooCanvasTable
TYPE GooCanvasTableClass AS _GooCanvasTableClass

TYPE _GooCanvasTable
  AS GooCanvasGroup parent
  AS GooCanvasTableData PTR table_data
END TYPE

TYPE _GooCanvasTableClass
  AS GooCanvasGroupClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_table_get_type() AS GType
DECLARE FUNCTION goo_canvas_table_new(BYVAL AS GooCanvasItem PTR, ...) AS GooCanvasItem PTR

#DEFINE GOO_TYPE_CANVAS_TABLE_MODEL (goo_canvas_table_model_get_type ())
#DEFINE GOO_CANVAS_TABLE_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_TABLE_MODEL, GooCanvasTableModel))
#DEFINE GOO_CANVAS_TABLE_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_TABLE_MODEL, GooCanvasTableModelClass))
#DEFINE GOO_IS_CANVAS_TABLE_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_TABLE_MODEL))
#DEFINE GOO_IS_CANVAS_TABLE_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_TABLE_MODEL))
#DEFINE GOO_CANVAS_TABLE_MODEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_TABLE_MODEL, GooCanvasTableModelClass))

TYPE GooCanvasTableModel AS _GooCanvasTableModel
TYPE GooCanvasTableModelClass AS _GooCanvasTableModelClass

TYPE _GooCanvasTableModel
  AS GooCanvasGroupModel parent_object
  AS GooCanvasTableData table_data
END TYPE

TYPE _GooCanvasTableModelClass
  AS GooCanvasGroupModelClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_table_model_get_type() AS GType
DECLARE FUNCTION goo_canvas_table_model_new(BYVAL AS GooCanvasItemModel PTR, ...) AS GooCanvasItemModel PTR

#ENDIF ' __GOO_CANVAS_TABLE_H__

#IFNDEF __GOO_CANVAS_TEXT_H__
#DEFINE __GOO_CANVAS_TEXT_H__

TYPE GooCanvasTextData AS _GooCanvasTextData

TYPE _GooCanvasTextData
  AS gchar PTR text
  AS gdouble x, y, width
  AS guint use_markup : 1
  AS guint anchor : 5
  AS guint alignment : 3
  AS guint ellipsize : 3
  AS guint wrap : 3
END TYPE

#DEFINE GOO_TYPE_CANVAS_TEXT (goo_canvas_text_get_type ())
#DEFINE GOO_CANVAS_TEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_TEXT, GooCanvasText))
#DEFINE GOO_CANVAS_TEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_TEXT, GooCanvasTextClass))
#DEFINE GOO_IS_CANVAS_TEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_TEXT))
#DEFINE GOO_IS_CANVAS_TEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_TEXT))
#DEFINE GOO_CANVAS_TEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_TEXT, GooCanvasTextClass))

TYPE GooCanvasText AS _GooCanvasText
TYPE GooCanvasTextClass AS _GooCanvasTextClass

TYPE _GooCanvasText
  AS GooCanvasItemSimple parent
  AS GooCanvasTextData PTR text_data
  AS gdouble layout_width
END TYPE

TYPE _GooCanvasTextClass
  AS GooCanvasItemSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_text_get_type() AS GType
DECLARE FUNCTION goo_canvas_text_new(BYVAL AS GooCanvasItem PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GooCanvasAnchorType, ...) AS GooCanvasItem PTR
DECLARE SUB goo_canvas_text_get_natural_extents(BYVAL AS GooCanvasText PTR, BYVAL AS PangoRectangle PTR, BYVAL AS PangoRectangle PTR)

#DEFINE GOO_TYPE_CANVAS_TEXT_MODEL (goo_canvas_text_model_get_type ())
#DEFINE GOO_CANVAS_TEXT_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_TEXT_MODEL, GooCanvasTextModel))
#DEFINE GOO_CANVAS_TEXT_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_TEXT_MODEL, GooCanvasTextModelClass))
#DEFINE GOO_IS_CANVAS_TEXT_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_TEXT_MODEL))
#DEFINE GOO_IS_CANVAS_TEXT_MODEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_TEXT_MODEL))
#DEFINE GOO_CANVAS_TEXT_MODEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_TEXT_MODEL, GooCanvasTextModelClass))

TYPE GooCanvasTextModel AS _GooCanvasTextModel
TYPE GooCanvasTextModelClass AS _GooCanvasTextModelClass

TYPE _GooCanvasTextModel
  AS GooCanvasItemModelSimple parent_object
  AS GooCanvasTextData text_data
END TYPE

TYPE _GooCanvasTextModelClass
  AS GooCanvasItemModelSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_text_model_get_type() AS GType
DECLARE FUNCTION goo_canvas_text_model_new(BYVAL AS GooCanvasItemModel PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GooCanvasAnchorType, ...) AS GooCanvasItemModel PTR

#ENDIF ' __GOO_CANVAS_TEXT_H__

#IFNDEF __GOO_CANVAS_WIDGET_H__
#DEFINE __GOO_CANVAS_WIDGET_H__

#DEFINE GOO_TYPE_CANVAS_WIDGET (goo_canvas_widget_get_type ())
#DEFINE GOO_CANVAS_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS_WIDGET, GooCanvasWidget))
#DEFINE GOO_CANVAS_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS_WIDGET, GooCanvasWidgetClass))
#DEFINE GOO_IS_CANVAS_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS_WIDGET))
#DEFINE GOO_IS_CANVAS_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS_WIDGET))
#DEFINE GOO_CANVAS_WIDGET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS_WIDGET, GooCanvasWidgetClass))

TYPE GooCanvasWidget AS _GooCanvasWidget
TYPE GooCanvasWidgetClass AS _GooCanvasWidgetClass

TYPE _GooCanvasWidget
  AS GooCanvasItemSimple parent_object
  AS GtkWidget PTR widget
  AS gdouble x, y, width, height
  AS GooCanvasAnchorType anchor
END TYPE

TYPE _GooCanvasWidgetClass
  AS GooCanvasItemSimpleClass parent_class
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_widget_get_type() AS GType
DECLARE FUNCTION goo_canvas_widget_new(BYVAL AS GooCanvasItem PTR, BYVAL AS GtkWidget PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, ...) AS GooCanvasItem PTR

#ENDIF ' __GOO_CANVAS_WIDGET_H__

#DEFINE GOO_TYPE_CANVAS (goo_canvas_get_type ())
#DEFINE GOO_CANVAS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_CANVAS, GooCanvas))
#DEFINE GOO_CANVAS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_CANVAS, GooCanvasClass))
#DEFINE GOO_IS_CANVAS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_CANVAS))
#DEFINE GOO_IS_CANVAS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_CANVAS))
#DEFINE GOO_CANVAS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_CANVAS, GooCanvasClass))

TYPE GooCanvasClass AS _GooCanvasClass

TYPE _GooCanvas
  AS GtkContainer container
  AS GooCanvasItemModel PTR root_item_model
  AS GooCanvasItem PTR root_item
  AS GooCanvasBounds bounds
  AS gdouble scale_x, scale_y
  AS gdouble scale
  AS GooCanvasAnchorType anchor
  AS guint idle_id
  AS guint need_update : 1
  AS guint need_entire_subtree_update : 1
  AS guint integer_layout : 1
  AS guint automatic_bounds : 1
  AS guint bounds_from_origin : 1
  AS guint clear_background : 1
  AS guint redraw_when_scrolled : 1
  AS guint before_initial_draw : 1
  AS guint hscroll_policy : 1
  AS guint vscroll_policy : 1
  AS gdouble bounds_padding
  AS GooCanvasItem PTR pointer_item
  AS GooCanvasItem PTR pointer_grab_item
  AS GooCanvasItem PTR pointer_grab_initial_item
  AS guint pointer_grab_button
  AS GooCanvasItem PTR focused_item
  AS GooCanvasItem PTR keyboard_grab_item
  AS GdkEventCrossing crossing_event
  AS GdkWindow PTR canvas_window
  AS gint canvas_x_offset
  AS gint canvas_y_offset
  AS GtkAdjustment PTR hadjustment
  AS GtkAdjustment PTR vadjustment
  AS gint freeze_count
  AS GdkWindow PTR tmp_window
  AS GHashTable PTR model_to_item
  AS GtkUnit units
  AS gdouble resolution_x, resolution_y
  AS gdouble device_to_pixels_x, device_to_pixels_y
  AS GList PTR widget_items
END TYPE

TYPE _GooCanvasClass
  AS GtkContainerClass parent_class
  create_item AS FUNCTION(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItemModel PTR) AS GooCanvasItem PTR
  item_created AS SUB(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasItemModel PTR)
  _goo_canvas_reserved1 AS SUB()
  _goo_canvas_reserved2 AS SUB()
  _goo_canvas_reserved3 AS SUB()
  _goo_canvas_reserved4 AS SUB()
  _goo_canvas_reserved5 AS SUB()
  _goo_canvas_reserved6 AS SUB()
  _goo_canvas_reserved7 AS SUB()
  _goo_canvas_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION goo_canvas_get_type() AS GType
DECLARE FUNCTION goo_canvas_new() AS GtkWidget PTR
DECLARE FUNCTION goo_canvas_get_root_item(BYVAL AS GooCanvas PTR) AS GooCanvasItem PTR
DECLARE SUB goo_canvas_set_root_item(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR)
DECLARE FUNCTION goo_canvas_get_root_item_model(BYVAL AS GooCanvas PTR) AS GooCanvasItemModel PTR
DECLARE SUB goo_canvas_set_root_item_model(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItemModel PTR)
DECLARE FUNCTION goo_canvas_get_static_root_item(BYVAL AS GooCanvas PTR) AS GooCanvasItem PTR
DECLARE SUB goo_canvas_set_static_root_item(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR)
DECLARE FUNCTION goo_canvas_get_static_root_item_model(BYVAL AS GooCanvas PTR) AS GooCanvasItemModel PTR
DECLARE SUB goo_canvas_set_static_root_item_model(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItemModel PTR)
DECLARE FUNCTION goo_canvas_get_item(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItemModel PTR) AS GooCanvasItem PTR
DECLARE FUNCTION goo_canvas_get_item_at(BYVAL AS GooCanvas PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gboolean) AS GooCanvasItem PTR
DECLARE FUNCTION goo_canvas_get_items_at(BYVAL AS GooCanvas PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gboolean) AS GList PTR
DECLARE FUNCTION goo_canvas_get_items_in_area(BYVAL AS GooCanvas PTR, BYVAL AS CONST GooCanvasBounds PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS gboolean) AS GList PTR
DECLARE FUNCTION goo_canvas_get_scale(BYVAL AS GooCanvas PTR) AS gdouble
DECLARE SUB goo_canvas_set_scale(BYVAL AS GooCanvas PTR, BYVAL AS gdouble)
DECLARE SUB goo_canvas_get_bounds(BYVAL AS GooCanvas PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB goo_canvas_set_bounds(BYVAL AS GooCanvas PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_scroll_to(BYVAL AS GooCanvas PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB goo_canvas_grab_focus(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR)
DECLARE SUB goo_canvas_render(BYVAL AS GooCanvas PTR, BYVAL AS cairo_t PTR, BYVAL AS CONST GooCanvasBounds PTR, BYVAL AS gdouble)
DECLARE SUB goo_canvas_convert_to_pixels(BYVAL AS GooCanvas PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB goo_canvas_convert_from_pixels(BYVAL AS GooCanvas PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB goo_canvas_convert_to_item_space(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB goo_canvas_convert_from_item_space(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB goo_canvas_convert_bounds_to_item_space(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GooCanvasBounds PTR)
DECLARE FUNCTION goo_canvas_pointer_grab(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS GdkEventMask, BYVAL AS GdkCursor PTR, BYVAL AS guint32) AS GdkGrabStatus
DECLARE SUB goo_canvas_pointer_ungrab(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS guint32)
DECLARE FUNCTION goo_canvas_keyboard_grab(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS gboolean, BYVAL AS guint32) AS GdkGrabStatus
DECLARE SUB goo_canvas_keyboard_ungrab(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItem PTR, BYVAL AS guint32)
DECLARE FUNCTION goo_canvas_create_cairo_context(BYVAL AS GooCanvas PTR) AS cairo_t PTR
DECLARE FUNCTION goo_canvas_create_item(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItemModel PTR) AS GooCanvasItem PTR
DECLARE SUB goo_canvas_unregister_item(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasItemModel PTR)
DECLARE SUB goo_canvas_update(BYVAL AS GooCanvas PTR)
DECLARE SUB goo_canvas_request_update(BYVAL AS GooCanvas PTR)
DECLARE SUB goo_canvas_request_redraw(BYVAL AS GooCanvas PTR, BYVAL AS CONST GooCanvasBounds PTR)
DECLARE SUB goo_canvas_request_item_redraw(BYVAL AS GooCanvas PTR, BYVAL AS CONST GooCanvasBounds PTR, BYVAL AS gboolean)
DECLARE FUNCTION goo_canvas_get_default_line_width(BYVAL AS GooCanvas PTR) AS gdouble
DECLARE SUB goo_canvas_register_widget_item(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasWidget PTR)
DECLARE SUB goo_canvas_unregister_widget_item(BYVAL AS GooCanvas PTR, BYVAL AS GooCanvasWidget PTR)

#ENDIF ' __GOO_CANVAS_H__

#IFNDEF __GOO_CANVAS_ATK_H__
#DEFINE __GOO_CANVAS_ATK_H__

DECLARE FUNCTION goo_canvas_accessible_factory_get_type() AS GType
DECLARE FUNCTION goo_canvas_item_accessible_factory_get_type() AS GType
DECLARE FUNCTION goo_canvas_widget_accessible_factory_get_type() AS GType

#ENDIF ' __GOO_CANVAS_ATK_H__

#IFNDEF __goo_canvas_marshal_MARSHAL_H__
#DEFINE __goo_canvas_marshal_MARSHAL_H__

#DEFINE goo_canvas_marshal_VOID__VOID g_cclosure_marshal_VOID__VOID
#DEFINE goo_canvas_marshal_VOID__INT g_cclosure_marshal_VOID__INT

EXTERN goo_canvas_marshal_VOID__INT_INT AS SUB(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)

#DEFINE goo_canvas_marshal_VOID__BOOLEAN g_cclosure_marshal_VOID__BOOLEAN

EXTERN goo_canvas_marshal_VOID__OBJECT_OBJECT AS SUB(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
EXTERN goo_canvas_marshal_BOOLEAN__BOXED AS SUB(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
EXTERN goo_canvas_marshal_BOOLEAN__OBJECT_BOXED AS SUB(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
EXTERN goo_canvas_marshal_BOOLEAN__DOUBLE_DOUBLE_BOOLEAN_OBJECT AS SUB(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)

#ENDIF ' __goo_canvas_marshal_MARSHAL_H__

#IFNDEF __GOO_CANVAS_PRIVATE_H__
#DEFINE __GOO_CANVAS_PRIVATE_H__

DECLARE SUB goo_canvas_util_ptr_array_insert(BYVAL AS GPtrArray PTR, BYVAL AS gpointer, BYVAL AS gint)
DECLARE SUB goo_canvas_util_ptr_array_move(BYVAL AS GPtrArray PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION goo_canvas_util_ptr_array_find_index(BYVAL AS GPtrArray PTR, BYVAL AS gpointer) AS gint
DECLARE FUNCTION goo_canvas_cairo_pattern_from_pixbuf(BYVAL AS GdkPixbuf PTR) AS cairo_pattern_t PTR
DECLARE FUNCTION goo_canvas_cairo_surface_from_pixbuf(BYVAL AS GdkPixbuf PTR) AS cairo_surface_t PTR
DECLARE FUNCTION goo_canvas_convert_colors_to_rgba(BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS guint
DECLARE SUB goo_canvas_get_rgba_value_from_pattern(BYVAL AS cairo_pattern_t PTR, BYVAL AS GValue PTR)
DECLARE SUB goo_canvas_set_style_property_from_pattern(BYVAL AS GooCanvasStyle PTR, BYVAL AS GQuark, BYVAL AS cairo_pattern_t PTR)
DECLARE FUNCTION goo_canvas_create_pattern_from_color_value(BYVAL AS CONST GValue PTR) AS cairo_pattern_t PTR
DECLARE FUNCTION goo_canvas_create_pattern_from_rgba_value(BYVAL AS CONST GValue PTR) AS cairo_pattern_t PTR
DECLARE FUNCTION goo_canvas_create_pattern_from_pixbuf_value(BYVAL AS CONST GValue PTR) AS cairo_pattern_t PTR
DECLARE FUNCTION goo_canvas_boolean_handled_accumulator(BYVAL AS GSignalInvocationHint PTR, BYVAL AS GValue PTR, BYVAL AS CONST GValue PTR, BYVAL AS gpointer) AS gboolean

#ENDIF ' __GOO_CANVAS_PRIVATE_H__

END EXTERN ' (h_2_bi -P_oCD option)

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF

' Translated at 11-09-19 20:47:50, by h_2_bi (version 0.2.1.1,
' released under GPLv3 by Thomas[ dot ]Freiherr{ at }gmx[ dot ]net)

'   Protocol: goocanvas-2.0.0.bi
' Parameters:
'                                  Process time [s]: 0.3282270974013954
'                                  Bytes translated: 75942
'                                      Maximum deep: 5
'                                SUB/FUNCTION names: 235
'                                mangled TYPE names: 0
'                                        files done: 20
' goocanvas-2.0.0/src/goocanvas.h
' goocanvas-2.0.0/src/goocanvasenumtypes.h
' goocanvas-2.0.0/src/goocanvasellipse.h
' goocanvas-2.0.0/src/goocanvasitemsimple.h
' goocanvas-2.0.0/src/goocanvasitem.h
' goocanvas-2.0.0/src/goocanvasstyle.h
' goocanvas-2.0.0/src/goocanvasitemmodel.h
' goocanvas-2.0.0/src/goocanvasutils.h
' goocanvas-2.0.0/src/goocanvasgrid.h
' goocanvas-2.0.0/src/goocanvasgroup.h
' goocanvas-2.0.0/src/goocanvasimage.h
' goocanvas-2.0.0/src/goocanvaspath.h
' goocanvas-2.0.0/src/goocanvaspolyline.h
' goocanvas-2.0.0/src/goocanvasrect.h
' goocanvas-2.0.0/src/goocanvastable.h
' goocanvas-2.0.0/src/goocanvastext.h
' goocanvas-2.0.0/src/goocanvaswidget.h
' goocanvas-2.0.0/src/goocanvasatk.h
' goocanvas-2.0.0/src/goocanvasmarshal.h
' goocanvas-2.0.0/src/goocanvasprivate.h
'                                      files missed: 0
'                                       __FOLDERS__: 1
' goocanvas-2.0.0/src/
'                                        __MACROS__: 2
' 20: #define G_BEGIN_DECLS
' 20: #define G_END_DECLS
'                                       __HEADERS__: 0
'                                         __TYPES__: 0
'                                     __POST_REPS__: 0

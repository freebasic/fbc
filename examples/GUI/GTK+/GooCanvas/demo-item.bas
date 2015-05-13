'/*
 '* GooCanvas Demo. Copyright (C) 2006 Damon Chaplin.
 '* Released under the GNU LGPL license. See COPYING for details.
 '*
 '* demo-item.c - a simple demo item.
 '*/
'
' FB translation by TJF, 2011
' Details: http://library.gnome.org/devel/goocanvas/unstable/

'#DEFINE __USE_GTK3__
#INCLUDE "goocanvas.bi"

#DEFINE GOO_TYPE_DEMO_ITEM (goo_demo_item_get_type ())
#DEFINE GOO_DEMO_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GOO_TYPE_DEMO_ITEM, GooDemoItem))
#DEFINE GOO_DEMO_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GOO_TYPE_DEMO_ITEM, GooDemoItemClass))
#DEFINE GOO_IS_DEMO_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GOO_TYPE_DEMO_ITEM))
#DEFINE GOO_IS_DEMO_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GOO_TYPE_DEMO_ITEM))
#DEFINE GOO_DEMO_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GOO_TYPE_DEMO_ITEM, GooDemoItemClass))

TYPE GooDemoItem AS _GooDemoItem
TYPE GooDemoItemClass AS _GooDemoItemClass

TYPE _GooDemoItem
  AS GooCanvasItemSimple parent_object
  AS gdouble x, y, WIDTH, height
END TYPE

TYPE _GooDemoItemClass
  AS GooCanvasItemSimpleClass parent_class
END TYPE

'/* Use the GLib convenience macro to define the type. GooDemoItem is the
   'class struct, goo_demo_item is the function prefix, and our class is a
   'subclass of GOO_TYPE_CANVAS_ITEM_SIMPLE. */
G_DEFINE_TYPE (GooDemoItem, goo_demo_item, GOO_TYPE_CANVAS_ITEM_SIMPLE)

'/* The standard object initialization function. */
SUB goo_demo_item_init CDECL( _
  BYVAL demo_item AS GooDemoItem PTR)

  demo_item->x = 0.0
  demo_item->y = 0.0
  demo_item->WIDTH = 0.0
  demo_item->height = 0.0
END SUB

'/* The convenience function to create new items. This should start with a
   'parent argument and end with a variable list of object properties to fit
   'in with the standard canvas items. */
FUNCTION goo_demo_item_new CDECL( _
  BYVAL parent AS GooCanvasItem PTR, _
  BYVAL x AS gdouble, _
  BYVAL y AS gdouble, _
  BYVAL width_ AS gdouble, _
  BYVAL height AS gdouble, _
  ...) AS GooCanvasItem PTR

  VAR item = g_object_new (GOO_TYPE_DEMO_ITEM, NULL)

  VAR demo_item = CAST(GooDemoItem PTR, item)
  demo_item->x = x
  demo_item->y = y
  demo_item->width = width_
  demo_item->height = height

  VAR va = VA_FIRST(), first_property = VA_ARG(va, ZSTRING PTR)
  IF first_property THEN _
    g_object_set_valist (CAST(GObject PTR, item), first_property, VA_NEXT(va, ZSTRING PTR))

  IF parent THEN
    goo_canvas_item_add_child (parent, item, -1)
    g_object_unref (item)
  END IF

  RETURN item
END FUNCTION

'/* The update method. This is called when the canvas is initially shown and
   'also whenever the object is updated and needs to change its size and/or
   'shape. It should calculate its new bounds in its own coordinate space,
   'storing them in simple->bounds. */
SUB goo_demo_item_update CDECL( _
  BYVAL simple AS GooCanvasItemSimple PTR, _
  BYVAL cr AS cairo_t PTR)

  VAR demo_item = CAST(GooDemoItem PTR, simple)

  '/* Compute the new bounds. */
  simple->bounds.x1 = demo_item->x
  simple->bounds.y1 = demo_item->y
  simple->bounds.x2 = demo_item->x + demo_item->WIDTH
  simple->bounds.y2 = demo_item->y + demo_item->height
END SUB

'/* The paint method. This should draw the item on the given cairo_t, using
   'the item's own coordinate space. */
SUB goo_demo_item_paint CDECL( _
  BYVAL simple AS GooCanvasItemSimple PTR, _
  BYVAL cr AS cairo_t PTR, _
  BYVAL bounds AS CONST GooCanvasBounds PTR)

  VAR demo_item = CAST(GooDemoItem PTR, simple)

  cairo_move_to (cr, demo_item->x, demo_item->y)
  cairo_line_to (cr, demo_item->x, demo_item->y + demo_item->height)
  cairo_line_to (cr, demo_item->x + demo_item->WIDTH, _
     demo_item->y + demo_item->height)
  cairo_line_to (cr, demo_item->x + demo_item->WIDTH, demo_item->y)
  cairo_close_path (cr)
  goo_canvas_style_set_fill_options (simple->simple_data->style, cr)
  cairo_fill (cr)
END SUB

'/* Hit detection. This should check if the given coordinate (in the item's
   'coordinate space) is within the item. If it is it should return TRUE,
   'otherwise it should return FALSE. */
FUNCTION goo_demo_item_is_item_at CDECL( _
  BYVAL simple AS GooCanvasItemSimple PTR, _
  BYVAL x AS gdouble, _
  BYVAL y AS gdouble, _
  BYVAL cr AS cairo_t PTR, _
  BYVAL is_pointer_event AS gboolean) AS gboolean

  VAR demo_item = CAST(GooDemoItem PTR, simple)

  IF x < demo_item->x ORELSE (x > demo_item->x + demo_item->WIDTH) _
      ORELSE y < demo_item->y ORELSE (y > demo_item->y + demo_item->height) THEN _
    RETURN FALSE

  RETURN TRUE
END FUNCTION

'/* The class initialization function. Here we set the class' update(), paint()
   'and is_item_at() methods. */
SUB goo_demo_item_class_init CDECL( _
  BYVAL klass AS GooDemoItemClass PTR)

  VAR simple_class = CAST(GooCanvasItemSimpleClass PTR, klass)

  simple_class->simple_update      = @goo_demo_item_update
  simple_class->simple_paint       = @goo_demo_item_paint
  simple_class->simple_is_item_at  = @goo_demo_item_is_item_at
END SUB


FUNCTION create_demo_item_page() AS GtkWidget PTR

  VAR scrolled_win = gtk_scrolled_window_new (NULL, NULL)
  gtk_scrolled_window_set_shadow_type (GTK_SCROLLED_WINDOW (scrolled_win), _
               GTK_SHADOW_IN)
  gtk_widget_show (scrolled_win)

  VAR canvas = goo_canvas_new ()
  gtk_widget_set_can_focus (canvas, TRUE)
  gtk_widget_set_size_request (canvas, 600, 450)
  goo_canvas_set_bounds (GOO_CANVAS (canvas), 0, 0, 1000, 1000)
  gtk_widget_show (canvas)
  gtk_container_add (GTK_CONTAINER (scrolled_win), canvas)

  VAR root = goo_canvas_get_root_item (GOO_CANVAS (canvas))

  VAR demo = goo_demo_item_new(root, 100.0, 100.0, 400.0, 300.0, _
                               "fill-color", "blue", _
                               NULL)

  RETURN scrolled_win
END FUNCTION


' Initialize GTK+.
gtk_init (@__FB_ARGC__, @__FB_ARGV__)

' Create the window and widgets.
VAR win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
gtk_window_set_default_size (GTK_WINDOW (win), 640, 600)
gtk_widget_show (win)
g_signal_connect (win, "delete_event", G_CALLBACK(@gtk_main_quit), NULL)

VAR page = create_demo_item_page()
gtk_container_add (GTK_CONTAINER (win), page)

' Pass control to the GTK+ main event loop.
gtk_main ()

END 0

'/*
 '* GooCanvas Demo. Copyright (C) 2006 Damon Chaplin.
 '* Released under the GNU LGPL license. See COPYING for details.
 '*
 '* simple-demo.c
 '*/
'
' FB translation by TJF, 2011
' Details: http://library.gnome.org/devel/goocanvas/unstable/

'#DEFINE __USE_GTK3__
#INCLUDE "goocanvas.bi"

'This handles button presses in item views. We simply output a message to
'the console.
FUNCTION on_rect_button_press(BYVAL item AS GooCanvasItem PTR, _
                              BYVAL target AS GooCanvasItem PTR, _
                              BYVAL event AS GdkEventButton PTR, _
                              BYVAL data_ AS gpointer) AS gboolean
  ?"rect item received button press event"
  RETURN TRUE
END FUNCTION


' Initialize GTK+.
  'gtk_set_locale ()
gtk_init (@__FB_ARGC__, @__FB_ARGV__)

' Create the window and widgets.
VAR win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
gtk_window_set_default_size (GTK_WINDOW (win), 640, 600)
gtk_widget_show (win)
g_signal_connect (win, "delete_event", G_CALLBACK(@gtk_main_quit), NULL)

VAR scrolled_win = gtk_scrolled_window_new (NULL, NULL)
gtk_scrolled_window_set_shadow_type (GTK_SCROLLED_WINDOW (scrolled_win), _
                                     GTK_SHADOW_IN)
gtk_widget_show (scrolled_win)
gtk_container_add (GTK_CONTAINER (win), scrolled_win)

VAR canvas = goo_canvas_new ()
gtk_widget_set_size_request (canvas, 600, 450)
goo_canvas_set_bounds (GOO_CANVAS (canvas), 0, 0, 1000, 1000)
gtk_widget_show (canvas)
gtk_container_add (GTK_CONTAINER (scrolled_win), canvas)

VAR root = goo_canvas_get_root_item (GOO_CANVAS (canvas))

' Add a few simple items.
VAR rect_item = goo_canvas_rect_new (root, 100, 100, 400, 400, _
                                     "line-width", 10.0, _
                                     "radius-x", 20.0, _
                                     "radius-y", 10.0, _
                                     "stroke-color", "yellow", _
                                     "fill-color", "red", _
                                     NULL)

VAR text_item = goo_canvas_text_new (root, "Hello FB users", 300, 300, -1, _
                                     GOO_CANVAS_ANCHOR_CENTER, _
                                     "font", "Sans 24", _
                                     NULL)
goo_canvas_item_rotate (text_item, -45, 300, 300)

' Connect a signal handler for the rectangle item.
g_signal_connect(rect_item, "button_press_event", _
                    G_CALLBACK(@on_rect_button_press), NULL)

' Pass control to the GTK+ main event loop.
gtk_main ()

END 0

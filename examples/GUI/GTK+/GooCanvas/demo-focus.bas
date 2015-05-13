'/*
 '* GooCanvas Demo. Copyright (C) 2006 Damon Chaplin.
 '* Released under the GNU LGPL license. See COPYING for details.
 '*
 '* demo-focus.c
 '*/
'
' FB translation by TJF, 2011
' Details: http://library.gnome.org/devel/goocanvas/unstable/

#INCLUDE "goocanvas.bi"

FUNCTION on_focus_in CDECL(BYVAL item AS GooCanvasItem PTR, _
                           BYVAL target AS GooCanvasItem PTR, _
                           BYVAL event AS GdkEventKey PTR, _
                           BYVAL dat AS gpointer) AS gboolean
  DIM AS ZSTRING PTR id = g_object_get_data (G_OBJECT (item), "id")

  g_print (!"%s received focus-in event\n", IIF(id, id, @"unknown"))

  '/* Note that this is only for testing. Setting item properties to indicate
     'focus isn't a good idea for real apps, as there may be multiple views. */
  g_object_set (item, "stroke-color", "black", NULL)

  RETURN FALSE
END FUNCTION

FUNCTION on_focus_out CDECL(BYVAL item AS GooCanvasItem PTR, _
                            BYVAL target AS GooCanvasItem PTR, _
                            BYVAL event AS GdkEventKey PTR, _
                            BYVAL dat AS gpointer) AS gboolean
  DIM AS ZSTRING PTR id = g_object_get_data (G_OBJECT (item), "id")

  g_print (!"%s received focus-out event\n", IIF(id, id, @"unknown"))

  '/* Note that this is only for testing. Setting item properties to indicate
     'focus isn't a good idea for real apps, as there may be multiple views. */
  g_object_set (item, "stroke-pattern", NULL, NULL)

  RETURN FALSE
END FUNCTION

FUNCTION on_button_press CDECL(BYVAL item AS GooCanvasItem PTR, _
                               BYVAL target AS GooCanvasItem PTR, _
                               BYVAL event AS GdkEventKey PTR, _
                               BYVAL dat AS gpointer) AS gboolean
  DIM AS ZSTRING PTR id = g_object_get_data (G_OBJECT (item), "id")

  g_print (!"%s received button-press event\n", IIF(id, id, @"unknown"))

  VAR canvas = goo_canvas_item_get_canvas (item)
  goo_canvas_grab_focus (canvas, item)

  RETURN TRUE
END FUNCTION

FUNCTION on_key_press CDECL(BYVAL item AS GooCanvasItem PTR, _
                            BYVAL target AS GooCanvasItem PTR, _
                            BYVAL event AS GdkEventKey PTR, _
                            BYVAL dat AS gpointer) AS gboolean
  DIM AS ZSTRING PTR id = g_object_get_data (G_OBJECT (item), "id")

  g_print (!"%s received key-press event\n", IIF(id, id, @"unknown"))

  RETURN FALSE
END FUNCTION

SUB create_focus_box(BYVAL canvas AS GtkWidget PTR, _
                     BYVAL x AS gdouble, _
                     BYVAL y AS gdouble, _
                     BYVAL width_ AS gdouble, _
                     BYVAL height AS gdouble, _
                     BYVAL color_ AS gchar PTR)
  VAR root = goo_canvas_get_root_item (GOO_CANVAS (canvas))
  VAR item = goo_canvas_rect_new (root, x, y, width_, height, _
            "stroke-pattern", NULL, _
            "fill-color", color_, _
            "line-width", 5.0, _
            "can-focus", TRUE, _
            NULL)
  g_object_set_data (G_OBJECT (item), "id", color_)

  g_signal_connect (item, "focus_in_event", _
        G_CALLBACK (@on_focus_in), NULL)
  g_signal_connect (item, "focus_out_event", _
        G_CALLBACK (@on_focus_out), NULL)

  g_signal_connect (item, "button_press_event", _
        G_CALLBACK (@on_button_press), NULL)

  g_signal_connect (item, "key_press_event", _
        G_CALLBACK (@on_key_press), NULL)
END SUB

SUB setup_canvas(BYVAL canvas AS GtkWidget PTR)
  create_focus_box (canvas, 110, 80, 50, 30, "red")
  create_focus_box (canvas, 300, 160, 50, 30, "orange")
  create_focus_box (canvas, 500, 50, 50, 30, "yellow")
  create_focus_box (canvas, 70, 400, 50, 30, "blue")
  create_focus_box (canvas, 130, 200, 50, 30, "magenta")
  create_focus_box (canvas, 200, 160, 50, 30, "green")
  create_focus_box (canvas, 450, 450, 50, 30, "cyan")
  create_focus_box (canvas, 300, 350, 50, 30, "grey")
  create_focus_box (canvas, 900, 900, 50, 30, "gold")
  create_focus_box (canvas, 800, 150, 50, 30, "thistle")
  create_focus_box (canvas, 600, 800, 50, 30, "azure")
  create_focus_box (canvas, 700, 250, 50, 30, "moccasin")
  create_focus_box (canvas, 500, 100, 50, 30, "cornsilk")
  create_focus_box (canvas, 200, 750, 50, 30, "plum")
  create_focus_box (canvas, 400, 800, 50, 30, "orchid")
END SUB

FUNCTION create_focus_page() AS GtkWidget PTR
  VAR vbox = gtk_vbox_new (FALSE, 4)
  gtk_container_set_border_width (GTK_CONTAINER (vbox), 4)
  gtk_widget_show (vbox)

  VAR label = gtk_label_new (!"Use Tab, Shift+Tab or the arrow keys to move the keyboard focus between the canvas items.")
  gtk_box_pack_start (GTK_BOX (vbox), label, FALSE, FALSE, 0)
  gtk_widget_show (label)

  VAR scrolled_win = gtk_scrolled_window_new (NULL, NULL)
  gtk_scrolled_window_set_shadow_type (GTK_SCROLLED_WINDOW (scrolled_win), _
               GTK_SHADOW_IN)
  gtk_widget_show (scrolled_win)
  gtk_container_add (GTK_CONTAINER (vbox), scrolled_win)

  VAR canvas = goo_canvas_new ()
  gtk_widget_set_can_focus (canvas, TRUE)
  gtk_widget_set_size_request (canvas, 600, 450)
  goo_canvas_set_bounds (GOO_CANVAS (canvas), 0, 0, 1000, 1000)
  gtk_widget_show (canvas)
  gtk_container_add (GTK_CONTAINER (scrolled_win), canvas)

  setup_canvas (canvas)

  RETURN vbox
END FUNCTION


' Initialize GTK+.
gtk_init (@__FB_ARGC__, @__FB_ARGV__)

' Create the window and widgets.
VAR win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
gtk_window_set_default_size (GTK_WINDOW (win), 640, 600)
gtk_widget_show (win)
g_signal_connect (win, "delete_event", G_CALLBACK(@gtk_main_quit), NULL)

VAR page = create_focus_page()
gtk_container_add (GTK_CONTAINER (win), page)

' Pass control to the GTK+ main event loop.
gtk_main ()

END 0

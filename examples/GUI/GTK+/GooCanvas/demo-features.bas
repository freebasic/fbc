'/*
 '* GooCanvas Demo. Copyright (C) 2006 Damon Chaplin.
 '* Released under the GNU LGPL license. See COPYING for details.
 '*
 '* demo-features.c
 '*/
'
' FB translation by TJF, 2011
' Details: http://library.gnome.org/devel/goocanvas/unstable/

'#DEFINE __USE_GTK3__
#INCLUDE "goocanvas.bi"

FUNCTION on_button_press(BYVAL item AS GooCanvasItem PTR, _
                        BYVAL target AS GooCanvasItem PTR, _
                        BYVAL event AS GdkEventButton PTR, _
                        BYVAL dat AS gpointer) AS gboolean
  IF event->button <> 1 ORELSE event->TYPE <> GDK_BUTTON_PRESS THEN RETURN FALSE

  g_print (!"In on_button_press\n")

  VAR parent1 = g_object_get_data (G_OBJECT (item), "parent1")
  VAR parent2 = g_object_get_data (G_OBJECT (item), "parent2")

  VAR parent = goo_canvas_item_get_parent (item)
  g_object_ref (item)
  goo_canvas_item_remove (item)
  IF parent = parent1 THEN
    goo_canvas_item_add_child (parent2, item, -1)
  ELSE
    goo_canvas_item_add_child (parent1, item, -1)
  END IF
  g_object_unref (item)

  RETURN TRUE
END FUNCTION

FUNCTION create_canvas_features() AS GtkWidget PTR
  VAR vbox = gtk_vbox_new (FALSE, 4)
  gtk_container_set_border_width (GTK_CONTAINER (vbox), 4)
  gtk_widget_show (vbox)

  '/* Instructions */

  VAR w = gtk_label_new ("Reparent test:  click on the items to switch them between parents")
  gtk_box_pack_start (GTK_BOX (vbox), w, FALSE, FALSE, 0)
  gtk_widget_show (w)

  '/* Frame and canvas */

  VAR alignment = gtk_alignment_new (0.5, 0.5, 0.0, 0.0)
  gtk_box_pack_start (GTK_BOX (vbox), alignment, FALSE, FALSE, 0)
  gtk_widget_show (alignment)

  VAR frame = gtk_frame_new (NULL)
  gtk_frame_set_shadow_type (GTK_FRAME (frame), GTK_SHADOW_IN)
  gtk_container_add (GTK_CONTAINER (alignment), frame)
  gtk_widget_show (frame)

  VAR canvas = goo_canvas_new ()
  VAR root = goo_canvas_get_root_item (GOO_CANVAS (canvas))

  gtk_widget_set_size_request (canvas, 400, 200)
  goo_canvas_set_bounds (GOO_CANVAS (canvas), 0, 0, 400, 200)
  gtk_container_add (GTK_CONTAINER (frame), canvas)
  gtk_widget_show (canvas)

  '/* First parent and box */

  VAR parent1 = goo_canvas_group_new (root, NULL)

  goo_canvas_rect_new (parent1, 0, 0, 200, 200, _
           "fill_color", "tan", _
           NULL)

  '/* Second parent and box */

  VAR parent2 = goo_canvas_group_new (root, NULL)
  goo_canvas_item_translate (parent2, 200, 0)

  goo_canvas_rect_new (parent2, 0, 0, 200, 200, _
           "fill_color", "#204060", _
           NULL)

  '/* Big circle to be reparented */

  VAR item = goo_canvas_ellipse_new (parent1, 100, 100, 90, 90, _
               "stroke_color", "black", _
               "fill_color", "mediumseagreen", _
               "line-width", 3.0, _
               NULL)
  g_object_set_data (G_OBJECT (item), "parent1", parent1)
  g_object_set_data (G_OBJECT (item), "parent2", parent2)
  g_signal_connect (item, "button_press_event", _
        G_CALLBACK (@on_button_press), NULL)

  '/* A group to be reparented */

  VAR group = goo_canvas_group_new (parent2, NULL)
  goo_canvas_item_translate (group, 100, 100)

  goo_canvas_ellipse_new (group, 0, 0, 50, 50, _
        "stroke_color", "black", _
        "fill_color", "wheat", _
        "line_width", 3.0, _
        NULL)
  goo_canvas_ellipse_new (group, 0, 0, 25, 25, _
        "fill_color", "steelblue", _
        NULL)

  g_object_set_data (G_OBJECT (group), "parent1", parent1)
  g_object_set_data (G_OBJECT (group), "parent2", parent2)
  g_signal_connect (group, "button_press_event", _
        G_CALLBACK (@on_button_press), NULL)

  RETURN vbox
END FUNCTION


' Initialize GTK+.
gtk_init (@__FB_ARGC__, @__FB_ARGV__)

' Create the window and widgets.
VAR win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
gtk_window_set_default_size (GTK_WINDOW (win), 640, 600)
gtk_widget_show (win)
g_signal_connect (win, "delete_event", G_CALLBACK(@gtk_main_quit), NULL)

VAR page = create_canvas_features()
gtk_container_add (GTK_CONTAINER (win), page)

' Pass control to the GTK+ main event loop.
gtk_main ()

END 0

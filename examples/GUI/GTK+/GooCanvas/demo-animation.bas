'/*
 '* GooCanvas Demo. Copyright (C) 2006 Damon Chaplin.
 '* Released under the GNU LGPL license. See COPYING for details.
 '*
 '* demo-animation.c
 '*/
'
' FB translation by TJF, 2011
' Details: http://library.gnome.org/devel/goocanvas/unstable/

'#DEFINE __USE_GTK3__
#INCLUDE "goocanvas.bi"

STATIC SHARED AS GooCanvasItem PTR ellipse1, ellipse2, rect1, rect2, rect3, rect4

SUB start_animation_clicked CDECL(BYVAL button AS GtkWidget, _
                                  BYVAL dat AS gpointer)
  '/* Absolute. */
  goo_canvas_item_set_simple_transform (ellipse1, 100, 100, 1, 0)
  goo_canvas_item_animate (ellipse1, 500, 100, 2, 720, TRUE, 2000, 40, _
         GOO_CANVAS_ANIMATE_BOUNCE)

  goo_canvas_item_set_simple_transform (rect1, 100, 200, 1, 0)
  goo_canvas_item_animate (rect1, 100, 200, 1, 350, TRUE, 40 * 36, 40, _
         GOO_CANVAS_ANIMATE_RESTART)

  goo_canvas_item_set_simple_transform (rect3, 200, 200, 1, 0)
  goo_canvas_item_animate (rect3, 200, 200, 3, 0, TRUE, 400, 40, _
         GOO_CANVAS_ANIMATE_BOUNCE)

  '/* Relative. */
  goo_canvas_item_set_simple_transform (ellipse2, 100, 400, 1, 0)
  goo_canvas_item_animate (ellipse2, 400, 0, 2, 720, FALSE, 2000, 40, _
         GOO_CANVAS_ANIMATE_BOUNCE)

  goo_canvas_item_set_simple_transform (rect2, 100, 500, 1, 0)
  goo_canvas_item_animate (rect2, 0, 0, 1, 350, FALSE, 40 * 36, 40, _
         GOO_CANVAS_ANIMATE_RESTART)

  goo_canvas_item_set_simple_transform (rect4, 200, 500, 1, 0)
  goo_canvas_item_animate (rect4, 0, 0, 3, 0, FALSE, 400, 40, _
         GOO_CANVAS_ANIMATE_BOUNCE)
END SUB

SUB stop_animation_clicked CDECL(BYVAL button AS GtkWidget PTR, _
                                 BYVAL dat AS gpointer)
  goo_canvas_item_stop_animation (ellipse1)
  goo_canvas_item_stop_animation (ellipse2)
  goo_canvas_item_stop_animation (rect1)
  goo_canvas_item_stop_animation (rect2)
  goo_canvas_item_stop_animation (rect3)
  goo_canvas_item_stop_animation (rect4)
END SUB

SUB on_animation_finished CDECL(BYVAL item AS GooCanvasItem PTR, _
                                BYVAL stopped AS gboolean, _
                                BYVAL dat AS gpointer)

  g_print (!"Animation finished stopped: %i\n", stopped)

#IF 0
  '/* Test starting another animation. */
  goo_canvas_item_animate (ellipse1, 500, 200, 2, 720, TRUE, 2000, 40,
         GOO_CANVAS_ANIMATE_BOUNCE)
#ENDIF
END SUB

SUB setup_canvas(BYVAL canvas AS GtkWidget PTR)

  VAR root = goo_canvas_get_root_item (GOO_CANVAS (canvas))

  '/* Absolute. */
  ellipse1 = goo_canvas_ellipse_new (root, 0, 0, 25, 15, _
             "fill-color", "blue", _
             NULL)
  goo_canvas_item_translate (ellipse1, 100, 100)
  g_signal_connect (ellipse1, "animation_finished", _
        G_CALLBACK (@on_animation_finished), NULL)

  rect1 = goo_canvas_rect_new (root, -10, -10, 20, 20, _
             "fill-color", "blue", _
             NULL)
  goo_canvas_item_translate (rect1, 100, 200)

  rect3 = goo_canvas_rect_new (root, -10, -10, 20, 20, _
             "fill-color", "blue", _
             NULL)
  goo_canvas_item_translate (rect3, 200, 200)

  '/* Relative. */
  ellipse2 = goo_canvas_ellipse_new (root, 0, 0, 25, 15, _
             "fill-color", "red", _
             NULL)
  goo_canvas_item_translate (ellipse2, 100, 400)

  rect2 = goo_canvas_rect_new (root, -10, -10, 20, 20, _
             "fill-color", "red", _
             NULL)
  goo_canvas_item_translate (rect2, 100, 500)

  rect4 = goo_canvas_rect_new (root, -10, -10, 20, 20, _
             "fill-color", "red", _
             NULL)
  goo_canvas_item_translate (rect4, 200, 500)
END SUB

FUNCTION create_animation_page() AS GtkWidget PTR

  VAR vbox = gtk_vbox_new (FALSE, 4)
  gtk_container_set_border_width (GTK_CONTAINER (vbox), 4)
  gtk_widget_show (vbox)

  VAR hbox = gtk_hbox_new (FALSE, 4)
  gtk_box_pack_start (GTK_BOX (vbox), hbox, FALSE, FALSE, 0)
  gtk_widget_show (hbox)

  VAR w = gtk_button_new_with_mnemonic("St_art Animation")
  gtk_box_pack_start (GTK_BOX (hbox), w, FALSE, FALSE, 0)
  gtk_widget_show (w)
  g_signal_connect (w, "clicked", G_CALLBACK (@start_animation_clicked), _
        NULL)

  w = gtk_button_new_with_mnemonic("St_op Animation")
  gtk_box_pack_start (GTK_BOX (hbox), w, FALSE, FALSE, 0)
  gtk_widget_show (w)
  g_signal_connect (w, "clicked", G_CALLBACK (@stop_animation_clicked), _
        NULL)

  VAR scrolled_win = gtk_scrolled_window_new (NULL, NULL)
  gtk_scrolled_window_set_shadow_type (GTK_SCROLLED_WINDOW (scrolled_win), _
               GTK_SHADOW_IN)
  gtk_widget_show (scrolled_win)
  gtk_container_add (GTK_CONTAINER (vbox), scrolled_win)

  VAR canvas = goo_canvas_new ()
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

VAR page = create_animation_page()
gtk_container_add (GTK_CONTAINER (win), page)

' Pass control to the GTK+ main event loop.
gtk_main ()

END 0

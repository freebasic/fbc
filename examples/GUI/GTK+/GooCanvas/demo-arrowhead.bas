'/*
 '* GooCanvas Demo. Copyright (C) 2006 Damon Chaplin.
 '* Released under the GNU LGPL license. See COPYING for details.
 '*
 '* demo-arrowhead.c
 '*/
'
' FB translation by TJF, 2011
' Details: http://library.gnome.org/devel/goocanvas/unstable/

'#DEFINE __USE_GTK3__
#INCLUDE "goocanvas.bi"

#DEFINE LEFT_    50.0
#DEFINE RIGHT_  350.0
#DEFINE MIDDLE 150.0
#DEFINE DEFAULT_WIDTH   2
#DEFINE DEFAULT_SHAPE_A 4
#DEFINE DEFAULT_SHAPE_B 5
#DEFINE DEFAULT_SHAPE_C 4


SUB set_dimension(BYVAL canvas AS GooCanvas PTR, _
                  BYVAL arrow_name AS ZSTRING PTR, _
                  BYVAL text_name AS ZSTRING PTR, _
                  BYVAL x1 AS DOUBLE, _
                  BYVAL y1 AS DOUBLE, _
                  BYVAL x2 AS DOUBLE, _
                  BYVAL y2 AS DOUBLE, _
                  BYVAL tx AS DOUBLE, _
                  BYVAL ty AS DOUBLE, _
                  BYVAL dim_ AS INTEGER)
  DIM AS ZSTRING*100 buf

  VAR points = goo_canvas_points_new (2)
  points->coords[0] = x1
  points->coords[1] = y1
  points->coords[2] = x2
  points->coords[3] = y2

  g_object_set (g_object_get_data (G_OBJECT (canvas), arrow_name), _
          "points", points, _
          NULL)

  sprintf (@buf, !"%d", dim_)
  g_object_set (g_object_get_data (G_OBJECT (canvas), text_name), _
          "text", @buf, _
          "x", tx, _
          "y", ty, _
          NULL)

  goo_canvas_points_unref (points)
END SUB

SUB move_drag_box(BYVAL item AS GooCanvasItem PTR, _
                  BYVAL x AS DOUBLE, _
                  BYVAL y AS DOUBLE)
  g_object_set (item, _
          "x", x - 5.0, _
          "y", y - 5.0, _
          NULL)
END SUB

SUB set_arrow_shape(BYVAL canvas AS GooCanvas PTR)
  DIM AS ZSTRING*100 buf

  VAR width_ = GPOINTER_TO_INT (g_object_get_data (G_OBJECT (canvas), "width"))
  VAR shape_a = GPOINTER_TO_INT (g_object_get_data (G_OBJECT (canvas), "shape_a"))
  VAR shape_b = GPOINTER_TO_INT (g_object_get_data (G_OBJECT (canvas), "shape_b"))
  VAR shape_c = GPOINTER_TO_INT (g_object_get_data (G_OBJECT (canvas), "shape_c"))

  '/* Big arrow */

  g_object_set (g_object_get_data (G_OBJECT (canvas), "big_arrow"), _
          "line-width", 10.0 * width_, _
          "arrow-tip-length", CAST(DOUBLE, shape_a), _
          "arrow-length", CAST(DOUBLE, shape_b), _
          "arrow-width", CAST(DOUBLE, shape_c), _
          NULL)

  '/* Outline */

  VAR points = goo_canvas_points_new (5)
  points->coords[0] = RIGHT_ - 10 * shape_a * width_
  points->coords[1] = MIDDLE - 10 * width_ / 2
  points->coords[2] = RIGHT_ - 10 * shape_b * width_
  points->coords[3] = MIDDLE - 10 * (shape_c * width_ / 2.0)
  points->coords[4] = RIGHT_
  points->coords[5] = MIDDLE
  points->coords[6] = points->coords[2]
  points->coords[7] = MIDDLE + 10 * (shape_c * width_ / 2.0)
  points->coords[8] = points->coords[0]
  points->coords[9] = MIDDLE + 10 * width_ / 2
  g_object_set (g_object_get_data (G_OBJECT (canvas), "outline"), _
          "points", points, _
          NULL)
  goo_canvas_points_unref (points)

  '/* Drag boxes */

  move_drag_box (g_object_get_data (G_OBJECT (canvas), "width_drag_box"), _
           LEFT_, _
           MIDDLE - 10 * width_ / 2.0)

  move_drag_box (g_object_get_data (G_OBJECT (canvas), "shape_a_drag_box"), _
           RIGHT_ - 10 * shape_a * width_, _
           MIDDLE)

  move_drag_box (g_object_get_data (G_OBJECT (canvas), "shape_b_c_drag_box"), _
           RIGHT_ - 10 * shape_b * width_, _
           MIDDLE - 10 * (shape_c * width_ / 2.0))

  '/* Dimensions */

  set_dimension (canvas, "width_arrow", "width_text", _
           LEFT_ - 10, _
           MIDDLE - 10 * width_ / 2.0, _
           LEFT_ - 10, _
           MIDDLE + 10 * width_ / 2.0, _
           LEFT_ - 15, _
           MIDDLE, _
           width_)

  set_dimension (canvas, "shape_a_arrow", "shape_a_text", _
           RIGHT_ - 10 * shape_a * width_, _
           MIDDLE + 10 * (shape_c * width_ / 2.0) + 10, _
           RIGHT_, _
           MIDDLE + 10 * (shape_c * width_ / 2.0) + 10, _
           RIGHT_ - 10 * shape_a * width_ / 2.0, _
           MIDDLE + 10 * (shape_c * width_ / 2.0) + 15, _
           shape_a)

  set_dimension (canvas, "shape_b_arrow", "shape_b_text", _
           RIGHT_ - 10 * shape_b * width_, _
           MIDDLE + 10 * (shape_c * width_ / 2.0) + 35, _
           RIGHT_, _
           MIDDLE + 10 * (shape_c * width_ / 2.0) + 35, _
           RIGHT_ - 10 * shape_b * width_ / 2.0, _
           MIDDLE + 10 * (shape_c * width_ / 2.0) + 40, _
           shape_b)

  set_dimension (canvas, "shape_c_arrow", "shape_c_text", _
           RIGHT_ + 10, _
           MIDDLE - 10 * shape_c * width_ / 2.0, _
           RIGHT_ + 10, _
           MIDDLE + 10 * shape_c * width_ / 2.0, _
           RIGHT_ + 15, _
           MIDDLE, _
           shape_c)

  '/* Info */

  sprintf (@buf, !"line-width: %d", width_)
  g_object_set (g_object_get_data (G_OBJECT (canvas), "width_info"), _
          "text", @buf, _
          NULL)

  sprintf (@buf, !"arrow-tip-length: %d (* line-width)", shape_a)
  g_object_set (g_object_get_data (G_OBJECT (canvas), "shape_a_info"), _
          "text", @buf, _
          NULL)

  sprintf (@buf, !"arrow-length: %d (* line-width)", shape_b)
  g_object_set (g_object_get_data (G_OBJECT (canvas), "shape_b_info"), _
          "text", @buf, _
          NULL)
  sprintf (@buf, !"arrow-width: %d (* line-width)", shape_c)
  g_object_set (g_object_get_data (G_OBJECT (canvas), "shape_c_info"), _
          "text", @buf, _
          NULL)

  '/* Sample arrows */

  g_object_set (g_object_get_data (G_OBJECT (canvas), "sample_1"), _
          "line-width", CAST(DOUBLE, width_), _
          "arrow-tip-length", CAST(DOUBLE, shape_a), _
          "arrow-length", CAST(DOUBLE, shape_b), _
          "arrow-width", CAST(DOUBLE, shape_c), _
          NULL)
  g_object_set (g_object_get_data (G_OBJECT (canvas), "sample_2"), _
          "line-width", CAST(DOUBLE, width_), _
          "arrow-tip-length", CAST(DOUBLE, shape_a), _
          "arrow-length", CAST(DOUBLE, shape_b), _
          "arrow-width", CAST(DOUBLE, shape_c), _
          NULL)
  g_object_set (g_object_get_data (G_OBJECT (canvas), "sample_3"), _
          "line-width", CAST(DOUBLE, width_), _
          "arrow-tip-length", CAST(DOUBLE, shape_a), _
          "arrow-length", CAST(DOUBLE, shape_b), _
          "arrow-width", CAST(DOUBLE, shape_c), _
          NULL)
END SUB


SUB create_dimension(BYVAL canvas AS GtkWidget PTR, _
                     BYVAL root AS GooCanvasItem PTR, _
                     BYVAL arrow_name AS ZSTRING PTR, _
                     BYVAL text_name AS ZSTRING PTR, _
                     BYVAL anchor AS GooCanvasAnchorType)
  VAR item = goo_canvas_polyline_new (root, FALSE, 0, _
              "fill_color", "black", _
              "start-arrow", TRUE, _
              "end-arrow", TRUE, _
              NULL)
  g_object_set_data (G_OBJECT (canvas), arrow_name, item)

  item = goo_canvas_text_new (root, NULL, 0, 0, -1, anchor, _
            "fill_color", "black", _
            "font", "Sans 12", _
            NULL)
  g_object_set_data (G_OBJECT (canvas), text_name, item)
END SUB

SUB create_info(BYVAL canvas AS GtkWidget PTR, _
                BYVAL root AS GooCanvasItem PTR, _
                BYVAL info_name AS ZSTRING PTR, _
                BYVAL x AS DOUBLE, _
                BYVAL y AS DOUBLE)
  VAR item = goo_canvas_text_new (root, NULL, x, y, -1, GOO_CANVAS_ANCHOR_NW, _
            "fill_color", "black", _
            "font", "Sans 14", _
            NULL)
  g_object_set_data (G_OBJECT (canvas), info_name, item)
END SUB


SUB create_sample_arrow(BYVAL canvas AS GtkWidget PTR, _
                        BYVAL root AS GooCanvasItem PTR, _
                        BYVAL sample_name AS ZSTRING PTR, _
                        BYVAL x1 AS DOUBLE, _
                        BYVAL y1 AS DOUBLE, _
                        BYVAL x2 AS DOUBLE, _
                        BYVAL y2 AS DOUBLE)
  VAR item = goo_canvas_polyline_new_line (root, x1, y1, x2, y2, _
               "start-arrow", TRUE, _
               "end-arrow", TRUE, _
               NULL)
  g_object_set_data (G_OBJECT (canvas), sample_name, item)
END SUB


FUNCTION on_enter_notify CDECL(BYVAL item AS GooCanvasItem PTR, _
                               BYVAL target AS GooCanvasItem PTR, _
                               BYVAL event AS GdkEventCrossing PTR, _
                               BYVAL dat AS gpointer) AS gboolean
  g_object_set (item, _
    "fill_color", "red", _
    NULL)
  RETURN TRUE
END FUNCTION


FUNCTION on_leave_notify CDECL(BYVAL item AS GooCanvasItem PTR, _
                               BYVAL target AS GooCanvasItem PTR, _
                               BYVAL event AS GdkEvent PTR, _
                               BYVAL dat AS gpointer) AS gboolean
  g_object_set (item, _
    "fill_color", "black", _
    NULL)
  RETURN TRUE
END FUNCTION

FUNCTION on_button_press CDECL(BYVAL item AS GooCanvasItem PTR, _
                               BYVAL target AS GooCanvasItem PTR, _
                               BYVAL event AS GdkEventButton PTR, _
                               BYVAL dat AS gpointer) AS gboolean
  VAR fleur = gdk_cursor_new (GDK_FLEUR)
  VAR canvas = goo_canvas_item_get_canvas (item)
  goo_canvas_pointer_grab (canvas, item, _
         GDK_POINTER_MOTION_MASK OR GDK_POINTER_MOTION_HINT_MASK OR GDK_BUTTON_RELEASE_MASK, _
         fleur, _
         event->TIME)
  gdk_cursor_unref (fleur)
  RETURN TRUE
END FUNCTION



FUNCTION on_button_release CDECL(BYVAL item AS GooCanvasItem PTR, _
                                 BYVAL target AS GooCanvasItem PTR, _
                                 BYVAL event AS GdkEventButton PTR, _
                                 BYVAL dat AS gpointer) AS gboolean
  VAR canvas = goo_canvas_item_get_canvas (item)
  goo_canvas_pointer_ungrab (canvas, item, event->TIME)
  RETURN TRUE
END FUNCTION

FUNCTION on_motion CDECL(BYVAL item AS GooCanvasItem PTR, _
                         BYVAL target AS GooCanvasItem PTR, _
                         BYVAL event AS GdkEventMotion PTR, _
                         BYVAL dat AS gpointer) AS gboolean
  VAR canvas = goo_canvas_item_get_canvas (item)
  DIM AS INTEGER x, y, width_, shape_a, shape_b, shape_c
  DIM AS gboolean change = FALSE

  IF 0 = (event->state AND GDK_BUTTON1_MASK) THEN RETURN FALSE

  IF item = g_object_get_data (G_OBJECT (canvas), "width_drag_box") THEN
    y = event->y
    width_ = (MIDDLE - y) / 5
    IF width_ < 0 THEN RETURN FALSE
    g_object_set_data (G_OBJECT (canvas), "width", GINT_TO_POINTER (width_))
    set_arrow_shape (canvas)
  ELSEIF item = g_object_get_data (G_OBJECT (canvas), "shape_a_drag_box") THEN
    x = event->x
    width_ = GPOINTER_TO_INT (g_object_get_data (G_OBJECT (canvas), "width"))
    shape_a = (RIGHT_ - x) / 10 / width_
    IF shape_a < 0 ORELSE shape_a > 30 THEN RETURN FALSE
    g_object_set_data (G_OBJECT (canvas), "shape_a", _
        GINT_TO_POINTER (shape_a))
    set_arrow_shape (canvas)
  ELSEIF item = g_object_get_data (G_OBJECT (canvas), "shape_b_c_drag_box") THEN
    width_ = GPOINTER_TO_INT (g_object_get_data (G_OBJECT (canvas), "width"))

    x = event->x
    shape_b = (RIGHT_ - x) / 10 / width_
    IF shape_b >= 0 ANDALSO shape_b <= 30 THEN
      g_object_set_data (G_OBJECT (canvas), "shape_b", _
           GINT_TO_POINTER (shape_b))
      change = TRUE
    END IF

    y = event->y
    shape_c = (MIDDLE - y) * 2 / 10 / width_
    IF shape_c >= 0 THEN
      g_object_set_data (G_OBJECT (canvas), "shape_c", _
           GINT_TO_POINTER (shape_c))
      change = TRUE
    END IF

    IF change THEN set_arrow_shape (canvas)
  END IF

  RETURN TRUE
END FUNCTION


SUB create_drag_box(BYVAL canvas AS GtkWidget PTR, _
                    BYVAL root AS GooCanvasItem PTR, _
                    BYVAL box_name AS ZSTRING PTR)

  VAR item = goo_canvas_rect_new (root, 0, 0, 10, 10, _
            "fill_color", "black", _
            "stroke_color", "black", _
            "line_width", 1.0, _
            NULL)
  g_object_set_data (G_OBJECT (canvas), box_name, item)

  g_signal_connect (item, "enter_notify_event", _
        G_CALLBACK (@on_enter_notify), _
        NULL)
  g_signal_connect (item, "leave_notify_event", _
        G_CALLBACK (@on_leave_notify), _
        NULL)
  g_signal_connect (item, "button_press_event", _
        G_CALLBACK (@on_button_press), _
        NULL)
  g_signal_connect (item, "button_release_event", _
        G_CALLBACK (@on_button_release), _
        NULL)
  g_signal_connect (item, "motion_notify_event", _
        G_CALLBACK (@on_motion), _
        NULL)
END SUB


FUNCTION create_canvas_arrowhead() AS GtkWidget PTR
  VAR vbox = gtk_vbox_new (FALSE, 4)
  gtk_container_set_border_width (GTK_CONTAINER (vbox), 4)
  gtk_widget_show (vbox)

  VAR w = gtk_label_new (!"This demo allows you to edit arrowhead shapes.  Drag the little boxes\n" _
         !"to change the shape of the line and its arrowhead.  You can see the\n" _
         !"arrows at their normal scale on the right hand side of the window.")
  gtk_box_pack_start (GTK_BOX (vbox), w, FALSE, FALSE, 0)
  gtk_widget_show (w)

  w = gtk_alignment_new (0.5, 0.5, 0.0, 0.0)
  gtk_box_pack_start (GTK_BOX (vbox), w, TRUE, TRUE, 0)
  gtk_widget_show (w)

  VAR frame = gtk_frame_new (NULL)
  gtk_frame_set_shadow_type (GTK_FRAME (frame), GTK_SHADOW_IN)
  gtk_container_add (GTK_CONTAINER (w), frame)
  gtk_widget_show (frame)

  VAR canvas = goo_canvas_new ()
  VAR root = goo_canvas_get_root_item (GOO_CANVAS (canvas))

  gtk_widget_set_size_request (canvas, 500, 350)
  goo_canvas_set_bounds (GOO_CANVAS (canvas), 0, 0, 500, 350)
  gtk_container_add (GTK_CONTAINER (frame), canvas)
  gtk_widget_show (canvas)

  g_object_set_data (G_OBJECT (canvas), "width", _
         GINT_TO_POINTER (DEFAULT_WIDTH))
  g_object_set_data (G_OBJECT (canvas), "shape_a", _
         GINT_TO_POINTER (DEFAULT_SHAPE_A))
  g_object_set_data (G_OBJECT (canvas), "shape_b", _
         GINT_TO_POINTER (DEFAULT_SHAPE_B))
  g_object_set_data (G_OBJECT (canvas), "shape_c", _
         GINT_TO_POINTER (DEFAULT_SHAPE_C))

  '/* Big arrow */

  VAR item = goo_canvas_polyline_new_line (root, _
               LEFT_, MIDDLE, RIGHT_, MIDDLE, _
               "stroke_color", "mediumseagreen", _
               "end-arrow", TRUE, _
               NULL)
  g_object_set_data (G_OBJECT (canvas), "big_arrow", item)

  '/* Arrow outline */

  item = goo_canvas_polyline_new (root, TRUE, 0, _
          "stroke_color", "black", _
          "line-width", 2.0, _
          "line-cap", CAIRO_LINE_CAP_ROUND, _
          "line-join", CAIRO_LINE_JOIN_ROUND, _
          NULL)
  g_object_set_data (G_OBJECT (canvas), "outline", item)

  '/* Drag boxes */

  create_drag_box (canvas, root, "width_drag_box")
  create_drag_box (canvas, root, "shape_a_drag_box")
  create_drag_box (canvas, root, "shape_b_c_drag_box")

  '/* Dimensions */

  create_dimension (canvas, root, "width_arrow", "width_text", GOO_CANVAS_ANCHOR_E)
  create_dimension (canvas, root, "shape_a_arrow", "shape_a_text", GOO_CANVAS_ANCHOR_N)
  create_dimension (canvas, root, "shape_b_arrow", "shape_b_text", GOO_CANVAS_ANCHOR_N)
  create_dimension (canvas, root, "shape_c_arrow", "shape_c_text", GOO_CANVAS_ANCHOR_W)

  '/* Info */

  create_info (canvas, root, "width_info", LEFT_, 260)
  create_info (canvas, root, "shape_a_info", LEFT_, 280)
  create_info (canvas, root, "shape_b_info", LEFT_, 300)
  create_info (canvas, root, "shape_c_info", LEFT_, 320)

  '/* Division line */

  goo_canvas_polyline_new_line (root, RIGHT_ + 50, 0, RIGHT_ + 50, 1000, _
              "fill_color", "black", _
              "line-width", 2.0, _
              NULL)

  '/* Sample arrows */

  create_sample_arrow (canvas, root, "sample_1", _
           RIGHT_ + 100, 30, RIGHT_ + 100, MIDDLE - 30)
  create_sample_arrow (canvas, root, "sample_2", _
           RIGHT_ + 70, MIDDLE, RIGHT_ + 130, MIDDLE)
  create_sample_arrow (canvas, root, "sample_3", _
           RIGHT_ + 70, MIDDLE + 30, RIGHT_ + 130, MIDDLE + 120)

  '/* Done! */

  set_arrow_shape (GOO_CANVAS (canvas))
  RETURN vbox
END FUNCTION


' Initialize GTK+.
gtk_init (@__FB_ARGC__, @__FB_ARGV__)

' Create the window and widgets.
VAR win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
gtk_window_set_default_size (GTK_WINDOW (win), 640, 600)
gtk_widget_show (win)
g_signal_connect (win, "delete_event", G_CALLBACK(@gtk_main_quit), NULL)

VAR page = create_canvas_arrowhead()
gtk_container_add (GTK_CONTAINER (win), page)

' Pass control to the GTK+ main event loop.
gtk_main ()

END 0


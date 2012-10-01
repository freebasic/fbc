'/*
 '* GooCanvas Demo. Copyright (C) 2006 Damon Chaplin.
 '* Released under the GNU LGPL license. See COPYING for details.
 '*
 '* demo-table.c
 '*/
'
' FB translation by TJF, 2011
' Details: http://library.gnome.org/devel/goocanvas/unstable/

'#DEFINE __USE_GTK3__
#INCLUDE "goocanvas.bi"

#DEFINE DEMO_RECT_ITEM 0
#DEFINE DEMO_TEXT_ITEM 1
#DEFINE DEMO_WIDGET_ITEM 2

FUNCTION on_button_press CDECL(BYVAL item AS GooCanvasItem PTR, _
                               BYVAL target AS GooCanvasItem PTR, _
                               BYVAL event AS GdkEventButton PTR, _
                               BYVAL data_TJF AS gpointer) AS gboolean
  DIM AS gchar PTR id = g_object_get_data (G_OBJECT (item), "id")

  g_print (!"%s received 'button-press' signal at %g, %g (root: %g, %g)\n", _
     IIF(id, id, @"unknown"), event->x, event->y, _
     event->x_root, event->y_root)

  RETURN TRUE
END FUNCTION

SUB create_demo_item (BYVAL table AS GooCanvasItem PTR, _
                      BYVAL demo_item_type AS gint, _
                      BYVAL row AS gint, _
                      BYVAL column AS gint, _
                      BYVAL rows AS gint, _
                      BYVAL columns AS gint, _
                      BYVAL text AS gchar PTR)
  DIM AS GooCanvasItem PTR item = NULL
  DIM AS GtkWidget PTR widget
  DIM AS GValue value = TYPE<GValue>(0)

  SELECT CASE demo_item_type
  CASE DEMO_RECT_ITEM
    item = goo_canvas_rect_new (table, 0, 0, 38, 19, _
        "fill-color", "red", _
        NULL)
  CASE DEMO_TEXT_ITEM
    item = goo_canvas_text_new (table, text, 0, 0, -1, GOO_CANVAS_ANCHOR_NW, NULL)
  CASE DEMO_WIDGET_ITEM
    widget = gtk_button_new_with_label (text)
    item = goo_canvas_widget_new (table, widget, 0, 0, -1, -1, NULL)
  END SELECT

  g_value_init_ (@value, G_TYPE_UINT) ' Note: name-mangling!
  g_value_set_uint (@value, row)
  goo_canvas_item_set_child_property (table, item, "row", @value)
  g_value_set_uint (@value, column)
  goo_canvas_item_set_child_property (table, item, "column", @value)
  g_value_set_uint (@value, rows)
  goo_canvas_item_set_child_property (table, item, "rows", @value)
  g_value_set_uint (@value, columns)
  goo_canvas_item_set_child_property (table, item, "columns", @value)

  '/* Test the get function. */
  goo_canvas_item_get_child_property (table, item, "row", @value)
  VAR new_row = g_value_get_uint (@value)
  IF new_row <> row THEN _
    g_warning ("Got bad row setting: %i should be: %i\n", new_row, row)

#IF 1
  goo_canvas_item_set_child_properties (table, item, _
          "x-expand", TRUE, _
          "x-fill", TRUE, _
          "y-expand", TRUE, _
          "y-fill", TRUE, _
          NULL)
#ENDIF

  g_object_set_data (G_OBJECT (item), "id", text)
  g_signal_connect (item, "button_press_event", _
        G_CALLBACK (@on_button_press), NULL)
END SUB

FUNCTION create_table (BYVAL parent AS GooCanvasItem PTR, _
                       BYVAL row AS gint, _
                       BYVAL column AS gint, _
                       BYVAL embedding_level AS gint, _
                       BYVAL x AS gdouble, _
                       BYVAL y AS gdouble, _
                       BYVAL rotation AS gdouble, _
                       BYVAL scale AS gdouble, _
                       BYVAL demo_item_type AS gint) AS GooCanvasItem PTR
  '/* Add a few simple items. */
  VAR table = goo_canvas_table_new (parent, _
        "row-spacing", 4.0, _
        "column-spacing", 4.0, _
        NULL)
  goo_canvas_item_translate (table, x, y)
#IF 1
  goo_canvas_item_rotate (table, rotation, 0, 0)
#ENDIF
#IF 1
  goo_canvas_item_scale (table, scale, scale)
#ENDIF

#IF 1
  IF row <> -1 THEN _
    goo_canvas_item_set_child_properties (parent, table, _
            "row", row, _
            "column", column, _
            "x-expand", TRUE, _
            "x-fill", TRUE, _
            NULL)
#ELSE
  IF row <> -1 THEN _
    goo_canvas_item_set_child_properties (parent, table, _
            "row", row, _
            "column", column, _
            "y-expand", TRUE, _
            "y-fill", TRUE, _
            NULL)
#ENDIF

  IF embedding_level THEN
    VAR level = embedding_level - 1
    create_table (table, 0, 0, level, 50, 50, 0, 0.7, demo_item_type)
    create_table (table, 0, 1, level, 50, 50, 45, 1.0, demo_item_type)
    create_table (table, 0, 2, level, 50, 50, 90, 1.0, demo_item_type)
    create_table (table, 1, 0, level, 50, 50, 135, 1.0, demo_item_type)
    create_table (table, 1, 1, level, 50, 50, 180, 1.5, demo_item_type)
    create_table (table, 1, 2, level, 50, 50, 225, 1.0, demo_item_type)
    create_table (table, 2, 0, level, 50, 50, 270, 1.0, demo_item_type)
    create_table (table, 2, 1, level, 50, 50, 315, 1.0, demo_item_type)
    create_table (table, 2, 2, level, 50, 50, 360, 2.0, demo_item_type)
  ELSE
    create_demo_item (table, demo_item_type, 0, 0, 1, 1, "(0,0)")
    create_demo_item (table, demo_item_type, 0, 1, 1, 1, "(1,0)")
    create_demo_item (table, demo_item_type, 0, 2, 1, 1, "(2,0)")
    create_demo_item (table, demo_item_type, 1, 0, 1, 1, "(0,1)")
    create_demo_item (table, demo_item_type, 1, 1, 1, 1, "(1,1)")
    create_demo_item (table, demo_item_type, 1, 2, 1, 1, "(2,1)")
    create_demo_item (table, demo_item_type, 2, 0, 1, 1, "(0,2)")
    create_demo_item (table, demo_item_type, 2, 1, 1, 1, "(1,2)")
    create_demo_item (table, demo_item_type, 2, 2, 1, 1, "(2,2)")
  END IF

  RETURN table
END FUNCTION

SUB create_demo_table (BYVAL root AS GooCanvasItem PTR, _
                       BYVAL x AS gdouble, _
                       BYVAL y AS gdouble, _
                       BYVAL width_TJF AS gdouble, _
                       BYVAL height AS gdouble)
  VAR table = goo_canvas_table_new (root, _
                                "row-spacing", 4.0, _
                                "column-spacing", 4.0, _
        "width", WIDTH, _
        "height", height, _
                                NULL)
  goo_canvas_item_translate (table, x, y)

  VAR square = goo_canvas_rect_new (table, 0.0, 0.0, 50.0, 50.0, _
        "fill-color", "red", _
        NULL)
  goo_canvas_item_set_child_properties (table, square, _
          "row", 0, _
          "column", 0, _
          "x-shrink", TRUE, _
          NULL)
  g_object_set_data (G_OBJECT (square), "id", @"Red square")
  g_signal_connect (square, "button_press_event", _
        G_CALLBACK (@on_button_press), NULL)

  VAR circl = goo_canvas_ellipse_new (table, 0.0, 0.0, 25.0, 25.0, _
           "fill-color", "blue", _
           NULL)
  goo_canvas_item_set_child_properties (table, circl, _
          "row", 0, _
          "column", 1, _
          "x-shrink", TRUE, _
          NULL)
  g_object_set_data (G_OBJECT (circl), "id", @"Blue circle")
  g_signal_connect (circl, "button_press_event", _
        G_CALLBACK (@on_button_press), NULL)

  VAR triangle = goo_canvas_polyline_new (table, TRUE, 3, _
              25.0, 0.0, 0.0, 50.0, 50.0, 50.0, _
              "fill-color", "yellow", _
              NULL)
  goo_canvas_item_set_child_properties (table, triangle, _
          "row", 0, _
          "column", 2, _
          "x-shrink", TRUE, _
          NULL)
  g_object_set_data (G_OBJECT (triangle), "id", @"Yellow triangle")
  g_signal_connect (triangle, "button_press_event", _
        G_CALLBACK (@on_button_press), NULL)
END SUB

SUB create_width_for_height_table (BYVAL root AS GooCanvasItem PTR, _
                                   BYVAL x AS gdouble, _
                                   BYVAL y AS gdouble, _
                                   BYVAL width_TJF AS gdouble, _
                                   BYVAL height AS gdouble, _
                                   BYVAL rotation AS gdouble)
  DIM AS gchar PTR text = @!"This is a long paragraph that will have to be split over a few lines so we can see if its allocated height changes when its allocated width is changed."

  VAR table = goo_canvas_table_new (root, _
        "width", WIDTH, _
        "height", height, _
         NULL)
  goo_canvas_item_translate (table, x, y)
  goo_canvas_item_rotate (table, rotation, 0, 0)

  VAR item = goo_canvas_rect_new (table, 0.0, 0.0, WIDTH - 2, 10.0, _
            "fill-color", "red", _
            NULL)
  goo_canvas_item_set_child_properties (table, item, _
          "row", 0, _
          "column", 0, _
          "x-shrink", TRUE, _
          NULL)

#IF 1
  item = goo_canvas_text_new (table, text, 0, 0, -1, GOO_CANVAS_ANCHOR_NW, NULL)
  goo_canvas_item_set_child_properties (table, item, _
          "row", 1, _
          "column", 0, _
          "x-expand", TRUE, _
          "x-fill", TRUE, _
          "x-shrink", TRUE, _
          "y-expand", TRUE, _
          "y-fill", TRUE, _
          NULL)
  g_object_set_data (G_OBJECT (item), "id", @"Text Item")
  g_signal_connect (item, "button_press_event", _
        G_CALLBACK (@on_button_press), NULL)
#ENDIF

  item = goo_canvas_rect_new (table, 0.0, 0.0, WIDTH - 2, 10.0, _
            "fill-color", "red", _
            NULL)
  goo_canvas_item_set_child_properties (table, item, _
          "row", 2, _
          "column", 0, _
          "x-shrink", TRUE, _
          NULL)
END SUB

FUNCTION create_table_page () AS GtkWidget PTR
  DIM AS GooCanvasItem PTR table

  VAR vbox = gtk_vbox_new (FALSE, 4)
  gtk_container_set_border_width (GTK_CONTAINER (vbox), 4)
  gtk_widget_show (vbox)

  VAR scrolled_win = gtk_scrolled_window_new (NULL, NULL)
  gtk_scrolled_window_set_shadow_type (GTK_SCROLLED_WINDOW (scrolled_win), _
               GTK_SHADOW_IN)
  gtk_widget_show (scrolled_win)
  gtk_box_pack_start (GTK_BOX (vbox), scrolled_win, TRUE, TRUE, 0)

  VAR canvas = goo_canvas_new ()
  gtk_widget_set_size_request (canvas, 600, 450)
  goo_canvas_set_bounds (GOO_CANVAS (canvas), 0, 0, 1000, 2000)
  gtk_container_add (GTK_CONTAINER (scrolled_win), canvas)

  VAR root = goo_canvas_get_root_item (GOO_CANVAS (canvas))

#IF 1
  create_demo_table (root, 400, 200, -1, -1)
  create_demo_table (root, 400, 260, 100, -1)
#ENDIF

#IF 1
  create_table (root, -1, -1, 0, 10, 10, 0, 1.0, DEMO_TEXT_ITEM)
  create_table (root, -1, -1, 0, 180, 10, 30, 1.0, DEMO_TEXT_ITEM)
  create_table (root, -1, -1, 0, 350, 10, 60, 1.0, DEMO_TEXT_ITEM)
  create_table (root, -1, -1, 0, 500, 10, 90, 1.0, DEMO_TEXT_ITEM)
#ENDIF

#IF 1
  table = create_table (root, -1, -1, 0, 30, 150, 0, 1.0, DEMO_TEXT_ITEM)
  g_object_set (table, "width", 300.0, "height", 100.0, NULL)
#ENDIF

#IF 1
  create_table (root, -1, -1, 1, 200, 200, 30, 0.8, DEMO_TEXT_ITEM)
#ENDIF

#IF 1
  table = create_table (root, -1, -1, 0, 10, 700, 0, 1.0, DEMO_WIDGET_ITEM)
  g_object_set (table, "width", 300.0, "height", 200.0, NULL)
#ENDIF

  create_width_for_height_table (root, 100, 1000, 200, -1, 0)
#IF 1
  create_width_for_height_table (root, 100, 1200, 300, -1, 0)

  create_width_for_height_table (root, 500, 1000, 200, -1, 30)
  create_width_for_height_table (root, 500, 1200, 300, -1, 30)
#ENDIF

  gtk_widget_show (canvas)

  RETURN vbox
END FUNCTION


 'Initialize GTK+.
gtk_init (@__FB_ARGC__, @__FB_ARGV__)

' Create the window and widgets.
VAR win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
gtk_window_set_default_size (GTK_WINDOW (win), 640, 600)
gtk_widget_show (win)
g_signal_connect (win, "delete_event", G_CALLBACK(@gtk_main_quit), NULL)

VAR page = create_table_page()
gtk_container_add (GTK_CONTAINER (win), page)

' Pass control to the GTK+ main event loop.
gtk_main ()

END 0

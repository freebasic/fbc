' An FB example by TJF
' Details: http://library.gnome.org/devel/goocanvas/unstable/
' (en) http://www.freebasic.net/forum/viewtopic.php?t=18535
' (de) http://www.freebasic-portal.de/code-beispiele/grafik-und-fonts/zeichnen-mit-goocanval-ein-graph-226.html

'#DEFINE __USE_GTK3__
#INCLUDE ONCE "goocanvas.bi"

' Some globals
CONST Xmax = 1000, Ymax = 1000, Smin = 0.1
CONST GridX = 100.0, GridY = GridX, GridW = 400.0, GridH = 300.0

' Initialize GTK+.
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
goo_canvas_set_bounds (GOO_CANVAS (canvas), 0, 0, Xmax, ymax)
gtk_widget_show (canvas)
gtk_container_add (GTK_CONTAINER (scrolled_win), canvas)

VAR root = goo_canvas_get_root_item (GOO_CANVAS (canvas))

VAR title = goo_canvas_text_new(root, "<span size=""xx-large"">"_
                                "GooCanvas FreeBasic-Example</span>", _
                                GridX + 0.5 * GridW, GridY - 25, -1, _
                                GOO_CANVAS_ANCHOR_S, _
                                "use-markup", 1, _
                                "font", "Times bold 14", _
                                NULL)

VAR group = goo_canvas_group_new(root, _
                                 "font", "Sans 14", _
                                 NULL)

' calculate some values
VAR line_group = 0.8 ' basic line width
VAR az = 100, pi = 4.0 * ATN(1), n = 2 * az - 1
VAR fx = GridW / (n - 1), sx = (az - 1) / pi, dx = 0.25 * GridW
VAR fy = GridH * 0.45, oy = GridY + 0.5 * GridH

VAR grid = goo_canvas_grid_new(group, _
                               GridX, GridY, GridW, GridH, _
                               dx, fy * 0.5, dx * 1.001, 0.05 * GridH, _
                               "border-width", line_group * 2, _
                               "horz-grid-line-width", line_group, _
                               "vert-grid-line-width", line_group, _
                               "horz-grid-line-color", "gray", _
                               "vert-grid-line-color", "gray", _
                               NULL)

VAR CanPoi = goo_canvas_points_new(az), copo = CanPoi->coords
FOR i AS INTEGER = 0 TO n STEP 2
  copo[i] = GridX + i * fx
  copo[i + 1] = oy - SIN(i/sx) * fy
NEXT
VAR poly = goo_canvas_polyline_new(group, 0, 0, _
                                   "stroke-color", "red",_
                                   "line-width", line_group * 4,_
                                   "tooltip", "Test Polyline", _
                                   "points", CanPoi,_
                                   NULL)
goo_canvas_points_unref(CanPoi)

' and now some text, text, text, ...
VAR ox = GridX - 8 * line_group
VAR text = goo_canvas_text_new(group, "1", _
                               ox, oy - fy, -1, _
                               GOO_CANVAS_ANCHOR_E, _
                               NULL)
text = goo_canvas_text_new(group, "-1", _
                           ox, oy + fy, -1, _
                           GOO_CANVAS_ANCHOR_E, _
                           NULL)
fy /= 2
text = goo_canvas_text_new(group, "<small>0.5</small>", _
                           ox, oy - fy, -1, _
                           GOO_CANVAS_ANCHOR_E, _
                           "use-markup", 1, _
                           NULL)
text = goo_canvas_text_new(group, "<small>-0.5</small>", _
                           ox, oy + fy, -1, _
                           GOO_CANVAS_ANCHOR_E, _
                           "use-markup", 1, _
                           NULL)
text = goo_canvas_text_new(group, "0", _
                           ox, oy, -1, _
                           GOO_CANVAS_ANCHOR_E, _
                           NULL)
ox -= 35
text = goo_canvas_text_new(group, "f(<i>φ</i>) = sin(<i>φ</i>)", _
                           ox, oy, -1, _
                           GOO_CANVAS_ANCHOR_S, _
                           "use-markup", 1, _
                           NULL)
goo_canvas_item_rotate(text, -90.0, ox, oy)

ox = GridX
oy = GridY + GridH + 8 * line_group
text = goo_canvas_text_new(group, "0", _
                           ox, oy, -1, _
                           GOO_CANVAS_ANCHOR_N, _
                           NULL)
ox += dx
text = goo_canvas_text_new(group, "<small>0.5π</small>", _
                           ox, oy, -1, _
                           GOO_CANVAS_ANCHOR_N, _
                           "use-markup", 1, _
                           NULL)
ox += dx
text = goo_canvas_text_new(group, "π", _
                           ox, oy, -1, _
                           GOO_CANVAS_ANCHOR_N, _
                           NULL)
text = goo_canvas_text_new(group, "This <i>φ</i> looks like an <i>angel</i>", _
                           ox, oy + 25, -1, _
                           GOO_CANVAS_ANCHOR_N, _
                           "use-markup", 1, _
                           NULL)
ox += dx
text = goo_canvas_text_new(group, "<small>1.5π</small>", _
                           ox, oy, -1, _
                           GOO_CANVAS_ANCHOR_N, _
                           "use-markup", 1, _
                           NULL)
ox += dx
text = goo_canvas_text_new(group, "2π", _
                           ox, oy, -1, _
                           GOO_CANVAS_ANCHOR_N, _
                           NULL)
text = goo_canvas_text_new(group, "<span size=""x-small""><span foreground=""blue"">" _
                           !"Click me!</span>\n<span background=""yellow"">" _
                           " l · m · r </span></span>", _
                           ox - 0.5 * dx, GridY + .05 * GridH + 0.5 * fy, -1, _
                           GOO_CANVAS_ANCHOR_CENTER, _
                           "use-markup", 1, _
                           "alignment", PANGO_ALIGN_CENTER, _
                           NULL)

' unvisible rect to make the grid clickable (not only lines)
VAR rect = goo_canvas_rect_new(group, _
                               GridX, GridY, GridW, GridH, _
                               "fill-color-rgba", &hFF000000, _
                               "stroke-pattern", NULL, _
                               NULL)

TYPE CbPointer
  AS GooCanvasItem PTR Title, Group
END TYPE

' signal handler (callback)
FUNCTION on_button_press CDECL(BYVAL item AS GooCanvasItem PTR, _
                               BYVAL target AS GooCanvasItem PTR, _
                               BYVAL event AS GdkEventButton PTR, _
                               BYVAL dat AS CbPointer PTR) AS gboolean
  STATIC AS INTEGER mo = 0
  IF event->button = 2 THEN
    goo_canvas_item_stop_animation(dat->Title) : mo = 0
    goo_canvas_item_set_simple_transform (dat->Title, 0.0, 0.0, 1.0, 0.0)
    goo_canvas_item_stop_animation(dat->Group) : mo = 0
    goo_canvas_item_set_simple_transform (dat->Group, 0.0, 0.0, 1.0, 0.0)
    RETURN TRUE
  ELSEIF mo = 0 THEN
    goo_canvas_item_animate (dat->Title, _
                             GridX + 0.5 * GridW, GridY - 25, _
                             Smin, -7.0, _
                             FALSE, 8 * 40, 40, _
                             GOO_CANVAS_ANIMATE_BOUNCE)
    goo_canvas_item_animate (dat->Group, _
                             Xmax, Ymax, _
                             Smin, 90, _
                             FALSE, event->button * 50 * 40, 40, _
                             GOO_CANVAS_ANIMATE_BOUNCE)
    mo = 1
  ELSE
    goo_canvas_item_stop_animation(dat->Title)
    goo_canvas_item_set_simple_transform (dat->Title, 0.0, 0.0, 1.0, 0.0)
    goo_canvas_item_stop_animation(dat->Group) : mo = 0
  END IF

  RETURN TRUE
END FUNCTION
g_signal_connect (group, "button_press_event", _
                  G_CALLBACK (@on_button_press), @TYPE<CbPointer>(title, group))

' Pass control to the GTK+ main event loop.
gtk_main ()

END 0

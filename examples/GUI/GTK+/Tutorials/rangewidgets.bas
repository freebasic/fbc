' Rangewidgets.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __FB_GTK3__
#include once "gtk/gtk.bi"

Dim Shared As GtkScale Ptr hscale
Dim Shared As GtkScale Ptr vscale
Dim Shared As GtkWidget Ptr digits


Sub cb_pos_menu_select Cdecl( Byval item As GtkWidget Ptr, Byval dat As gpointer)

  Var pos_ = GTK_POS_TOP, active = TRUE
  SELECT CASE AS CONST gtk_combo_box_get_active(GTK_COMBO_BOX(item))
  CASE 1
  CASE 2 : pos_ = GTK_POS_BOTTOM
  CASE 3 : pos_ = GTK_POS_RIGHT
  CASE 4 : pos_ = GTK_POS_LEFT
  CASE ELSE : active = FALSE
  END SELECT

  ' Set the value position on both scale widgets
  gtk_scale_set_value_pos (hscale, pos_)
  gtk_scale_set_value_pos (vscale, pos_)
  gtk_scale_set_draw_value (hscale, active)
  gtk_scale_set_draw_value (vscale, active)
  gtk_widget_set_sensitive(digits, active)

End Sub

Sub cb_digits_scale Cdecl( Byval adj As GtkAdjustment Ptr )

  ' Set the number of decimal places to which adj->value is rounded
  Var value = gtk_adjustment_get_value(adj)
  gtk_scale_set_digits (hscale, value)
  gtk_scale_set_digits (vscale, value)

End Sub

Sub cb_page_size Cdecl( Byval get_adj As GtkAdjustment Ptr, Byval set_adj As GtkAdjustment Ptr )

    ' Set the page size and page increment size of the sample
    ' adjustment to the value specified by the "Page Size" scale
    Var value = gtk_adjustment_get_value(get_adj) + 1
    gtk_adjustment_set_page_size(set_adj, value)
    gtk_adjustment_set_step_increment(set_adj, value)

    ' This sets the adjustment and makes it emit the "changed" signal to
    ' reconfigure all the widgets that are attached to this signal.
    Var lower = gtk_adjustment_get_lower(set_adj)
    Var upper = gtk_adjustment_get_upper(set_adj)
    gtk_adjustment_clamp_page (set_adj, lower, upper)

End Sub


' makes the sample window

Sub create_range_controls( )

    ' Standard window-creating stuff
    Var win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    g_signal_connect (G_OBJECT (win), "destroy", _
                      G_CALLBACK (@gtk_main_quit), NULL)
    gtk_window_set_title (GTK_WINDOW (win), "range controls")

    Var box1 = gtk_vbox_new (FALSE, 0)
    gtk_container_add (GTK_CONTAINER (win), box1)
    gtk_widget_show (box1)

    Var box2 = gtk_hbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
    gtk_widget_show (box2)

    ' value, lower, upper, step_increment, page_increment, page_size
    ' Note that the page_size value only makes a difference for
    ' scrollbar widgets, and the highest value you'll get is actually
    ' (upper - page_size).
    Var adj1 = gtk_adjustment_new (0.0, 0.0, 101.0, 0.1, 1.0, 1.0)

    Var item = gtk_vscale_new (GTK_ADJUSTMENT (adj1))
    gtk_scale_set_digits (GTK_SCALE (item), 1)

    gtk_box_pack_start (GTK_BOX (box2), item, TRUE, TRUE, 0)
    gtk_widget_show (item)
    vscale = GTK_SCALE (item)

    Var box3 = gtk_vbox_new (FALSE, 10)
    gtk_box_pack_start (GTK_BOX (box2), box3, TRUE, TRUE, 0)
    gtk_widget_show (box3)

    ' Reuse the same adjustment
    item = gtk_hscale_new (GTK_ADJUSTMENT (adj1))
    gtk_widget_set_size_request (GTK_WIDGET (item), 200, -1)
    gtk_scale_set_digits (GTK_SCALE (item), 1)
    gtk_box_pack_start (GTK_BOX (box3), item, TRUE, TRUE, 0)
    gtk_widget_show (item)
    hscale = GTK_SCALE (item)

    ' Reuse the same adjustment again
    Var scrollbar = gtk_hscrollbar_new (GTK_ADJUSTMENT (adj1))
    ' Notice how this causes the scales to always be updated
    ' continuously when the scrollbar is moved
    gtk_box_pack_start (GTK_BOX (box3), scrollbar, TRUE, TRUE, 0)
    gtk_widget_show (scrollbar)

    box2 = gtk_hbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)

    ' An option menu to change the position of the value
    Var label = gtk_label_new ("Scale Value Position:")
    gtk_box_pack_start (GTK_BOX (box2), label, FALSE, FALSE, 0)
    gtk_widget_show (label)

    DIM As GtkTreeIter iter
    Var store = gtk_list_store_new(1, G_TYPE_STRING)
    gtk_list_store_insert_with_values(store, @iter, 0, 0, "None", -1)
    gtk_list_store_insert_with_values(store, @iter, 1, 0, "Top", -1)
    gtk_list_store_insert_with_values(store, @iter, 2, 0, "Bottom", -1)
    gtk_list_store_insert_with_values(store, @iter, 3, 0, "Left", -1)
    gtk_list_store_insert_with_values(store, @iter, 4, 0, "Right", -1)

    Var combo = gtk_combo_box_new_with_model (GTK_TREE_MODEL(store))
    Var renderer = gtk_cell_renderer_text_new ()
    gtk_cell_layout_pack_start (GTK_CELL_LAYOUT (combo), renderer, TRUE)
    gtk_cell_layout_set_attributes (GTK_CELL_LAYOUT (combo), renderer, _
                                    "text", 0, _
                                    NULL)
    gtk_combo_box_set_active (GTK_COMBO_BOX(combo), 1)
    g_signal_connect (G_OBJECT (combo), "changed", _
                      G_CALLBACK(@cb_pos_menu_select), NULL)

    gtk_box_pack_start (GTK_BOX (box2), combo, TRUE, TRUE, 0)
    gtk_widget_show (combo)

    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
    gtk_widget_show (box2)

    box2 = gtk_hbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)

    ' An HScale widget for adjusting the number of digits on the
    ' sample scales.
    label = gtk_label_new ("Scale Digits:")
    gtk_box_pack_start (GTK_BOX (box2), label, FALSE, FALSE, 0)
    gtk_widget_show (label)

    Var adj2 = gtk_adjustment_new (1.0, 0.0, 5.0, 1.0, 1.0, 0.0)
    g_signal_connect (G_OBJECT (adj2), "value_changed", _
                      G_CALLBACK (@cb_digits_scale), NULL)
    Var scale = gtk_hscale_new (GTK_ADJUSTMENT (adj2))
    gtk_scale_set_digits (GTK_SCALE (scale), 0)
    gtk_box_pack_start (GTK_BOX (box2), scale, TRUE, TRUE, 0)
    gtk_widget_show (scale)

    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
    gtk_widget_show (box2)
    digits = box2

    box2 = gtk_hbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)

    ' And, one last HScale widget for adjusting the page size of the
    ' scrollbar.
    label = gtk_label_new ("Scrollbar Page Size:")
    gtk_box_pack_start (GTK_BOX (box2), label, FALSE, FALSE, 0)
    gtk_widget_show (label)

    adj2 = gtk_adjustment_new (0.0, 0.0, 100.0, 1.0, 1.0, 0.0)
    g_signal_connect (G_OBJECT (adj2), "value_changed", _
                      G_CALLBACK (@cb_page_size), adj1)
    scale = gtk_hscale_new (GTK_ADJUSTMENT (adj2))
    gtk_scale_set_digits (GTK_SCALE (scale), 0)
    gtk_box_pack_start (GTK_BOX (box2), scale, TRUE, TRUE, 0)
    gtk_widget_show (scale)

    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
    gtk_widget_show (box2)

    Var separator = gtk_hseparator_new ()
    gtk_box_pack_start (GTK_BOX (box1), separator, FALSE, TRUE, 0)
    gtk_widget_show (separator)

    box2 = gtk_vbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
    gtk_box_pack_start (GTK_BOX (box1), box2, FALSE, TRUE, 0)
    gtk_widget_show (box2)

    Var button = gtk_button_new_with_label ("Quit")
    g_signal_connect_swapped (G_OBJECT (button), "clicked", _
                              G_CALLBACK (@gtk_main_quit), NULL)
    gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0)
    gtk_widget_set_can_default (button, TRUE)
    gtk_widget_grab_default (button)
    gtk_widget_show (button)

    gtk_widget_show (win)

End Sub


' ==============================================
' Main
' ==============================================

  gtk_init (NULL, NULL)

  create_range_controls ()

  gtk_main ()

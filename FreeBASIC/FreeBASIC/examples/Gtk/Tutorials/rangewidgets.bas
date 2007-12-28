' Rangewidgets.bas
' Translated from C to FB by TinyCla, 2006

#include once "gtk/gtk.bi"

#define NULL 0

Dim Shared As GtkWidget Ptr hscale
Dim Shared As GtkWidget Ptr vscale


Function CLAMP(byval x As gdouble, byval low As gdouble, byval high As gdouble) As double
    
	Dim retval As double
	If x > high Then
		retval = high
	Elseif x < low Then
		retval = low
	Else
		retval = x
	End If
	Return retval
    
End Function

Sub cb_pos_menu_select Cdecl( Byval item As GtkWidget Ptr, Byval pos_widget As GtkPositionType)
    
	' Set the value position on both scale widgets 
	gtk_scale_set_value_pos (GTK_SCALE (hscale), pos_widget)
	gtk_scale_set_value_pos (GTK_SCALE (vscale), pos_widget)
    
End Sub

Sub cb_update_menu_select Cdecl( Byval item As GtkWidget Ptr, Byval policy As GtkUpdateType)
    
	' Set the update policy for both scale widgets
	gtk_range_set_update_policy (GTK_RANGE (hscale), policy)
	gtk_range_set_update_policy (GTK_RANGE (vscale), policy)
    
End Sub

Sub cb_digits_scale Cdecl( Byval adj As GtkAdjustment Ptr )
    
	' Set the number of decimal places to which adj->value is rounded 
	gtk_scale_set_digits (GTK_SCALE (hscale), adj->value)
	gtk_scale_set_digits (GTK_SCALE (vscale), adj->value)
    
End Sub

Sub cb_page_size Cdecl( Byval get_adj As GtkAdjustment Ptr, Byval set_adj As GtkAdjustment Ptr )
    
    ' Set the page size and page increment size of the sample
    ' adjustment to the value specified by the "Page Size" scale 

    set_adj->page_size = get_adj->value
    set_adj->page_increment = get_adj->value

    ' This sets the adjustment and makes it emit the "changed" signal to 
    ' reconfigure all the widgets that are attached to this signal. 
    Dim As double value
    value = CLAMP (set_adj->value, set_adj->lower, (set_adj->upper - set_adj->page_size))
    gtk_adjustment_set_value (set_adj, value)
    
End Sub

Sub cb_draw_value Cdecl( Byval button As GtkToggleButton Ptr )
    
	' Turn the value display on the scale widgets off or on depending
	' on the state of the checkbutton 
	gtk_scale_set_draw_value (GTK_SCALE (hscale), button->active)
	gtk_scale_set_draw_value (GTK_SCALE (vscale), button->active)
    
End Sub

' Convenience functions 

Function make_menu_item Cdecl(Byval name_item As gchar Ptr, Byval callback As GCallback, Byval user_data As gpointer) As GtkWidget Ptr

	Dim As GtkWidget Ptr item
  
	item = gtk_menu_item_new_with_label (name_item)
	g_signal_connect (G_OBJECT (item), "activate", callback, user_data)
	gtk_widget_show (item)

	Return item
    
End Function

Sub scale_set_default_values Cdecl( Byval scale As GtkScale Ptr )
    
	gtk_range_set_update_policy (GTK_RANGE (scale), GTK_UPDATE_CONTINUOUS)
	gtk_scale_set_digits (scale, 1)
	gtk_scale_set_value_pos (scale, GTK_POS_TOP)
	gtk_scale_set_draw_value (scale, TRUE)
    
End Sub


' makes the sample window 

Sub create_range_controls( )

    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr box1
    Dim As GtkWidget Ptr box2
    Dim As GtkWidget Ptr box3
    Dim As GtkWidget Ptr button
    Dim As GtkWidget Ptr scrollbar
    Dim As GtkWidget Ptr separator
    Dim As GtkWidget Ptr opt
    Dim As GtkWidget Ptr menu
    Dim As GtkWidget Ptr item
    Dim As GtkWidget Ptr label
    Dim As GtkWidget Ptr scale
    Dim As GtkObject Ptr adj1
    Dim As GtkObject Ptr adj2
    Dim As Zstring * 128 buffer
    Dim As gint pos_top
    Dim As gint pos_bottom
    Dim As gint pos_left
    Dim As gint pos_right
    Dim As gint update_continuous
    Dim As gint update_discontinuous
    Dim As gint update_delayed

    ' Standard window-creating stuff 
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    g_signal_connect (G_OBJECT (win), "destroy", G_CALLBACK (@gtk_main_quit), NULL)
    gtk_window_set_title (GTK_WINDOW (win), "range controls")

    box1 = gtk_vbox_new (FALSE, 0)
    gtk_container_add (GTK_CONTAINER (win), box1)
    gtk_widget_show (box1)

    box2 = gtk_hbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
    gtk_widget_show (box2)

    ' value, lower, upper, step_increment, page_increment, page_size 
    ' Note that the page_size value only makes a difference for
    ' scrollbar widgets, and the highest value you'll get is actually
    ' (upper - page_size). 
    adj1 = gtk_adjustment_new (0.0, 0.0, 101.0, 0.1, 1.0, 1.0)
  
    vscale = gtk_vscale_new (GTK_ADJUSTMENT (adj1))
    scale_set_default_values (GTK_SCALE (vscale))
    gtk_box_pack_start (GTK_BOX (box2), vscale, TRUE, TRUE, 0)
    gtk_widget_show (vscale)

    box3 = gtk_vbox_new (FALSE, 10)
    gtk_box_pack_start (GTK_BOX (box2), box3, TRUE, TRUE, 0)
    gtk_widget_show (box3)

    ' Reuse the same adjustment 
    hscale = gtk_hscale_new (GTK_ADJUSTMENT (adj1))
    gtk_widget_set_size_request (GTK_WIDGET (hscale), 200, -1)
    scale_set_default_values (GTK_SCALE (hscale))
    gtk_box_pack_start (GTK_BOX (box3), hscale, TRUE, TRUE, 0)
    gtk_widget_show (hscale)

    ' Reuse the same adjustment again 
    scrollbar = gtk_hscrollbar_new (GTK_ADJUSTMENT (adj1))
    ' Notice how this causes the scales to always be updated
    ' continuously when the scrollbar is moved 
    gtk_range_set_update_policy (GTK_RANGE (scrollbar), GTK_UPDATE_CONTINUOUS)
    gtk_box_pack_start (GTK_BOX (box3), scrollbar, TRUE, TRUE, 0)
    gtk_widget_show (scrollbar)

    box2 = gtk_hbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
    gtk_widget_show (box2)

    ' A checkbutton to control whether the value is displayed or not 
    button = gtk_check_button_new_with_label("Display value on scale widgets")
    gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (button), TRUE)
    g_signal_connect (G_OBJECT (button), "toggled", G_CALLBACK (@cb_draw_value), NULL)
    gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0)
    gtk_widget_show (button)
  
    box2 = gtk_hbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)

    ' An option menu to change the position of the value 
    label = gtk_label_new ("Scale Value Position:")
    gtk_box_pack_start (GTK_BOX (box2), label, FALSE, FALSE, 0)
    gtk_widget_show (label)
  
    opt = gtk_option_menu_new ()
    menu = gtk_menu_new ()

    buffer = "Top"
    pos_top = GTK_POS_TOP
    item = make_menu_item (g_strdup(buffer), G_CALLBACK (@cb_pos_menu_select), @pos_top)
    gtk_menu_shell_append (GTK_MENU_SHELL (menu), item)
  
    buffer = "Bottom"
    pos_bottom = GTK_POS_BOTTOM
    item = make_menu_item (g_strdup(buffer), G_CALLBACK (@cb_pos_menu_select), @pos_bottom)
    gtk_menu_shell_append (GTK_MENU_SHELL (menu), item)
  
    buffer = "Left"
    pos_left = GTK_POS_LEFT
    item = make_menu_item (g_strdup(buffer), G_CALLBACK (@cb_pos_menu_select), @pos_left)
    gtk_menu_shell_append (GTK_MENU_SHELL (menu), item)

    buffer = "Right"
    pos_right = GTK_POS_RIGHT
    item = make_menu_item (g_strdup(buffer), G_CALLBACK (@cb_pos_menu_select), @pos_right)
    gtk_menu_shell_append (GTK_MENU_SHELL (menu), item)
  
    gtk_option_menu_set_menu (GTK_OPTION_MENU (opt), menu)
    gtk_box_pack_start (GTK_BOX (box2), opt, TRUE, TRUE, 0)
    gtk_widget_show (opt)

    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
    gtk_widget_show (box2)

    box2 = gtk_hbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)

    ' Yet another option menu, this time for the update policy of the
    ' scale widgets 
    label = gtk_label_new ("Scale Update Policy:")
    gtk_box_pack_start (GTK_BOX (box2), label, FALSE, FALSE, 0)
    gtk_widget_show (label)
  
    opt = gtk_option_menu_new ()
    menu = gtk_menu_new ()
  
    buffer = "Continuous"
    update_continuous = GTK_UPDATE_CONTINUOUS
    item = make_menu_item (g_strdup(buffer), G_CALLBACK (@cb_update_menu_select), @update_continuous)
    gtk_menu_shell_append (GTK_MENU_SHELL (menu), item)

    buffer = "Discontinuous"
    update_discontinuous = GTK_UPDATE_DISCONTINUOUS
    item = make_menu_item (g_strdup(buffer), G_CALLBACK (@cb_update_menu_select), @update_discontinuous)
    gtk_menu_shell_append (GTK_MENU_SHELL (menu), item)

    buffer = "Dealyed"
    update_delayed = GTK_UPDATE_DELAYED
    item = make_menu_item (g_strdup(buffer), G_CALLBACK (@cb_update_menu_select), @update_delayed)
    gtk_menu_shell_append (GTK_MENU_SHELL (menu), item)
  
    gtk_option_menu_set_menu (GTK_OPTION_MENU (opt), menu)
    gtk_box_pack_start (GTK_BOX (box2), opt, TRUE, TRUE, 0)
    gtk_widget_show (opt)
  
    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
    gtk_widget_show (box2)

    box2 = gtk_hbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
  
    ' An HScale widget for adjusting the number of digits on the
    ' sample scales. 
    label = gtk_label_new ("Scale Digits:")
    gtk_box_pack_start (GTK_BOX (box2), label, FALSE, FALSE, 0)
    gtk_widget_show (label)

    adj2 = gtk_adjustment_new (1.0, 0.0, 5.0, 1.0, 1.0, 0.0)
    g_signal_connect (G_OBJECT (adj2), "value_changed", G_CALLBACK (@cb_digits_scale), NULL)
    scale = gtk_hscale_new (GTK_ADJUSTMENT (adj2))
    gtk_scale_set_digits (GTK_SCALE (scale), 0)
    gtk_box_pack_start (GTK_BOX (box2), scale, TRUE, TRUE, 0)
    gtk_widget_show (scale)

    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
    gtk_widget_show (box2)
  
    box2 = gtk_hbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
  
    ' And, one last HScale widget for adjusting the page size of the
    ' scrollbar. 
    label = gtk_label_new ("Scrollbar Page Size:")
    gtk_box_pack_start (GTK_BOX (box2), label, FALSE, FALSE, 0)
    gtk_widget_show (label)

    adj2 = gtk_adjustment_new (1.0, 1.0, 101.0, 1.0, 1.0, 0.0)
    g_signal_connect (G_OBJECT (adj2), "value_changed", G_CALLBACK (@cb_page_size), adj1)
    scale = gtk_hscale_new (GTK_ADJUSTMENT (adj2))
    gtk_scale_set_digits (GTK_SCALE (scale), 0)
    gtk_box_pack_start (GTK_BOX (box2), scale, TRUE, TRUE, 0)
    gtk_widget_show (scale)

    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
    gtk_widget_show (box2)

    separator = gtk_hseparator_new ()
    gtk_box_pack_start (GTK_BOX (box1), separator, FALSE, TRUE, 0)
    gtk_widget_show (separator)

    box2 = gtk_vbox_new (FALSE, 10)
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
    gtk_box_pack_start (GTK_BOX (box1), box2, FALSE, TRUE, 0)
    gtk_widget_show (box2)

    button = gtk_button_new_with_label ("Quit")
    g_signal_connect_swapped (G_OBJECT (button), "clicked", G_CALLBACK (@gtk_main_quit), NULL)
    gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0)
    GTK_WIDGET_SET_FLAGS (button, GTK_CAN_DEFAULT)
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

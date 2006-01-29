''
'' combo box example, translated from an C example written by Özcan Güngör
''

option explicit
#include once "gtk/gtk.bi"

#define NULL 0

'':::::
sub enter_callback( byval widget as GtkWidget ptr, _
                    byval entry as GtkWidget ptr )
  
  dim as zstring ptr entry_text
  
  entry_text = gtk_entry_get_text (GTK_ENTRY (entry))
  
  print "Entry contents: "; *entry_text

end sub

'':::::
sub entry_toggle_editable( byval checkbutton as GtkWidget ptr, _
                           byval entry as GtkWidget ptr )

  gtk_editable_set_editable (GTK_EDITABLE (entry), _
                             GTK_TOGGLE_BUTTON (checkbutton)->active)

end sub

'':::::
sub entry_toggle_visibility( byval checkbutton as GtkWidget ptr, _
                             byval entry as GtkWidget ptr )

  gtk_entry_set_visibility (GTK_ENTRY (entry), _
			    			GTK_TOGGLE_BUTTON (checkbutton)->active)

end sub

'':::::
'' main
    dim as GtkWidget ptr win
    dim as GtkWidget ptr vbox, hbox
    dim as GtkWidget ptr entry
    dim as GtkWidget ptr button
    dim as GtkWidget ptr check
    dim as gint tmp_pos

    gtk_init( NULL, NULL )

    '' create a new window
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_widget_set_size_request (GTK_WIDGET (win), 200, 100)
    gtk_window_set_title (GTK_WINDOW (win), "GTK Entry")
    g_signal_connect (G_OBJECT (win), "destroy", _
                      G_CALLBACK (@gtk_main_quit), NULL)
    g_signal_connect_swapped (G_OBJECT (win), "delete_event", _
                              G_CALLBACK (@gtk_widget_destroy),  _
                              G_OBJECT (win))

    vbox = gtk_vbox_new (FALSE, 0)
    gtk_container_add (GTK_CONTAINER (win), vbox)
    gtk_widget_show (vbox)

    entry = gtk_entry_new ()
    gtk_entry_set_max_length (GTK_ENTRY (entry), 50)
    g_signal_connect (G_OBJECT (entry), "activate", _
		      		  G_CALLBACK (@enter_callback), _
		      		  cast(gpointer, entry))
    gtk_entry_set_text (GTK_ENTRY (entry), "hello")
    tmp_pos = GTK_ENTRY (entry)->text_length
    gtk_editable_insert_text (GTK_EDITABLE (entry), " world", -1, @tmp_pos)
    gtk_editable_select_region (GTK_EDITABLE (entry), _
			        			0, GTK_ENTRY (entry)->text_length)
    gtk_box_pack_start (GTK_BOX (vbox), entry, TRUE, TRUE, 0)
    gtk_widget_show (entry)

    hbox = gtk_hbox_new (FALSE, 0)
    gtk_container_add (GTK_CONTAINER (vbox), hbox)
    gtk_widget_show (hbox)
                                  
    check = gtk_check_button_new_with_label ("Editable")
    gtk_box_pack_start (GTK_BOX (hbox), check, TRUE, TRUE, 0)
    g_signal_connect (G_OBJECT (check), "toggled", _
	              	  G_CALLBACK (@entry_toggle_editable), cast(gpointer, entry))
    gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (check), TRUE)
    gtk_widget_show (check)
    
    check = gtk_check_button_new_with_label ("Visible")
    gtk_box_pack_start (GTK_BOX (hbox), check, TRUE, TRUE, 0)
    g_signal_connect (G_OBJECT (check), "toggled", _
	              	  G_CALLBACK (@entry_toggle_visibility), cast(gpointer, entry))
    gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (check), TRUE)
    gtk_widget_show (check)
                                   
    button = gtk_button_new_from_stock (GTK_STOCK_CLOSE)
    g_signal_connect_swapped (G_OBJECT (button), "clicked", _
			      			  G_CALLBACK (@gtk_widget_destroy), _
			      			  G_OBJECT (win))
    gtk_box_pack_start (GTK_BOX (vbox), button, TRUE, TRUE, 0)
    GTK_WIDGET_SET_FLAGS (button, GTK_CAN_DEFAULT)
    gtk_widget_grab_default (button)
    gtk_widget_show (button)
    
    gtk_widget_show (win)

    gtk_main()

	end 0

' Entry.bas
' Translated from C to FB by TinyCla, 2006

#include once "gtk/gtk.bi"

#define NULL 0


Sub enter_callback cdecl( Byval widget As GtkWidget Ptr, Byval entry As GtkWidget Ptr )

	Dim As Zstring Ptr entry_text

	entry_text = gtk_entry_get_text (GTK_ENTRY (entry))
	g_print ( !"Entry contents:  %s\n", entry_text)
    
End Sub

Sub entry_toggle_editable cdecl( Byval checkbutton As GtkWidget Ptr, Byval entry As GtkWidget Ptr )

	gtk_editable_set_editable (GTK_EDITABLE (entry), GTK_TOGGLE_BUTTON (checkbutton)->active)

End Sub

Sub entry_toggle_visibility cdecl( Byval checkbutton As GtkWidget Ptr, Byval entry As GtkWidget Ptr )

	gtk_entry_set_visibility (GTK_ENTRY (entry), GTK_TOGGLE_BUTTON (checkbutton)->active)

End Sub


' ==============================================
' Main
' ==============================================

	Dim As GtkWidget Ptr win
	Dim As GtkWidget Ptr vbox
	Dim As GtkWidget Ptr hbox
	Dim As GtkWidget Ptr entry
	Dim As GtkWidget Ptr button
	Dim As GtkWidget Ptr check
	Dim As Integer tmp_pos
	
	gtk_init (NULL, NULL)
	
	' create a new window 
	win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
	gtk_widget_set_size_request (GTK_WIDGET (win), 200, 100)
	gtk_window_set_title (GTK_WINDOW (win), "GTK Entry")
	g_signal_connect (G_OBJECT (win), "destroy", G_CALLBACK (@gtk_main_quit), NULL)
	g_signal_connect_swapped (G_OBJECT (win), "delete_event", G_CALLBACK (@gtk_widget_destroy),  G_OBJECT (win))
	
	vbox = gtk_vbox_new (FALSE, 0)
	gtk_container_add (GTK_CONTAINER (win), vbox)
	gtk_widget_show (vbox)
	
	entry = gtk_entry_new ()
	gtk_entry_set_max_length (GTK_ENTRY (entry), 50)
	g_signal_connect (G_OBJECT (entry), "activate", G_CALLBACK (@enter_callback), entry)
	gtk_entry_set_text (GTK_ENTRY (entry), "hello")
	tmp_pos = GTK_ENTRY (entry)->text_length
	gtk_editable_insert_text (GTK_EDITABLE (entry), " world", -1, @tmp_pos)
	gtk_editable_select_region (GTK_EDITABLE (entry), 0, GTK_ENTRY (entry)->text_length)
	gtk_box_pack_start (GTK_BOX (vbox), entry, TRUE, TRUE, 0)
	gtk_widget_show (entry)
	
	hbox = gtk_hbox_new (FALSE, 0)
	gtk_container_add (GTK_CONTAINER (vbox), hbox)
	gtk_widget_show (hbox)
				  
	check = gtk_check_button_new_with_label ("Editable")
	gtk_box_pack_start (GTK_BOX (hbox), check, TRUE, TRUE, 0)
	g_signal_connect (G_OBJECT (check), "toggled", G_CALLBACK (@entry_toggle_editable), entry)
	gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (check), TRUE)
	gtk_widget_show (check)
	
	check = gtk_check_button_new_with_label ("Visible")
	gtk_box_pack_start (GTK_BOX (hbox), check, TRUE, TRUE, 0)
	g_signal_connect (G_OBJECT (check), "toggled", G_CALLBACK (@entry_toggle_visibility), entry)
	gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (check), TRUE)
	gtk_widget_show (check)
				   
	button = gtk_button_new_from_stock (GTK_STOCK_CLOSE)
	g_signal_connect_swapped (G_OBJECT (button), "clicked", G_CALLBACK (@gtk_widget_destroy), G_OBJECT (win))
	gtk_box_pack_start (GTK_BOX (vbox), button, TRUE, TRUE, 0)
	GTK_WIDGET_SET_FLAGS (button, GTK_CAN_DEFAULT)
	gtk_widget_grab_default (button)
	gtk_widget_show (button)
	
	gtk_widget_show (win)
	
	gtk_main()

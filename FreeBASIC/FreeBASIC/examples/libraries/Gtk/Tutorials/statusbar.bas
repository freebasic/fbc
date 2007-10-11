' Statusbas.bas
' Translated from C to FB by TinyCla, 2006


#include once "gtk/gtk.bi"

#define NULL 0


Dim Shared As GtkWidget Ptr status_bar

Sub push_item Cdecl( Byval widget As GtkWidget Ptr, Byval user_data As gpointer )

	Static As gint count
	count += 1

	Dim As String buff
	Dim As UInteger Ptr context_id
	
	context_id =  user_data

	buff = "Item " + Str(count)
	gtk_statusbar_push (GTK_STATUSBAR (status_bar), *context_id, Strptr(buff))

End Sub

Sub pop_item Cdecl( Byval widget As GtkWidget Ptr, Byval user_data As gpointer )

	Dim As UInteger Ptr context_id
	
	context_id =  user_data
	gtk_statusbar_pop (GTK_STATUSBAR (status_bar), *context_id)
    
End Sub

' ==============================================
' Main
' ==============================================

	Dim As GtkWidget Ptr win
	Dim As GtkWidget Ptr vbox
	Dim As GtkWidget Ptr button
	Dim As Integer context_id
	
	gtk_init (NULL, NULL )
	
	' create a new window 
	win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
	gtk_widget_set_size_request (GTK_WIDGET (win), 200, 100)
	gtk_window_set_title (GTK_WINDOW (win), "GTK Statusbar Example")
	g_signal_connect (G_OBJECT (win), "delete_event", G_CALLBACK (@gtk_main_quit), NULL)
	
	vbox = gtk_vbox_new (FALSE, 1)
	gtk_container_add (GTK_CONTAINER (win), vbox)
	gtk_widget_show (vbox)
	
	status_bar = gtk_statusbar_new ()
	gtk_box_pack_start (GTK_BOX (vbox), status_bar, TRUE, TRUE, 0)
	gtk_widget_show (status_bar)
	
	context_id = gtk_statusbar_get_context_id( GTK_STATUSBAR (status_bar), "Statusbar example")
	
	button = gtk_button_new_with_label ("push item")
	g_signal_connect (G_OBJECT (button), "clicked", G_CALLBACK (@push_item), @context_id)
	gtk_box_pack_start (GTK_BOX (vbox), button, TRUE, TRUE, 2)
	gtk_widget_show (button)
	
	button = gtk_button_new_with_label ("pop last item")
	g_signal_connect (G_OBJECT (button), "clicked", G_CALLBACK (@pop_item), @context_id)
	gtk_box_pack_start (GTK_BOX (vbox), button, TRUE, TRUE, 2)
	gtk_widget_show (button)
	
	' always display the window as the last step so it all splashes on
	' the screen at once.
	gtk_widget_show (win)
	
	gtk_main ()

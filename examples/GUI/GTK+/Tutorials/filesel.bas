' Filesel.bas
' Translated from C to FB by TinyCla, 2006

#include once "gtk/gtk.bi"

#define NULL 0

' Get the selected filename and print it to the console 
Sub file_ok_sel Cdecl ( Byval w As GtkWidget Ptr, Byval fs As GtkFileSelection Ptr )
	Print *gtk_file_selection_get_filename (GTK_FILE_SELECTION (fs))
End Sub


' ==============================================
' Main
' ==============================================

	Dim As GtkWidget Ptr filew
	
	gtk_init (NULL, NULL)
	
	' Create a new file selection widget 
	filew = gtk_file_selection_new ("File selection")
	
	g_signal_connect (G_OBJECT (filew), "destroy", G_CALLBACK (@gtk_main_quit), NULL)
	
	' Connect the ok_button to file_ok_sel function 
	g_signal_connect (G_OBJECT (GTK_FILE_SELECTION (filew)->ok_button), "clicked", G_CALLBACK (@file_ok_sel), filew)
	
	' Connect the cancel_button to destroy the widget 
	g_signal_connect_swapped (G_OBJECT (GTK_FILE_SELECTION (filew)->cancel_button), "clicked", G_CALLBACK (@gtk_widget_destroy), G_OBJECT (filew))
	
	' Lets set the filename, as if this were a save dialog, and we are giving a default filename 
	gtk_file_selection_set_filename (GTK_FILE_SELECTION(filew),  "penguin.png")
	    
	gtk_widget_show (filew)
	gtk_main ()

' Buttons.bas
' Translated from C to FB by TinyCla, 2006

#include once "gtk/gtk.bi"

#define NULL 0

' Create a new hbox with an image and a label packed into it
' and return the box.
Function xpm_label_box(Byval xpm_filename As ZString Ptr, Byval label_text As ZString Ptr) As GtkWidget Ptr

	Dim As GtkWidget Ptr box
	Dim As GtkWidget Ptr label
	Dim As GtkWidget Ptr image

	' Create box for image and label 
	box = gtk_hbox_new (FALSE, 0)
	gtk_container_set_border_width (GTK_CONTAINER (box), 2)

	' Now on to the image stuff 
	image = gtk_image_new_from_file (xpm_filename)

	' Create a label for the button 
	label = gtk_label_new (label_text)

	' Pack the image and label into the box 
	gtk_box_pack_start (GTK_BOX (box), image, FALSE, FALSE, 3)
	gtk_box_pack_start (GTK_BOX (box), label, FALSE, FALSE, 3)

	gtk_widget_show (image)
	gtk_widget_show (label)

	Return box
End Function

' Our usual callback function 
Sub callback Cdecl(Byval widget As GtkWidget Ptr, Byval user_data As gpointer Ptr)
    
    g_print (!"Hello again - %s was pressed\n", user_data)
    
End Sub


' ==============================================
' Main
' ==============================================

	' GtkWidget is the storage type for widgets 
	Dim As GtkWidget Ptr win
	Dim As GtkWidget Ptr button
	Dim As GtkWidget Ptr box
	
	gtk_init (NULL, NULL)
	
	' Create a new window 
	win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
	
	gtk_window_set_title (GTK_WINDOW (win), "Pixmap'd Buttons!")
	
	' It's a good idea to do this for all windows. 
	g_signal_connect (G_OBJECT (win), "destroy", G_CALLBACK (@gtk_main_quit), NULL)
	g_signal_connect (G_OBJECT (win), "delete_event", G_CALLBACK (@gtk_main_quit), NULL)
	
	' Sets the border width of the window. 
	gtk_container_set_border_width (GTK_CONTAINER (win), 10)
	
	' Create a new button 
	button = gtk_button_new ()
	
	' Connect the "clicked" signal of the button to our callback 
	g_signal_connect (G_OBJECT (button), "clicked", G_CALLBACK (@callback), strptr("cool button"))
	
	' This calls our box creating function 
	box = xpm_label_box("info.xpm", "cool button")
	
	' Pack and show all our widgets 
	gtk_widget_show (box)
	
	gtk_container_add (GTK_CONTAINER (button), box)
	
	gtk_widget_show (button)
	
	gtk_container_add (GTK_CONTAINER (win), button)
	
	gtk_widget_show (win)
	
	' Rest in gtk_main and wait for the fun to begin! 
	gtk_main ()

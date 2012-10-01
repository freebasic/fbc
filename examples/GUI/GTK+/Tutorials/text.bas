' Text.bas
' Translated from C to FB by TinyCla, 2006

#include once "gtk/gtk.bi"

#define NULL 0
#define GTK_ENABLE_BROKEN 1

Sub text_toggle_editable Cdecl (Byval checkbutton As GtkWidget Ptr, Byval text As GtkWidget Ptr)
    
	gtk_text_set_editable (GTK_TEXT (text), GTK_TOGGLE_BUTTON (checkbutton)->active)
    
End Sub

Sub text_toggle_word_wrap  Cdecl(Byval checkbutton As GtkWidget Ptr, Byval text As GtkWidget Ptr)
    
	gtk_text_set_word_wrap (GTK_TEXT (text), GTK_TOGGLE_BUTTON (checkbutton)->active)
    
End Sub

Sub close_application Cdecl( Byval widget As GtkWidget Ptr, Byval user_data As gpointer)
    
	gtk_main_quit ()
    
End Sub


' ==============================================
' Main
' ==============================================

	Dim As GtkWidget Ptr win
	Dim As GtkWidget Ptr box1
	Dim As GtkWidget Ptr box2
	Dim As GtkWidget Ptr hbox
	Dim As GtkWidget Ptr button
	Dim As GtkWidget Ptr check
	Dim As GtkWidget Ptr separator
	Dim As GtkWidget Ptr table
	Dim As GtkWidget Ptr vscrollbar
	Dim As GtkWidget Ptr text
	Dim As GdkColormap Ptr cmap
	Dim As GdkColor val_color
	Dim As GdkFont Ptr fixed_font
	Dim As Integer infile
	
	gtk_init (NULL, NULL)
	
	win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
	gtk_widget_set_size_request (win, 600, 500)
	gtk_window_set_policy (GTK_WINDOW (win), TRUE, TRUE, FALSE)
	g_signal_connect (G_OBJECT (win), "destroy", G_CALLBACK (@close_application), NULL)
	gtk_window_set_title (GTK_WINDOW (win), "Text Widget Example")
	gtk_container_set_border_width (GTK_CONTAINER (win), 0)
	
	
	box1 = gtk_vbox_new (FALSE, 0)
	gtk_container_add (GTK_CONTAINER (win), box1)
	gtk_widget_show (box1)
	
	box2 = gtk_vbox_new (FALSE, 10)
	gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
	gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
	gtk_widget_show (box2)
	
	table = gtk_table_new (2, 2, FALSE)
	gtk_table_set_row_spacing (GTK_TABLE (table), 0, 2)
	gtk_table_set_col_spacing (GTK_TABLE (table), 0, 2)
	gtk_box_pack_start (GTK_BOX (box2), table, TRUE, TRUE, 0)
	gtk_widget_show (table)
	
	' Create the GtkText widget 
	text = gtk_text_new (NULL, NULL)
	gtk_text_set_editable (GTK_TEXT (text), TRUE)
	gtk_table_attach (GTK_TABLE (table), text, 0, 1, 0, 1, GTK_EXPAND Or GTK_SHRINK Or GTK_FILL, GTK_EXPAND Or GTK_SHRINK Or GTK_FILL, 0, 0)
	gtk_widget_show (text)
	
	' Add a vertical scrollbar to the GtkText widget 
	vscrollbar = gtk_vscrollbar_new (GTK_TEXT (text)->vadj)
	gtk_table_attach (GTK_TABLE (table), vscrollbar, 1, 2, 0, 1, GTK_FILL, GTK_EXPAND Or GTK_SHRINK Or GTK_FILL, 0, 0)
	gtk_widget_show (vscrollbar)
	
	' Get the system color map and allocate the color red 
	cmap = gdk_colormap_get_system ()
	val_color.red = 65535
	val_color.green = 0
	val_color.blue = 0
	If Not gdk_color_alloc (cmap, @val_color) Then
		g_print ("couldn't allocate color")
	End If
	
	' Load a fixed font 
	fixed_font = gdk_font_load ("-misc-fixed-medium-r-*-*-*-140-*-*-*-*-*-*")
	
	' Realizing a widget creates a window for it,
	' ready for us to insert some text 
	gtk_widget_realize (text)
	
	' Freeze the text widget, ready for multiple updates 
	gtk_text_freeze (GTK_TEXT (text))
	
	' Insert some colored text 
	gtk_text_insert (GTK_TEXT (text), NULL, @text->style->black, NULL, "Supports ", -1)
	gtk_text_insert (GTK_TEXT (text), NULL, @val_color, NULL, "colored ", -1)
	gtk_text_insert (GTK_TEXT (text), NULL, @text->style->black, NULL, "text and different ", -1)
	gtk_text_insert (GTK_TEXT (text), fixed_font, @text->style->black, NULL, !"fonts\n\n", -1)
	
	' Load the file text.c into the text window 
	infile = Freefile
	Open "text.bas" For Input As #infile
	
	Dim As String inbuf
	Dim As Zstring * 1024 buffer
	Dim As Integer nchars
	    
	Do Until Eof(infile)
		Line Input #infile, inbuf
		nchars = Len(inbuf)
		buffer = inbuf
		gtk_text_insert (GTK_TEXT (text), fixed_font, NULL, NULL, buffer, nchars)
		buffer = !"\n"
		gtk_text_insert (GTK_TEXT (text), fixed_font, NULL, NULL, buffer, 1)
	Loop
	
	Close #infile
	
	' Thaw the text widget, allowing the updates to become visible 
	gtk_text_thaw (GTK_TEXT (text))
	
	hbox = gtk_hbutton_box_new ()
	gtk_box_pack_start (GTK_BOX (box2), hbox, FALSE, FALSE, 0)
	gtk_widget_show (hbox)
	
	check = gtk_check_button_new_with_label ("Editable")
	gtk_box_pack_start (GTK_BOX (hbox), check, FALSE, FALSE, 0)
	g_signal_connect (G_OBJECT (check), "toggled", G_CALLBACK (@text_toggle_editable), text)
	gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (check), TRUE)
	gtk_widget_show (check)
	check = gtk_check_button_new_with_label ("Wrap Words")
	gtk_box_pack_start (GTK_BOX (hbox), check, FALSE, TRUE, 0)
	g_signal_connect (G_OBJECT (check), "toggled", G_CALLBACK (@text_toggle_word_wrap), text)
	gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (check), FALSE)
	gtk_widget_show (check)
	
	separator = gtk_hseparator_new ()
	gtk_box_pack_start (GTK_BOX (box1), separator, FALSE, TRUE, 0)
	gtk_widget_show (separator)
	
	box2 = gtk_vbox_new (FALSE, 10)
	gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
	gtk_box_pack_start (GTK_BOX (box1), box2, FALSE, TRUE, 0)
	gtk_widget_show (box2)
	
	button = gtk_button_new_with_label ("close")
	g_signal_connect (G_OBJECT (button), "clicked", G_CALLBACK (@close_application), NULL)
	gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0)
	GTK_WIDGET_SET_FLAGS (button, GTK_CAN_DEFAULT)
	gtk_widget_grab_default (button)
	gtk_widget_show (button)
	
	gtk_widget_show (win)
	
	gtk_main ()
	
	End 0

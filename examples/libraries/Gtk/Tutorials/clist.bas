' Clist.bas
' Translated from C to FB by TinyCla, 2006

#include once "gtk/gtk.bi"

#define NULL 0


' User clicked the "Add List" button. 
Sub button_add_clicked Cdecl( Byval user_data As gpointer )

	Dim As Integer indx
	Dim As GtkList Ptr c_list

	Dim drink(1 To 4, 1 To 2) As Zstring Ptr => {_
	{@"Milk", @"3 Oz"}, _
	{@"Water", @"6 l"},_
	{@"Carrots", @"2"},_
	{@"Snakes", @"55"}_
	}
	
	' Here we do the actual adding of the text. It's done once for
	' each row.

	For indx = 1 To 4
		gtk_clist_append(cast(GtkCList Ptr, user_data), cast(Zstring Ptr Ptr, @drink(indx, 1)))
	Next
End Sub

' User clicked the "Clear List" button. 
Sub button_clear_clicked Cdecl( Byval user_data As gpointer )

	' Clear the list using gtk_clist_clear. This is much faster than
	' calling gtk_clist_remove once for each row.
	gtk_clist_clear (cast(GtkCList Ptr, user_data ))

End Sub

' The user clicked the "Hide/Show titles" button. 
Sub button_hide_show_clicked Cdecl( Byval user_data As gpointer )

	' Just a flag to remember the status. 0 = currently visible 
	Static flag As Integer

	If flag = 0 Then
		' Hide the titles and set the flag to 1 
		gtk_clist_column_titles_hide (cast(GtkCList Ptr, user_data ))
		flag += 1
	Else
		' Show the titles and reset flag to 0 
		gtk_clist_column_titles_show (cast(GtkCList Ptr, user_data ))
		flag -= 1
	End If
End Sub

' If we come here, then the user has selected a row in the list. 
Sub selection_made Cdecl( Byval clist As GtkWidget Ptr, Byval row As gint, Byval column As gint, Byval event As GdkEventButton Ptr, Byval user_data As gpointer)

	Dim text As Zstring Ptr

	' Get the text that is stored in the selected row and column
	' which was clicked in. We will receive it as a pointer in the
	' argument text.
	gtk_clist_get_text (cast (GtkCList Ptr, clist), row, column, @text)

	' Just prints some information about the selected row 
	g_print (!"You selected row %d. More specifically you clicked in column %d, and the text in this cell is %s\n\n", row, column, text)

End Sub


' ==============================================
' Main
' ==============================================

	Dim As GtkWidget Ptr win
	Dim As GtkWidget Ptr vbox
	Dim As GtkWidget Ptr hbox
	Dim As GtkWidget Ptr scrolled_window
	Dim As GtkWidget Ptr clist
	Dim As GtkWidget Ptr button_add
	Dim As GtkWidget Ptr button_clear
	Dim As GtkWidget Ptr button_hide_show
	Dim As Zstring Ptr titles(1 To 2) => { @"Ingredients", @"Amount" }
	
	gtk_init(NULL, NULL)
	
	win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
	gtk_widget_set_size_request (GTK_WIDGET (win), 300, 150)
	
	gtk_window_set_title (GTK_WINDOW (win), "GtkCList Example")
	g_signal_connect (G_OBJECT (win), "destroy", GTK_SIGNAL_FUNC (@gtk_main_quit), NULL)
	
	vbox = gtk_vbox_new (FALSE, 5)
	gtk_container_set_border_width (GTK_CONTAINER (vbox), 5)
	gtk_container_add (GTK_CONTAINER (win), vbox)
	gtk_widget_show (vbox)
	
	' Create a scrolled window to pack the CList widget into
	scrolled_window = gtk_scrolled_window_new (NULL, NULL)
	gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scrolled_window), GTK_POLICY_AUTOMATIC, GTK_POLICY_ALWAYS)
	
	gtk_box_pack_start (GTK_BOX (vbox), scrolled_window, TRUE, TRUE, 0)
	gtk_widget_show (scrolled_window)
	
	' Create the CList. For this example we use 2 columns 
	clist = gtk_clist_new_with_titles (2, @titles(1))
	
	' When a selection is made, we want to know about it. The callback
	' used is selection_made, and its code can be found further down 
	g_signal_connect (G_OBJECT (clist), "select_row", GTK_SIGNAL_FUNC (@selection_made), NULL)
	
	' It isn't necessary to shadow the border, but it looks nice :)
	gtk_clist_set_shadow_type (cast(GtkCList Ptr, clist), GTK_SHADOW_OUT)
	
	' What however is important, is that we set the column widths as
	' they will never be right otherwise. Note that the columns are
	' numbered from 0 and up (to 1 in this case).
	gtk_clist_set_column_width (cast(GtkCList Ptr, clist), 0, 150)
	
	' Add the CList widget to the vertical box and show it. 
	gtk_container_add (GTK_CONTAINER (scrolled_window), clist)
	gtk_widget_show (clist)
	
	' Create the buttons and add them to the window. See the button
	' tutorial for more examples and comments on this.
	hbox = gtk_hbox_new (FALSE, 0)
	gtk_box_pack_start (GTK_BOX (vbox), hbox, FALSE, TRUE, 0)
	gtk_widget_show (hbox)
	
	button_add = gtk_button_new_with_label ("Add List")
	button_clear = gtk_button_new_with_label ("Clear List")
	button_hide_show = gtk_button_new_with_label ("Hide/Show titles")
	
	gtk_box_pack_start (GTK_BOX (hbox), button_add, TRUE, TRUE, 0)
	gtk_box_pack_start (GTK_BOX (hbox), button_clear, TRUE, TRUE, 0)
	gtk_box_pack_start (GTK_BOX (hbox), button_hide_show, TRUE, TRUE, 0)
	
	' Connect our callbacks to the three buttons 
	g_signal_connect_swapped (G_OBJECT (button_add), "clicked", GTK_SIGNAL_FUNC (@button_add_clicked), clist)
	g_signal_connect_swapped (G_OBJECT (button_clear), "clicked", GTK_SIGNAL_FUNC (@button_clear_clicked), clist)
	g_signal_connect_swapped (G_OBJECT (button_hide_show), "clicked", GTK_SIGNAL_FUNC (@button_hide_show_clicked), clist)
	
	gtk_widget_show (button_add)
	gtk_widget_show (button_clear)
	gtk_widget_show (button_hide_show)
	
	' The interface is completely set up so we show the window and
	' enter the gtk_main loop.
	
	gtk_widget_show (win)
	
	gtk_main()

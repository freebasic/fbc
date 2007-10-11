' List.bas
' Translated from C to FB by TinyCla, 2006

#include once "crt.bi"
#include once "gtk/gtk.bi"

#define NULL 0


' This is our data identification string to store data in list items
Const list_item_data_key ="list_item_data"


Declare Sub sigh_button_event Cdecl ( Byval gtklist As GtkWidget Ptr, Byval event As GdkEventButton Ptr, Byval frame As GtkWidget Ptr )
Declare Sub sigh_print_selection Cdecl ( Byval gtklist As GtkWidget Ptr, Byval func_data As gpointer )


' ==============================================
' Main
' ==============================================

	Dim As GtkWidget Ptr separator
	Dim As GtkWidget Ptr win
	Dim As GtkWidget Ptr vbox
	Dim As GtkWidget Ptr scrolled_window
	Dim As GtkWidget Ptr frame
	Dim As GtkWidget Ptr gtklist
	Dim As GtkWidget Ptr button
	Dim As GtkWidget Ptr list_item
	Dim As GList Ptr dlist 
	Dim As Integer i
	Dim As Zstring * 64 buffer
	
	' Initialize GTK (and subsequently GDK) 
	
	gtk_init (NULL, NULL)
	
	' Create a window to put all the widgets in
	' connect gtk_main_quit() to the "destroy" event of
	' the window to handle window manager close-window-events
	
	win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
	gtk_window_set_title (GTK_WINDOW (win), "GtkList Example")
	g_signal_connect (G_OBJECT (win), "destroy", G_CALLBACK (@gtk_main_quit), NULL)
	
	' Inside the window we need a box to arrange the widgets vertically 
	vbox=gtk_vbox_new (FALSE, 5)
	gtk_container_set_border_width (GTK_CONTAINER (vbox), 5)
	gtk_container_add (GTK_CONTAINER (win), vbox)
	gtk_widget_show (vbox)
	
	' This is the scrolled window to put the List widget inside 
	scrolled_window = gtk_scrolled_window_new (NULL, NULL)
	gtk_widget_set_size_request (scrolled_window, 250, 150)
	gtk_container_add (GTK_CONTAINER (vbox), scrolled_window)
	gtk_widget_show (scrolled_window)
	
	' Create thekList widget.
	' Connect the sigh_print_selection() signal handler
	' function to the "selection_changed" signal of the List
	' to print out the selected items each time the selection
	' has changed */
	gtklist=gtk_list_new ()
	gtk_scrolled_window_add_with_viewport (GTK_SCROLLED_WINDOW (scrolled_window), gtklist)
	gtk_widget_show (gtklist)
	g_signal_connect (G_OBJECT (gtklist), "selection_changed", G_CALLBACK (@sigh_print_selection), NULL)
	
	' We create a "Prison" to put a list item in ;) 
	frame=gtk_frame_new ("Prison")
	gtk_widget_set_size_request (frame, 200, 50)
	gtk_container_set_border_width (GTK_CONTAINER (frame), 5)
	gtk_frame_set_shadow_type (GTK_FRAME (frame), GTK_SHADOW_OUT)
	gtk_container_add (GTK_CONTAINER (vbox), frame)
	gtk_widget_show (frame)
	
	' Connect the sigh_button_event() signal handler to the List
	' which will handle the "arresting" of list items
	g_signal_connect (G_OBJECT (gtklist), "button_release_event", G_CALLBACK (@sigh_button_event), frame)
	
	' Create a separator 
	separator=gtk_hseparator_new ()
	gtk_container_add (GTK_CONTAINER (vbox), separator)
	gtk_widget_show (separator)
	
	' Finally create a button and connect its "clicked" signal
	' to the destruction of the window 
	button=gtk_button_new_with_label ("Close")
	gtk_container_add (GTK_CONTAINER (vbox), button)
	gtk_widget_show (button)
	g_signal_connect_swapped (G_OBJECT (button), "clicked", G_CALLBACK (@gtk_widget_destroy), win)
	
	'* Now we create 5 list items, each having its own
	' label and add them to the List using gtk_container_add()
	' Also we query the text string from the label and
	' associate it with the list_item_data_key for each list item
	Dim As Zstring Ptr tmp
	For i = 0 To 4
		Dim As GtkWidget Ptr label
		Dim As Zstring Ptr m_string
	
		sprintf(buffer, "ListItemContainer with Label #%d", i)
		label=gtk_label_new (buffer)
		list_item=gtk_list_item_new ()
		gtk_container_add (GTK_CONTAINER (list_item), label)
		gtk_widget_show (label)
		gtk_container_add (GTK_CONTAINER (gtklist), list_item)
		gtk_widget_show (list_item)
		gtk_label_get (GTK_LABEL (label), @m_string)
		g_object_set_data (G_OBJECT (list_item), @list_item_data_key, m_string)
	Next
	
	' Here, we are creating another 5 labels, this time
	' we use gtk_list_item_new_with_label() for the creation
	' we can't query the text string from the label because
	' we don't have the labels pointer and therefore
	' we just associate the list_item_data_key of each
	' list item with the same text string.
	' For adding of the list items we put them all into a doubly
	' linked list (GList), and then add them by a single call to
	' gtk_list_append_items().
	' Because we use g_list_prepend() to put the items into the
	' doubly linked list, their order will be descending (instead
	' of ascending when using g_list_append())
	
	dlist = NULL
	For  i = 5 To 9
		sprintf(buffer, "List Item with Label %d", i)
		list_item = gtk_list_item_new_with_label (buffer)
		dlist = g_list_prepend (dlist, list_item)
		gtk_widget_show (list_item)
		tmp = @"ListItem with integrated Label"
		g_object_set_data (G_OBJECT (list_item), @list_item_data_key, tmp)
	Next
	gtk_list_append_items (GTK_LIST (gtklist), dlist)
	
	' Finally we want to see the window, don't we? ;) 
	gtk_widget_show (win)
	
	' Fire up the main event loop of gtk 
	gtk_main ()
	
	' We get here after gtk_main_quit() has been called which
	' happens if the main window gets destroyed
	
	End 0
	


' This is the signal handler that got connected to button
' press/release events of the List

Sub sigh_button_event Cdecl ( Byval gtklist As GtkWidget Ptr, Byval event As GdkEventButton Ptr, Byval frame As GtkWidget Ptr )

	' We only do something if the third (rightmost mouse button was released

	If event->Type = GDK_BUTTON_RELEASE And event->button = 3 Then
		Dim As GList Ptr dlist, free_list
		Dim As GtkWidget Ptr new_prisoner

		' Fetch the currently selected list item which
		' will be our next prisoner ;)
		dlist = GTK_LIST (gtklist)->selection
		If dlist Then
			new_prisoner = GTK_WIDGET (dlist->Data)
		Else
			new_prisoner = NULL
		End If

		' Look for already imprisoned list items, we
		' will put them back into the list.
		' Remember to free the doubly linked list that
		' gtk_container_children() returns
		dlist = gtk_container_children (GTK_CONTAINER (frame))
		free_list = dlist
		Do While (dlist) 
			Dim As GtkWidget Ptr list_item

			list_item = dlist->Data

			gtk_widget_reparent (list_item, gtklist)

			dlist = dlist->Next
		Loop
	
		g_list_free (free_list)
	
		' If we have a new prisoner, remove him from the
		' List and put him into the frame "Prison".
		' We need to unselect the item first.
		If (new_prisoner) Then
			Dim As GList static_dlist
	    
			static_dlist.data = new_prisoner
			static_dlist.next = NULL
			static_dlist.prev = NULL
	    
			gtk_list_unselect_child (GTK_LIST (gtklist), new_prisoner)
			gtk_widget_reparent (new_prisoner, frame)
		End If
	End If
End Sub


' This is the signal handler that gets called if List
' emits the "selection_changed" signal

Sub sigh_print_selection Cdecl ( Byval gtklist As GtkWidget Ptr, Byval func_data As gpointer )

	Dim As GList Ptr dlist

	' Fetch the doubly linked list of selected items
	' of the List, remember to treat this as read-only!

	dlist = GTK_LIST (gtklist)->selection
	
	' If there are no selected items there is nothing more
	' to do than just telling the user so

	If  dlist = NULL Then
		g_print (!"Selection cleared\n")
		Return
	End If
	
	' Ok, we got a selection and so we print it
	g_print ("The selection is a ")
    
	' Get the list item from the doubly linked list
	' and then query the data associated with list_item_data_key.
	' We then just print it */
	Do While (dlist) 
		Dim As Zstring Ptr  item_data_string

		item_data_string = g_object_get_data (G_OBJECT (dlist->Data), list_item_data_key)
		g_print("%s ", *item_data_string)
 	
		dlist = dlist->Next
	Loop
	g_print (!"\n")
End Sub

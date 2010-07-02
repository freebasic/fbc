' Colorsel.bas
' Translated from C to FB by TinyCla, 2006

#include once "gtk/gtk.bi"

#define NULL 0

Dim Shared As GtkWidget Ptr colorseldlg = NULL
Dim Shared As GtkWidget Ptr drawingarea = NULL
Dim Shared As GdkColor val_color

' Color changed handler 

Sub color_changed_cb Cdecl( Byval widget As GtkWidget Ptr, Byval colorsel As GtkColorSelection Ptr )

	Dim As GdkColor ncolor

	gtk_color_selection_get_current_color (colorsel, @ncolor)
	gtk_widget_modify_bg (drawingarea, GTK_STATE_NORMAL, @ncolor)
	
End Sub


' Drawingarea event handler 

Function area_event Cdecl( Byval widget As GtkWidget Ptr, Byval event As GdkEvent  Ptr, Byval client_data As gpointer ) As Integer

	Dim As Integer handled = FALSE
	Dim As Integer response
	Dim As GtkColorSelection Ptr colorsel

	' Check if we've received a button pressed event 

	If event->Type = GDK_BUTTON_PRESS Then
		handled = TRUE
	
		' Create color selection dialog 
		If colorseldlg = NULL Then
			colorseldlg = gtk_color_selection_dialog_new ("Select background color")
		End If
		
		' Get the ColorSelection widget 
		colorsel = GTK_COLOR_SELECTION (GTK_COLOR_SELECTION_DIALOG (colorseldlg)->colorsel)

		gtk_color_selection_set_previous_color (colorsel, @val_color)
		gtk_color_selection_set_current_color (colorsel, @val_color)
		gtk_color_selection_set_has_palette (colorsel, TRUE)

		' Connect to the "color_changed" signal, set the client-data to the colorsel widget 
		g_signal_connect (G_OBJECT (colorsel), "color_changed", G_CALLBACK (@color_changed_cb), colorsel)

		' Show the dialog 
		response = gtk_dialog_run (GTK_DIALOG (colorseldlg))

		If response = GTK_RESPONSE_OK Then
			gtk_color_selection_get_current_color (colorsel, @val_color)
		Else 
			gtk_widget_modify_bg (drawingarea, GTK_STATE_NORMAL, @val_color)
		End If

		gtk_widget_hide (colorseldlg)
	End If

	return handled
    
End Function

' Close down and exit handler

Function destroy_window Cdecl ( Byval widget As GtkWidget Ptr, Byval event As GdkEvent Ptr, Byval client_data As gpointer) As Integer

	gtk_main_quit ()
	return TRUE

End Function


' ==============================================
' Main
' ==============================================
	Dim As GtkWidget Ptr win
	
	' Initialize the toolkit, remove gtk-related commandline stuff 
	gtk_init (NULL, NULL)
	
	' Create toplevel window, set title and policies 
	win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
	gtk_window_set_title (GTK_WINDOW (win), "Color selection test")
	gtk_window_set_policy (GTK_WINDOW (win), TRUE, TRUE, TRUE)
	
	' Attach to the "delete" and "destroy" events so we can exit 
	g_signal_connect (GTK_OBJECT (win), "delete_event", GTK_SIGNAL_FUNC (@destroy_window), win)
	
	' Create drawingarea, set size and catch button events 
	drawingarea = gtk_drawing_area_new ()
	
	val_color.red = 0
	val_color.blue = 65535
	val_color.green = 0
	gtk_widget_modify_bg (drawingarea, GTK_STATE_NORMAL, @val_color)
	
	gtk_widget_set_size_request (GTK_WIDGET (drawingarea), 200, 200)
	
	gtk_widget_set_events (drawingarea, GDK_BUTTON_PRESS_MASK)
	
	g_signal_connect (GTK_OBJECT (drawingarea), "event",  GTK_SIGNAL_FUNC (@area_event), drawingarea)
	
	' Add drawingarea to window, then show them both 
	gtk_container_add (GTK_CONTAINER (win), drawingarea)
	
	gtk_widget_show (drawingarea)
	gtk_widget_show (win)
	
	' Enter the gtk main loop (this never returns) 
	gtk_main ()
	
	End 0

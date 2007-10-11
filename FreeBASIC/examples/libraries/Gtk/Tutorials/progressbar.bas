' ProgressBar.bas
' Translated from C to FB by TinyCla, 2006


#include once "gtk/gtk.bi"

#define NULL 0


Type ProgressData 
	win As GtkWidget Ptr
	pbar As GtkWidget Ptr
	pb_timer As gint
	activity_mode As gboolean
End Type

' Update the value of the progress bar so that we get
' some movement 
Function progress_timeout Cdecl( Byval user_data As gpointer ) As integer
    
	Dim As ProgressData Ptr pdata
	Dim As double new_val
  
	pdata = user_data  
	
	If  pdata->activity_mode Then
		gtk_progress_bar_pulse (GTK_PROGRESS_BAR (pdata->pbar))
	Else 
		' Calculate the value of the progress bar using the
		' value range set in the adjustment object 
		new_val = gtk_progress_bar_get_fraction (GTK_PROGRESS_BAR (pdata->pbar)) + 0.01
		If new_val > 1.0 Then
			new_val = 0.0
			' Set the new value 
			gtk_progress_bar_set_fraction (GTK_PROGRESS_BAR (pdata->pbar), new_val)
		End If
	End If
  
	' As this is a timeout function, return TRUE so that it
	' continues to get called 
	Return TRUE
    
End Function

' Callback that toggles the text display within the progress bar trough 
Sub toggle_show_text Cdecl( Byval widget As GtkWidget  Ptr, Byval pdata As ProgressData Ptr)
    
	Dim As Zstring Ptr text

	text = gtk_progress_bar_get_text (GTK_PROGRESS_BAR (pdata->pbar))
	If text Then
		gtk_progress_bar_set_text (GTK_PROGRESS_BAR (pdata->pbar), "")
	Else 
		gtk_progress_bar_set_text (GTK_PROGRESS_BAR (pdata->pbar), "some text")
	End If
    
End Sub

' Callback that toggles the activity mode of the progress bar 
Sub toggle_activity_mode Cdecl( Byval widget As GtkWidget Ptr, Byval pdata As ProgressData Ptr )
    
	pdata->activity_mode = Not pdata->activity_mode
	If pdata->activity_mode Then
		gtk_progress_bar_pulse (GTK_PROGRESS_BAR (pdata->pbar))
	Else
		gtk_progress_bar_set_fraction (GTK_PROGRESS_BAR (pdata->pbar), 0.0)
	End If
    
End Sub
 
' Callback that toggles the orientation of the progress bar 
Sub toggle_orientation Cdecl( Byval widget As GtkWidget Ptr, Byval pdata As ProgressData Ptr)
    
	Select Case (gtk_progress_bar_get_orientation (GTK_PROGRESS_BAR (pdata->pbar)))
		Case GTK_PROGRESS_LEFT_TO_RIGHT:
			gtk_progress_bar_set_orientation (GTK_PROGRESS_BAR (pdata->pbar),  GTK_PROGRESS_RIGHT_TO_LEFT)
		Case GTK_PROGRESS_RIGHT_TO_LEFT:
			gtk_progress_bar_set_orientation (GTK_PROGRESS_BAR (pdata->pbar), GTK_PROGRESS_LEFT_TO_RIGHT)
		Case Else
    End Select
        
End Sub
 
' Clean up allocated memory and remove the timer 
Sub destroy_progress Cdecl( Byval widget As GtkWidget Ptr, Byval pdata As ProgressData Ptr)
    
	gtk_timeout_remove (pdata->pb_timer)
	pdata->pb_timer = 0
	pdata->win = NULL
	g_free (pdata)
	gtk_main_quit ()
    
End Sub



' ==============================================
' Main
' ==============================================

	Dim As ProgressData Ptr pdata
	Dim As GtkWidget Ptr align
	Dim As GtkWidget Ptr separator
	Dim As GtkWidget Ptr table
	Dim As GtkWidget Ptr button
	Dim As GtkWidget Ptr check
	Dim As GtkWidget Ptr vbox
	Dim As Uinteger interval
	
	gtk_init (NULL, NULL)
	
	' Allocate memory for the data that is passed to the callbacks 
	pdata = g_malloc (Sizeof(ProgressData))
	
	pdata->win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
	gtk_window_set_resizable (GTK_WINDOW (pdata->win), TRUE)
	
	g_signal_connect (G_OBJECT (pdata->win), "destroy", G_CALLBACK (@destroy_progress), pdata)
	gtk_window_set_title (GTK_WINDOW (pdata->win), "GtkProgressBar")
	gtk_container_set_border_width (GTK_CONTAINER (pdata->win), 0)
	
	vbox = gtk_vbox_new (FALSE, 5)
	gtk_container_set_border_width (GTK_CONTAINER (vbox), 10)
	gtk_container_add (GTK_CONTAINER (pdata->win), vbox)
	gtk_widget_show (vbox)
	
	' Create a centering alignment object 
	align = gtk_alignment_new (0.5, 0.5, 0, 0)
	gtk_box_pack_start (GTK_BOX (vbox), align, FALSE, FALSE, 5)
	gtk_widget_show (align)
	
	' Create the GtkProgressBar
	pdata->pbar = gtk_progress_bar_new ()
	
	gtk_container_add (GTK_CONTAINER (align), pdata->pbar)
	gtk_widget_show (pdata->pbar)
	
	' Add a timer callback to update the value of the progress bar 
	interval = 100
	pdata->pb_timer = gtk_timeout_add (interval, cast(gpointer, @progress_timeout), pdata)
	
	separator = gtk_hseparator_new ()
	gtk_box_pack_start (GTK_BOX (vbox), separator, FALSE, FALSE, 0)
	gtk_widget_show (separator)
	
	' rows, columns, homogeneous 
	table = gtk_table_new (2, 3, FALSE)
	gtk_box_pack_start (GTK_BOX (vbox), table, FALSE, TRUE, 0)
	gtk_widget_show (table)
	
	' Add a check button to select displaying of the trough text 
	check = gtk_check_button_new_with_label ("Show text")
	gtk_table_attach (GTK_TABLE (table), check, 0, 1, 0, 1, GTK_EXPAND Or GTK_FILL, GTK_EXPAND Or GTK_FILL, 5, 5)
	g_signal_connect (G_OBJECT (check), "clicked", G_CALLBACK (@toggle_show_text), pdata)
	gtk_widget_show (check)
	
	' Add a check button to toggle activity mode 
	check = gtk_check_button_new_with_label ("Activity mode")
	gtk_table_attach (GTK_TABLE (table), check, 0, 1, 1, 2, GTK_EXPAND Or GTK_FILL, GTK_EXPAND Or GTK_FILL, 5, 5)
	g_signal_connect (G_OBJECT (check), "clicked", G_CALLBACK (@toggle_activity_mode), pdata)
	gtk_widget_show (check)
	
	' Add a check button to toggle orientation 
	check = gtk_check_button_new_with_label ("Right to Left")
	gtk_table_attach (GTK_TABLE (table), check, 0, 1, 2, 3, GTK_EXPAND Or GTK_FILL, GTK_EXPAND Or GTK_FILL, 5, 5)
	g_signal_connect (G_OBJECT (check), "clicked", G_CALLBACK (@toggle_orientation), pdata)
	gtk_widget_show (check)
	
	' Add a button to exit the program 
	button = gtk_button_new_with_label ("close")
	g_signal_connect_swapped (G_OBJECT (button), "clicked", G_CALLBACK (@destroy_progress), G_OBJECT (pdata->win))
	gtk_box_pack_start (GTK_BOX (vbox), button, FALSE, FALSE, 0)
	
	' This makes it so the button is the default. 
	GTK_WIDGET_SET_FLAGS (button, GTK_CAN_DEFAULT)
	
	' This grabs this button to be the default button. Simply hitting
	' the "Enter" key will cause this button to activate. 
	gtk_widget_grab_default (button)
	gtk_widget_show (button)
	
	gtk_widget_show (pdata->win)
	
	gtk_main ()

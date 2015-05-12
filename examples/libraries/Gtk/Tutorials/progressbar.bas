' ProgressBar.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#Include once "gtk/gtk.bi"

Type ProgressData
  As GtkWidget Ptr win
  As GtkWidget Ptr pbar
#IfDef __USE_GTK3__
  As GtkWidget Ptr perbut
#EndIf
  As GtkWidget Ptr infbut
  As guint pb_timer = 100
  As gboolean activity_mode
End Type

' Update the value of the progress bar so that we get
' some movement
Function progress_timeout Cdecl( Byval user_data As gpointer ) As gboolean

  Var pdata = Cast(ProgressData Ptr, user_data)
  Var pbar = GTK_PROGRESS_BAR (pdata->pbar)

  If  pdata->activity_mode Then
    gtk_progress_bar_pulse (pbar)
  Else
    ' Calculate the value of the progress bar using the
    ' value range set in the adjustment object
    Var new_val = gtk_progress_bar_get_fraction (pbar) + 0.01
    If new_val > 1.0 Then new_val = 0.0
    ' Set the new value
    gtk_progress_bar_set_fraction (pbar, new_val)
  End If

  ' As this is a timeout function, return TRUE so that it
  ' continues to get called
  Return TRUE

End Function

' Callback that toggles the text display within the progress bar trough
Sub toggle_show_text Cdecl( Byval widget As GtkWidget  Ptr, Byval pdata As ProgressData Ptr)

  Var pbar = GTK_PROGRESS_BAR (pdata->pbar)

#IFDEF __USE_GTK3__
  VAR show = IIF(gtk_progress_bar_get_show_text (pbar), 0, 1)
  gtk_progress_bar_set_show_text (pbar, show)
  gtk_widget_set_sensitive(pdata->perbut, show)
#ELSE
  Var text = gtk_progress_bar_get_text (pbar)
  If text Then
    gtk_progress_bar_set_text (pbar, NULL)
  Else
    gtk_progress_bar_set_text (pbar, "some text")
  End If
#ENDIF

End Sub

#IFDEF __USE_GTK3__
' Callback that toggles the text display within the progress bar trough
SUB toggle_show_percentage CDECL( BYVAL widget AS GtkWidget  PTR, BYVAL pdata AS ProgressData PTR)

  VAR pbar = GTK_PROGRESS_BAR (pdata->pbar)

  VAR text = gtk_progress_bar_get_text (pbar)
  IF text THEN
    gtk_progress_bar_set_text (pbar, NULL)
  ELSE
    gtk_progress_bar_set_text (pbar, "some text")
  END IF

END SUB
#ENDIF

' Callback that toggles the activity mode of the progress bar
Sub toggle_activity_mode Cdecl( Byval widget As GtkWidget Ptr, Byval pdata As ProgressData Ptr )

  pdata->activity_mode = Not pdata->activity_mode
  If pdata->activity_mode Then
    gtk_progress_bar_pulse (GTK_PROGRESS_BAR (pdata->pbar))
    gtk_widget_set_sensitive(pdata->infbut, FALSE)
  Else
    gtk_progress_bar_set_fraction (GTK_PROGRESS_BAR (pdata->pbar), 0.0)
    gtk_widget_set_sensitive(pdata->infbut, TRUE)
  End If

End Sub

' Callback that toggles the orientation of the progress bar
Sub toggle_orientation Cdecl( Byval widget As GtkWidget Ptr, Byval pdata As ProgressData Ptr)

  Var pbar = GTK_PROGRESS_BAR (pdata->pbar)

#IFDEF __USE_GTK3__
  VAR ori = IIF(gtk_progress_bar_get_inverted (pbar), 0, 1)
  gtk_progress_bar_set_inverted (pbar, ori)
#ELSE
  Select Case As Const gtk_progress_bar_get_orientation (pbar)
  Case GTK_PROGRESS_LEFT_TO_RIGHT:
    gtk_progress_bar_set_orientation (pbar,  GTK_PROGRESS_RIGHT_TO_LEFT)
  Case GTK_PROGRESS_RIGHT_TO_LEFT:
    gtk_progress_bar_set_orientation (pbar, GTK_PROGRESS_LEFT_TO_RIGHT)
  Case Else
  End Select
#ENDIF

End Sub



' ==============================================
' Main
' ==============================================

  gtk_init (NULL, NULL)

  ' Create the data that is passed to the callbacks
  Var pdata = New ProgressData

  pdata->win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
  gtk_window_set_resizable (GTK_WINDOW (pdata->win), TRUE)

  g_signal_connect (G_OBJECT (pdata->win), "delete-event", _
                    G_CALLBACK (@gtk_main_quit), pdata)
  gtk_window_set_title (GTK_WINDOW (pdata->win), "GtkProgressBar")
  gtk_container_set_border_width (GTK_CONTAINER (pdata->win), 0)

  Var vbox = gtk_vbox_new (FALSE, 5)
  gtk_container_set_border_width (GTK_CONTAINER (vbox), 10)
  gtk_container_add (GTK_CONTAINER (pdata->win), vbox)
  gtk_widget_show (vbox)

  ' Create a centering alignment object
  Var align = gtk_alignment_new (0.5, 0.5, 0, 0)
  gtk_box_pack_start (GTK_BOX (vbox), align, FALSE, FALSE, 5)
  gtk_widget_show (align)

  ' Create the GtkProgressBar
  pdata->pbar = gtk_progress_bar_new ()
  gtk_container_add (GTK_CONTAINER (align), pdata->pbar)
#IFDEF __USE_GTK3__
  gtk_progress_bar_set_show_text(GTK_PROGRESS_BAR(pdata->pbar), TRUE)
  gtk_progress_bar_set_text (GTK_PROGRESS_BAR(pdata->pbar), "some text")
  gtk_progress_bar_set_show_text (GTK_PROGRESS_BAR(pdata->pbar), FALSE)
#ENDIF
  gtk_widget_show (pdata->pbar)

  ' Add a timer callback to update the value of the progress bar
  pdata->pb_timer = g_timeout_add (pdata->pb_timer, @progress_timeout, pdata)

  Var separator = gtk_hseparator_new ()
  gtk_box_pack_start (GTK_BOX (vbox), separator, FALSE, FALSE, 5)
  gtk_widget_show (separator)

  ' Add a check button to select displaying of the trough text
  Var check = gtk_check_button_new_with_label ("Show text")
  gtk_box_pack_start (GTK_BOX (vbox), check, FALSE, FALSE, 0)
  g_signal_connect (G_OBJECT (check), "clicked", G_CALLBACK (@toggle_show_text), pdata)
  gtk_widget_show (check)

#IFDEF __USE_GTK3__
  ' Add a check button to select displaying of the percentage
  pdata->perbut = gtk_check_button_new_with_label ("Percentage")
  gtk_widget_set_sensitive(pdata->perbut, FALSE)
  gtk_box_pack_start (GTK_BOX (vbox), pdata->perbut, FALSE, FALSE, 0)
  g_signal_connect (G_OBJECT (pdata->perbut), "clicked", _
                    G_CALLBACK (@toggle_show_percentage), pdata)
  gtk_widget_show (pdata->perbut)
#ENDIF

  ' Add a check button to toggle activity mode
  check = gtk_check_button_new_with_label ("Activity mode")
  gtk_box_pack_start (GTK_BOX (vbox), check, FALSE, FALSE, 0)
  g_signal_connect (G_OBJECT (check), "clicked", _
                    G_CALLBACK (@toggle_activity_mode), pdata)
  gtk_widget_show (check)

  ' Add a check button to toggle orientation
  pdata->infbut = gtk_check_button_new_with_label ("Inverted")
  gtk_box_pack_start (GTK_BOX (vbox), pdata->infbut, FALSE, FALSE, 0)
  g_signal_connect (G_OBJECT (pdata->infbut), "clicked", _
                    G_CALLBACK (@toggle_orientation), pdata)
  gtk_widget_show (pdata->infbut)

  separator = gtk_hseparator_new ()
  gtk_box_pack_start (GTK_BOX (vbox), separator, FALSE, FALSE, 5)
  gtk_widget_show (separator)

  ' Add a button to exit the program
  Var button = gtk_button_new_with_label ("close")
  g_signal_connect_swapped (G_OBJECT (button), "clicked", _
                            G_CALLBACK (@gtk_main_quit), pdata)
  gtk_box_pack_start (GTK_BOX (vbox), button, FALSE, FALSE, 0)

  ' This makes it so the button is the default.
  gtk_widget_set_can_default (button, TRUE)

  ' This grabs this button to be the default button. Simply hitting
  ' the "Enter" key will cause this button to activate.
  gtk_widget_grab_default (button)
  gtk_widget_show (button)

  gtk_widget_show (pdata->win)

  gtk_main ()

  Delete (pdata)

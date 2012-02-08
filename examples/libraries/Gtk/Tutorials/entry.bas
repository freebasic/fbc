' Entry.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

Sub enter_callback cdecl( Byval widget As GtkWidget Ptr, Byval user_data As gpointer )

  VAR entry_text = gtk_entry_get_text (GTK_ENTRY (widget))
  g_print ( !"Entry contents:  %s\n", entry_text)

End Sub

Sub entry_toggle_editable cdecl( Byval widget As GtkWidget Ptr, Byval entry As GtkWidget Ptr )

  VAR active = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(widget))
  gtk_editable_set_editable (GTK_EDITABLE (entry), active)

End Sub

Sub entry_toggle_visibility cdecl( Byval widget As GtkWidget Ptr, Byval entry As GtkWidget Ptr )

  VAR active = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(widget))
  gtk_entry_set_visibility (GTK_ENTRY (entry), active)

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

  gtk_init (NULL, NULL)

  ' create a new window
  win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
  gtk_widget_set_size_request (GTK_WIDGET (win), 200, 100)
  gtk_window_set_title (GTK_WINDOW (win), "GTK Entry")
  g_signal_connect (G_OBJECT (win), "delete-event", _
                    G_CALLBACK (@gtk_main_quit), NULL)

  vbox = gtk_vbox_new (FALSE, 0)
  gtk_container_add (GTK_CONTAINER (win), vbox)
  gtk_widget_show (vbox)

  entry = gtk_entry_new ()
  gtk_entry_set_max_length (GTK_ENTRY (entry), 50)
  g_signal_connect (G_OBJECT (entry), "activate", _
                    G_CALLBACK (@enter_callback), NULL)
  VAR tpos = 0
  gtk_editable_insert_text (GTK_EDITABLE (entry), "hello ", -1, @tpos)
  VAR startpos = tpos
  gtk_editable_insert_text (GTK_EDITABLE (entry), "world", -1, @tpos)
  gtk_editable_select_region (GTK_EDITABLE (entry), startpos, tpos)
  gtk_box_pack_start (GTK_BOX (vbox), entry, TRUE, TRUE, 0)
  gtk_widget_show (entry)

  hbox = gtk_hbox_new (FALSE, 0)
  gtk_container_add (GTK_CONTAINER (vbox), hbox)
  gtk_widget_show (hbox)

  check = gtk_check_button_new_with_label ("Editable")
  gtk_box_pack_start (GTK_BOX (hbox), check, TRUE, TRUE, 0)
  g_signal_connect (G_OBJECT (check), "toggled", _
                    G_CALLBACK (@entry_toggle_editable), entry)
  gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (check), TRUE)
  gtk_widget_show (check)

  check = gtk_check_button_new_with_label ("Visible")
  gtk_box_pack_start (GTK_BOX (hbox), check, TRUE, TRUE, 0)
  g_signal_connect (G_OBJECT (check), "toggled", _
                    G_CALLBACK (@entry_toggle_visibility), entry)
  gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (check), TRUE)
  gtk_widget_show (check)

  button = gtk_button_new_from_stock (GTK_STOCK_CLOSE)
  g_signal_connect (G_OBJECT (button), "clicked", _
                    G_CALLBACK (@gtk_main_quit), NULL)
  gtk_box_pack_start (GTK_BOX (vbox), button, TRUE, TRUE, 0)
  gtk_widget_set_can_default (button, TRUE)
  gtk_widget_grab_default (button)
  gtk_widget_show (button)

  gtk_widget_show (win)

  gtk_main()

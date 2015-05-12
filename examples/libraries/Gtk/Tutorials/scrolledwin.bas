' Scrolledwin.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"


' ==============================================
' Main
' ==============================================

  Dim As GtkWidget Ptr win
  Dim As GtkWidget Ptr scrolled_window
  Dim As GtkWidget Ptr table
  Dim As GtkWidget Ptr button
  Dim As String buffer
  Dim As Integer i, j

  gtk_init (NULL, NULL)

  ' Create a new dialog window for the scrolled window to be
  ' packed into.
  win = gtk_dialog_new ()
  g_signal_connect (G_OBJECT (win), "delete-event", _
                    G_CALLBACK (@gtk_main_quit), NULL)
  gtk_window_set_title (GTK_WINDOW (win), "GtkScrolledWindow example")
  gtk_container_set_border_width (GTK_CONTAINER (win), 0)
  gtk_widget_set_size_request (win, 300, 300)

  ' create a new scrolled window.
  scrolled_window = gtk_scrolled_window_new (NULL, NULL)

  gtk_container_set_border_width (GTK_CONTAINER (scrolled_window), 10)

  ' the policy is one of GTK_POLICY AUTOMATIC, or GTK_POLICY_ALWAYS.
  ' GTK_POLICY_AUTOMATIC will automatically decide whether you need
  ' scrollbars, whereas GTK_POLICY_ALWAYS will always leave the scrollbars
  ' there.  The first one is the horizontal scrollbar, the second,
  ' the vertical.
  gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scrolled_window), GTK_POLICY_AUTOMATIC, GTK_POLICY_ALWAYS)

  ' The dialog window is created with a vbox packed into it.
  VAR box = gtk_dialog_get_content_area(GTK_DIALOG(win))
  gtk_box_pack_start (GTK_BOX (box), scrolled_window, TRUE, TRUE, 0)
  gtk_widget_show (scrolled_window)

  ' create a table of 10 by 10 squares.
  table = gtk_table_new (10, 10, FALSE)

  ' set the spacing to 10 on x and 10 on y
  gtk_table_set_row_spacings (GTK_TABLE (table), 10)
  gtk_table_set_col_spacings (GTK_TABLE (table), 10)

  ' pack the table into the scrolled window
  gtk_scrolled_window_add_with_viewport (GTK_SCROLLED_WINDOW (scrolled_window), table)
  gtk_widget_show (table)

  ' this simply creates a grid of toggle buttons on the table
  ' to demonstrate the scrolled window.
  For i = 0 To 9
    For j = 0 To 9
      buffer = "button (" + Str(i) + "," + Str(j) + !")\n"
      button = gtk_toggle_button_new_with_label (Strptr(buffer))
      gtk_table_attach_defaults (GTK_TABLE (table), button, i, i + 1, j, j + 1)
      gtk_widget_show (button)
    Next j
  Next i

  ' Add a "close" button to the bottom of the dialog
  button = gtk_button_new_with_label ("close")
  g_signal_connect (G_OBJECT (button), "clicked", _
                    G_CALLBACK(@gtk_main_quit), NULL)

  ' this makes it so the button is the default.
  gtk_widget_set_can_default (button, TRUE)
  box = gtk_dialog_get_action_area(GTK_DIALOG(win))
  gtk_box_pack_start (GTK_BOX (box), button, TRUE, TRUE, 0)

  ' This grabs this button to be the default button. Simply hitting
  ' the "Enter" key will cause this button to activate.
  gtk_widget_grab_default (button)
  gtk_widget_show (button)

  gtk_widget_show (win)

  gtk_main()

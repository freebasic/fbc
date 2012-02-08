' Text.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

Sub text_toggle_editable Cdecl (Byval checkbutton As GtkWidget Ptr, Byval text As GtkWidget Ptr)

  Var active = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON (checkbutton))
  gtk_text_view_set_editable (GTK_TEXT_VIEW (text), active)

End Sub

Sub text_toggle_word_wrap Cdecl(Byval checkbutton As GtkWidget Ptr, Byval text As GtkWidget Ptr)

  Var active = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON (checkbutton))
  gtk_text_view_set_wrap_mode (GTK_TEXT_VIEW (text), active)

End Sub


'
' ==============================================
' Main
' ==============================================

  gtk_init (NULL, NULL)

  Var win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
  gtk_widget_set_size_request (win, 500, 450)
  g_signal_connect (G_OBJECT (win), "destroy", _
                    G_CALLBACK (@gtk_main_quit), NULL)
  gtk_window_set_title (GTK_WINDOW (win), "Text Widget Example")
  gtk_container_set_border_width (GTK_CONTAINER (win), 0)

  Var box1 = gtk_vbox_new (FALSE, 0)
  gtk_container_add (GTK_CONTAINER (win), box1)
  gtk_widget_show (box1)

  Var box2 = gtk_vbox_new (FALSE, 10)
  gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
  gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
  gtk_widget_show (box2)

  ' Create the GtkText widget
  ' Create a new scrolled window, with scrollbars only if needed
  Var scroll = gtk_scrolled_window_new (NULL, NULL)
  gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scroll), _
                                  GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC)
  gtk_box_pack_start (GTK_BOX (box2), scroll, TRUE, TRUE, 0)
  gtk_widget_show (scroll)

  VAR text = gtk_text_view_new ()
  gtk_text_view_set_editable (GTK_TEXT_VIEW (text), TRUE)
  gtk_container_add (GTK_CONTAINER (scroll), text)
  gtk_widget_show (text)

  VAR panfo = pango_font_description_from_string("monospace 10")
  gtk_widget_modify_font(GTK_WIDGET(text), panfo)
  pango_font_description_free(panfo)

 ' define some text sytles / einige Textstile definieren
  Var buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW (text))
  gtk_text_buffer_create_tag(buffer, "big", _
                             "font", "Serif bold italic 32", NULL)
  gtk_text_buffer_create_tag(buffer, "color", _
                             "background", "grey", _
                             "foreground", "red", NULL)
  gtk_text_buffer_create_tag(buffer, "attr", _
                             "weight", PANGO_WEIGHT_BOLD, _
                             "underline", PANGO_UNDERLINE_DOUBLE, _
                             NULL)

  Dim AS GTKTextIter iter
  gtk_text_buffer_get_iter_at_offset(buffer, @Iter, 0)
  gtk_text_buffer_insert (buffer, @iter, "Supports text in different ", -1)
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, _
                         "fonts ", -1, "big", NULL)
  gtk_text_buffer_insert (buffer, @iter, !"and DragAndDrop\nand ", -1)
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, _
                         "attributes", -1, "attr", NULL)
  gtk_text_buffer_insert (buffer, @iter, " and ", -1)
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, _
                         "colors", -1, "color", NULL)
  gtk_text_buffer_insert (buffer, @iter, !" and ...\n\n\n", -1)

  ' Load the file text.bas into the text window
  Var inbuf = "", fnam = "textview.bas", infile = Freefile
  If Open (fnam For Input As #infile) Then
    inbuf = "Cannot open " & fnam & "!"
  Else
    inbuf = String(Lof(infile), 0)
    Get #infile, , inbuf
    Close #infile
  End If
  gtk_text_buffer_insert (buffer, @iter, inbuf, -1)

  Var hbox = gtk_hbutton_box_new ()
  gtk_box_pack_start (GTK_BOX (box2), hbox, FALSE, FALSE, 0)
  gtk_widget_show (hbox)

  Var check = gtk_check_button_new_with_label ("Editable")
  gtk_box_pack_start (GTK_BOX (hbox), check, FALSE, FALSE, 0)
  g_signal_connect (G_OBJECT (check), "toggled", G_CALLBACK (@text_toggle_editable), text)
  gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (check), TRUE)
  gtk_widget_show (check)
  check = gtk_check_button_new_with_label ("Wrap Words")
  gtk_box_pack_start (GTK_BOX (hbox), check, FALSE, TRUE, 0)
  g_signal_connect (G_OBJECT (check), "toggled", G_CALLBACK (@text_toggle_word_wrap), text)
  gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (check), FALSE)
  gtk_widget_show (check)

  Var separator = gtk_hseparator_new ()
  gtk_box_pack_start (GTK_BOX (box1), separator, FALSE, TRUE, 0)
  gtk_widget_show (separator)

  box2 = gtk_vbox_new (FALSE, 10)
  gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
  gtk_box_pack_start (GTK_BOX (box1), box2, FALSE, TRUE, 0)
  gtk_widget_show (box2)

  Var button = gtk_button_new_with_label ("close")
  g_signal_connect (G_OBJECT (button), "clicked", _
                    G_CALLBACK (@gtk_main_quit), NULL)
  gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0)
  gtk_widget_set_can_default(button, TRUE)
  gtk_widget_grab_default (button)
  gtk_widget_show (button)

  gtk_widget_show (win)

  gtk_main ()

  End 0

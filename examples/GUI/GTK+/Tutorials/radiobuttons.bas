' Radiobuttons.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

#define NULL 0


' ==============================================
' Main
' ==============================================

  Dim As GtkWidget Ptr win
  Dim As GtkWidget Ptr box1
  Dim As GtkWidget  Ptr box2
  Dim As GtkWidget Ptr button
  Dim As GtkWidget Ptr separator
  Dim As GSList Ptr group

  gtk_init (NULL, NULL)

  win = gtk_window_new (GTK_WINDOW_TOPLEVEL)

  g_signal_connect (G_OBJECT (win), "delete-event", _
                    G_CALLBACK (@gtk_main_quit), NULL)

  gtk_window_set_title (GTK_WINDOW (win), "radio buttons")
  gtk_container_set_border_width (GTK_CONTAINER (win), 0)

  box1 = gtk_vbox_new (FALSE, 0)
  gtk_container_add (GTK_CONTAINER (win), box1)
  gtk_widget_show (box1)

  box2 = gtk_vbox_new (FALSE, 10)
  gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
  gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0)
  gtk_widget_show (box2)

  button = gtk_radio_button_new_with_label (NULL, "button1")
  gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0)
  gtk_widget_show (button)

  group = gtk_radio_button_get_group (GTK_RADIO_BUTTON (button))
  button = gtk_radio_button_new_with_label (group, "button2")
  gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (button), TRUE)
  gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0)
  gtk_widget_show (button)

  button = gtk_radio_button_new_with_label_from_widget (GTK_RADIO_BUTTON (button), "button3")
  gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0)
  gtk_widget_show (button)

  separator = gtk_hseparator_new ()
  gtk_box_pack_start (GTK_BOX (box1), separator, FALSE, TRUE, 0)
  gtk_widget_show (separator)

  box2 = gtk_vbox_new (FALSE, 10)
  gtk_container_set_border_width (GTK_CONTAINER (box2), 10)
  gtk_box_pack_start (GTK_BOX (box1), box2, FALSE, TRUE, 0)
  gtk_widget_show (box2)

  button = gtk_button_new_with_label ("close")
  g_signal_connect (G_OBJECT (button), "clicked", _
                    G_CALLBACK (@gtk_main_quit), NULL)
  gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0)
  gtk_widget_set_can_default (button, TRUE)
  gtk_widget_grab_default (button)
  gtk_widget_show (button)
  gtk_widget_show (win)

  gtk_main ()


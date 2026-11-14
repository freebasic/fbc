''
'' GTK-4 components demo
''

#include "glib-object.bi"
#include "gtk/gtk4.bi"

Sub OnMessageDialogClicked (button as GtkButton Ptr, user_data as gpointer)
  Dim as GtkWindow Ptr parent_window = GTK_WINDOW(user_data)
  Dim as GtkAlertDialog Ptr dialog
  Static As Integer i = 1

  dialog = gtk_alert_dialog_new ("Gtk4 Alert Dialog %d", i)
  gtk_alert_dialog_set_detail (dialog, "This is an alert dialog showing over the parent")
  gtk_alert_dialog_show (dialog, parent_window)
  g_object_unref (dialog)
  i = i + 1

End Sub

Function GetLabel(Msg as String) as GtkWidget Ptr
  Dim as GtkWidget Ptr hbox = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 8)
  Dim as GtkWidget Ptr label = gtk_label_new(NULL)
  gtk_label_set_markup(GTK_LABEL(label), "<b>" & Msg & "</b>")
  gtk_box_append (GTK_BOX (hbox), label)

  Return hbox
End Function

Sub OnActivate ( app as GtkApplication Ptr, user_data as gpointer )
  Dim as GtkWidget Ptr grid, vbox
  Dim as GtkWidget Ptr textbox, dropdown, button, flowbox

  Dim as GtkWidget Ptr win = gtk_application_window_new (app)
  gtk_window_set_title (GTK_WINDOW (win), "Gtk4 Components")
  gtk_window_set_default_size (GTK_WINDOW (win), 300, 200)
  gtk_window_set_resizable (GTK_WINDOW (win), TRUE)

  vbox = gtk_box_new (GTK_ORIENTATION_VERTICAL, 0)
  gtk_widget_set_margin_start (vbox, 16)
  gtk_widget_set_margin_end (vbox, 16)
  gtk_widget_set_margin_top (vbox, 16)
  gtk_widget_set_margin_bottom (vbox, 16)
  grid = gtk_grid_new()
  gtk_grid_set_column_spacing(GTK_GRID(grid), 16)
  gtk_grid_set_row_spacing(GTK_GRID(grid), 16)
  gtk_box_append (GTK_BOX (vbox), grid)
  gtk_window_set_child (GTK_WINDOW (win), vbox)

  '' Text box
  vbox = gtk_box_new (GTK_ORIENTATION_VERTICAL, 8)
  gtk_grid_attach(GTK_GRID(grid), vbox, 0, 0, 1, 1)

  gtk_box_append (GTK_BOX (vbox), GetLabel("Text Box"))
  textbox = gtk_text_new ()
  gtk_text_set_placeholder_text(GTK_TEXT(textbox), "Enter some text...")
  gtk_widget_set_hexpand(textbox, TRUE)
  gtk_box_append (GTK_BOX (vbox), textbox)

  '' Dropdown boxes
  vbox = gtk_box_new (GTK_ORIENTATION_VERTICAL, 8)
  gtk_grid_attach(GTK_GRID(grid), vbox, 1, 0, 1, 1)

  gtk_box_append (GTK_BOX (vbox), GetLabel("DropDown"))
  Dim choices(0 to 3) As ZString Ptr => {@"First Choice", @"Second", @"Last", 0}
  dropdown = gtk_drop_down_new_from_strings (@choices(0))
  '' direct cast GtkWidget -> GtkDropDown when there is a missing GTK_* #define
  gtk_drop_down_set_show_arrow(Cast(GtkDropDown Ptr, dropdown), TRUE)
  gtk_widget_set_hexpand(dropdown, TRUE)
  gtk_box_append (GTK_BOX (vbox), dropdown)

  '' Alert dialog button
  vbox = gtk_box_new (GTK_ORIENTATION_VERTICAL, 8)
  gtk_grid_attach(GTK_GRID(grid), vbox, 0, 1, 1, 1)

  gtk_box_append (GTK_BOX (vbox), GetLabel("Alert Dialog"))
  button = gtk_button_new_with_mnemonic ("_Message Dialog")
  g_signal_connect (button, "clicked", G_CALLBACK (@OnMessageDialogClicked), win)
  gtk_box_append (GTK_BOX (vbox), button)

  '' Flow box
  vbox = gtk_box_new (GTK_ORIENTATION_VERTICAL, 8)
  gtk_grid_attach(GTK_GRID(grid), vbox, 1, 1, 1, 1)

  gtk_box_append (GTK_BOX (vbox), GetLabel("Flowbox"))
  flowbox = gtk_flow_box_new ()
  gtk_widget_set_valign (flowbox, GTK_ALIGN_START)
  gtk_flow_box_set_max_children_per_line (GTK_FLOW_BOX (flowbox), 2)
  gtk_flow_box_set_selection_mode (GTK_FLOW_BOX (flowbox), GTK_SELECTION_NONE)
  gtk_box_append (GTK_BOX (vbox), flowbox)
  For i as Integer = 1 To 6
    gtk_flow_box_insert (GTK_FLOW_BOX (flowbox), GetLabel(Str(i)), -1)
  Next

  gtk_window_present (GTK_WINDOW (win))

End Sub


Dim As GtkApplication Ptr app
Dim as Integer status

app = gtk_application_new ("freebasic.gtk4.dialogs", 0)
g_signal_connect (app, "activate", G_CALLBACK(@OnActivate), NULL)
status = g_application_run (G_APPLICATION (app), __FB_ARGC__, __FB_ARGV__)
g_object_unref (app)

End status

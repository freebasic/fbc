' GtkBuilder.bas
' GPLv3: Copyright by TJF, 2011
' (replacement for glade_gui.bas and glade-xml.bas)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#INCLUDE ONCE "gtk/gtk.bi"

' Note:
'  one source code, different GUIs. Choose one
'#DEFINE Ui_filename "GtkBuilder1.ui" ' simple 'Click me!' button
#DEFINE Ui_filename "GtkBuilder2.ui" ' complex UI with notebook
'  try tab 'Buttons' -> 'Hello' button (check console output)
'  try tab 'Listview' -> sort column by clicking on header
'                     -> reorder column by dragging with mouse

SUB on_ClickButton_clicked CDECL ALIAS "on_ClickButton_clicked" ( _
  BYVAL button AS GtkButton PTR, _
  BYVAL user_data AS gpointer) EXPORT

  g_message("ClickButton clicked!")

END SUB


gtk_init( NULL, NULL )

VAR xml = gtk_builder_new()
DIM AS GError PTR mess
IF 0 = gtk_builder_add_from_file(xml, Ui_filename, @mess) THEN
  ?"Fehler/Error (GTK-Builder):"
  ?*mess->message
  END 2
END IF

gtk_builder_connect_signals( xml, NULL )
gtk_main( )

g_object_unref( xml )

END 0

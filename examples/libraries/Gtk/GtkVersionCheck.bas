' GtkTest.bas
' GPLv3: Copyright by TJF, 2010 - 2011
' Details: http://developer.gnome.org/gtk/
' Note: mind the name mangling 'gtk_check_version_'

'#DEFINE __USE_GTK_OLD__
'#DEFINE __USE_GTK3__
#INCLUDE ONCE "gtk/gtk.bi"

#DEFINE NULL 0

DIM AS GtkWidget PTR win, frame, label
DIM AS         guint v1, v2, v3
DIM AS        STRING GtkVersion

?"This code is compiled using headers for GTK ";
?GTK_MAJOR_VERSION & "." & GTK_MINOR_VERSION & "." &  GTK_MICRO_VERSION

' Initialise GTK
IF gtk_init_check (@__FB_ARGC__, @__FB_ARGV__) THEN
  v1 =  4 : WHILE gtk_check_version_(v1, v2, v3) : v1 -= 1 : WEND
  v2 = 99 : WHILE gtk_check_version_(v1, v2, v3) : v2 -= 1 : WEND
  v3 = 44 : WHILE gtk_check_version_(v1, v2, v3) : v3 -= 1 : WEND
  GtkVersion = !"\n" & v1 & "." & v2 & "." & v3 & !"\n"
ELSE
  SCREENRES 300, 70
  ?!"\n\nGTK init failed!\n\nPress a key to finish."
  SLEEP
  END -1
END IF

win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
g_signal_connect(G_OBJECT(win), "destroy", _
                 G_CALLBACK(@gtk_main_quit), NULL)
g_signal_connect(G_OBJECT(win), "key-press-event", _
                 G_CALLBACK(@gtk_main_quit), NULL)

gtk_window_set_title (GTK_WINDOW (win), "GtkTest")
gtk_container_set_border_width (GTK_CONTAINER (win), 70)

frame = gtk_frame_new (" running version is ")
label = gtk_label_new (SADD(GtkVersion))
gtk_container_add (GTK_CONTAINER (frame), label)
gtk_container_add (GTK_CONTAINER (win), frame)

gtk_widget_show_all (win)

gtk_main ()
END 0

option explicit

#include once "gtk/gtk.bi"

'' by Danilo, 30th December 2004

Function btn1_Click(byval object as GtkObject ptr, byval user_data as gpointer)
  	
  	gtk_main_quit( )
  	
End Function

	Dim win1  as GtkWidget ptr
	Dim btn1  as GtkWidget ptr
	Dim btn1c as GtkWidget ptr
	
	gtk_init( 0, 0 )

	gdk_beep()

	win1 = gtk_window_new( GTK_WINDOW_TOPLEVEL )
  	gtk_window_set_title( win1, "Danilo's Test 001" )
  	gtk_widget_set_usize( win1, 640, 480 )
  	gtk_widget_set_uposition( win1, 200, 200 )
  	gtk_container_set_border_width( win1, 5 )
	
	btn1c = gtk_alignment_new( 0.1, 0.1, 0.05, 0.02 )

	btn1 = gtk_button_new_with_label( "QUIT" )
  	gtk_widget_set_usize( btn1, 100, 20 )
  	gtk_widget_set_uposition( btn1, 10, 10 )


	gtk_signal_connect( btn1, "clicked", @btn1_Click(), 0 )
	gtk_signal_connect( win1, "destroy", @btn1_Click(), 0 )

	gtk_container_add( btn1c, btn1 )
	gtk_container_add( win1, btn1c )

	gtk_widget_show( btn1c )
	gtk_widget_show( btn1 )
	gtk_widget_show( win1 )

	gtk_main( )

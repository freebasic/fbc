'' translated from an "C" example written by Vijay Kumar B.
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/


'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

#define NULL 0

'':::::
sub on_window_destroy cdecl (byval widget as GtkWidget ptr, byval userdata as gpointer)
  gtk_main_quit( )
end sub

'':::::
'' Callback for close button
sub on_button_clicked cdecl (byval button as GtkWidget ptr, byval buffer as GtkTextBuffer ptr)
  dim as GtkTextIter start, end_
  dim as gchar ptr text

  '' Obtain iters for the start and end of points of the buffer
  gtk_text_buffer_get_start_iter( buffer, @start )
  gtk_text_buffer_get_end_iter( buffer, @end_ )

  '' Get the entire buffer text.
  text = gtk_text_buffer_get_text( buffer, @start, @end_, FALSE )

  '' Print the text
  g_print( "%s", text )

  g_free( text )

  gtk_main_quit( )
end sub

'':::::
  dim as GtkWidget ptr win
  dim as GtkWidget ptr vbox
  dim as GtkWidget ptr text_view
  dim as GtkWidget ptr button
  dim as GtkTextBuffer ptr buffer

  gtk_init( NULL, NULL )

  '' Create a Window.
  win = gtk_window_new( GTK_WINDOW_TOPLEVEL )
  gtk_window_set_title( GTK_WINDOW( win ), "Simple Multiline Text Input" )

  '' Set a decent default size for the window.
  gtk_window_set_default_size( GTK_WINDOW( win ), 200, 200 )
  g_signal_connect( G_OBJECT( win ), "destroy", _
                    G_CALLBACK( @on_window_destroy ), _
                    NULL )

  vbox = gtk_vbox_new( FALSE, 2 )
  gtk_container_add( GTK_CONTAINER( win ), vbox )

  '' Create a multiline text widget.
  text_view = gtk_text_view_new( )
  gtk_box_pack_start( GTK_BOX( vbox ), text_view, 1, 1, 0 )

  '' Obtaining the buffer associated with the widget.
  buffer = gtk_text_view_get_buffer( GTK_TEXT_VIEW( text_view ) )
  '' Set the default buffer text.
  gtk_text_buffer_set_text( buffer, "Hello Text View!", -1 )

  '' Create a close button.
  button = gtk_button_new_with_label( "Close" )
  gtk_box_pack_start( GTK_BOX( vbox ), button, 0, 0, 0)
  g_signal_connect( G_OBJECT( button ), "clicked", _
                    G_CALLBACK( @on_button_clicked ), _
                    buffer )

  gtk_widget_show_all( win )

  gtk_main( )

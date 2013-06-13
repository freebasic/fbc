

#include "gtk/gtk.bi"
#include "glade/glade-xml.bi"

#ifndef NULL
#define NULL 0
#endif

''
'' call-backs
''
declare sub on_window1_destroy cdecl alias "on_window1_destroy" (byval object_ as GtkObject ptr, byval user_data as gpointer )
declare sub on_button1_clicked cdecl alias "on_button1_clicked" (byval object_ as GtkObject ptr, byval user_data as gpointer )

    dim xml as GladeXML ptr

    gtk_init( NULL, NULL )

    xml = glade_xml_new( "test.xml", NULL, NULL )

	dim toplevel as GtkWidget ptr

    toplevel = glade_xml_get_widget( xml, "window1" )
    gtk_widget_show_all( toplevel )
    g_signal_connect( toplevel, "delete-event", @gtk_main_quit, NULL )
    glade_xml_signal_autoconnect( xml )
    gtk_main( )

    g_object_unref( xml )

	end 0


'':::::
sub on_window1_destroy cdecl (byval object_ as GtkObject ptr, _
							  byval user_data as gpointer ) export
    gtk_main_quit()

end sub

'':::::
sub on_button1_clicked cdecl (byval object_ as GtkObject ptr, _
							  byval user_data as gpointer ) export

	gtk_main_quit()

end sub

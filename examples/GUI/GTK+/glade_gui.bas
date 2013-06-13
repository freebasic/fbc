 

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
dim toplevel as GtkWidget ptr 

gtk_init( NULL, NULL ) 

xml = glade_xml_new( "glade_gui.xml", NULL, NULL ) 


toplevel = glade_xml_get_widget( xml, "window" ) 
gtk_widget_show_all( toplevel ) 
glade_xml_signal_autoconnect( xml ) 
gtk_main( ) 

g_object_unref( xml ) 


end 0 


''::::: 
sub on_window1_destroy cdecl (byval object_ as GtkObject ptr, byval user_data as gpointer ) export 
    'Messagebox(0,"QUIT","MESSAGE",0) 
    gtk_main_quit () 'this is needed, otherwise the process is not destroyed by the os... 
end sub 

''::::: 
sub on_button1_clicked cdecl (byval object_ as GtkObject ptr, byval user_data as gpointer ) export 
    'Messagebox(0,"I'm here...","HELLO",0) 
end sub 

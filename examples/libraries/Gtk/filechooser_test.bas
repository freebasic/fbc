''
'' file chooser example
''
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

    dim as GtkWidget ptr dialog

    gtk_init( 0, NULL )

    dialog = gtk_file_chooser_dialog_new( "Choose File", _
                                          NULL, _
                                          GTK_FILE_CHOOSER_ACTION_OPEN, _
                                          GTK_STOCK_CANCEL, GTK_RESPONSE_CANCEL, _
                                          GTK_STOCK_OPEN, GTK_RESPONSE_ACCEPT, _
                                          NULL )

    if( gtk_dialog_run( GTK_DIALOG( dialog ) ) = GTK_RESPONSE_ACCEPT ) then
        dim as zstring ptr filename

        filename = gtk_file_chooser_get_filename( GTK_FILE_CHOOSER( dialog ) )
        print "File name: """; *filename; """"
        g_free( filename )
    end if

    gtk_widget_destroy( GTK_WIDGET(dialog) )

    end 0

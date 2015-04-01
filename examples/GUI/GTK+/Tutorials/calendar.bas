' Calendar.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

#DEFINE __FB_GTK3__
#include once "gtk/gtk.bi"

Sub show_date Cdecl (Byval obj As GObject Ptr, Byval user_data As gpointer )

    Dim As guint cal_year, cal_month, cal_day

    VAR cal1 = GTK_CALENDAR(user_data)
    gtk_calendar_get_date(cal1, @cal_year, @cal_month, @cal_day)

    Print cal_year & "/" ;
    Print RIGHT(STR(cal_month + 100), 2) & "/";
    Print RIGHT(STR(cal_day + 100), 2)

End Sub

Sub select_font Cdecl (Byval obj As GObject Ptr, Byval user_data As gpointer )

    VAR dialog = gtk_font_selection_dialog_new( "Font selection")

    If GTK_RESPONSE_OK = gtk_dialog_run(  GTK_DIALOG (dialog) ) Then

        VAR newFont = gtk_font_selection_dialog_get_font_name ( _
                      GTK_FONT_SELECTION_DIALOG (dialog))
        VAR font_desc = pango_font_description_from_string (newFont)
        g_free( newFont )
        If font_desc Then
            gtk_widget_modify_font (user_data, font_desc)
            pango_font_description_free( font_desc )
        End If

    End If

    gtk_widget_destroy( GTK_WIDGET(dialog) )

End Sub

''Main

    gtk_init( NULL, NULL )

    ''Imposta la finestra principale
    VAR win = gtk_window_new( GTK_WINDOW_TOPLEVEL )
    gtk_window_set_title( GTK_WINDOW( win ), "Calendar" )
    'gtk_widget_set_size_request( win, 400, 320 )
    'gtk_window_set_position( GTK_WINDOW( win ), GTK_WIN_POS_MOUSE )
    gtk_container_set_border_width( GTK_CONTAINER( win ), 10 )

    ''Imposta un pannello in cui inserire i controlli:
    VAR panel = gtk_vbox_new( 0, 10 )
    gtk_container_add( GTK_CONTAINER( win ), panel )
    gtk_widget_show( panel )

    VAR cal = gtk_calendar_new()
    g_signal_connect_swapped( G_OBJECT( cal ), "day-selected-double-click", _
                              G_CALLBACK(@show_date ), cal)
    gtk_container_add( GTK_CONTAINER( panel ), cal )
    gtk_widget_show( cal )

    VAR btnbox = gtk_hbox_new(0, 3)

    VAR btn1 = gtk_button_new_from_stock(GTK_STOCK_QUIT)
    g_signal_connect( G_OBJECT( btn1 ), "clicked",  _
                      G_CALLBACK( @gtk_main_quit ), NULL )
    gtk_container_add ( GTK_CONTAINER( btnbox ), btn1 )

    VAR btn2 = gtk_button_new_from_stock(GTK_STOCK_SELECT_FONT)
    g_signal_connect( G_OBJECT( btn2 ), "clicked", _
                      G_CALLBACK( @select_font ), cal )
    gtk_container_add( GTK_CONTAINER( btnbox ), btn2 )

    VAR btn3 = gtk_button_new_from_stock(GTK_STOCK_OK)
    g_signal_connect( G_OBJECT( btn3 ), "clicked", _
                      G_CALLBACK( @show_date ), cal )
    gtk_container_add( GTK_CONTAINER( btnbox ), btn3 )

    gtk_container_add( GTK_CONTAINER( panel ), btnbox )

    g_signal_connect( G_OBJECT( win ), "destroy", _
                      G_CALLBACK( @gtk_main_quit ), NULL )

    gtk_widget_show( btn1 )
    gtk_widget_show( btn2 )
    gtk_widget_show( btn3 )
    gtk_widget_show( btnbox )
    gtk_widget_show( panel )
    gtk_widget_show( win )

    gtk_main( )


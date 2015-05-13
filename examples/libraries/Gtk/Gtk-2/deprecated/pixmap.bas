' pixmap.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011), GdkPixmap is deprecated -> use CairoImageSurface instead
' Details: http://developer.gnome.org/gtk/

'#DEFINE __FB_GTK3__
#include once "gtk/gtk.bi"

' is invoked when the button is clicked.  It just prints a message.

Sub button_clicked Cdecl ( Byval widget As GtkWidget Ptr, Byval user_data As gpointer )

    Print "button clicked"

End Sub



' ==============================================
' Main
' ==============================================

    ' GtkWidget is the storage type for widgets
    Dim As GtkWidget Ptr win, pixmapwid, button
    Dim As GdkPixmap Ptr pixmap
    Dim As GdkBitmap Ptr mask
    Dim As GtkStyle Ptr style

    ' XPM data of Open-File icon
    Dim As Zstring Ptr xpm_data(20) => { _
    @"16 16 3 1", _
    @"       c None", _
    @".      c #000000000000", _
    @"X      c #FFFFFFFFFFFF", _
    @"                ", _
    @"   ......       ", _
    @"   .XXX.X.      ", _
    @"   .XXX.XX.     ", _
    @"   .XXX.XXX.    ", _
    @"   .XXX.....    ", _
    @"   .XXXXXXX.    ", _
    @"   .XXXXXXX.    ", _
    @"   .XXXXXXX.    ", _
    @"   .XXXXXXX.    ", _
    @"   .XXXXXXX.    ", _
    @"   .XXXXXXX.    ", _
    @"   .XXXXXXX.    ", _
    @"   .........    ", _
    @"                ", _
    @"                "}


    ' create the main window, and attach delete_event signal to terminating the application
    gtk_init (NULL, NULL)
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK (@gtk_main_quit), NULL)
    gtk_container_set_border_width (GTK_CONTAINER (win), 10)
    gtk_widget_show (win)

    ' now for the pixmap from gdk
    style = gtk_widget_get_style (win)
    pixmap = gdk_pixmap_create_from_xpm_d (win->Window,  @mask, @style->bg(GTK_STATE_NORMAL), cast(Zstring Ptr Ptr, @xpm_data(0)))

    ' a pixmap widget to contain the pixmap
    pixmapwid = gtk_pixmap_new (pixmap, mask)
    gtk_widget_show (pixmapwid)

    ' a button to contain the pixmap widget
    button = gtk_button_new ()
    gtk_container_add (GTK_CONTAINER (button), pixmapwid)
    gtk_container_add (GTK_CONTAINER (win), button)
    gtk_widget_show (button)

    g_signal_connect (G_OBJECT (button), "clicked", G_CALLBACK (@button_clicked), NULL)

    ' show the window
    gtk_main ()

' FB example (deprecated)
'
' Reviewed by TJF (2011), gdk_draw_rgb_image is deprecated -> use cairo instead
' Details: http://developer.gnome.org/gtk/

#include once "gtk/gtk.bi"

#define IMAGE_WIDTH  256
#define IMAGE_HEIGHT 256

dim shared rgbbuf(IMAGE_WIDTH * IMAGE_HEIGHT * 3) as byte

declare function on_darea_expose cdecl( byval widget as GtkWidget ptr, _
                                        byval event as GdkEventExpose ptr, _
                                        byval userdata as gpointer ) as gboolean

'' main

    dim as GtkWidget ptr win, drawarea
    dim as integer x, y, i

    '' initialize Gtk
    gtk_init( NULL, NULL )

    '' create a window
    win = gtk_window_new( GTK_WINDOW_TOPLEVEL )
    gtk_window_set_title( GTK_WINDOW(win), "RGB Test" )
    g_signal_connect( G_OBJECT(win), "delete_event", _
                      G_CALLBACK(@gtk_main_quit), NULL )

    '' create a drawable area on it
    drawarea = gtk_drawing_area_new( )
    gtk_widget_set_size_request( drawarea, IMAGE_WIDTH, IMAGE_HEIGHT )
    gtk_container_add( GTK_CONTAINER(win), drawarea )

    '' set the callback for when the window is redrawn
    g_signal_connect( G_OBJECT(drawarea), "expose-event", _
                      G_CALLBACK(@on_darea_expose), NULL )
    gtk_widget_show_all( win )

    '' create an 24-bit RGB image
    for y = 0 to IMAGE_HEIGHT-1
        for x = 0 to IMAGE_WIDTH-1
            rgbbuf(i)    = x - (x and 31)                   '' R
            rgbbuf(i+1) = (x \ 32) * 4 + y - (y and 31)     '' G
            rgbbuf(i+2) = y - (y and 31)                    '' B
            i += 3
        next
    next

    '' run..
    gtk_main()

    end

'':::::
function on_darea_expose cdecl( byval widget as GtkWidget ptr, _
                                byval event as GdkEventExpose ptr, _
                                byval userdata as gpointer) as gboolean

    '' draw the 24-bit RGB image (conversions are done automatically)
    gdk_draw_rgb_image( widget->window, _
                        widget->style->fg_gc(GTK_STATE_NORMAL), _
                        0, 0, IMAGE_WIDTH, IMAGE_HEIGHT, _
                        GDK_RGB_DITHER_MAX, @rgbbuf(0), IMAGE_WIDTH * 3 )

    '' return OK
    return TRUE

end function

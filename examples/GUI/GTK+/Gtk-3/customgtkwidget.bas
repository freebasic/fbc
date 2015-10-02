#include "customgtkwidget.bi"

type MyCustomWidgetPrivate
	imcontext as GtkIMContext ptr
	as double mousex, mousey
end type

'' MyCustomWidget extends GtkWidget
G_DEFINE_TYPE(MyCustomWidget, mycustomwidget, GTK_TYPE_WIDGET)

'' realize(): Allocate a GdkWindow for the widget, setup everything needed to
'' show the widget
private sub widget_realize(byval widget as GtkWidget ptr)
	dim allocation as GtkAllocation
	gtk_widget_get_allocation(widget, @allocation)

	dim attr as GdkWindowAttr
	attr.x = allocation.x
	attr.y = allocation.y
	attr.width = allocation.width
	attr.height = allocation.height
	attr.wclass = GDK_INPUT_OUTPUT
	attr.window_type = GDK_WINDOW_CHILD
	attr.event_mask = gtk_widget_get_events(widget) or _
		GDK_EXPOSURE_MASK or _
		GDK_BUTTON_PRESS_MASK or GDK_BUTTON_RELEASE_MASK or _
		GDK_POINTER_MOTION_MASK or _
		GDK_FOCUS_CHANGE_MASK or _
		GDK_KEY_PRESS_MASK or GDK_KEY_RELEASE_MASK

	var win = gdk_window_new(gtk_widget_get_parent_window(widget), _
	                         @attr, GDK_WA_X or GDK_WA_Y)
	gdk_window_set_user_data(win, widget)
	gtk_widget_set_window(widget, win)

	gtk_widget_set_realized(widget, CTRUE)
end sub

'' unrealize(): Deallocate the GdkWindow
private sub widget_unrealize(byval widget as GtkWidget ptr)
	var win = gtk_widget_get_window(widget)

	gtk_widget_set_window(widget, NULL)

	gdk_window_set_user_data(win, NULL)
	gdk_window_destroy(win)

	gtk_widget_set_realized(widget, FALSE)
end sub

'' dispose(): called 1st during GObject cleanup, may be called repeatedly, other
'' methods may be called after this. Unref GObject's from here, if any.
private sub widget_dispose(byval obj as GObject ptr)
	dim priv as MyCustomWidgetPrivate ptr = MY_CUSTOM_WIDGET(obj)->priv
	if priv->imcontext then
		g_object_unref(priv->imcontext)
		priv->imcontext = NULL
	end if
	G_OBJECT_CLASS(mycustomwidget_parent_class)->dispose(obj)
end sub

'' finalize(): called last during GObject cleanup
private sub widget_finalize(byval obj as GObject ptr)
	var widget = MY_CUSTOM_WIDGET(obj)

	'' Clean up private data
	if widget->priv then
		deallocate(widget->priv)
		widget->priv = NULL
	end if

	G_OBJECT_CLASS(mycustomwidget_parent_class)->finalize(obj)
end sub

private function widget_draw(byval widget as GtkWidget ptr, byval cr as cairo_t ptr) as gboolean
	dim priv as MyCustomWidgetPrivate ptr = MY_CUSTOM_WIDGET(widget)->priv

	var w = gtk_widget_get_allocated_width(widget)
	var h = gtk_widget_get_allocated_height(widget)

	cairo_set_line_width(cr, 1)

	cairo_set_source_rgb(cr, 1.0, 1.0, 1.0)
	cairo_rectangle(cr, 0, 0, w, h)
	cairo_fill(cr)

	cairo_set_source_rgb(cr, 1.0, 0.0, 0.0)
	const BoxWidth = 100
	cairo_rectangle(cr, priv->mousex - (BoxWidth \ 2) + 0.5, _
	                    priv->mousey - (BoxWidth \ 2) + 0.5, _
	                    BoxWidth - 1, BoxWidth - 1)
	cairo_stroke(cr)

	cairo_select_font_face(cr, "monospace", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
	cairo_set_font_size(cr, 13)
	cairo_move_to(cr, 100, 100)
	cairo_show_text(cr, "Hello world!")

	return CTRUE '' event was handled here, don't propagate to children
end function

private function widget_focus_in(byval widget as GtkWidget ptr, byval event as GdkEventFocus ptr) as gboolean
	return GTK_WIDGET_CLASS(mycustomwidget_parent_class)->focus_in_event(widget, event)
end function

private function widget_focus_out(byval widget as GtkWidget ptr, byval event as GdkEventFocus ptr) as gboolean
	return GTK_WIDGET_CLASS(mycustomwidget_parent_class)->focus_out_event(widget, event)
end function

private sub imcontext_commit(byval imcontext as GtkIMContext ptr, byval s as const zstring ptr, byval userdata as any ptr)
	print "typed text: <" + *s + ">"
end sub

private function widget_key_press(byval widget as GtkWidget ptr, byval event as GdkEventKey ptr) as gboolean
	dim priv as MyCustomWidgetPrivate ptr = MY_CUSTOM_WIDGET(widget)->priv

	if gtk_im_context_filter_keypress(priv->imcontext, event) then
		'' The input method context handled the key press (and possibly
		'' called the commit callback). Nothing more to do.
		return CTRUE '' we handled it, stop propagating
	end if

	select case event->keyval
	case GDK_KEY_Return
		print "pressed RETURN"
	end select

	return CTRUE '' we handled it, stop propagating
end function

private function widget_motion_notify(byval widget as GtkWidget ptr, byval event as GdkEventMotion ptr) as gboolean
	dim priv as MyCustomWidgetPrivate ptr = MY_CUSTOM_WIDGET(widget)->priv
	priv->mousex = event->x
	priv->mousey = event->y

	'' Trigger redraw - we want to update the box position
	gtk_widget_queue_draw(widget)

	return CTRUE
end function

'' Initialize the MyCustomWidget class
private sub mycustomwidget_class_init(byval klass as MyCustomWidgetClass ptr)
	'' Override GObject/GtkWidget methods

	var obj = G_OBJECT_CLASS(klass)
	obj->dispose = @widget_dispose
	obj->finalize = @widget_finalize

	var widget = GTK_WIDGET_CLASS(klass)
	widget->realize = @widget_realize
	widget->unrealize = @widget_unrealize
	widget->draw = @widget_draw
	widget->key_press_event = @widget_key_press
	widget->motion_notify_event = @widget_motion_notify
	widget->focus_in_event = @widget_focus_in
	widget->focus_out_event = @widget_focus_out
end sub

private sub mycustomwidget_init(byval widget as MyCustomWidget ptr)
	gtk_widget_set_has_window(GTK_WIDGET(widget), CTRUE)
	gtk_widget_set_can_focus(GTK_WIDGET(widget), CTRUE)

	var priv = new MyCustomWidgetPrivate
	priv->imcontext = gtk_im_multicontext_new()
	g_signal_connect(priv->imcontext, "commit", G_CALLBACK(@imcontext_commit), widget)

	widget->priv = priv
end sub

function mycustomwidget_new() as GtkWidget ptr
	return GTK_WIDGET(g_object_new(mycustomwidget_get_type(), NULL))
end function

''
'' Test application
''

gtk_init(@__FB_ARGC__, @__FB_ARGV__)

'' Main window
var win = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_title(GTK_WINDOW(win), "test")
gtk_widget_set_size_request(win, 600, 400)
g_signal_connect(win, "destroy", G_CALLBACK(@gtk_main_quit), NULL)

'' Add our custom widget to it
var mycustomwidget = mycustomwidget_new()
gtk_container_add(GTK_CONTAINER(win), mycustomwidget)

gtk_widget_show_all(win)
gtk_main()

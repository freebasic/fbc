#pragma once

#include "glib-object.bi"
#include "gtk/gtk3.bi"

extern "C"

type MyCustomWidget
	parent_instance as GtkWidget '' extends GtkWidget
	priv as any ptr '' Pointer to internal data structure
end type

type MyCustomWidgetClass
	parent_class as GtkWidgetClass '' extends GtkWidget
end type

#define MY_CUSTOM_WIDGET_TYPE mycustomwidget_get_type()
#define MY_CUSTOM_WIDGET(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), MY_CUSTOM_WIDGET_TYPE, MyCustomWidget)
#define MY_CUSTOM_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), MY_CUSTOM_WIDGET_TYPE, MyCustomWidgetClass)
#define IS_MYCUSTOMWIDGET(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), MY_CUSTOM_WIDGET_TYPE)
#define IS_MYCUSTOMWIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), MY_CUSTOM_WIDGET_TYPE)

declare function mycustomwidget_get_type() as GType
declare function mycustomwidget_new() as GtkWidget ptr

end extern

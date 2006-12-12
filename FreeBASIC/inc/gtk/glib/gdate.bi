''
''
'' gdate -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdate_bi__
#define __gdate_bi__

#include once "gquark.bi"

#ifndef tm
type tm as any
#endif

type GTime as gint32
type GDateYear as guint16
type GDateDay as guint8
type GDate as _GDate

enum GDateDMY
	G_DATE_DAY = 0
	G_DATE_MONTH = 1
	G_DATE_YEAR = 2
end enum


enum GDateWeekday
	G_DATE_BAD_WEEKDAY = 0
	G_DATE_MONDAY = 1
	G_DATE_TUESDAY = 2
	G_DATE_WEDNESDAY = 3
	G_DATE_THURSDAY = 4
	G_DATE_FRIDAY = 5
	G_DATE_SATURDAY = 6
	G_DATE_SUNDAY = 7
end enum


enum GDateMonth
	G_DATE_BAD_MONTH = 0
	G_DATE_JANUARY = 1
	G_DATE_FEBRUARY = 2
	G_DATE_MARCH = 3
	G_DATE_APRIL = 4
	G_DATE_MAY = 5
	G_DATE_JUNE = 6
	G_DATE_JULY = 7
	G_DATE_AUGUST = 8
	G_DATE_SEPTEMBER = 9
	G_DATE_OCTOBER = 10
	G_DATE_NOVEMBER = 11
	G_DATE_DECEMBER = 12
end enum


#define G_DATE_BAD_JULIAN 0U
#define G_DATE_BAD_DAY 0U
#define G_DATE_BAD_YEAR 0U

type _GDate
	julian_days as guint
	julian:1 as guint
	dmy:1 as guint
	day:6 as guint
	month:4 as guint
	year:16 as guint
end type

declare function g_date_new () as GDate ptr
declare function g_date_new_dmy (byval day as GDateDay, byval month as GDateMonth, byval year as GDateYear) as GDate ptr
declare function g_date_new_julian (byval julian_day as guint32) as GDate ptr
declare sub g_date_free (byval date as GDate ptr)
declare function g_date_valid (byval date as GDate ptr) as gboolean
declare function g_date_valid_day (byval day as GDateDay) as gboolean
declare function g_date_valid_month (byval month as GDateMonth) as gboolean
declare function g_date_valid_year (byval year as GDateYear) as gboolean
declare function g_date_valid_weekday (byval weekday as GDateWeekday) as gboolean
declare function g_date_valid_julian (byval julian_date as guint32) as gboolean
declare function g_date_valid_dmy (byval day as GDateDay, byval month as GDateMonth, byval year as GDateYear) as gboolean
declare function g_date_get_weekday (byval date as GDate ptr) as GDateWeekday
declare function g_date_get_month (byval date as GDate ptr) as GDateMonth
declare function g_date_get_year (byval date as GDate ptr) as GDateYear
declare function g_date_get_day (byval date as GDate ptr) as GDateDay
declare function g_date_get_julian (byval date as GDate ptr) as guint32
declare function g_date_get_day_of_year (byval date as GDate ptr) as guint
declare function g_date_get_monday_week_of_year (byval date as GDate ptr) as guint
declare function g_date_get_sunday_week_of_year (byval date as GDate ptr) as guint
declare function g_date_get_iso8601_week_of_year (byval date as GDate ptr) as guint
declare sub g_date_clear (byval date as GDate ptr, byval n_dates as guint)
declare sub g_date_set_parse (byval date as GDate ptr, byval str as zstring ptr)
declare sub g_date_set_time (byval date as GDate ptr, byval time_ as GTime)
declare sub g_date_set_month (byval date as GDate ptr, byval month as GDateMonth)
declare sub g_date_set_day (byval date as GDate ptr, byval day as GDateDay)
declare sub g_date_set_year (byval date as GDate ptr, byval year as GDateYear)
declare sub g_date_set_dmy (byval date as GDate ptr, byval day as GDateDay, byval month as GDateMonth, byval y as GDateYear)
declare sub g_date_set_julian (byval date as GDate ptr, byval julian_date as guint32)
declare function g_date_is_first_of_month (byval date as GDate ptr) as gboolean
declare function g_date_is_last_of_month (byval date as GDate ptr) as gboolean
declare sub g_date_add_days (byval date as GDate ptr, byval n_days as guint)
declare sub g_date_subtract_days (byval date as GDate ptr, byval n_days as guint)
declare sub g_date_add_months (byval date as GDate ptr, byval n_months as guint)
declare sub g_date_subtract_months (byval date as GDate ptr, byval n_months as guint)
declare sub g_date_add_years (byval date as GDate ptr, byval n_years as guint)
declare sub g_date_subtract_years (byval date as GDate ptr, byval n_years as guint)
declare function g_date_is_leap_year (byval year as GDateYear) as gboolean
declare function g_date_get_days_in_month (byval month as GDateMonth, byval year as GDateYear) as guint8
declare function g_date_get_monday_weeks_in_year (byval year as GDateYear) as guint8
declare function g_date_get_sunday_weeks_in_year (byval year as GDateYear) as guint8
declare function g_date_days_between (byval date1 as GDate ptr, byval date2 as GDate ptr) as gint
declare function g_date_compare (byval lhs as GDate ptr, byval rhs as GDate ptr) as gint
declare sub g_date_to_struct_tm (byval date as GDate ptr, byval tm as tm ptr)
declare sub g_date_clamp (byval date as GDate ptr, byval min_date as GDate ptr, byval max_date as GDate ptr)
declare sub g_date_order (byval date1 as GDate ptr, byval date2 as GDate ptr)
declare function g_date_strftime (byval s as zstring ptr, byval slen as gsize, byval format as zstring ptr, byval date as GDate ptr) as gsize

#define g_date_weekday g_date_get_weekday
#define g_date_month_ g_date_get_month
#define g_date_year_ g_date_get_year
#define g_date_day_ g_date_get_day
#define g_date_julian g_date_get_julian
#define g_date_day_of_year g_date_get_day_of_year
#define g_date_monday_week_of_year g_date_get_monday_week_of_year
#define g_date_sunday_week_of_year g_date_get_sunday_week_of_year
#define g_date_days_in_month g_date_get_days_in_month
#define g_date_monday_weeks_in_year g_date_get_monday_weeks_in_year
#define g_date_sunday_weeks_in_year	g_date_get_sunday_weeks_in_year

#endif

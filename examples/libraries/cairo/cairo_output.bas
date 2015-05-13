' This is file cairo_output.bas, an example for cairo library
' (C) 2011 by Thomas[ dot ]Freiherr[ at ]gmx{ dot }net
' License GPLv 3
'
' See for details
' http://www.freebasic.net/forum/viewtopic.php?p=163599&highlight=#163599
' http://cairographics.org/documentation/

#INCLUDE ONCE "cairo/cairo.bi"
#INCLUDE ONCE "cairo/cairo-pdf.bi"
#INCLUDE ONCE "cairo/cairo-ps.bi"
#INCLUDE ONCE "cairo/cairo-svg.bi"

'{612, 792},     /* PAGE_SIZE_LETTER */
'{612, 1008},    /* PAGE_SIZE_LEGAL */
'{841.89, 1199.551},    /* PAGE_SIZE_A3 */
'{595.276, 841.89},     /* PAGE_SIZE_A4 */
'{419.528, 595.276},     /* PAGE_SIZE_A5 */
'{708.661, 1000.63},     /* PAGE_SIZE_B4 */
'{498.898, 708.661},     /* PAGE_SIZE_B5 */
'{522, 756},     /* PAGE_SIZE_EXECUTIVE */
'{288, 432},     /* PAGE_SIZE_US4x6 */
'{288, 576},     /* PAGE_SIZE_US4x8 */
'{360, 504},     /* PAGE_SIZE_US5x7 */
'{297, 684}      /* PAGE_SIZE_COMM10 */

CONST Pag_W = 595.276, Pag_H = 841.89 '                        A4 format
CONST M_PI = 4 * ATN(1) '                                             Pi

TYPE arc_seg_data
  AS cairo_t PTR c_t
  AS DOUBLE xc, yc, ri, ra, a1, a2, fg, fb
END TYPE

' draw a colored circle segment / farbiges Kreissegment zeichnen
SUB arc_seg(BYVAL seg AS arc_seg_data PTR)
  VAR pa = NEW cairo_path_t
  WITH *seg
    cairo_arc_negative(.c_t, .xc, .yc, .ri, .a2, .a1)
    cairo_arc(.c_t, .xc, .yc, .ra, .a1, .a2)
    cairo_close_path(.c_t)
    pa = cairo_copy_path(.c_t)
    cairo_set_source_rgba(.c_t, 1, .fg, .fb, 0.9)
    cairo_fill(.c_t)
    cairo_append_path(.c_t, pa)
    cairo_set_source_rgb(.c_t, 0.0, 0.0, 0.0)
    cairo_stroke(.c_t)
  END WITH
  cairo_path_destroy(pa)
END SUB

' draw / zeichnen
SUB DoDrawing(BYVAL C AS cairo_surface_t PTR)
  VAR seg = NEW arc_seg_data, t = "Press a key to output PS, PDF and SVG."
  WITH *seg
    .c_t = cairo_create(C)
    cairo_set_source_rgb(.c_t, 1.0, 1.0, 1.0) '         white background
    cairo_paint(.c_t) '                                        fill page
    cairo_set_line_width(.c_t, 0.5)
    VAR f = 0.3 * Pag_W
    .xc = f
    .yc = f
    FOR z AS INTEGER = 0 TO 1 '                        two center points
      .ri = 0.1 * f
      FOR j AS INTEGER = 1 TO 5 STEP 1 '                     five radius
        .ra = .ri + 0.35 * f / j
        FOR i AS INTEGER = 0 TO 5 STEP 2 '                three segments
          .a1 = 60.0 * M_PI / 180 * i
          .a2 = 60.0 * M_PI / 180 * (i + 1)
          .fg = .ra / f
          .fb = .a1 / M_PI / 2
          arc_seg(seg)
        NEXT
        .ri = .ra
      NEXT
'      cairo_stroke(.c_t)

      .yc = Pag_H - f
      .xc = Pag_W - f
    NEXT
    cairo_set_font_size (.c_t, 0.15 * f)
    DIM AS cairo_font_extents_t fe '                         font data
    cairo_font_extents (.c_t, @fe)

    DIM AS cairo_text_extents_t te '                         text size
    cairo_text_extents (.c_t, t, @te)
    cairo_move_to (.c_t, _ '                 lower left corner of text
                   Pag_W / 2 - (te.width / 2 + te.x_bearing), _
                   Pag_H / 2 + (te.height / 2) - fe.descent)
    cairo_show_text(.c_t, t)
    cairo_show_page(.c_t)
    cairo_destroy(.c_t)
  END WITH
  cairo_surface_flush(C)
  cairo_surface_destroy(C)
END SUB

' screen output / Bildschirmausgabe
SUB write_screen()
  VAR S_W = CUINT(Pag_W) + 1, S_H = CUINT(Pag_H) + 1
  SCREENRES S_W, S_H, 32
  VAR c_s_t = cairo_image_surface_create_for_data( _
                SCREENPTR, CAIRO_FORMAT_ARGB32, _
                S_W, S_H, S_W * LEN(INTEGER))
  SCREENLOCK
  DoDrawing(c_s_t)
  SCREENUNLOCK
  SLEEP
END SUB

' file output / Schreibt eine Datei, pdf/svg/ps je nach Endung in fname
SUB write_file(BYREF fname AS STRING = "")
  DIM AS cairo_surface_t PTR c_s_t

  SELECT CASE LCASE(RIGHT(fname, 4))
  CASE ".pdf"
    c_s_t = cairo_pdf_surface_create(fname, Pag_W, Pag_H)
  CASE ".svg"
    c_s_t = cairo_svg_surface_create(fname, Pag_W, Pag_H)
  CASE ELSE
    c_s_t = cairo_ps_surface_create(fname, Pag_W, Pag_H)
  END SELECT
  DoDrawing(c_s_t)
END SUB


' main / Hauptprogramm
write_screen()

VAR f = "cairo_circle."
write_file(f & "pdf")
write_file(f & "ps")
write_file(f & "svg")
END 0

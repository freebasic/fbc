<?php
/***************************************************************************
 *							lang_admin_captcha.php (german)
 *                         ------------------------
 *   copyright            : (C) 2006 AmigaLink
 *   website              : www.amigalink.de
 *
 ***************************************************************************/ 

$lang['VC_Captcha_Config'] = 'CAPTCHA Konfiguration';
$lang['captcha_config_explain'] = 'Hier kannst du das Aussehen des Bildes bestimmen, das bei aktivierter Visuellen Bestätigung den Registrierungscode anzeigt.';
$lang['captcha_config_explain'] .= '<br />Bedenke bitte das die Lesbarkeit des Bestätigungs-Codes, extrem erschwert oder sogar unmöglich werden kann.';
$lang['VC_active'] = 'Visuelle Bestätigung ist aktiviert!';
$lang['VC_inactive'] = 'Visuelle Bestätigung ist nicht aktiviert!';
$lang['background_configs'] = 'Hintergrund';
$lang['Click_return_captcha_config'] = 'Klick %shier%s um zur CAPTCHA Konfiguartion zurückzukehren';

$lang['CAPTCHA_width'] = 'Breite des CAPTCHA';
$lang['CAPTCHA_height'] = 'Höhe des CAPTCHA';
$lang['background_color'] = 'Hintergrundfarbe';
$lang['background_color_explain'] = 'Angabe in Hexadezimaler schreibweise (z.B. #0000FF für Blau).';
$lang['pre_letters'] = 'Anzahl der Schattenzeichen';
$lang['pre_letters_explain'] = '';
$lang['great_pre_letters'] = 'Schattenzeichen vergrößern';
$lang['great_pre_letters_explain'] = '';
$lang['Random'] = 'Zufällig';
$lang['random_font_per_letter'] = 'Zufälliger Schriftsatz pro Zeichen';
$lang['random_font_per_letter_explain'] = 'Für jedes Zeichen wird ein anderer Schriftsatz benutzt.';

$lang['back_chess'] = 'Schachmuster';
$lang['back_chess_explain'] = 'Füllt den kompletten Hintergrund mit 16 Vierecken.';
$lang['back_ellipses'] = 'Ovale und Kreise';
$lang['back_arcs'] = 'Gebogene Linien';
$lang['back_lines'] = 'Linien';
$lang['back_image'] = 'Hintergrundbild';
$lang['back_image_explain'] = '(Diese Funktion ist derzeitig noch nicht integriert)';

$lang['foreground_lattice'] = 'Vordergrundgitter';
$lang['foreground_lattice_explain'] = '(breite x höhe)<br />Generiert ein Gitter über dem CAPTCHA';
$lang['foreground_lattice_color'] = 'Gitterfarbe';
$lang['foreground_lattice_color_explain'] = $lang['background_color_explain'];
$lang['gammacorrect'] = 'Kontrastkorrektur';
$lang['gammacorrect_explain'] = '(0 = aus)<br />ACHTUNG!!! Eine Änderungen des Wertes hat direkte auswirkung auf die Lesbarkeit des CAPTCHA!!';
$lang['generate_jpeg'] = 'Bildformat';
$lang['generate_jpeg_explain'] = 'Das JPEG Format hat eine höhere Kompression als PNG und kann, anhand der Qualitätseinstellung (max 95%), einen direkten einfluss auf die Lesbarkeit ausüben.';
$lang['generate_jpeg_quality'] = 'Qualität';

?>
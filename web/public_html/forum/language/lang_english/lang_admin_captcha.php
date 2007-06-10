<?php
/***************************************************************************
 *							lang_admin_captcha.php (english)
 *                         ------------------------
 *   copyright            : (C) 2006 AmigaLink
 *   website              : www.amigalink.de
 *
 ***************************************************************************/ 

$lang['VC_Captcha_Config'] = 'CAPTCHA Config';
$lang['captcha_config_explain'] = 'Here you can determine the appearance of the picture, which indicates the registration code on activated visual confirmation.';
$lang['VC_active'] = 'Visual Confirmation is activ!';
$lang['VC_inactive'] = 'Visual Confirmation is not activ!';
$lang['background_configs'] = 'Background';
$lang['Click_return_captcha_config'] = 'Click %sHere%s to return to CAPTCHA Configuration';

$lang['CAPTCHA_width'] = 'CAPTCHA width';
$lang['CAPTCHA_height'] = 'CAPTCHA height';
$lang['background_color'] = 'Backgroundcolor';
$lang['background_color_explain'] = 'Indication in hexadecimal (eg. #0000FF for blue).';
$lang['pre_letters'] = 'Number of shade letters';
$lang['pre_letters_explain'] = '';
$lang['great_pre_letters'] = 'Shade letter increase';
$lang['great_pre_letters_explain'] = '';
$lang['Random'] = 'Random';
$lang['random_font_per_letter'] = 'Random font per letter';
$lang['random_font_per_letter_explain'] = 'Each letter uses an random font.';

$lang['back_chess'] = 'Chess sample';
$lang['back_chess_explain'] = 'Fill the complete background with 16 rectangles.';
$lang['back_ellipses'] = 'Ellipses';
$lang['back_arcs'] = 'Curved lines';
$lang['back_lines'] = 'Lines';
$lang['back_image'] = 'Background image';
$lang['back_image_explain'] = '(This function is not integrated yet)';

$lang['foreground_lattice'] = 'Foreground lattice';
$lang['foreground_lattice_explain'] = '(width x height)<br />Generate a white lattice over the CAPTCHA';
$lang['foreground_lattice_color'] = 'Littice color';
$lang['foreground_lattice_color_explain'] = $lang['background_color_explain'];
$lang['gammacorrect'] = 'Contrast correction';
$lang['gammacorrect_explain'] = '(0 = off)<br />NOTE!!! Changes of the value hat direct effect on the legibility of the CAPTCHA!';
$lang['generate_jpeg'] = 'Imagetype';
$lang['generate_jpeg_explain'] = 'The JPEG format has a higher compression than png and has, through the quality attitude (max 95%), a direct influence on the legibility of the CAPTCHA.';
$lang['generate_jpeg_quality'] = 'Quality';
?>
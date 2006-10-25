<?php
/*
	"image" action

	Parameters:
		url		- URL of image to be embedded
		link		- target link for image (optional). Supports URL, WikiName links, InterWiki links etc.
		title		- title text displayed when mouse hovers above image
		class		- a class for the image
		alt         - an alt text

*/

$title="WikiImage";
$class="";
$alt="image";

if (is_array($vars))
{
    foreach ($vars as $param => $value)
    {
    	if ($param == 'src' and $vars['url'] == '') {$vars['url']=$value;}
    	if ($param == 'title') {$title=$this->htmlspecialchars_ent($vars['title']);}
    	if ($param == 'class') {$class=$this->htmlspecialchars_ent($vars['class']);}
    	if ($param == 'alt') {$alt=$this->htmlspecialchars_ent($vars['alt']);}
	}
}

$url = $this->cleanUrl(trim($vars['url']));

if( substr( $url, 0, 7 ) == '/images' )
{
	$url = $this->config['upload_path'] . '/' . $this->GetPageTag() . '/' . basename( $url );
}

$output = "<img class=\"".$class."\" src=\"".$url."\" alt=\"".$alt."\" title=\"".$title."\" />";


// link?
if ($link = $vars['link'])
{
	$output = $this->Link($link, "", $output, 1, 0, 0);
}

$output = $this->ReturnSafeHTML($output);
print($output);

?>
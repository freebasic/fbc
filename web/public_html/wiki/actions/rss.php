<?php

// Action usage:
// {{rss http://domain.com/feed.xml}} or {{rss url="http://domain.com/feed.xml" cachetime="30"}}

$max_items = 30; // set this to the maximum items the RSS action should ever display

$caching = true; // change this to false to disable caching
$rss_cache_path = "/tmp"; // set this to a writable directory to store the cache files in
$lowest_cache_time_allowed = "5"; // set this to the lowest caching time allowed

$rss_cache_time = (int)trim($vars['cachetime']);
if (!$rss_cache_time) {
	$rss_cache_time = 30; // set this for default cache time
} elseif ($rss_cache_time < $lowest_cache_time_allowed) {
	$rss_cache_time = $lowest_cache_time_allowed;
}
$rss_cache_file = ""; // initial value, no need to ever change

//Action configuration
$rss_path = $vars['url'];
if ((!$rss_path) && $wikka_vars) $rss_path = $wikka_vars;
$rss_path = $this->cleanUrl(trim($rss_path));

if (preg_match("/^(http|https):\/\/([^\\s\"<>]+)$/i", $rss_path))
{
	if ($caching) {
		// Create unique cache file name based on URL
		$rss_cache_file = md5($rss_path).".xml";
	}

	//Load the RSS Feed
	include_once('3rdparty/plugins/onyx-rss/onyx-rss.php');
	$rss =& new ONYX_RSS();
	$rss->setCachePath($rss_cache_path);
	$rss->parse($rss_path, $rss_cache_file, $rss_cache_time);
	$meta = $rss->getData(ONYX_META);

	//List the feed's items
	$cached_output = "<h3>".$meta['title']."</h3>";
	$cached_output .= "<ul>\n";
	while ($max_items > 0 && ($item = $rss->getNextItem()))
	{
		$cached_output .= "<li><a href=\"".$item['link']."\">".$item['title']."</a><br />\n";
		$cached_output .= $item['description']."</li>\n";
		$max_items = $max_items - 1;
	}
	$cached_output .= "</ul>\n";
	echo $this->ReturnSafeHTML($cached_output);
} else {
	echo "<span class='error'><em>Error: Invalid RSS syntax. <br /> Proper usage: {{rss http://domain.com/feed.xml}} or {{rss url=\"http://domain.com/feed.xml\"}}</em></span>";
}

?>
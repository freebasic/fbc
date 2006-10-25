<?php
header("Content-type: text/xml");

$xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
$xml .= "<rss version=\"2.0\">\n";
$xml .= "<channel>\n";
$xml .= "<title>".$this->GetConfigValue("wakka_name")." - ".$this->tag."</title>\n";
$xml .= "<link>".$this->GetConfigValue("base_url").$this->tag."</link>\n";
$xml .= "<description>History/revisions of ".$this->GetConfigValue("wakka_name")."/".$this->tag."</description>\n";
$xml .= "<language>en-us</language>\n";

if ($this->HasAccess("read"))
{
	// load revisions for this page
	if ($pages = $this->LoadRevisions($this->tag))
	{
		$max = 20;

		$c = 0;
		foreach ($pages as $page)
		{
			$c++;
			if (($c <= $max) || !$max)
			{
				$xml .= "<item>\n";
				$xml .= "<title>".$page["time"]."</title>\n";
				$xml .= "<link>".$this->Href("show", "", "time=").urlencode($page["time"])."</link>\n";
				$xml .= "<description>Edited by ".$page["user"]." - ".$page["note"]."</description>\n";
				$xml .= "\t<pubDate>".date("r",strtotime($page["time"]))."</pubDate>\n";
				$xml .= "</item>\n";
			}
		}
		$output .= "</table>".$this->FormClose()."\n";
	}
}
else
{
	$xml .= "<item>\n";
	$xml .= "<title>Error</title>\n";
	$xml .= "<link>".$this->Href("show")."</link>\n";
	$xml .= "<description>You're not allowed to access this information.</description>\n";
	$xml .= "</item>\n";
}

$xml .= "</channel>\n";
$xml .= "</rss>\n";

print($xml);

?>

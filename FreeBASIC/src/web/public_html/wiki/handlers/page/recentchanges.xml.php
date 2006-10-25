<?php
header("Content-type: text/xml");

$xml = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n";
$xml .= '<?xml-stylesheet href="' . $this->GetConfigValue("base_url") .'/css/xml.css" type="text/css"?' .">\n";
$xml .= "<rss version=\"0.92\">\n";
$xml .= "<channel>\n";
$xml .= "<title>".$this->GetConfigValue("wakka_name")." - ".$this->tag."</title>\n";
$xml .= "<link>".$this->GetConfigValue("base_url")."</link>\n";
$xml .= "<description>Recent changes of ".$this->GetConfigValue("wakka_name")."</description>\n";
$xml .= "<language>en-us</language>\n";

if ($pages = $this->LoadRecentlyChanged())
{
    $max = $this->GetConfigValue("xml_recent_changes");

    $c = 0;
    foreach ($pages as $page)
    {
        $c++;
        if (($c <= $max) || !$max)
        {
            $xml .= "<item>\n";
            $xml .= "<title>".$page["tag"]."</title>\n";
            $xml .= "<link>".$this->Href("show", $page["tag"], "time=".urlencode($page["time"]))."</link>\n";
			$xml .= "\t<description>".$page["time"]." by ".$page["user"].($page["note"] ? " - ".$page["note"] : "")."</description>\n";
			//$xml .= "\t<guid>".$page["id"]."</guid>";
			$xml .= "\t<pubDate>".date("r",strtotime($page["time"]))."</pubDate>\n";
            $xml .= "</item>\n";
        }
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
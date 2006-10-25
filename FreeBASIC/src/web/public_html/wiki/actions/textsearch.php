<?php echo $this->FormOpen("", "", "get") ?>
		Search for:&nbsp;
		<input name="phrase" size="35" value="<?php echo $this->htmlspecialchars_ent(stripslashes($_REQUEST["phrase"])) ?>" class="searchbox" /> <input type="submit" value="Search" />
<?php echo $this->FormClose(); ?>

<?php
if ($phrase = $_REQUEST["phrase"])
{
	$phrase = stripslashes($phrase); 
	$results = $this->FullTextSearch($phrase);
	print("<br />");
	$total_results = count($results);
	$match_str = $total_results <> 1 ? " matches" : " match";
	print("Search results: <strong>".$total_results.$match_str."</strong> for <strong>$phrase</strong><br /><br />\n");
	if ($results) 
	{
		foreach ($results as $i => $page)
		{
			print(($i+1).". ".$this->Link($page["tag"])."<br />\n");
		}
		$phrase = urlencode($phrase); 
		print("<br />Not sure which page to choose?<br />Try the <a href=\"".$this->href("", "TextSearchExpanded", "phrase=$phrase")."\">Expanded Text Search</a> which shows surrounding text.");
	}
}

if ($this->CheckMySQLVersion(4,00,01))
{	
	$search_tips = "<br /><br /><hr /><br /><strong>Search Tips:</strong><br /><br />"
		."<div class=\"indent\">apple banana</div>"
		."Find pages that contain at least one of the two words. <br />"
		."<br />"
		."<div class=\"indent\">+apple +juice</div>"
		."Find pages that contain both words. <br />"
		."<br />"
		."<div class=\"indent\">+apple -macintosh</div>"
		."Find pages that contain the word 'apple' but not 'macintosh'. <br />"
		."<br />"
		."<div class=\"indent\">apple*</div>"
		."Find pages that contain words such as apple, apples, applesauce, or applet. <br />"
		."<br />"
		."<div class=\"indent\">\"some words\"</div>"
		."Find pages that contain the exact phrase 'some words' (for example, pages that contain 'some words of wisdom' <br />"
		."but not 'some noise words'). <br />";

	print($search_tips);
}

?>
<div class="page">
<?php
if ($this->HasAccess("read")) {
	// load revisions for this page
	if ($pages = $this->LoadRevisions($this->tag))
	{
		$output .= $this->FormOpen("diff", "", "get");
		$output .= "<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">\n";
		$output .= "<tr>\n";
		$output .= "<td><input type=\"submit\" value=\"Show Differences\" /></td>";
		$output .= "<td><input value=\"1\" type=\"checkbox\" checked=\"checked\" name=\"fastdiff\"/>\n".$this->Format("Simple Diff")."</td>";
		$output .= "</tr>\n";
		$output .= "</table>\n";
		$output .= "<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">\n";
		if ($user = $this->GetUser())
		{
			$max = $user["revisioncount"];
		}
		else
		{
			$max = 20;
		}

		$c = 0;
		foreach ($pages as $page)
		{
			$c++;
			if (($c <= $max) || !$max)
			{
				if ($page["note"]) $note="[".$page["note"]."]"; else $note ="";
				$output .= "<tr>";
				$output .= "<td><input type=\"radio\" name=\"a\" value=\"".$page["id"]."\" ".($c == 1 ? "checked=\"checked\"" : "")." /></td>";
				$output .= "<td><input type=\"radio\" name=\"b\" value=\"".$page["id"]."\" ".($c == 2 ? "checked=\"checked\"" : "")." /></td>";
				$output .= "<td>&nbsp;<a href=\"".$this->Href("show","","time=").urlencode($page["time"])."\">".$page["time"]."</a></td>";
				$output .= "<td>&nbsp;by ".$this->Format($page["user"])." <span style=\"color:#888;font-size:smaller;\">$note</span></td>";
				$output .= "</tr>\n";
			}
		}
		$output .= "</table><br />\n";
		$output .= "<input type=\"button\" value=\"Return To Node / Cancel\" onclick=\"document.location='".$this->Href("")."';\" />\n";
		$output .= $this->FormClose()."\n";
	}
	print($output);
} else {
	print("<em>You aren't allowed to read this page.</em>");
}
?>
</div>

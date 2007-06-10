<?php

if ($comments = $this->LoadRecentlyCommented())
{
	$curday = "";
	foreach ($comments as $comment)
	{
		// day header
		list($day, $time) = explode(" ", $comment["time"]);
		if ($day != $curday)
		{
			$dateformatted = date("D, d M Y", strtotime($day));

			if ($curday) print("<br />\n");
			print("<strong>$dateformatted:</strong><br />\n");
			$curday = $day;
		}

		$timeformatted = date("H:i T", strtotime($comment["time"]));

		$max_preview_length = 122;
		$comment_preview = str_replace("<br />", "", $comment["comment"]);
		if (strlen($comment_preview) > $max_preview_length) {
			$comment_spillover_link = "<a href=\"".$this->href("", $comment["page_tag"], "show_comments=1")."#comment_".$comment["id"]."\" title=\"View comment\">[.... ]</a>";		
			$comment_preview = substr($comment_preview, 0, $max_preview_length).$comment_spillover_link;
		}
		$commentlink = "<a href=\"".$this->href("", $comment["page_tag"], "show_comments=1")."#comment_".$comment["id"]."\" title=\"View comment\">".$comment["page_tag"]."</a>";		
		
		$comment_by = $comment["user"];	
		if (!$this->LoadUser($comment_by)) $comment_by .= " (unregistered user)";

		// print entry
		print("&nbsp;&nbsp;&nbsp; $commentlink, comment by $comment_by: <br />\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>$comment_preview</em><br />\n");
	}
}
else
{
	print("<em>There are no recently commented pages.</em>");
}

?>
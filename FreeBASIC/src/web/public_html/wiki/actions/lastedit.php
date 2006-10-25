<?php

// Prints short infos on last edit
// Uses parameter: show
// 0 show user only
// 1 show user and notes
// 2 show user, notes, date
// 3 show user, notes, date and quickdiff link

// set default
if ($show == "") {$show="1";}

if ($this->method == "show") {
	$page = $this->page;
	$pagetag = $page["tag"];
	$user = ($this->LoadUser($page["user"]))? $this->Link($page["user"]) : "anonymous";

	if (!($show == 0)) {
		$note = ($page["note"])? ":<br/><span class=\"notes\">".$page["note"]."</span>" : "";
	}

	if ($show == 2 || $show == 3) {
		list($day, $time) = explode(" ", $page["time"]);
		$dateformatted = date("D, d M Y", strtotime($day));
		$timeformatted = date("H:i T", strtotime($page["time"]));
	}
	if ($show == 3) {
		$oldpage = $this->LoadSingle("SELECT * FROM ".$this->config["table_prefix"]."pages WHERE tag='".$this->GetPageTag()."' AND latest = 'N' ORDER BY time desc LIMIT 1");
		$newid = $page["id"];
		$oldid = $oldpage["id"];
		$difflink = " [<a title=\"Show differences from last version\" href=\"".$this->Href("diff", $pagetag, "a=".$page["id"]."&b=".$oldpage["id"]."&fastdiff=1")."\">diff</a>]";
	}
	$output = "<div class=\"lastedit\">Last edited by ".$user.$note."<br /> ".$dateformatted." ".$timeformatted.$difflink."</div>";
	print $output;
}
?>
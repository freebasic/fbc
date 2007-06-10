<?php


function setUriParameter($uri, $name, $value) {

	$BaseURI = $uri;
	$HasParams = FALSE;

	$querypos = strpos($uri, "?");
	if (is_integer($querypos)) {
		$HasParams = TRUE;

		$start = strpos($uri, $name . "=", $querypos);
		if (is_integer($start)) {
			$end = strpos($uri, "&", $start);
			if (is_integer($end)) {
				$BaseURI = substr($uri, 0, $start) . substr($uri, $end+1);
			} else {
				if ($start == $querypos+1) {
					$HasParams = FALSE;
				}
				$BaseURI = substr($uri, 0, $start-1);
			}
		}
	}
	if (is_null($value)) {
		return $BaseURI;
	} else {
		return $BaseURI . ( $HasParams ? "&" : "?") . $name . "=" . $value;
	}
}

?>
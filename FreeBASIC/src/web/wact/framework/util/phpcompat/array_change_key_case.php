<?php


define ('CASE_LOWER',1);
define ('CASE_UPPER',2);

function array_change_key_case($array, $changeCase = CASE_LOWER) {
	switch($changeCase) {
		case CASE_UPPER:
			$caseFunc = 'strtoupper';
		break;
		case CASE_LOWER:
		default:
			$caseFunc = 'strtolower';
		break;
	}
	$return = array();
	foreach($array as $key => $value) {
		$return[$caseFunc($key)] = $value;
	}
	return $return;
}
?>
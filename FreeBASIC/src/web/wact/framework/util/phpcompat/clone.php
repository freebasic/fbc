<?php

if (version_compare(phpversion(), '5', '>=')) {
	require WACT_ROOT . 'util/phpcompat/clone_php5.php';
} else {
	
	function clone_obj($object) {
		return $object;
	}
}
?>
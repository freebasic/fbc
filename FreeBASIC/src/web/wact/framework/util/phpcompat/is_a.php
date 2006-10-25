<?php


function is_a($object, $classname) {
	return ((strtolower($classname) == get_class($object))
		or (is_subclass_of($object, $classname)));
}
?>
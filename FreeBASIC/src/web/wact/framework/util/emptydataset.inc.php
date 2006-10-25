<?php


class EmptyDataSet  {


	function reset() {
	}

	function next() {
		return FALSE;
	}


    function &get($name) {
    }

    function set($name, $value) {
    }

    function remove($name) {
    }

    function removeAll() {
    }

    function import($property_list) {
	}

    function merge($property_list) {
    }

    function &export() {
		return array();
	}

    function isDataSource() {
        return TRUE;
    }

	function registerFilter(&$filter) {
	}

	function prepare() {
	}
}
?>
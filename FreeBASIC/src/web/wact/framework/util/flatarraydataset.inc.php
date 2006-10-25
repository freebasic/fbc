<?php



class FlatArrayDataSet {
    var $dataset;
    var $keyField;
    var $valueField;
    var $first;

    function FlatArrayDataSet($array, $key_field = "key", $value_field = "value") {
        $this->keyField = $key_field;
        $this->valueField = $value_field;
        $this->dataset =& $array;
    }

    function reset() {
        reset($this->dataset);
        $this->first = TRUE;
    }

    function next() {
        if ($this->first) {
            $this->first = FALSE;
            return current($this->dataset) !== FALSE;
        } else {
            return next($this->dataset) !== FALSE;
        }
    }

    function &get($name) {
        if ($name == $this->valueField) {
            return current($this->dataset);
        } else if ($name == $this->keyField) {
            return key($this->dataset);
        } else {
            return NULL;
        }
    }

}
?>

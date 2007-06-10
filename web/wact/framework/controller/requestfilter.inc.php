<?php


class RequestFilter {
    var $base;

    function RequestFilter(&$base) {
        $this->base =& $base;
    }

    function hasParameters() {
        return $this->base->hasParameters();
    }

    function hasParameter($name) {
        return $this->base->hasParameter($name);
    }

    function getParameter($name) {
        return $this->base->getParameter($name);
    }

    function hasPostProperty($name) {
        return $this->base->hasPostProperty($name);
    }

    function getPostProperty($name) {
        return $this->base->getPostProperty($name);
    }

    function exportPostProperties() {
        return $this->base->exportPostProperties();
    }

    function getMethod() {
        return $this->base->getMethod();
    }

    function getPathInfo() {
        return $this->base->getPathInfo();
    }
}

?>
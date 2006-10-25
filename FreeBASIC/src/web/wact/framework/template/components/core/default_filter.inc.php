<?php

function ApplyDefault($value, $default) {
    if (empty($value) && $value !== "0" && $value !== 0) {
        return $default;
    } else {
        return $value;
    }
}
?>
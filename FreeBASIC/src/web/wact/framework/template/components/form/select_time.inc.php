<?php


require_once WACT_ROOT . 'template/components/form/form.inc.php';
require_once 'select.inc.php';


class FormSelectTimeComponent extends FormComponent
{
    var $selectHour   = null;
    var $selectMinute = null;
    var $selectSecond = null;
    var $selectedTime = array();

    var $setDefaultSelection = false;
    var $asArray = false;
    var $groupName;

    
    function isVisible() {
        return true;
    }

	
	function setGroupName($name) {
	    $this->groupName = $name;
	}

    function setAsArray() {
        $this->asArray = $this->getAttribute('asArray');
    }

    
	function parseTime($time=null)
	{
        if (is_integer($time)) {
                        return array(
                'hour'   => date('H', $time),
		        'minute' => date('i', $time),
		        'second' => date('s', $time)
		    );
        }
        $len = (is_string($time)) ? strlen($time) : 0;
        if ($len == 14) {
                        return array(
		        'hour'   => (int)substr($time, 8, 2),
		        'minute' => (int)substr($time, 10, 2),
		        'second' => (int)substr($time, 12, 2),
		    );
        }

        if ($len == 19) {
                        return array(
		        'hour'   => (int)substr($time, 11, 2),
		        'minute' => (int)substr($time, 14, 2),
		        'second' => (int)substr($time, 17, 2),
		    );
        }
                if (empty($time)) {
            $time = 'now';
        }
        $time = strtotime($time);
        if (!is_numeric($time) || $time == -1) {
            $time = strtotime('now');
        }
        return array(
		    'hour'   => date('H', $time),
		    'minute' => date('i', $time),
		    'second' => date('s', $time)
        );
	}

    
    function prepareHour()
    {
        $this->selectHour  = new SelectSingleComponent();         $this->addChild($this->selectHour);

        $use24hours = ($this->hasAttribute('use24hours') ? $this->getAttribute('use24hours') : true);

        $hours = array();
        $end = ($use24hours ? 24 : 12);
        for ($i=1; $i<=$end; $i++) {
            $hours[sprintf('%02d', $i)] = sprintf('%02d', $i);
        }
        $this->selectHour->setChoices($hours);
        if ($this->setDefaultSelection) {
            $this->selectHour->setSelection(($this->selectedTime['hour'] % $end));
        }

                $FormComponent = &$this->findParentByClass('FormComponent');
        if ($h = $FormComponent->_getValue($this->groupName.'_Hour')) {
            $this->selectHour->setSelection($h);
        }
        if ($date = $FormComponent->_getValue($this->groupName)) {
            if (is_array($date) && array_key_exists('Hour', $date)) {
                $this->selectHour->setSelection($date['Hour']);
            } else {
                $this->selectedTime = $this->parseTime($date);
                $this->selectHour->setSelection($this->selectedTime['hour']);
            }
        }
    }

	
    function prepareMinute()
    {

        $this->selectMinute = new SelectSingleComponent();         $this->addChild($this->selectMinute);

        $minutes = array();
        for ($i=1; $i<=60; $i++) {
            $minutes[sprintf('%02d', $i)] = sprintf('%02d', $i);
        }
        $this->selectMinute->setChoices($minutes);
        if ($this->setDefaultSelection) {
            $this->selectMinute->setSelection($this->selectedTime['minute']);
        }

                $FormComponent = &$this->findParentByClass('FormComponent');
        if ($m = $FormComponent->_getValue($this->groupName.'_Minute')) {
            $this->selectMinute->setSelection($m);
        }
        if ($date = $FormComponent->_getValue($this->groupName)) {
            if (is_array($date) && array_key_exists('Minute', $date)) {
                $this->selectMinute->setSelection($date['Minute']);
            } else {
                $this->selectedTime = $this->parseTime($date);
                $this->selectMinute->setSelection($this->selectedTime['minute']);
            }
        }
    }

    
    function prepareSecond()
    {
        $this->selectSecond = new SelectSingleComponent();         $this->addChild($this->selectSecond);

        $seconds = array();
        for ($i=1; $i<=60; $i++) {
            $seconds[sprintf('%02d', $i)] = sprintf('%02d', $i);
        }
        $this->selectSecond->setChoices($seconds);
        if ($this->setDefaultSelection) {
            $this->selectSecond->setSelection($this->selectedTime['second']);
        }

                $FormComponent = &$this->findParentByClass('FormComponent');
        if ($s = $FormComponent->_getValue($this->groupName.'_Second')) {
            $this->selectSecond->setSelection($s);
        }
        if ($date = $FormComponent->_getValue($this->groupName)) {
            if (is_array($date) && array_key_exists('Second', $date)) {
                $this->selectSecond->setSelection($date['Second']);
            } else {
                $this->selectedTime = $this->parseTime($date);
                $this->selectSecond->setSelection($this->selectedTime['second']);
            }
        }
    }

    
    function setSelection($time=null) {
        if (is_null($time)) {
            $time = time();
        }
        $this->selectedTime = $this->parseTime($time);
        $this->setDefaultSelection = true;
    }

    
	function & getHour() {
		return $this->selectHour;
	}

	
	function & getMinute() {
		return $this->selectMinute;
	}

	
	function & getSecond() {
		return $this->selectSecond;
	}
}
?>

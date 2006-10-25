<?php


require_once WACT_ROOT . 'validation/rule.inc.php';


class FileUploadRequiredRule extends SingleFieldRule {
    
    function FileUploadRequiredRule($fieldname) {
        parent :: SingleFieldRule($fieldname);
    }
    
    function validate(&$DataSource, &$ErrorList) {
        $value = $DataSource->get($this->fieldname);

        if (empty($value['name'])) {
            $ErrorList->addError($this->Group, 'MISSING', 
                                 array('Field' => $this->fieldname));
            
            $DataSource->set($this->fieldname, '');
            return FALSE;
        }
        return TRUE;
    }
}


class FileUploadPartialRule extends SingleFieldRule {
    
    function FileUploadPartialRule($fieldname) {
        parent :: SingleFieldRule($fieldname);
    }
    
    function Check($value) {
        if (version_compare(phpversion(), '4.2.0', '>=')) {
            if ($value['error'] == UPLOAD_ERR_PARTIAL) {
                $this->Error('FILEUPLOAD_PARTIAL');
            }
        }
    }
}


class FileUploadMaxSizeRule extends SingleFieldRule {
    var $maxsize;
    
	
	function FileUploadMaxSizeRule($fieldname, $maxsize = NULL) {
		parent :: SingleFieldRule($fieldname);
        $this->maxsize = $maxsize;
	}

    
    function Check($value) {
        if (! is_null($this->maxsize) &&
            $value['size'] > (int) $this->maxsize) {
            $this->Error('FILEUPLOAD_MAX_USER_SIZE',
                         array('maxsize' =>
                               $this->_sizeToHuman($this->maxsize)));
            return;
        }

        if (version_compare(phpversion(), '4.2.0', '>=') &&
            ($value['error'] == UPLOAD_ERR_INI_SIZE ||
             $value['error'] == UPLOAD_ERR_FORM_SIZE)) {
            $this->Error('FILEUPLOAD_MAX_SIZE');
        }
    }

    
    function _sizeToHuman($filesize = 0) {
        if ($filesize < 1024) {
            $size = $filesize . "B";
        } else if ($filesize >= 1024 &&
            $filesize < 1048576) {
            $size = sprintf("%.2fKB", $filesize / 1024);
        } else {
            $size = sprintf("%.2fMB", $filesize / 1048576);
        }
        return $size;        
    }
}


class FileUploadMimeTypeRule extends SingleFieldRule {
    var $mimetypes = array();

	
	function FileUploadMimeTypeRule($fieldname, $mimetypes = array()) {
		parent :: SingleFieldRule($fieldname);
        if (is_array($mimetypes)) {
            $this->mimetypes = $mimetypes;
        }
	}

	
    function Check($value) {
        if (! empty($value['type']) &&
            ! in_array($value['type'], $this->mimetypes)) {
            $this->Error('FILEUPLOAD_MIMETYPE',
                         array('mimetypes' => implode(', ', $this->mimetypes)));
        }
	}
}
?>
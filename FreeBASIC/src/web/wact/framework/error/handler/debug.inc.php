<?php

require_once WACT_ROOT . 'error/error.inc.php';

require_once WACT_ROOT . 'template/template.inc.php';

$GLOBALS['CurrentErrorObject'] = NULL;

function HandleError($ErrorNumber, $ErrorMessage, $FileName, $LineNumber) {
		if ($ErrorNumber & E_USER_ERROR) {
		HandleFrameworkError($ErrorMessage);
	} else {
		HandleGeneralError($ErrorNumber, $ErrorMessage, $FileName, $LineNumber);
	}
}


function HandleFrameworkError($ErrorMessage) {
	$Error = @unserialize($ErrorMessage);
	if (is_object($Error)) {
		$GLOBALS['CurrentErrorObject'] =& $Error;

		if ( !defined('WACT_ERROR_CONTINUE') ) {
			$OldHandler = set_error_handler('BareBonesErrorHandler');
		}

		$Group = $Error->group;
		$MessageList = importVarFile("/errormessages/$Group.vars");
		$ErrorMessage = $MessageList[$Error->id];

		if ( defined('WACT_ERROR_CONTINUE') ) {
			$OldHandler = set_error_handler('BareBonesErrorHandler');
		}

		foreach($Error->info as $key => $replacement) {
			$ErrorMessage = str_replace('{' . $key . '}', $replacement, $ErrorMessage);
		}

		echo "<br><hr>\n";
		echo "<h3>Error:</h3>$ErrorMessage\n";
		echo "<br><hr>\n";

        echo "<ul>";
        DisplayTraceBack();
        echo "</ul>";

		if ( !defined('WACT_ERROR_CONTINUE') ) {
			exit;
		}
	} else {
	    	    echo "Could not unserialize object for framework error<BR>";
	    echo "Probably because message string exceeded 1023 byte charater limit<BR>";

        echo "<ul>";
        DisplayTraceBack();
        echo "</ul>";

	    exit;
	    	}
}

function DisplayTraceBack() {
		if (version_compare(PHPVERSION(), '4.3', '>=')) {
		$Trace = debug_backtrace();

		foreach ($Trace as $line) {

		    if (in_array($line['function'], array(
		        'raiseerror', 'raiseerrorhandler', 'trigger_error', 'errorhandlerdispatch',
		        'handleerror', 'handleframeworkerror', 'displaytraceback' ))) {
		        continue;
		    }

			echo '<li>';
			echo '<font face="Courier New,Courier"><B>';
			if (isset($line['class'])) {
				echo $line['class'];
				echo ".";
			}
			echo $line['function'];
			echo "(";
			if (isset($line['args'])) {
				$sep = '';
				foreach ($line['args'] as $arg) {
					echo $sep;
					$sep = ', ';

					if (is_null($arg)) {
						echo 'NULL';
					} else if (is_array($arg)) {
						echo 'ARRAY[' . sizeof($arg) . ']';
					} else if (is_object($arg)) {
						echo 'OBJECT:' . get_class($arg);
					} else if (is_bool($arg)) {
						echo $arg ? 'TRUE' : 'FALSE';
					} else {
						echo '"';
						echo htmlspecialchars((string) @$arg);
					}
				}
			}
			echo ")";
			echo "</b><br>\n";
			if (isset($line['file'])) {
                echo $line['file'];
                echo " line <b>";
                echo $line['line'];
                echo '</b></font>';
			}
		}
	}
}


function HandleGeneralError($ErrorNumber, $ErrorMessage, $FileName, $LineNumber) {
	$ErrorTime = date("Y-m-d H:i:s (T)");

				$ErrorType = array (
				1   =>  "Error",
				2   =>  "Warning",
				4   =>  "Parsing Error",
				8   =>  "Notice",
				16  =>  "Core Error",
				32  =>  "Core Warning",
				64  =>  "Compile Error",
				128 =>  "Compile Warning",
				256 =>  "User Error",
				512 =>  "User Warning",
				1024=>  "User Notice"
				);

	if ($ErrorNumber & (E_NOTICE | E_USER_NOTICE)) {
		$Level = 'NOTICE';
	} else if ($ErrorNumber & (E_WARNING | E_USER_WARNING | E_CORE_WARNING | E_COMPILE_WARNING)) {
		$Level = 'WARNING';
	} else if ($ErrorNumber & (E_ERROR | E_PARSE | E_CORE_ERROR | E_COMPILE_ERROR | E_USER_ERROR)) {
		$Level = 'ERROR';
	} else {
		$Level = 'Unknown';
	}

	echo "<br><hr>\n";
	echo "<h3>$Level:</h3>$ErrorMessage\n";
	echo "<ul><li>";
	echo '<font face="Courier New,Courier">';
	echo "$FileName line $LineNumber\n";

	//DisplayTraceBack();

	echo "</ul>";
	echo "<hr>\n";
	if ( !defined('WACT_ERROR_CONTINUE') ) {
		exit;
	}
}


function BareBonesErrorHandler($ErrorNumber, $ErrorMessage, $FileName, $LineNumber) {
	$Error =& $GLOBALS['CurrentErrorObject'];

	$filename = WACT_ROOT . 'default/errormessages/' . $Error->group . '.vars';

    $MessageList = array();

	if (FALSE !== ($RawLines = file($filename)) ) {
		while (list(,$Line) = each($RawLines)) {
			$EqualPos = strpos($Line, '=');
			if ($EqualPos === FALSE) {
				$MessageList[trim($Line)] = NULL;
			} else {
				$Key = trim(substr($Line, 0, $EqualPos));
				if (strlen($Key) > 0) {
					$MessageList[$Key] = trim(substr($Line, $EqualPos+1));
				}
			}
		}

		$ErrorMessage = $MessageList[$Error->id];
	} else {
		$ErrorMessage = "An resolvable WACT framework error occured.
							<br>Group: {$Error->group}
							<br>ID: {$Error->id}
							<br>Info: {$Error->info}
							<br>File: $FileName
							<br>Line: $LineNumber";
	}

	foreach($Error->info as $key => $replacement) {
		$ErrorMessage = str_replace('{' . $key . '}', $replacement, $ErrorMessage);
	}

	DisplayTraceBack();

	echo "<br><hr>\n";
	echo "<h3>Error:</h3>$ErrorMessage\n";
	if ( !defined('WACT_ERROR_CONTINUE') ) {
		exit;
	}
}
?>
# procedure

set application/config/config.php
set application/config/database.php

idem for development/


index.php
=> set ENVIRONMENT urls



# common troubleshoot :

application/config/database.php
	'dbdriver' => 'mysqli'

enable / disable auto connect mysqli
	autoload.php
	$autoload['libraries'] = array('database'); //remove database
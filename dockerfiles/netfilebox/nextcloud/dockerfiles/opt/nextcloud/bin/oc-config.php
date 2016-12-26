<?php
    $configFile = "/opt/www/nextcloud/config/config.php";
    if (file_exists($configFile)) {
     require("$configFile");
    } else {
      exit(); 
    }

    $externalIp = getenv('EXTERNAL_IP');
//    $internalIp = getenv('INTERNAL_IP');
    $fqdn = getenv('FQDN');

    $CONFIG['trusted_domains'] = array_fill(0,1,$externalIp);
    $CONFIG['trusted_domains'][1] = $fqdn;
//    $CONFIG['trusted_domains'][2] = trim($internalIp);
    file_put_contents($configFile, 
    '<?php
    $CONFIG = ' . var_export($CONFIG, true) . ";\n");

?>

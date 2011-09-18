name "dev_server"
description "a development server, which use most of current software"

default_attributes "apache2" => { "listen_ports" => [ "80", "443" ] }

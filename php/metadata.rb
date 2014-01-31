maintainer        "Daniel Fahlke aka Flyingmana"
maintainer_email  "flyingmana@googlemail.com"
description       "compile and install PHP from latest release"
version           "0.2.1"
recipe "php::install", "Installs PHP"
recipe "php::prepare", "Install needed packages and creates prequesites like user and directories"
recipe "php::pear", "Installs required PEAR packages"
supports 'ubuntu'
depends "libjpeg"
depends "helper"


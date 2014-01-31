maintainer        "Daniel Fahlke aka Flyingmana"
maintainer_email  "flyingmana@googlemail.com"
description       "install nginx"
version           "0.1.1"
recipe "nginx::install", "Installs nginx"
supports 'debian'
depends "helper"


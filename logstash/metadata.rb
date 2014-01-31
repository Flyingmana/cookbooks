maintainer			"Daniel Fahlke aka Flyingmana"
maintainer_email	"flyingmana@googlemail.com"
description 		"install and configure logstash"
version 				"0.1.0"
recipe "logstash::install", "Install"
recipe "logstash::configure", "create configs"
supports 'debian'

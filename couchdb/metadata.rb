maintainer			"Daniel Fahlke aka Flyingmana"
maintainer_email	"flyingmana@googlemail.com"
description 		"compile and install couchdb from release"
version 				"0.1.0"
recipe "couchdb::install", "Install"
recipe "couchdb::prepare", "Install needed packages and creates prequesites like user and directories"
supports 'ubuntu'

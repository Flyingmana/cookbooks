maintainer			"Daniel Fahlke aka Flyingmana"
maintainer_email	"flyingmana@googlemail.com"
description 		"compile and install mysql from release"
version 				"0.1.0"
recipe "mysql::install", "Install"
recipe "mysql::prepare", "Install dependencies"
supports 'ubuntu'

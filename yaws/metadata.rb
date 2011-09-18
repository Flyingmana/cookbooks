maintainer			"Daniel Fahlke aka Flyingmana"
maintainer_email	"flyingmana@googlemail.com"
description 		"compile and install yaws from release"
version 				"0.1.0"
recipe "yaws::install", "Install"
recipe "yaws::prepare", "Install needed packages and creates prequesites like user and directories"
supports 'ubuntu'

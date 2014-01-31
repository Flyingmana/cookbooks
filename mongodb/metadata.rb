maintainer			"Daniel Fahlke aka Flyingmana"
maintainer_email	"flyingmana@googlemail.com"
description 		"install mongodb from distributor deb"
version 				"0.1.0"
recipe "mongodb::install", "Install"
recipe "mongodb::prepare", "setup dependencies and repository"
supports 'debian'

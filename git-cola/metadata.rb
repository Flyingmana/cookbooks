maintainer			"Daniel Fahlke aka Flyingmana"
maintainer_email	"flyingmana@googlemail.com"
description			"compile and install git-cola from latest release"
version				"0.1.0"
recipe "git-cola::install", "Install"
recipe "git-cola::prepare", "Install needed packages and creates prequesites like user and directories"
supports 'ubuntu'

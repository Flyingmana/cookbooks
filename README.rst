
This Repository contains cookbooks for opscode chef


Why another repository for cookbooks?
=====================================

The Opscode cookbook repository contains a lot cookbooks.
But after a first look it seems, that always the easiest way for install is used.
This means, they use in most cases the distribution specific package manager.

The package managers are great.
But they have one downside, if you often use very new software.
You need to build a package and to host a repository with all own packages, you need.
You shouldnt need to mess with another bild system.

For this, i write recipes, which not only install the software.
It compiles from the latest source release too.


Tasks need to be done
=====================

- make the costumization of compile options possible
- create a webserver interface (some general tasks are equal for all webservers)

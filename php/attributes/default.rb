default["php"] = {}
default["php"][:version] = "5.5.7"
#default["php"][:version] = "5.3.18"
#sha256 hash
#default["php"][:checksum] = "bd175282260d49932499da26e5ae8d81e8e54123ae22e16ffc96c9edee8e8f0f"
default["php"][:prefix] = "/usr/local"
default["php"][:displayerrors] = true
default["php"][:logerrors] = true
default["php"][:sessionautostart] = false
default["php"][:reinstall] = false
default["php"][:opcache][:revalidate_freq] = 2

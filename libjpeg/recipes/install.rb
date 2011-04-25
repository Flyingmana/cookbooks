case node["platform"]
when "debian"
  packageName = "libjpeg62"
when "ubuntu"
    case node["platform_version"]
    when "10.04"
      packageName = "libjpeg62"
    else
      packageName = "libjpeg8"
    end
else
  packageName = "libjpeg8"
end


package "#{packageName}-dev"
name 'harmony'
maintainer "Chef Software Inc"
homepage   "https://www.chef.io"
license "Apache-2.0"
license_file "LICENSE"

install_dir "#{default_root}/#{name}"

build_version "0.0.112"
build_iteration 1

# creates required build directories
dependency 'preparation'

# harmony dependencies/components
dependency "libxml2"
dependency "libxslt"
dependency "libiconv"
dependency "liblzma"
dependency "zlib"
dependency 'openssl'

unless windows?
  # builds the 'discord' dummy project
  # see the discord software def. for more details
  dependency 'discord'
end

exclude '\.git*'
exclude 'bundler\/git'
exclude 'man\/'

package :rpm do
  signing_passphrase ENV["OMNIBUS_RPM_SIGNING_PASSPHRASE"]
end

package :pkg do
  identifier 'com.getchef.harmony'
  signing_identity 'Developer ID Installer: Chef Software, Inc. (EU3VF8YLX2)'
end
compress :dmg

package :msi do
  upgrade_code '3AA89B1F-D8F3-4D46-8CB2-534C8313DBFD'
  signing_identity "E05FF095D07F233B78EB322132BFF0F035E11B5B", machine_store: true
end

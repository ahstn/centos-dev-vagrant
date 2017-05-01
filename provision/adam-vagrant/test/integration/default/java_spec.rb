# install_dir='/usr/bin/intellij'

describe package('java-1.8.0-openjdk') do
  it { should be_installed }
end

describe package('maven') do
  it { should be_installed }
end

# https://github.com/chef/inspec/issues/541
# Waiting on "cleaner attribute interface"

# describe directory install_dir do
#   it { should exist }
# end

# describe file("#{install_dir}/bin/idea.sh") do
#   it { should exist }
#   it { should be_executable }
# end

# describe file('/usr/share/applications/intellij-idea.desktop') do
#   it { should exist }
#   its('content') { should include "Exec=#{install_dir}/bin/idea.sh" }
# end

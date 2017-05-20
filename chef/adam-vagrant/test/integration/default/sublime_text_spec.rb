install_dir = '/opt/sublime_text_3'
binary_path = "#{install_dir}/sublime_text"
icon_path = "#{install_dir}/Icon/128x128/sublime-text.png"

pc_dir = '/home/kitchen/.config/sublime-text-3/Installed Packages'
pc_path = "#{pc_dir}/Package Control.sublime-package"

describe directory install_dir do
  it { should exist }
end

describe file('/usr/bin/subl') do
  it { should exist }
  it { should be_executable }
  it { should be_symlink }
end

describe file binary_path do
  it { should exist }
  it { should be_executable }
end

describe file('/usr/share/applications/sublime-text-3.desktop') do
  it { should exist }
  its('content') { should include "Exec=#{binary_path}" }
  its('content') { should include "Icon=#{icon_path}" }
  its('mode') { should cmp '0644' }
end

describe directory pc_dir do
  it { should exist }
  its('mode') { should cmp '0755' }
end

describe file pc_path do
  it { should exist }
  its('mode') { should cmp '0755' }
end

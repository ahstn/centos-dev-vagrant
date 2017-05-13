
describe directory('/opt/sublime_text_3') do
  it { should exist }
end

describe file('/usr/bin/subl') do
  it { should exist }
  it { should be_executable }
  it { should be_symlink }
end

describe file('/opt/sublime_text_3/sublime_text') do
  it { should exist }
  it { should be_executable }
end

describe file('/usr/share/applications/sublime-text-3.desktop') do
  it { should exist }
  its('content') { should include "Exec=/opt/sublime_text_3/sublime_text" }
  its('content') { should include "Icon=/opt/sublime_text_3/Icon/128x128/sublime-text.png" }
  its('mode') { should cmp '0644' }
end

describe directory('/home/kitchen/.config/sublime-text-3/Installed Packages') do
  it { should exist }
  its('mode') { should cmp '0755' }
end

describe file('/home/kitchen/.config/sublime-text-3/Installed Packages/Package Control.sublime-package') do
  it { should exist }
  its('mode') { should cmp '0755' }
end

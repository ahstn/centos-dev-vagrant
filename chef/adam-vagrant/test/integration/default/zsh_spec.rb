describe package('zsh') do
  it { should be_installed }
end

describe file('/home/kitchen/oh-my-zsh.sh') do
  its('owner') { should eq 'kitchen' }
  its('group') { should eq 'kitchen' }
  its('mode')  { should cmp '0644' }
end

describe file('/home/kitchen/.zshrc') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
  its('group') { should eq 'kitchen' }
  its('mode')  { should cmp '0644' }
  its('content') { should include 'ZSH_THEME="pure"' }
  its('content') { should include 'plugins=(git sudo)' }
end

describe directory('/home/kitchen/.oh-my-zsh') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
end

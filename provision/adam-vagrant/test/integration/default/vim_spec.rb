describe package('vim-enhanced') do
  it { should be_installed }
end

describe file('/home/kitchen/.vim/autoload/plug.vim') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
  its('group') { should eq 'kitchen' }
  its('mode')  { should cmp '0755' }
end

describe directory('/home/kitchen/.vim/autoload') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
end

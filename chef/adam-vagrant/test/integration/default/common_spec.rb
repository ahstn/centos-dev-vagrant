
describe package('git') do
  it { should be_installed }
end

describe package('mlocate') do
  it { should be_installed }
end

describe file('/home/kitchen/.gitconfig') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
  its('group') { should eq 'kitchen' }
  its('mode')  { should cmp '0644' }
  its('content') { should include 'email = kitchen@chef.io' }
  its('content') { should include 'name = kitchen-user' }
end

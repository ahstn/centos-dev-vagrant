describe package('chefdk') do
  it { should be_installed }
end

describe file('/home/kitchen/.gemrc') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
  its('mode')  { should cmp '0755' }
  its('content') { should include 'http://rubygems.org' }
  its('content') { should include 'https://rubygems.org' }
end

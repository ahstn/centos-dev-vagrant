describe package('chefdk') do
  it { should be_installed }
end

describe file('/home/kitchen/.gemrc') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
  its('mode')  { should cmd '0755' }
end

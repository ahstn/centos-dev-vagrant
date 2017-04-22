describe package('epel-release') do 
  it { should be_installed }
end

describe yum.repo('epel') do
  it { should exist }
  it { should be_enabled }
end

describe yum.repo('epel-testing') do
  it { should exist }
end

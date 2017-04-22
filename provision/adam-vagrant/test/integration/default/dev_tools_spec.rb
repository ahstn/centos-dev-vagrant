
describe package('git') do
  it { should be_installed }
end

describe package('mlocate') do
  it { should be_installed }
end

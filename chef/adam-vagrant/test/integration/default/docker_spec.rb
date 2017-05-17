describe file('usr/lib/systemd/system/docker.service') do
  it { should exist }
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'root' }
end

describe package('docker-engine')
  it { should be_installed }
end

describe command('docker --help') do
  its('exit_status') { should eq 0 }
end

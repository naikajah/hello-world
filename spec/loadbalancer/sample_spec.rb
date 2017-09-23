require 'spec_helper'

describe port(80) do
  it { should be_listening }
  it { should be_listening.with('tcp') }
end

describe file('/etc/sudoers') do
  it { should be_owned_by 'root' }
  it { should be_readable }
  it { should be_mode 440 }
end

describe command('curl http://localhost:80/') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain('Hello World') }
end

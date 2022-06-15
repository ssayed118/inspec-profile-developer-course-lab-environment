control 'nginx-version' do
  impact 1.0
  title 'NGINX version'
  desc 'The required version of NGINX should be installed.'
  describe nginx do
    its('version') { should cmp >= input('nginx_version_yml') }
  end
end

control 'nginx-modules' do
  title 'NGINX modules'
  desc 'The required NGINX modules should be installed are http_ssl, stream_ssl, and mail_ssl'
  impact 1.0

  nginx_mod_control =  input('nginx_modules_yml')

  describe nginx do 
    nginx_mod_control.each do |current_module|
   #input('nginx_modules_yml').each do |current_module|
      its('modules') { should include current_module }
    end
  end
end
  
  #describe nginx do
   # its('modules') { should include 'http_ssl' }
   # its('modules') { should include 'stream_ssl' }
   # its('modules') { should include 'mail_ssl' }
  #end
#end

control 'nginx-conf' do
  title 'NGINX configuration'
  desc 'The NGINX config file should owned by root, be writable only by owner, and not writeable or and readable by others.'
  impact 1.0

  describe file(input('file_path')) do
    it { should be_owned_by input('root_users') }
    it { should be_grouped_into input('root_users') }
    it { should_not be_readable.by(input('others')) }
    it { should_not be_writable.by(input('others')) }
    it { should_not be_executable.by(input('others')) }
  end
end

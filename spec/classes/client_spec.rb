require 'spec_helper'
describe 'ossec::client', :type => :class do
  context "on a CentOS OS" do
    it { is_expected.to compile.with_all_deps }

    describe "ossec::client" do
      it { should contain_file('/var/ossec/etc/client.keys').with_owner('ossec') }
      it { should contain_file('/var/ossec/etc/client.keys').with_group('ossec') }
      it { should contain_file('/var/ossec/etc/client.keys').with_mode('0600') }
      it { should contain_file('/var/ossec/etc/ossec-agent.conf').with_owner('root') }
      it { should contain_file('/var/ossec/etc/ossec-agent.conf').with_group('root') }
      it { should contain_file('/var/ossec/etc/ossec-agent.conf').with_mode('0644') }
      it { should contain_package('ossec-hids-client').with( :ensure => 'present')}
    end

      describe 'should allow package ensure to be overridden' do
        let(:params) {{ :package_ensure => 'latest', :package_name => 'ossec-hids-client', :package_manage => true, }}
        it { should contain_package('ossec-hids-client').with_ensure('latest') }
      end

      describe 'should allow the package name to be overridden' do
        let(:params) {{ :package_ensure => 'present', :package_name => 'blah', :package_manage => true, }}
        it { should contain_package('blah') }
      end

      describe 'should allow the package to be unmanaged' do
        let(:params) {{ :package_manage => false, :package_name => 'ossec-hids-client', }}
        it { should_not contain_package('ossec-hids-client') }
      end

    describe 'ossec::client::service' do
      let(:params) {{
        :service_manage => true,
        :service_enable => true,
        :service_ensure => 'running',
        :service_name   => 'ossec-hids'
      }}

      describe 'with defaults' do
        it { should contain_service('ossec-hids').with(
          :enable => true,
          :ensure => 'running',
          :name   => 'ossec-hids'
        )}
      end

      describe 'service_ensure' do
        describe 'when overridden' do
          let(:params) {{ :service_name => 'ossec-hids', :service_ensure => 'stopped' }}
          it { should contain_service('ossec-hids').with_ensure('stopped') }
        end
      end

    end

  end
end

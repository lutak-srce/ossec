require 'spec_helper_acceptance'

describe 'ossec::client class' do

  context 'default parameters' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
        #  repos for installation of ossec package
        if $::osfamily == 'Debian' {
          class { 'apt': }
          apt::source { 'ossec':
            key         => {
              'id'     => '9FE55537D1713CA519DFB85114B9C8DB9A1B1C65',
              'source' => 'http://ossec.wazuh.com/repos/apt/conf/ossec-key.gpg.key',
	    },
            location    => 'http://ossec.wazuh.com/repos/apt/debian',
            release     => "${::lsbdistcodename}",
            repos       => 'main',
            include     => {
              'src' => false,
	    },
            before      => Class['ossec::client'],
          }
	  # execute apt-get update before installation
	  Exec["apt_update"] -> Package <| |>
        } elsif $::osfamily == 'RedHat' {
         yumrepo { 'ossec':
          baseurl  => "http://ossec.wazuh.com/el/$releasever/$basearch",
            enabled  => 1,
            gpgcheck => 0,
            before   => Class['ossec::client'],
          }
        }
        class { 'ossec': 
          client_id => '1',
          client_ip => '10.0.0.1',
          client_key => 'randomkey',
          before   => Class['ossec::client'],
        }
        class { 'ossec::client': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

  end
end

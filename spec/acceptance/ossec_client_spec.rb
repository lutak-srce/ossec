require 'spec_helper_acceptance'

describe 'ossec::client class' do

  context 'default parameters' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
        #  repos for installation of ossec package
        if $::osfamily == 'Debian' {
          class { 'apt': }
          apt::source { 'ossec':
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
          baseurl  => "http://updates.atomicorp.com/channels/mirrorlist/atomic/centos-$releasever-$basearch",
            enabled  => 1,
            gpgcheck => 0,
            before   => Class['ossec::client'],
          }
        }
        class { 'ossec::client': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

  end
end

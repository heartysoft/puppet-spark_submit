include stdlib

class spark_submit::install(
	$install_dir = $spark_submit::install_dir,
	$checkpoint_dir = $spark_submit::checkpoint_dir,
	$install_method = $spark_submit::install_method,
	$download_url = $spark_submit::download_url,
	$download_dir = $spark_submit::download_dir,
	$version = $spark_submit::version,
	$tarball = $spark_submit::tarball
) {

	file { [$install_dir, $download_dir, $checkpoint_dir] :
		ensure => directory
	}

	if $install_method == 'cp' {
		file{ "${download_dir}/${tarball}" :
			ensure => present,
        	source => "puppet:///modules/spark/$tarball",
        	mode => 744,
        	require => File[$download_dir],
        	before => Exec['extract-spark'],
		}
	} else {
		exec { 'download-spark':
	      command => "/usr/bin/wget -O ${download_dir}/${tarball} ${download_url}",
	      creates => "${download_dir}/${tarball}",
	      require => File[$download_dir],
	      before => Exec['extract-spark'],
	    }
	}
	
    exec { 'extract-spark':
		command => "/bin/chmod a+x ${download_dir}/${tarball} && /bin/tar -xzf ${download_dir}/${tarball} -C ${install_dir}",
		creates => "${install_dir}/${version}",
		require => File[$install_dir],
	}

	file { "${install_dir}/spark":
		ensure => link,
		target => "${install_dir}/${version}",
		require => Exec['extract-spark'],
	}

	file { '/etc/profile.d/spark_submit.sh' :
    	content => "export SPARK_HOME=/var/lib/spark/spark\nexport PATH=\$PATH:\$SPARK_HOME/bin/\n",
  	}	 
  	->
	file_line { 'spark_submit_bashrc':
		path => '/etc/bash.bashrc',
		line => "source /etc/profile.d/spark_submit.sh"
	}
}
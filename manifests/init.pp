include stdlib

class spark_submit (
	$master_node,
	$master_port = $spark_submit::params::master_port,
	$version = $spark_submit::params::version,
	$download_url = $spark_submit::params::download_url,
	$download_dir = $spark_submit::params::download_dir,
	$install_method = $spark_submit::params::install_method,
	$install_dir = $spark_submit::params::install_dir,
	$checkpoint_dir = $spark_submit::params::checkpoint_dir,
	$tarball = $spark_submit::params::tarball
	) inherits spark_submit::params {
	
	anchor {'spark_submit::begin:':} ->
	class {'spark_submit::install': } ->
	class { 'spark_submit::config': } -> 
	anchor {'spark_submit::end:': }
}

class spark_submit::config(
	$install_dir = $spark_submit::install_dir,
	$master_node = $spark_submit::master_node,
	$master_port = $spark_submit::master_port
	){

	file { "$install_dir/spark/conf/spark-defaults.conf":
			ensure => present,
			content => template('spark_submit/spark-defaults.conf.erb'),
			mode => '0755',
	}
}

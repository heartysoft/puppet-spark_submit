class spark_submit::params {
	$master_port = '7077'
	$version = 'spark-1.1.1-bin-hadoop1'
	$download_url = "http://d3kbcqa49mib13.cloudfront.net/${version}.tgz"
	$download_dir = '/tmp'
	$install_method = 'wget'
	$install_dir = '/var/lib/spark'
	$checkpoint_dir = '/var/lib/spark_checkpoints'
	$tarball = "${version}.tgz"
}
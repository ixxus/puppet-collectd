# https://github.com/egineering-llc/collectd-fast-jmx
class collectd::plugin::fastjmx (
  $ensure         = 'present',
  $jvmarg         = [],
  $manage_package = undef,
  $version        = '1.0.0',
) {

  include ::collectd
  include ::collectd::plugin::java

  $class_path  = "${collectd::java_dir}/collectd-api.jar:${collectd::java_dir}/collectd-fast-jmx.jar"
  $config_file = "${collectd::plugin_conf_dir}/15-fastjmx.conf"

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $_manage_package {
    archive { "${collectd::java_dir}/collectd-fast-jmx.jar":
      ensure        => present,
      extract       => false,
      source        => "http://central.maven.org/maven2/com/e-gineering/collectd-fast-jmx/${version}/collectd-fast-jmx-${version}.jar",
      cleanup       => false,
    }
  }

  concat { $config_file:
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }

  concat::fragment {
    'collectd_plugin_fastjmx_conf_header':
      order   => '00',
      content => template('collectd/plugin/fastjmx.conf.header.erb'),
      target  => $config_file;
    'collectd_plugin_fastjmx_conf_footer':
      order   => '99',
      content => "  </Plugin>\n</Plugin>\n",
      target  => $config_file;
  }
}

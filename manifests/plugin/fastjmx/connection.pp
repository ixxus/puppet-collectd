# https://github.com/egineering-llc/collectd-fast-jmx
define collectd::plugin::fastjmx::connection (
  $collect,
  $service_url,
  $host                     = undef,
  $user                     = undef,
  $password                 = undef,
  $instance_prefix          = undef,
  $include_port_in_hostname = false,
  $synchronous              = false,
  $ttl                      = undef,
) {

  include ::collectd
  include ::collectd::plugin::fastjmx

  concat::fragment { "collectd_plugin_fastjmx_conf_${name}":
    order   => 20,
    content => template('collectd/plugin/fastjmx/connection.conf.erb'),
    target  => $collectd::plugin::fastjmx::config_file,
  }
}

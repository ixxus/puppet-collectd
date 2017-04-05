# https://github.com/egineering-llc/collectd-fast-jmx
define collectd::plugin::fastjmx::mbean (
  $object_name,
  $values,
  $instance_prefix = undef,
  $instance_from   = undef,
) {

  include ::collectd
  include ::collectd::plugin::fastjmx

  validate_array($values)

  concat::fragment { "collectd_plugin_fastjmx_conf_${name}":
    order   => '10',
    content => template('collectd/plugin/fastjmx/mbean.conf.erb'),
    target  => $collectd::plugin::fastjmx::config_file,
  }
}

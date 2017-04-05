def os_specific_options(facts)
  case facts[:osfamily]
  when 'Gentoo'
    { package: 'app-admin/collectd', service: 'collectd', plugin_conf_dir: '/etc/collectd.d' }
  when 'Solaris'
    { package: 'CSWcollectd', service: 'cswcollectd', plugin_conf_dir: '/etc/opt/csw/collectd.d' }
  when 'FreeBSD'
    { package: 'collectd5', service: 'collectd', plugin_conf_dir: '/usr/local/etc/collectd' }
  when 'Archlinux', 'RedHat'
    { package: 'collectd', service: 'collectd', plugin_conf_dir: '/etc/collectd.d', java_dir: '/usr/share/collectd/java' }
  when 'Debian'
    { package: 'collectd', service: 'collectd', plugin_conf_dir: '/etc/collectd/conf.d', java_dir: '/usr/share/collectd/java' }
  else
    { package: 'collectd', service: 'collectd', plugin_conf_dir: '/etc/collectd' }
  end
end

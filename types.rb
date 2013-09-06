# Options you can set and their defaults...

  # :installer => :core,
  # :install_version => nil,
  # :setup => [],
  # :dctest => [],
  # :box => 'ubuntu-13.04',
  # :count => 1,
  # :ip => "10.1.1.12",
  # :bootstrap_ip => nil,
  # :dcurl => 'https://github.com/cfengine/design-center.git',
  # :dcbranch => 'master',
  # :vmname => 'cftester',
  # :vmsize => "1024",
  # :baseport => "8080",

module Types

  FRAGMENTS = {
    :inone => { :installer => :none },
    :ipackages => { :installer => :packages },
    :icore => { :installer => :core },

    :ubuntu_10_04 => { :box => "ubuntu-10.04", :vmname => "BOX-" },
    :ubuntu_13_04 => { :box => "ubuntu-13.04", :vmname => "BOX-" },
    :centos_6_4 => { :box => "centos-6.4", :vmname => "BOX-" },

    :centos_enterprise_rpm => { :install_version => "/vagrant/resources/packages/cfengine-nova-hub-3.5.1-1.x86_64.rpm" },
  }

  TEMPLATES = {
    :hub => { :setup => ["bootstrap", "custom_masterfiles", "dc", "hub", "converge" ] },
  }

  TYPES = {
    "single_centos_hub" => {}
      .merge(FRAGMENTS[:ipackages])
      .merge(FRAGMENTS[:centos_6_4])
      .merge(FRAGMENTS[:centos_enterprise_rpm])
      .merge(TEMPLATES[:hub])
      .merge({ :ip => "10.0.0.20", :count => 1 })
  }

  def Types.type(name)
    unless TYPES.has_key?(name)
      abort "Sorry, we can't find the requested type #{name}"
    end

    return TYPES[name]
  end

  def Types.types()
    return TYPES
  end

end

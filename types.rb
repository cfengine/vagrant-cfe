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
  # :fport => "80",

module Types

  FRAGMENTS = {
    :inone => { :installer => :none },
    :ipackages => { :installer => :packages },
    :icore => { :installer => :core },

    :ubuntu_10_04 => { :box => "ubuntu-10.04-amd64", :vmname => "BOX-64-" },
    :ubuntu_10_04_i386 => { :box => "ubuntu-10.04-i386", :vmname => "BOX-32-" },
    :ubuntu_10_10 => { :box => "ubuntu-10.10-amd64", :vmname => "BOX-64-" },
    :ubuntu_11_04 => { :box => "ubuntu-11.04-amd64", :vmname => "BOX-64-" },
    :ubuntu_11_10 => { :box => "ubuntu-11.10-amd64", :vmname => "BOX-64-" },
    :ubuntu_12_04 => { :box => "ubuntu-12.04-amd64", :vmname => "BOX-64-" },
    :ubuntu_12_10 => { :box => "ubuntu-12.10-amd64", :vmname => "BOX-64-" },
    :ubuntu_13_04 => { :box => "ubuntu-13.04-amd64", :vmname => "BOX-64-" },

    :ubuntu_precise => { :box => "precise32", :vmname => "BOX-32-" },
    :ubuntu_lucid => { :box => "lucid32", :vmname => "BOX-32-" },

    :suse_11_4 => { :box => "SUSE", :vmname => "BOX-64-" },

    :centos_5_5 => { :box => "centos-5.5", :vmname => "BOX-64-" },
    :centos_5_6 => { :box => "centos-5.6", :vmname => "BOX-64-" },
    :centos_5_7 => { :box => "centos-5.7", :vmname => "BOX-64-" },
    :centos_5_8 => { :box => "centos-5.8", :vmname => "BOX-64-" },
    :centos_5_9 => { :box => "centos-5.9", :vmname => "BOX-64-" },
    :centos_6_0 => { :box => "centos-6.0", :vmname => "BOX-64-" },
    :centos_6_1 => { :box => "centos-6.1", :vmname => "BOX-64-" },
    :centos_6_2 => { :box => "centos-6.2", :vmname => "BOX-64-" },
    :centos_6_3 => { :box => "centos-6.3", :vmname => "BOX-64-" },
    :centos_6_4 => { :box => "centos-6.4", :vmname => "BOX-64-" },

    :core_checkout_351 => { :install_version => "3.5.1" },
    :core_checkout_352 => { :install_version => "3.5.2" },
    :core_checkout_master => { :install_version => "master" },

    :centos_client_enterprise352_rpm => { :install_version => "/vagrant/resources/packages/cfengine-nova-3.5.2-1.x86_64.rpm" },
    :ubuntu_client_enterprise352_deb => { :install_version => "/vagrant/resources/packages/cfengine-nova_3.5.2-1_amd64.deb" },

    :centos_hub_enterprise352_rpm => { :install_version => "/vagrant/resources/packages/cfengine-nova-hub-3.5.2-1.x86_64.rpm" },
    :ubuntu_hub_enterprise352_deb => { :install_version => "/vagrant/resources/packages/cfengine-nova-hub_3.5.2-1_amd64.deb" },
  }

  TEMPLATES = {
    :hub => { :setup => [ "bootstrap", "custom_masterfiles", "dc", "hub", "converge" ] },
    :generic => { :setup => [ "converge" ] },
    :jenkins => { :setup => [ "jenkins" ], :fport => 8080 },
  }

  TYPES = {
    "single_centos_hub" => {}
      .merge(FRAGMENTS[:ipackages])
      .merge(FRAGMENTS[:centos_6_4])
      .merge(FRAGMENTS[:centos_hub_enterprise352_rpm])
      .merge(TEMPLATES[:hub])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_ubuntu_hub" => {}
      .merge(FRAGMENTS[:ipackages])
      .merge(FRAGMENTS[:ubuntu_13_04])
      .merge(FRAGMENTS[:ubuntu_hub_enterprise352_deb])
      .merge(TEMPLATES[:hub])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_centos_eclient" => {}
      .merge(FRAGMENTS[:ipackages])
      .merge(FRAGMENTS[:centos_6_4])
      .merge(FRAGMENTS[:centos_client_enterprise352_rpm])
      .merge(TEMPLATES[:generic])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_ubuntu_eclient" => {}
      .merge(FRAGMENTS[:ipackages])
      .merge(FRAGMENTS[:ubuntu_13_04])
      .merge(FRAGMENTS[:ubuntu_client_enterprise352_deb])
      .merge(TEMPLATES[:generic])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_centos_cclient" => {}
      .merge(FRAGMENTS[:ipackages])
      .merge(FRAGMENTS[:centos_6_4])
      .merge(TEMPLATES[:generic])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_ubuntu_cclient" => {}
      .merge(FRAGMENTS[:ipackages])
      .merge(FRAGMENTS[:ubuntu_13_04])
      .merge(TEMPLATES[:generic])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_suse_cclient" => {}
      .merge(FRAGMENTS[:ipackages])
      .merge(FRAGMENTS[:suse_11_4])
      .merge(TEMPLATES[:generic])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_centos_source" => {}
      .merge(FRAGMENTS[:icore])
      .merge(FRAGMENTS[:centos_6_4])
      .merge(FRAGMENTS[:core_checkout_master])
      .merge(TEMPLATES[:generic])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_ubuntu_source" => {}
      .merge(FRAGMENTS[:icore])
      .merge(FRAGMENTS[:ubuntu_13_04])
      .merge(FRAGMENTS[:core_checkout_master])
      .merge(TEMPLATES[:generic])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_suse_source" => {}
      .merge(FRAGMENTS[:icore])
      .merge(FRAGMENTS[:suse_11_4])
      .merge(FRAGMENTS[:core_checkout_master])
      .merge(TEMPLATES[:generic])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_centos" => {}
      .merge(FRAGMENTS[:inone])
      .merge(FRAGMENTS[:centos_6_4])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_centos_jenkins" => {}
      .merge(FRAGMENTS[:inone])
      .merge(FRAGMENTS[:centos_6_4])
      .merge(TEMPLATES[:jenkins])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_ubuntu" => {}
      .merge(FRAGMENTS[:inone])
      .merge(FRAGMENTS[:ubuntu_13_04])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

    "single_suse" => {}
      .merge(FRAGMENTS[:inone])
      .merge(FRAGMENTS[:suse_11_4])
      .merge({ :ip => "10.0.0.20", :count => 1 }),

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

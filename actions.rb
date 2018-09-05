module Actions

  def Actions.assemble(type, installer, version, setup_steps)
    steps = []

    # pp method(__method__).parameters.map{|arg| __method__.to_s + " #{arg[1]} = #{eval arg[1].to_s}" }

    # note order: install, then bootstrap, then other steps
    installer_args = []
    installer_args << version if version

    steps << { :path => "install_#{type}_#{installer}.sh", :args => installer_args }

    if setup_steps.include?('bootstrap')
      steps << { :path => "bootstrap.sh", :args => [ :bootstrap_ip ] }
      setup_steps -= [ 'bootstrap' ]
    end

    steps += setup_steps.map { |s| { :path => "setup_#{s}.sh", :args => [:i] } }

    return steps
  end

  def Actions.process_args(args, options)
    return args.map { |a| (a.is_a? Symbol) ? options[a] : a }.join(' ')
  end
end

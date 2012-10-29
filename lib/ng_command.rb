module Nailgun

  class NgCommand

    case RUBY_PLATFORM
    when /linux.*x86_64|x86_64.*linux/
      OS_PLATFORM = 'linux64'
    when /linux/
      OS_PLATFORM = 'linux32'
    when /darwin/
      OS_PLATFORM = 'darwin'
    else
      OS_PLATFORM = 'win32'
    end

    begin
      NGPATH = File.expand_path(File.join(File.dirname(__FILE__), 'java', 'bin', OS_PLATFORM, 'ng'))
    rescue NameError
      raise "OS cannot be identified"
    end

    JAVAPATH = Nailgun::NailgunConfig.options[:java_bin]
    NGJAR = File.expand_path(File.join(File.dirname(__FILE__), 'java','jar','nailgun-0.7.1.jar'))

    def self.start_server(config={})
      execute_command config do |p, s|
        "nohup #{JAVAPATH} -server -Djava.awt.headless=true -jar #{NGJAR} #{s}:#{p} > /dev/null 2>&1 &"
      end
    end

    def self.stop_server(config={})
      run "ng-stop", config
    end

    def self.add_cps(paths, config={})
      paths.each { |path| ng_cp path, config }
    end

    def self.ng_cp(absolute_jar_path="", config={})
      run "ng-cp #{absolute_jar_path}", config
    end

    def self.ng_alias(alias_name, class_name, config={})
      run "ng-alias #{alias_name} #{class_name}", config
    end

    def self.ng_version
      system "#{NGPATH} --nailgun-version"
    end

    def self.run(command, config={})
      execute_command config do |p, s|
        "#{NGPATH} --nailgun-port #{p} --nailgun-server #{s} #{command}"
      end      
    end

  private

    ##
    # Abtracts command execution plumbing
    #
    # &block is expected to return a nailgun command that can be executed in a
    # system subcall.

    def self.execute_command(config={}, &block)
      config[:server_address] ||= Nailgun::NailgunConfig.options[:server_address]
      config[:port_no]        ||= Nailgun::NailgunConfig.options[:port_no]

      command = yield config[:port_no], config[:server_address]
      system(command)
    end

  end
end

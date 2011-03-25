#require 'nailgun_config'
module Nailgun
	class NgCommand
	  if RUBY_PLATFORM =~ /linux/
      if RUBY_PLATFORM =~ /x86_64/
          OS_PLATFORM = 'linux64'
      else
        OS_PLATFORM = 'linux32'
      end
   elsif RUBY_PLATFORM =~ /darwin/
      OS_PLATFORM = 'darwin'
   else
     OS_PLATFORM = 'win32'
   end
  begin
	  NGPATH = File.expand_path(File.join(File.dirname(__FILE__), 'java','bin',OS_PLATFORM,'ng'))
  rescue Exception
    puts "cant find os version"
  end
		JAVAPATH = Nailgun::NailgunConfig.options[:java_bin]
		NGJAR = File.expand_path(File.join(File.dirname(__FILE__), 'java','jar','nailgun-0.7.1.jar'))

		def self.start_server(port_no="",server_address="")
			server_address = Nailgun::NailgunConfig.options[:server_address] if server_address.empty?
			port_no  = Nailgun::NailgunConfig.options[:port_no] if port_no.empty?
			arguments = "#{server_address}:#{port_no}"
			command= "nohup #{JAVAPATH} -jar #{NGJAR} #{arguments} > /dev/null 2>&1 &"
		# puts command
			system(command)
		end

		def self.stop_server(port_no="",server_address="")
			server_address = Nailgun::NailgunConfig.options[:server_address] if server_address.empty?
			port_no  = Nailgun::NailgunConfig.options[:port_no] if port_no.empty?
			command ="#{NGPATH} --nailgun-port #{port_no} --nailgun-server #{server_address} ng-stop"
		#	puts command
			system(command)
		end

		def self.ng_cp(absolute_jar_path,port_no="",server_address="")
			server_address = Nailgun::NailgunConfig.options[:server_address] if server_address.empty?
			port_no  = Nailgun::NailgunConfig.options[:port_no] if port_no.empty?
			command ="#{NGPATH} --nailgun-port #{port_no} --nailgun-server #{server_address} ng-cp #{absolute_jar_path}"
		#	puts command
			system(command)
		end
		
		def self.ng_alias(alias_name,class_name,port_no="",server_address="")
			server_address = Nailgun::NailgunConfig.options[:server_address] if server_address.empty?
			port_no  = Nailgun::NailgunConfig.options[:port_no] if port_no.empty?
				command = "#{NGPATH} --nailgun-port #{port_no} --nailgun-server #{server_address} ng-alias #{alias_name} #{class_name}"
 		#puts command
			system(command)
		end

		def self.ng_version
			command = "#{NGPATH} --nailgun-version"
		#	puts command
			system(command)
		end
	end
end

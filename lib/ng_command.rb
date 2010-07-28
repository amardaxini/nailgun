require 'nailgun_config'
module Nailgun
	class NgCommand
		NGPATH = File.expand_path(File.join(File.dirname(__FILE__), 'java','bin','ng'))
		JAVAPATH = Nailgun::NailgunConfig.options[:java_bin]
		NGJAR = File.expand_path(File.join(File.dirname(__FILE__), 'java','jar','nailgun-0.7.1.jar'))

		def self.start_server(port_no="",server_address="")
			server_address = Nailgun::NailgunConfig.options[:server_address] if server_address.blank?
			port_no  = Nailgun::NailgunConfig.options[:port_no] if port_no.blank?
			arguments = "#{server_address}:#{port_no}"
			command= "nohup #{JAVAPATH} -jar #{NGJAR} #{arguments} > /dev/null 2>&1 &"
			system(command)
		end

		def self.stop_server(port_no="",server_address="")
			server_address = Nailgun::NailgunConfig.options[:server_address] if server_address.blank?
			port_no  = Nailgun::NailgunConfig.options[:port_no] if port_no.blank?
			command ="#{NGPATH} --nailgun-port #{port_no} --nailgun-server #{server_address} ng-stop"
			system(command)
		end

		def self.ng_cp(absolute_jar_path,port_no="",server_address="")
			server_address = Nailgun::NailgunConfig.options[:server_address] if server_address.blank?
			port_no  = Nailgun::NailgunConfig.options[:port_no] if port_no.blank?
			command ="#{NGPATH} --nailgun-port #{port_no} --nailgun-server #{server_address} ng-cp #{absolute_jar_path}"
			system(command)
		end
		
		def self.ng_alias(alias_name,class_name,port_no="",server_address="")
			server_address = Nailgun::NailgunConfig.options[:server_address] if server_address.blank?
			port_no  = Nailgun::NailgunConfig.options[:port_no] if port_no.blank?
			command = "#{NGPATH} --nailgun-port #{port_no} --nailgun-server #{server_address} ng-alias #{alias_name} #{class_name}"
			system(command)
		end

		def self.ng_version
			command = "#{NGPATH} --nailgun-version"
			system(command)
		end
	end
end

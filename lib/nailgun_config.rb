module Nailgun
 class NailgunConfig
    # default options
		cattr_accessor :options
    @@options = {
      :java_bin => "java",
      :server_address => 'localhost',
      :port_no=>'2113',
      :run_mode => :once
    }

 end
end

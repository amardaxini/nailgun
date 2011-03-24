desc "Generate nailgun script"

task :nailgun do
	dest_file = File.expand_path(File.join(File.dirname(__FILE__),'..','..','..','..', "script", 'nailgun'))
	src_file = File.expand_path(File.join(File.dirname(__FILE__),'..','lib','generator' ,'nailgun'))
	FileUtils.cp_r(src_file, dest_file)
	File.chmod(0755,dest_file)
end
namespace :nailgun do
	desc "Start Naulgun server"
	task :start do
		Nailgun::NailgunServer.new("start").daemonize
	end
	desc "Stop Naulgun server"
	task :stop do
		Nailgun::NailgunServer.new("stop").daemonize
	end
end

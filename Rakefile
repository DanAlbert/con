# Author:		Chris Wailes <chris.wailes@gmail.com>
# Project: 	Con
# Date:		2014/10/02
# Description:	Con's Rakefile.

############
# Requires #
############

# Filigree
require 'filigree/request_file'

require File.expand_path("../lib/con/version", __FILE__)

###########
# Bundler #
###########

request_file('bundler', 'Bundler is not installed.') do
	Bundler::GemHelper.install_tasks
end

########
# Flay #
########

request_file('flay', 'Flay is not installed.') do
	desc 'Analyze code for similarities with Flay'
	task :flay do
		flay = Flay.new
		flay.process(*Dir['lib/**/*.rb'])
		flay.report
	end
end

########
# Flog #
########

request_file('flog_cli', 'Flog is not installed.') do
	desc 'Analyze code complexity with Flog'
	task :flog do
		whip = FlogCLI.new
		whip.flog('lib')
		whip.report
	end
end

############
# MiniTest #
############

request_file('rake/testtask', 'Minitest is not installed.') do
	Rake::TestTask.new do |t|
		t.libs << 'test'
		t.test_files = FileList['test/ts_con.rb']
	end
end

#########
# Notes #
#########

request_file('rake/notes/rake_task', 'Rake-notes is not installed.')

########
# Reek #
########

request_file('reek/rake/task', 'Reek is not installed.') do
	Reek::Rake::Task.new do |t|
	  t.fail_on_error = false
	end
end

##################
# Rubygems Tasks #
##################

request_file('rubygems/tasks', 'Rubygems-tasks is not installed.') do
	Gem::Tasks.new do |t|
		t.console.command = 'pry'
	end
end

########
# YARD #
########

request_file('yard', 'Yard is not installed.') do
	YARD::Rake::YardocTask.new do |t|
		t.options = [
			'--title',  'Con',
			'-m',       'markdown',
			'-M',       'redcarpet',
			'--private'
		]

		t.files = Dir['lib/**/*.rb']
	end
end

################
# Con Tasks #
################

desc 'Re-generate the Con parser table.'
task :grammar do
     begin
          $: << File.expand_path('../lib', __FILE__)
          require 'con'
          Con::Parser

     rescue Exception => e
          puts e.message
          puts e.backtrace
     end
end

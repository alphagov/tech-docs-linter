require "fileutils"

BUILD_DIR = File.expand_path("build", Dir.pwd)
LOCKFILE  = File.expand_path("tmp/cucumber-build.lock", Dir.pwd)
FileUtils.mkdir_p(File.dirname(LOCKFILE))

File.open(LOCKFILE, "w") do |f|
  f.flock(File::LOCK_EX)
  # build a fresh site to make sure any changes are present
  # don't clean after so that debugging is easier if needed
  FileUtils.rm_rf(BUILD_DIR)
  ok = system("bundle exec middleman build")
  raise "Middleman build failed" unless ok
end

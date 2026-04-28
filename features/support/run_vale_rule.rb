# features/support/vale_runner.rb
require "open3"
require "json"

module ValeRunner
  Result = Struct.new(
    :cmd, :stdout, :stderr, :status, :json,
    keyword_init: true
  )

  # Runs Vale against a single file and captures everything we need.
  # file_path:   built HTML file path (e.g. "build/lint-examples/rule-x/fail/index.html")
  # filter:      optional Vale --filter expression to narrow rules (string or nil)
  def self.run(file_path:, filter: nil)
    args = ["vale", file_path, "--config", File.expand_path(".vale.ini", Dir.pwd), "--output=JSON"]
    if filter
      filter_string = ".Name=='tech-writing-style-guide.#{filter}'"
      args << "--filter=#{filter_string}" 
    end

    stdout, stderr, status = Open3.capture3(*args) # stdout/stderr strings + Process::Status [1](https://docs.ruby-lang.org/en/master/Open3.html)[2](https://www.rubydoc.info/stdlib/open3/Open3.capture3)[3](https://www.honeybadger.io/blog/capturing-stdout-stderr-from-shell-commands-via-ruby/)

    parsed = begin
      JSON.parse(stdout) # => Hash/Array, depending on Vale JSON structure [6](https://docs.ruby-lang.org/en/master/JSON.html)[7](https://stackoverflow.com/questions/5410682/parsing-a-json-string-in-ruby)
    rescue JSON::ParserError
      nil
    end
    Result.new(
      cmd: args.join(" "),
      stdout: stdout,
      stderr: stderr,
      status: status,
      json: parsed
    )
  end
end

module ValeWorld
  def vale_result
    @vale_result
  end

  def vale_result=(result)
    @vale_result = result
  end
end

World(ValeWorld)
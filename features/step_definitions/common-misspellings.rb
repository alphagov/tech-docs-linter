Given('a page contains {string} misspelling') do |misspellings_expected|
  @dir = "common-misspellings"

  if "a single" == misspellings_expected
    @page = "single-misspelling"
  elsif "no" == misspellings_expected
    @page = "all-correct"
  else
    raise NotImplementedError, "Unimplemented linter: #{misspellings_expected}"
  end
end

def get_misspelling_filepath
  "build/#{@dir}/#{@page}.html"
end
Given("a page contains {string} misspelling") do |misspellings_expected|
  @dir = "common-misspellings"

  if misspellings_expected == "a single"
    @page = "single-misspelling"
  elsif misspellings_expected == "no"
    @page = "all-correct"
  else
    raise NotImplementedError, "Unimplemented linter: #{misspellings_expected}"
  end
end

def get_misspelling_filepath
  "build/#{@dir}/#{@page}.html"
end

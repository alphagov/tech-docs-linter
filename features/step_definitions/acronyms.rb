Given("a page contains {string} acronym") do |expected_number_of_acronyms|
  @dir = "acronyms"

  case expected_number_of_acronyms
  when "a single uncommon undefined"
    @page = "single-uncommon-undefined"
  when "a single uncommon defined"
    @page = "single-uncommon-defined"
  when "a single common defined"
    @page = "single-common-defined"
  when "a single common undefined"
    @page = "single-common-undefined"
  else
    raise NotImplementedError, "Unimplemented linter: #{expected_number_of_acronyms}"
  end
end

Given("a page contains {string} acronyms") do |types_of_acronyms|
  case types_of_acronyms
  when "multiple uncommon"
    @page = "multiple-uncommon"
  when "multiple common"
    @page = "multiple-common"
  when "3 common 3 uncommon"
    @page = "3-of-each"
  when "3 common 4 uncommon"
    @page = "3-common-4-not"
  end
end

Given("{string} of the acronyms have been defined") do |amount_of_acronyms|
  case amount_of_acronyms
  when "all"
    @page << "-fully-defined"
  when "none defined"
    @page << "-none-defined"
  when "half defined"
    @page << "-half-defined"
  end
end

def get_acronym_filepath
  "build/acronyms/#{@page}.html"
end

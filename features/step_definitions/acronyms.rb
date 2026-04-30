Given('a page contains {string} acronym') do |expected_number_of_acronyms|
  @dir = "acronyms"

  if "a single uncommon undefined" == expected_number_of_acronyms
    @page = "single-uncommon-undefined"
  elsif "a single uncommon defined" == expected_number_of_acronyms
    @page = "single-uncommon-defined"
  elsif "a single common defined" == expected_number_of_acronyms
    @page = "single-common-defined"
  elsif "a single common undefined" == expected_number_of_acronyms
    @page = "single-common-undefined"
  else
    raise NotImplementedError, "Unimplemented linter: #{expected_number_of_acronyms}"
  end
end

Given('a page contains {string} acronyms') do |types_of_acronyms|
  if "multiple uncommon" == types_of_acronyms
    @page = "multiple-uncommon"
  elsif "multiple common" == types_of_acronyms
    @page = "multiple-common"
  elsif "3 common 3 uncommon" == types_of_acronyms
    @page = "3-of-each"
  elsif "3 common 4 uncommon" == types_of_acronyms
    @page = "3-common-4-not"
  end
end

Given('{string} of the acronyms have been defined') do |amount_of_acronyms|
  if "all" == amount_of_acronyms
    @page << "-fully-defined"
  elsif "none defined" == amount_of_acronyms
    @page << "-none-defined"
  elsif "half defined" == amount_of_acronyms
    @page << "-half-defined"
  end
end

def get_acronym_filepath
  "build/acronyms/#{@page}.html"
end

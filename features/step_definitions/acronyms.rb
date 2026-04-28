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

def get_acronym_filepath
  "build/acronyms/#{@page}.html"
end

#  Json will be a response like:
#{"path/to/something.html"=>[
# {
#   "Action"=>{"Name"=>"", "Params"=>nil}, 
#   "Span"=>[17, 19], 
#   "Check"=>"tech-writing-style-guide.acronyms", 
#   "Description"=>"", 
#   "Link"=>"", 
#   "Message"=>"'BDD' must be defined in the first instance", 
#   "Severity"=>"error", 
#   "Match"=>"BDD", 
#   "Line"=>110
#  }
# ]
#}

Then('the number of errors in the linter report should be {float}') do |number_of_errors|
  # we have specified a single page so we expect the top object length to be 1.  This is just a defensive test before we go to the actual errors
  vale_result_key = vale_result.json.keys[0]
  @vale_result_json = vale_result.json[vale_result_key]
  expect(@vale_result_json.count).to eq number_of_errors
end

Then('the error should include {string}') do |error_message|
  expect(@vale_result_json[0]).to have_key("Message")
  expect(@vale_result_json[0]["Message"]).to include(error_message)
end


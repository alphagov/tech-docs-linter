When('the linter runs against the page with the {string} rule') do |rule_name|
  if "acronyms" == rule_name
    @file_to_be_tested = self.get_acronym_filepath
  elsif "common-misspellings" == rule_name
    @file_to_be_tested = self.get_misspelling_filepath
  else
    raise NotImplementedError, "Unimplemented linter: #{rule_name}"
  end
  # if vale finds no files it just passes.  This is to avoid false positive tests
  expect(File).to exist(@file_to_be_tested)

  self.vale_result = ValeRunner.run(
    file_path: @file_to_be_tested,
    filter: rule_name
  )
  expect(vale_result.status).not_to be_nil
  expect(vale_result.status.signaled?).to be false
end

Then('the linter should {string}') do |pass_or_fail|
  if "pass" == pass_or_fail
    expect(vale_result.status.exitstatus).to eq(0)
  elsif "fail" == pass_or_fail
    expect(vale_result.status.exitstatus).to eq(1)
  else
    raise NotImplementedError, "Unimplemented linter: #{pass_or_fail}"
  end

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

Then('the number of messages in the linter report should be {float}') do |number_of_errors|
  if number_of_errors < 1
    expect(vale_result.json.size).to be 0
  end

  if number_of_errors > 0
    expect(vale_result.json.size).to be > 0
    # we have specified a single page so we expect the top object length to be 1.  This is just a defensive test before we go to the actual errors
    vale_result_key = vale_result.json.keys[0]
    @vale_result_json = vale_result.json[vale_result_key]
    expect(@vale_result_json.count).to eq number_of_errors
  end

end

Then('the error level should be {string}') do | error_level|
  expect(@vale_result_json[0]["Severity"]).to eq(error_level)
end

And('the message should contain {string}') do |error_message|
  expect(@vale_result_json[0]).to have_key("Message")
  expect(@vale_result_json[0]["Message"]).to include(error_message)
end
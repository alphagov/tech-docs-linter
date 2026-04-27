require_relative "../support/run_vale_rule"

module ValeWorld 
  def vale_result
    @vale_result
  end

  def vale_result=(result)
    @vale_result = result
  end
end

World(ValeWorld)

Given('a page contains an acronym') do
  @dir = "acronyms"
end

Given('the acronym {string} considered well known') do |is_not|
  if is_not == "is not"
    @sub = "not-on-exceptions-list"
  elsif is_not == "is"
    @sub = "exceptions"
  end
end

Given('it {string} been defined in the first usage') do |has_not|
  if has_not == "has"
    @page = "is-defined"
  elsif has_not == "has not"
    @page = "not-defined"
  end
end

When('the linter runs against the page with the {string} rule') do |rule_name|
  self.vale_result = ValeRunner.run(
    file_path: "build/#{@dir}/#{@sub}/#{@page}/",
    filter: rule_name
  )
  expect(vale_result.status).not_to be_nil
  expect(vale_result.status.signaled?).to be false
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
Then('the linter should {string}') do |pass_or_fail|
  # we have specified a single page so we expect the top object length to be 1.  This is just a defensive test before we go to the actual errors
  if "pass" == pass_or_fail
    expect(vale_result.status.exitstatus).to eq(0)
  elsif "fail" == pass_or_fail
    expect(vale_result.status.exitstatus).to eq(1)
  else
    raise NotImplementedError, "Unimplemented linter: #{pass_or_fail}"
  end

end

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

Given('the {string} list') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

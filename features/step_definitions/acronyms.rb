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

Given('the acronym {string} on the exceptions list') do |is_not|
  if is_not == "is not"
    @sub = "no-exceptions"
  elsif is_not == "is"
    @sub = "exceptions"
  end
end

Given('it {string} been defined in the first usage') do |has_not|
  if has_not == "has"
    @page = "defined"
  elsif has_not == "has not"
    @page = "not-defined"
  end
end

When('the linter runs against the page with the {string} rule') do |rule_name|
  self.vale_result = ValeRunner.run(
    file_path: "build/#{@dir}/#{@sub}/",
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
Then('the linter should fail with {int} error') do |number_of_failures|
  # we have specified a single page so we expect the top object length to be 1.  This is just a defensive test before we go to the actual errors
  expect(vale_result.json.keys.count).to eq 1 

  vale_result_key = vale_result.json.keys[0]
  @vale_result_json = vale_result.json[vale_result_key]
  expect(@vale_result_json.count).to eq number_of_failures 
end

Then('the error should include {string}') do |error_message|
  expect(@vale_result_json[0]).to have_key("Message")
  expect(@vale_result_json[0]["Message"]).to include(error_message)
end

Then('the linter should pass') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('the {string} list') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

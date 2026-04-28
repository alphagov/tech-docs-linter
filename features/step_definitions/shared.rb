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
  # we have specified a single page so we expect the top object length to be 1.  This is just a defensive test before we go to the actual errors
  if "pass" == pass_or_fail
    expect(vale_result.status.exitstatus).to eq(0)
    expect(vale_result.json.size).to be 0
  elsif "fail" == pass_or_fail
    expect(vale_result.status.exitstatus).to eq(1)
    expect(vale_result.json.size).to be > 0
  else
    raise NotImplementedError, "Unimplemented linter: #{pass_or_fail}"
  end

end
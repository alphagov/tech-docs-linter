Given("a page contains content from the {string} style guide words to avoid") do |style_guide|
  if style_guide == "govuk"
    @page = "govuk-"
  elsif style_guide == "technical"
    @page = "technical-"
  else
    raise NotImplementedError, "Unimplemented style guide: #{style_guide}"
  end
end

Given("the style guide rule {string} got exceptions") do |has_has_not|
  if has_has_not == "has"
    @page << "with-exceptions"
  elsif has_has_not == "has not"
    @page << "with-no-exceptions"
  else
    raise NotImplementedError, "Unimplemented styler guide rule: #{has_has_not}"
  end
end

def get_words_to_avoid_filepath
  "build/words-to-avoid/#{@page}.html"
end

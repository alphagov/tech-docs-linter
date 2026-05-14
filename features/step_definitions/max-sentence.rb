Given('the page has {string}') do |number_of_sentences|
  if "a single long sentence" == number_of_sentences
    @page = "single-long"
  elsif "a single short sentence" == number_of_sentences
    @page = "single-short"
  elsif "four short sentences" == number_of_sentences
    @page = "four-short"
  elsif "four long sentences" == number_of_sentences
    @page = "four-long"
  elsif "three long and six short sentences" == number_of_sentences
    @page = "three-long-six-short"
  elsif "a sentence over 25 words expanding an acronym" == number_of_sentences
    @page = "long-expanding-acronym"
   elsif "a sentence under 26 words expanding an acronym" == number_of_sentences
    @page = "short-expanding-acronym"
   elsif "a sentence over 25 words containing an acronym" == number_of_sentences
    @page = "long-unexpanded-acronym"
   elsif "a sentence under 26 words containing an acronym" == number_of_sentences
    @page = "short-unexpanded-acronym"
   else
    raise NotImplementedError, "Unimplemented scenario: #{number_of_sentences}"
  end

end

Given('the number of long sentences is {int}') do |number_of_sentences|
  pending
end

Given('the number of short sentences is {int}') do |number_of_sentences|
  pending
  end

Given('the number of items in the list is {int}') do |number_of_sentences|
  pending
end

Given('the number of long lead in lines is {int}') do |number_of_sentences|
  pending
end

Given('the number of long list items is {int}') do |number_of_sentences|
  pending
end

Given('the total length of the sentence is {string} words') do |number_of_sentences|
  pending
end

And(/^the code block is "([^"]*)"$/) do |arg|
  pending
end

And(/^the code block is surrounded by "([^"]*)" backticks$/) do |arg|
  pending
end

And(/^the page "([^"]*)" have surrounding content$/) do |arg|
  pending
end

def get_max_sentence_filepath
  "build/sentence-length/#{@page}.html"
end
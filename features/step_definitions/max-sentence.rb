Given('the page has {string}') do |content|
  if "a single long sentence" == content
    @page = "single-long"
  elsif "a single short sentence" == content
    @page = "single-short"
  elsif "four short sentences" == content
    @page = "four-short"
  elsif "four long sentences" == content
    @page = "four-long"
  elsif "three long and six short sentences" == content
    @page = "three-long-six-short"
  elsif "a sentence over 25 words expanding an acronym" == content
    @page = "long-expanding-acronym"
   elsif "a sentence under 26 words expanding an acronym" == content
    @page = "short-expanding-acronym"
   elsif "a sentence over 25 words containing an acronym" == content
    @page = "long-unexpanded-acronym"
   elsif "a sentence under 26 words containing an acronym" == content
    @page = "short-unexpanded-acronym"
   elsif "under 26 words with a full url" == content
    @page = "short-sentence-full-url"
   elsif "over 25 words with a full url" == content
    @page = "long-sentence-full-url"
   elsif "under 26 words with a version number" == content
    @page = "short-sentence-version-number"
   elsif "over 25 words with a version number" == content
    @page = "long-sentence-version-number"
   elsif "under 26 words with a URN" == content
    @page = "short-sentence-version-number"
   elsif "over 25 words with a URN" == content
    @page = "long-sentence-version-number"
   else
    raise NotImplementedError, "Unimplemented scenario: #{content}"
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
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
  elsif "a short sentence with a hyphenated word" == content
    @page = "short-sentence-hyphen"
  elsif "a long sentence with a hyphenated word" == content
    @page = "long-sentence-hyphen"
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
   elsif "a code block inline" == content
    @page = "inline-code-block"
   elsif "a code block not inline" == content
    @page = "stand-alone"
   else
    raise NotImplementedError, "Unimplemented scenario: #{content}"
  end

end

And("the code block is surrounded by {string} backticks") do |single_triple|
  if single_triple == "single"
    @page << "-single-ticks"
  elsif single_triple == "triple"
    @page << "-tripple-ticks"
  else
    raise NotImplementedError, "Unimplemented scenario: the code block is surrounded by #{single_triple} backticks"
  end
end

And("the total length of the sentence is {string} words") do |sentence_length|
  if "under 26 words" == sentence_length
    @page << "-short-sentence"
  elsif "over 25 words" == sentence_length
    @page << "-long-sentence"
  else
    raise NotImplementedError, "Unimplemented scenario: the total length of the sentence is #{sentence_length} words"
  end
end

And("the page {string} have surrounding content") do |does_not|
  if "does" == does_not
    @page << "-code-block-surrounded"
  elsif "does_not" == does_not
    @page << "-code-block"
  else
    raise NotImplementedError, "Unimplemented scenario: the page #{does_not} have surrounding content"
  end
end

def get_max_sentence_filepath
  "build/sentence-length/#{@page}.html"
end
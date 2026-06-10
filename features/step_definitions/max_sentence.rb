Given("the page has {string}") do |content|
  case content
  when "a single long sentence"
    @page = "single-long"
  when "a single short sentence"
    @page = "single-short"
  when "four short sentences"
    @page = "four-short"
  when "four long sentences"
    @page = "four-long"
  when "three long and six short sentences"
    @page = "three-long-six-short"
  when "a short sentence with a hyphenated word"
    @page = "short-sentence-hyphen"
  when "a long sentence with a hyphenated word"
    @page = "long-sentence-hyphen"
  when "a sentence over 25 words expanding an acronym"
    @page = "long-expanding-acronym"
  when "a sentence under 26 words expanding an acronym"
    @page = "short-expanding-acronym"
  when "a sentence over 25 words containing an acronym"
    @page = "long-unexpanded-acronym"
  when "a sentence under 26 words containing an acronym"
    @page = "short-unexpanded-acronym"
  when "under 26 words with a full url"
    @page = "short-sentence-full-url"
  when "over 25 words with a full url"
    @page = "long-sentence-full-url"
  when "under 26 words with a version number"
    @page = "short-sentence-version-number"
  when "over 25 words with a version number"
    @page = "long-sentence-version-number"
  when "under 26 words with a URN"
    @page = "short-sentence-version-number"
  when "over 25 words with a URN"
    @page = "long-sentence-version-number"
  when "a code block inline"
    @page = "inline-code-block"
  when "a code block not inline"
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
  if sentence_length == "under 26 words"
    @page << "-short-sentence"
  elsif sentence_length == "over 25 words"
    @page << "-long-sentence"
  else
    raise NotImplementedError, "Unimplemented scenario: the total length of the sentence is #{sentence_length} words"
  end
end

And("the page {string} have surrounding content") do |does_not|
  if does_not == "does"
    @page << "-code-block-surrounded"
  elsif does_not == "does_not"
    @page << "-code-block"
  else
    raise NotImplementedError, "Unimplemented scenario: the page #{does_not} have surrounding content"
  end
end

def get_max_sentence_filepath
  "build/sentence-length/#{@page}.html"
end

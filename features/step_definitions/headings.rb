Given("the page has {string} tag") do |heading_tag|
  if heading_tag == "a single h1"
    @page = "valid-structure"
  elsif heading_tag == "more than one h1"
    @page = "invalid-structure"
  elsif ["an h4", "an h5", "an h6"].include? heading_tag
    @page = "invalid-structure"
  elsif ["a h1 and a h2 tag", "a h2 and a h2 tag","a h2 and a h3 tag", "a h3 and a h3 tag"].include? heading_tag
    @page = "missing-content/"
  elsif heading_tag == "a quite long header"
    @page = "length"
  else
    raise NotImplementedError, "Unimplemented step: #{heading_tag}"
  end
end

Given("there is {string} between them") do |content|
  if content == "no content"
    @page << "no-content"
  elsif content == "a table with no lead in line"
    @page << "table"
  elsif content == "a diagram with no lead in line"
    @page << "diagram"
  elsif content == "a code block with no lead in line"
    @page << "code-block"
  else
    raise NotImplementedError, "Unimplemented step: #{content}"
  end
end

Given('the heading contains {string} and the last character in the heading is {string}') do |non_terminal, terminal_punctuation_mark|
  # Target the already-created build directory directly
  @page = "test_#{terminal_punctuation_mark}_punctuation"
  @dynamic_file_path = File.join(BUILD_DIR, "/headings/#{@page}.html")

  # Mimic the HTML output Middleman would normally generate
  html_content = %(
    <!DOCTYPE html>
    <html>
      <body>
        <h1 id="test-heading">Testing punctuation like this #{non_terminal} in headings  headings is fun#{terminal_punctuation_mark}</h1>
        <p>Some standard body content here.</p>
      </body>
    </html>
  )

  File.write(@dynamic_file_path, html_content)
end

Given('heading tag {string} is followed by heading tag {string}') do | tag1, tag2|
  @page = "test_#{tag1}_to_#{tag2}"
  @dynamic_file_path = File.join(BUILD_DIR, "/headings/#{@page}.html")

  # Mimic the HTML output Middleman would normally generate
  html_content = %(
    <!DOCTYPE html>
    <html>
      <body>
        <#{tag1}>Testing headings is fun</#{tag1}>
          <p>There is a big old chunk of content here</p>
        <#{tag2}>Unless you like cheese</#{tag2}>
      </body>
    </html>
  )

  File.write(@dynamic_file_path, html_content)

end

def get_headings_filepath
  "build/headings/#{@page}.html"
end

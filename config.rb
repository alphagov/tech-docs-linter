require 'html-proofer'
require 'govuk_tech_docs'
require 'open3'
require 'json'

GovukTechDocs.configure(self)

after_build do |builder|
  begin
    
    # {stderr.read} #{wait_thr.value.exitstatus}
    puts("\n\nResults of Vale's style checks:")
    puts("\nFor each suggestion, the numbers at the start are the line number and character number in the HTML file - not the Markdown file)")
    stdin, stdout, stderr, wait_thr = Open3.popen3("vale --no-wrap build/")
    if wait_thr.value.exitstatus == 0 || wait_thr.value.exitstatus == 1
      vale_results = stdout.read
      puts(vale_results)
    else
      puts(wait_thr.value.exitstatus)
      puts(stderr)
    end

    puts("\n\nResults of HTMLProofer's checks:")
    HTMLProofer.check_directory(config[:build_dir],
      { :assume_extension => true,
        :disable_external => false,
        :allow_hash_href => true,
        :empty_alt_ignore => true,
        :extensions => "",
        :log_level => ':warn',
      }
    ).run

      
  rescue RuntimeError => e
    abort e.to_s
  end
  
end

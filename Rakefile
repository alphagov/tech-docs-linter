# Rakefile
require 'json'
require 'open3'
require 'set'

desc "Run Vale and output unique errors in a beautifully aligned, colorized terminal table"
namespace :lint do
  task :vale, [:target_dir] do |t, args|
    target = args[:target_dir] || "."

    stdout, stderr, status = Open3.capture3("vale --output=JSON #{target}")

    # Helper to print the raw JSON blocks for downstream CI consumption
    def finish_with_summary(totals)
      puts "\n" + "=" * [0, 40].max
      puts "\e[1m📊 Vale summary\e[0m"
      puts "=" * [0, 40].max
      puts "  Errors:      #{totals['error'] > 0 ? colorize(totals['error'], 'error') : totals['error']}"
      puts "  Warnings:    #{totals['warning'] > 0 ? colorize(totals['warning'], 'warning') : totals['warning']}"
      puts "  Suggestions: #{totals['suggestion'] > 0 ? colorize(totals['suggestion'], 'suggestion') : totals['suggestion']}"
      puts "-" * [0, 40].max
      exit 0 # Always exit 0 so individual project pipelines can evaluate the data themselves
    end

    # Color Escape Helper
    def colorize(text, severity)
      case severity.downcase
      when 'error'      then "\e[31m#{text}\e[0m" # Red
      when 'warning'    then "\e[33m#{text}\e[0m" # Yellow
      when 'suggestion' then "\e[34m#{text}\e[0m" # Blue
      else "\e[36m#{text}\e[0m"                   # Cyan
      end
    end

    if stdout.strip.empty?
      puts "\e[32m✨ Vale Style Check: No errors found!\e[0m"
      finish_with_summary({ 'error' => 0, 'warning' => 0, 'suggestion' => 0 })
    end

    begin
      report = JSON.parse(stdout)
      raw_rows = []
      widths = { file: 9, line: 4, severity: 8, message: 7, rule: 7 }
      totals = { 'error' => 0, 'warning' => 0, 'suggestion' => 0 }

      report.each do |file_path, alerts|
        next if alerts.empty?
        seen_messages = Set.new

        alerts.each do |alert|
          msg = alert['Message']
          severity = alert['Severity'].downcase

          # --- DEDUPLICATION LOGIC ---
          is_duplicate = seen_messages.include?(msg)
          if is_duplicate && alert['Check'].downcase == "tech-writing-style-guide.acronym"
            next
          end
          seen_messages.add(msg)
          # ---------------------------

          row_data = {
            file: file_path,
            line: alert['Line'].to_s,
            severity: alert['Severity'],
            message: msg,
            rule: alert['Check']
          }
          raw_rows << row_data

          if totals.key?(severity)
            totals[severity] += 1
          else
            totals[severity] = 1
          end

          widths[:file]     = [widths[:file],     row_data[:file].length].max
          widths[:line]     = [widths[:line],     row_data[:line].length].max
          widths[:severity] = [widths[:severity], row_data[:severity].length].max
          widths[:message]  = [widths[:message],  row_data[:message].length].max
          widths[:rule]     = [widths[:rule],     row_data[:rule].length].max
        end
      end

      if raw_rows.empty?
        puts "\e[32m✨ Vale Style Check: All duplicate errors filtered out. Clear skies!\e[0m"
        finish_with_summary(totals)
      else
        # 1. Print the human-readable terminal table
        fmt = "%-#{widths[:file]}s | %-#{widths[:line]}s | %-#{widths[:severity]}s | %-#{widths[:message]}s | %s"
        puts "\e[1m🔍 Vale Style Linting Report\e[0m\n\n"
        header = sprintf(fmt, "File", "Line", "Severity", "Message", "Rule")
        puts "\e[1m#{header}\e[0m"
        puts "-" * header.length

        raw_rows.each do |row|
          colored_severity = colorize(row[:severity].upcase, row[:severity])
          severity_padding = " " * (widths[:severity] - row[:severity].length)
          padded_severity  = "#{colored_severity}#{severity_padding}"

          puts sprintf(
                 "%-#{widths[:file]}s | %-#{widths[:line]}s | %s | %-#{widths[:message]}s | \e[90m%s\e[0m",
                 row[:file], row[:line], padded_severity, row[:message], row[:rule]
               )
        end
        # 3. Hand over the raw numbers for CI evaluation
        finish_with_summary(totals)
      end

    rescue JSON::ParserError
      puts "\e[31m❌ Error parsing Vale payload:\e[0m\n#{stdout}"
      exit 1
    end
  end
end
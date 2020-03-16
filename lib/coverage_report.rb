# frozen_string_literal: true

class CoverageReport
  class << self
    def generate(type, report_path, data)
      if type == 'simplecov'
        simplecov(report_path, data)
      elsif type == 'lcov'
        lcov(report_path, data)
      else
        raise 'InvalidCoverageReportType'
      end
    end

    def simplecov(report_path, data)
      report = read_json(report_path)
      minumum_percent = data[:min]
      covered_percent = report.dig('result', 'covered_percent')
      { 'lines' => { 'covered_percent' => covered_percent, 'minumum_percent' => minumum_percent } }
    end

    def lcov(report_path, data)
      lcov_result = execute_lcov_parse(report_path)
      minumum_percent = data[:min]
      { 'lines' => { 'covered_percent' => lcov_covered_percent(lcov_result), 'minumum_percent' => minumum_percent } }
    end

    private

    def lcov_covered_percent(lcov_result)
      lines = lcov_result.map { |r| r['lines']['details'] }.flatten
      total_lines = lines.count.to_f.round(2)
      covered_lines = lines.select { |r| r['hit'] >= 1 }.count.to_f
      ((covered_lines / total_lines) * 100).round(2)
    end

    def execute_lcov_parse(report_path)
      puts "Report path: #{report_path}"
      bin_path = "#{File.dirname(__FILE__)}/../bin"
      JSON.parse(`node #{bin_path}/lcov-parse.js #{report_path}` || {})
    end

    def read_json(path)
      JSON.parse(File.read(path))
    end
  end
end

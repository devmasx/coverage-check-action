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
      lcov = LcovParse.new(File.read("/github/workspace/#{report_path}"))
      { 'lines' => { 'covered_percent' => lcov.covered_percent, 'minumum_percent' => data[:min] } }
    end

    private

    def read_json(path)
      JSON.parse(File.read(path))
    end
  end
end

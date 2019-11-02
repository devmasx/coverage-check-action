# frozen_string_literal: true

class CoverageReport
  def self.generate(type, report_path, data)
    if type == 'simplecov'
      simplecov(report_path, data)
    elsif type == 'jest'
      jest(report_path, data)
    else
      raise 'InvalidCoverageReportType'
    end
  end

  def self.simplecov(report_path, data)
    report = read_json(report_path)
    minumum_percent = data[:min]
    covered_percent = report.dig('result', 'covered_percent')
    { 'lines' => { 'covered_percent' => covered_percent, 'minumum_percent' => minumum_percent } }
  end

  def self.jest(report_path, data)
    report = read_json(report_path)
    minumum_percent = data[:min]
    covered_percent = report.dig('result', 'covered_percent')
    { 'lines' => { 'covered_percent' => covered_percent, 'minumum_percent' => minumum_percent } }
  end

  private

  def read_json(path)
    JSON.parse(File.read(path))
  end
end

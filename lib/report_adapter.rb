# frozen_string_literal: true

# https://developer.github.com/v3/checks/runs/#output-object
class ReportAdapter
  class << self
    CONCLUSION_TYPES = { failure: 'failure', success: 'success' }.freeze
    ANNOTATION_LEVEL = { notice: 'notice', warning: 'warning', failure: 'failure' }.freeze

    def conslusion(report)
      return CONCLUSION_TYPES[:failure] if security_warnings(report).positive?

      CONCLUSION_TYPES[:success]
    end

    def summary(report)
      "**Brakeman Report**:\n#{security_warnings(report)} security warnings\n#{check_table(report)}"
    end

    def annotations(report)
      report['warnings'].map do |error|
        {
          'path' => error['file'],
          'start_line' => error['line'],
          'end_line' => error['line'],
          'annotation_level' => ANNOTATION_LEVEL[:warning],
          'title' => "#{error['confidence']} - #{error['check_name']}",
          'message' => error['message']
        }
      end
    end

    private

    def check_table(report)
      uniq_checks(report).reduce('') { |memo, check| memo + "- [#{check[:check_name]}](#{check[:link]})\n" }
    end

    def uniq_checks(report)
      report['warnings'].map { |w| { check_name: w['check_name'], link: w['link'] } }.uniq { |w| w[:check_name] }
    end

    def security_warnings(report)
      report['scan_info']['security_warnings']
    end
  end
end

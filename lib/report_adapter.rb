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
      "**Brakeman Report**: \n - #{security_warnings(report)} security warnings"
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

    def security_warnings(report)
      report['scan_info']['security_warnings']
    end
  end
end

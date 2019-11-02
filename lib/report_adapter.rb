# frozen_string_literal: true

# https://developer.github.com/v3/checks/runs/#output-object
class ReportAdapter
  class << self
    CONCLUSION_TYPES = { failure: 'failure', success: 'success' }.freeze
    ANNOTATION_LEVEL = { notice: 'notice', warning: 'warning', failure: 'failure' }.freeze

    def conslusion(report)
      CONCLUSION_TYPES[:success]
    end

    def summary(report)
      "**Coverage**: #{report.dig('result', 'covered_percent')}%"
    end

    def annotations(report)
      []
    end
  end
end

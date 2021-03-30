# frozen_string_literal: true

# https://developer.github.com/v3/checks/runs/#output-object
class ReportAdapter
  class << self
    CONCLUSION_TYPES = { failure: 'failure', success: 'success' }.freeze
    ANNOTATION_LEVEL = { notice: 'notice', warning: 'warning', failure: 'failure' }.freeze

    def conclusion(report)
      lines_covered_percent(report) >= lines_minimum_percent(report).to_f ? CONCLUSION_TYPES[:success] : CONCLUSION_TYPES[:failure]
    end

    def summary(report)
      "**Coverage**:\n\n#{table_head}\n| Lines | #{lines_covered_percent(report)}%     | #{lines_minimum_percent(report)}%     |\n"
    end

    def annotations(_report)
      []
    end

    def lines_covered_percent(report)
      @lines_covered_percent ||= report.dig('lines', 'covered_percent')
    end

    private

    def table_head
      "| Type  | covered | minimum |\n| ----- | ------- | ------- |"
    end

    def lines_minimum_percent(report)
      @lines_minimum_percent ||= report.dig('lines', 'minumum_percent')
    end
  end
end

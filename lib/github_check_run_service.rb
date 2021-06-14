# frozen_string_literal: true

class GithubCheckRunService
  def initialize(report, github_data, report_name, report_adapter)
    @report = report
    @github_data = github_data
    @report_name = report_name
    @report_adapter = report_adapter
    @client = GithubClient.new(@github_data[:token], user_agent: 'coverage-action')
  end

  def run
    id = @client.post(
      endpoint_url,
      create_check_payload
    )['id']
    @summary = @report_adapter.summary(@report)
    @annotations = @report_adapter.annotations(@report)
    @conclusion = @report_adapter.conslusion(@report)
    @percent = @report_adapter.lines_covered_percent(@report)

    @client.patch(
      "#{endpoint_url}/#{id}",
      update_check_payload
    )
  end

  private

  def endpoint_url
    "/repos/#{@github_data[:owner]}/#{@github_data[:repo]}/check-runs"
  end

  def create_check_payload
    {
      name: @report_name,
      head_sha: @github_data[:sha],
      status: 'in_progress',
      started_at: Time.now.iso8601
    }
  end

  def update_check_payload
    {
      name: @report_name,
      head_sha: @github_data[:sha],
      status: 'completed',
      completed_at: Time.now.iso8601,
      conclusion: @conclusion,
      output: {
        title: "#{@report_name} #{@percent}%",
        summary: @summary,
        annotations: @annotations
      }
    }
  end
end

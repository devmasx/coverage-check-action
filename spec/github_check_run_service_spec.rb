# frozen_string_literal: true

require './spec/spec_helper'

describe GithubCheckRunService do
  let(:report) do
    { 'lines' => { 'covered_percent' => 80, 'minumum_percent' => 80 } }
  end
  let(:github_data) { { sha: 'sha', token: 'token', owner: 'owner', repo: 'repository_name' } }
  let(:service) { GithubCheckRunService.new(report, github_data, ReportAdapter) }

  it '#run' do
    stub_request(:any, 'https://api.github.com/repos/owner/repository_name/check-runs/id')
      .to_return(status: 200, body: '{}')

    stub_request(:any, 'https://api.github.com/repos/owner/repository_name/check-runs')
      .to_return(status: 200, body: '{"id": "id"}')

    output = service.run
    expect(output).to be_a(Hash)
  end
end

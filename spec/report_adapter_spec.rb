# frozen_string_literal: true

require './spec/spec_helper'

describe ReportAdapter do
  let(:brakeman_report) do
    JSON(File.read('./spec/fixtures/input.json'))
  end

  let(:adapter) { ReportAdapter }

  it '.conslusion' do
    result = adapter.conslusion(brakeman_report)
    expect(result).to eq('failure')
  end

  it '.summary' do
    result = adapter.summary(brakeman_report)
    expect(result).to be_a(String)
  end

  it '.annotations' do
    result = adapter.annotations(brakeman_report)
    expect(result).to eq([{
      'path' => 'app/controllers/posts_controller.rb',
      'start_line' => 17,
      'annotation_level' => 'warning',
      'end_line' => 17,
      'title' => 'High - MassAssignment',
      'message' => 'Parameters should be whitelisted for mass assignment'
    }])
  end
end

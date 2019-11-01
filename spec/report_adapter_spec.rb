# frozen_string_literal: true

require './spec/spec_helper'

describe ReportAdapter do
  let(:brakeman_report) do
    JSON(File.read('./spec/fixtures/report.json'))
  end

  let(:spec_annotations) do
    JSON(File.read('./spec/fixtures/output/annotations.json'))
  end

  let(:spec_summary) do
    File.read('./spec/fixtures/output/summary.md')
  end

  let(:adapter) { ReportAdapter }

  it '.conslusion' do
    result = adapter.conslusion(brakeman_report)
    expect(result).to eq('failure')
  end

  it '.summary' do
    result = adapter.summary(brakeman_report)
    expect(result).to eq(spec_summary)
  end

  it '.annotations' do
    result = adapter.annotations(brakeman_report)
    expect(result).to eq(spec_annotations)
  end
end

# frozen_string_literal: true

require './spec/spec_helper'

describe ReportAdapter do
  let(:report) do
    { 'lines' => { 'covered_percent' => 80, 'minumum_percent' => 80 } }
  end

  let(:spec_summary) do
    File.read('./spec/fixtures/output/summary.md')
  end

  let(:adapter) { ReportAdapter }

  it '.conclusion' do
    result = adapter.conclusion(report)
    expect(result).to eq('success')
  end

  it '.summary' do
    result = adapter.summary(report)
    expect(result).to eq(spec_summary)
  end

  it '.annotations' do
    result = adapter.annotations(report)
    expect(result).to eq([])
  end
end

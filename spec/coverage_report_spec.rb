# frozen_string_literal: true

require './spec/spec_helper'

describe CoverageReport do
  # it '.simplecov' do
  #   result = adapter.conslusion(report)
  #   expect(result).to eq('success')
  # end

  it '.lcov' do
    result = CoverageReport.lcov('./spec/fixtures/example.lcov', { min: 80 })
    expect(result['lines']['covered_percent']).to eq('sas')
  end
end

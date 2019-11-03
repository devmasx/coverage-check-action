# frozen_string_literal: true

require './spec/spec_helper'

describe CoverageReport do
  it '.simplecov' do
    result = CoverageReport.simplecov('./spec/fixtures/simplecov.json', min: 80)
    expect(result['lines']['covered_percent']).to eq(80.5)
  end
end

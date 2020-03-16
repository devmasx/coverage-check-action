class LcovParse
  def initialize(lcov_content)
    @lcov = lcov_content
  end

  def to_json
    @to_json ||= @lcov.split("end_of_record").map do |file_item|
      file_item.split("\n").reduce({}) do |memo, item|
        type, value = item.split(":")
        case type
        when "DA", "FNF", "FNH", "LF", "LH", "FN", "FNDA", "BRDA", "BRF", "BRH"
          memo[type] = [] unless memo[type]
          memo[type].push(value&.strip)
        when "TN", "SF"
          memo[type] = value
        end
        memo
      end
    end
  end

  def lines
    @lines ||=
      to_json.map{|it| it["DA"] }
        .flatten.compact
        .map{|it| it.split(",").last }
  end

  def total_lines
    lines.count
  end

  def covered_lines
    lines.select{|it| it == "1" }.count
  end

  def covered_percent
    ((covered_lines / total_lines.to_f) * 100).round(2)
  end
end

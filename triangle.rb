class TriangleChecker
  def self.check(a, b, c)
    is_triangle = [
      a < b + c,
      b < a + c,
      c < a + b
    ].all?
    {
      :general_triangle => is_triangle,
      :isosceles_triangle => [a == b, a == c, b == c].any?,
      :equilateral_triangle => a == b && b == c,
      :non_triangle => !is_triangle
    }.select{ |k, v| v == true }.keys
  end
end

def main()
  # key: symbol of the triangle
  # value: list [message, speciality score]
  #   The speciality score is used to filter the triangle to the most
  #   special triangle. Lower score = more general triangle. 0 = not a triangle.
  msg_map = {
    :non_triangle => ["三角形じゃないです＞＜", 0],
    :general_triangle => ["不等辺三角形ですね！", 1],
    :isosceles_triangle => ["二等辺三角形ですね！", 2],
    :equilateral_triangle => ["正三角形ですね！", 3]
  }
  args = ARGV.join().split(",").map { |x| Integer(x) }
  msg = msg_map.select { |k, v|
    TriangleChecker.check(args[0], args[1], args[2]).include?(k)
  }.values().sort{ |a, b| b[1] <=> a[1] }[0]
  puts "#{msg[0]}"
end

if __FILE__ == $0
  main()
end

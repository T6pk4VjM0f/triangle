#!/usr/bin/env ruby -wKU

require File.expand_path(File.dirname(__FILE__) + '/triangle')

def generate_normal_triangle()
  # Generate a general triangle.
  a = nil
  b = nil
  c = nil
  loop {
    a = rand(100) + 1
    b = rand(100) + 1
    c = rand(a + b - 1) + 1
    break if [
      a != b, a != c, b != c,
      a < b + c,
      b < a + c,
      c < a + b
    ].all?
  }
  [a, b, c]
end

def generate_isosceles_triangle()
  tri = nil
  loop {
    tri = [rand(100) + 1, nil, nil]
    tri[1] = tri[0]
    tri[2] = rand(tri[0] + tri[1] - 1) + 1
    break if [
      tri[1] != tri[2],
      tri[0] < tri[1] + tri[2],
      tri[1] < tri[0] + tri[2],
      tri[2] < tri[0] + tri[1],
    ].all?
  }
  tri
end

def generate_non_triangle()
  # Generate a non-triangle.
  a = nil
  b = nil
  c = nil
  loop {
    a = rand(100)
    b = rand(100)
    c = rand(a + b - 1)
    break if [a != b, a != c, b != c].any? && [
      a >= b + c,
      b >= a + c,
      c >= a + b
    ].any?
  }
  [a, b, c]
end

describe TriangleChecker do
  (100).times { |c|
    describe "For normal triangle (#{c})" do
      tri = generate_normal_triangle()
      it "Should be proper message #{tri}" do
        expect(TriangleChecker.check tri[0], tri[1], tri[2]).to eq(
          [:general_triangle]
        )
      end
    end

    describe "For isosceles triangle" do
      tri = generate_isosceles_triangle()
      it "Should be proper message #{tri}" do
        expect(TriangleChecker.check tri[0], tri[1], tri[2]).to eq(
          [:general_triangle, :isosceles_triangle]
        )
      end
    end

    describe "For equilateral triangle" do
      tri = rand(100) + 1
      it "Should be proper message #{tri}" do
        expect(TriangleChecker.check tri, tri, tri).to eq(
          [:general_triangle, :isosceles_triangle, :equilateral_triangle]
        )
      end
    end

    describe "For non triangle" do
      tri = generate_non_triangle()
      it "Should be proper message #{tri}" do
        expect(TriangleChecker.check tri[0], tri[1], tri[2]).to eql [
          :non_triangle
        ]
      end
    end
  }
end

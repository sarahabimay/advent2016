defmodule Advent2016Test do
  use ExUnit.Case

  test "starting position is (0,0)" do
    assert Advent2016.One.start_position == [0, 0]
  end

  test "starting position faces North" do
    assert Advent2016.One.start_direction == :N
  end

  test "direction moves from N, W, S, E with L turns" do
    assert Advent2016.One.direction(:N, :L) == :W
    assert Advent2016.One.direction(:E, :L) == :N
    assert Advent2016.One.direction(:S, :L) == :E
    assert Advent2016.One.direction(:W, :L) == :S
  end

  test "direction moves from N, E, S, W with R turns" do
    assert Advent2016.One.direction(:N, :R) == :E
    assert Advent2016.One.direction(:E, :R) == :S
    assert Advent2016.One.direction(:S, :R) == :W
    assert Advent2016.One.direction(:W, :R) == :N
  end

  test "from start position, x is positive if moving East" do
    instruction = {:R, 1}
    final_position = {[1, 0], :E}
    assert Advent2016.One.next_position({[0, 0], :N}, instruction) == final_position
  end

  test "from start position, x is negative if moving West" do
    instruction = {:L, 1}
    final_position = {[-1, 0], :W}
    assert Advent2016.One.next_position({[0, 0], :N}, instruction) == final_position
  end

  test "from start position, y is negative after two moves L " do
    instruction1 = {:L, 1}
    step = Advent2016.One.next_position({[0, 0], :N}, instruction1)
    instruction2 = {:L, 1}
    final_position = Advent2016.One.next_position(step, instruction2)
    assert final_position == {[-1, -1], :S}
  end

  test "from start position, y is negative after two moves R " do
    instruction1 = {:R, 1}
    step = Advent2016.One.next_position({[0, 0], :N}, instruction1)
    instruction2 = {:R, 1}
    final_position = Advent2016.One.next_position(step, instruction2)
    assert final_position == {[1, -1], :S}
  end

  test "from start position, after two moves R then L " do
    instruction1 = {:R, 1}
    step = Advent2016.One.next_position({[0, 0], :N}, instruction1)
    instruction2 = {:L, 1}
    final_position = Advent2016.One.next_position(step, instruction2)
    assert final_position == {[1, 1 ], :N}
  end

  test "from start position, after two moves L then R " do
    instruction1 = {:L, 1}
    step = Advent2016.One.next_position({[0, 0], :N}, instruction1)
    instruction2 = {:R, 1}
    final_position = Advent2016.One.next_position(step, instruction2)
    assert final_position == {[-1, 1], :N}
  end

  test "from non-start position, after one L move" do
    initial_location = { [-1, 1], :N}
    instruction = {:L, 1}
    final_position = Advent2016.One.next_position(initial_location, instruction)
    assert final_position == {[-2, 1], :W}
  end

  test "from non-start position, after one R move" do
    initial_location = {[-1, -1], :E}
    instruction = {:R, 1}
    final_position = Advent2016.One.next_position(initial_location, instruction)
    assert final_position == {[-1, -2], :S}
  end

  test "position after multiple moves 1" do
    location = {[0, 0], :N}
    instruction1 = {:R, 2}
    instruction2 = {:L, 3}
    directions = [instruction1, instruction2]
    final_position = Advent2016.One.final_position(location, directions)
    assert final_position == {[2, 3], :N}
  end

  test "position after multiple moves 2" do
    location = {[0, 0], :N}
    instruction1 = {:R, 2}
    instruction2 = {:R, 2}
    instruction3 = {:R, 2}
    directions = [instruction1, instruction2, instruction3]
    final_position = Advent2016.One.final_position(location, directions)
    assert final_position == {[0, -2], :W}
  end

  test "position after multiple moves 3" do
    location = {[0, 0], :N}
    instruction1 = {:R, 5}
    instruction2 = {:L, 5}
    instruction3 = {:R, 5}
    instruction4 = {:R, 3}
    directions = [instruction1, instruction2, instruction3, instruction4]
    final_position = Advent2016.One.final_position(location, directions)
    assert final_position == {[10, 2], :S}
  end

  test "parse instructions" do
    assert Advent2016.One.parse(['R33']) == [{:R, 33}]
    assert Advent2016.One.parse(['R3', 'L2', 'R4']) == [{:R, 3}, {:L, 2}, {:R, 4}]
    assert Advent2016.One.parse(['R5', 'L5', 'R5', 'R3']) == [{:R, 5}, {:L, 5}, {:R, 5}, {:R, 3}]

  end

  test "final test" do
    instructions = ['R5', 'L5', 'R5', 'R3']
    assert Advent2016.One.distance({[0, 0], :N}, instructions) == 12
  end

  test "full instructions" do
    instructions = ['R3', 'R1', 'R4', 'L4', 'R3',
                    'R1', 'R1', 'L3', 'L5', 'L5',
                    'L3', 'R1', 'R4', 'L2', 'L1',
                    'R3', 'L3', 'R2', 'R1', 'R1',
                    'L5', 'L2', 'L1', 'R2', 'L4',   'R1', 'L2',  'L4', 'R2',
                    'R2', 'L2', 'L4', 'L3', 'R1',   'R4', 'R3',  'L1', 'R1',
                    'L5', 'R4', 'L2', 'R185', 'L2', 'R4', 'R49', 'L3',
                    'L4', 'R5', 'R1', 'R1', 'L1',   'L1', 'R2',  'L1', 'L4',
                    'R4', 'R5', 'R4', 'L3', 'L5',   'R1', 'R71', 'L1', 'R1', 'R186',
                    'L5', 'L2', 'R5', 'R4', 'R1', 'L5', 'L2', 'R3', 'R2', 'R5', 'R5',
                    'R4', 'R1', 'R4', 'R2', 'L1', 'R4', 'L1', 'L4', 'L5', 'L4', 'R4',
                    'R5', 'R1', 'L2', 'L4', 'L1', 'L5', 'L3', 'L5', 'R2', 'L5', 'R4',
                    'L4', 'R3', 'R3', 'R1', 'R4', 'L1', 'L2', 'R2', 'L1', 'R4', 'R2',
                    'R2', 'R5', 'R2', 'R5', 'L1', 'R1', 'L4', 'R5', 'R4', 'R2', 'R4',
                    'L5', 'R3', 'R2', 'R5', 'R3', 'L3', 'L5', 'L4', 'L3', 'L2', 'L2',
                    'R3', 'R2', 'L1', 'L1', 'L5', 'R1', 'L3', 'R3', 'R4', 'R5', 'L3',
                    'L5', 'R1', 'L3', 'L5', 'L5', 'L2', 'R1', 'L3', 'L1', 'L3', 'R4',
                    'L1', 'R3', 'L2', 'L2', 'R3', 'R3', 'R4', 'R4', 'R1', 'L4', 'R1', 'L5']
    IO.puts Advent2016.One.distance({[0, 0], :N}, instructions)
  end

  def expected_directions(instructions) do
    list = String.split(instructions, ", ")
    split = Enum.map(list, fn(i) -> String.split(i, ~r{}, parts: 2) end)
    Enum.map(split, fn([t, b]) -> %{:turn => String.to_atom(t), :blocks => b} end)
  end
end

defmodule Advent2016.One do
  def distance(current_position = {[x, y], _}, instructions) do
    {[x_final, y_final], _} = final_position(current_position, parse(instructions))
    abs(x_final - x) + abs(y_final - y)
  end

  def parse([]), do: []
  def parse([[rotation | blocks] | rest]) when rotation === 82 do
    [{:R, List.to_integer(blocks)}] ++ parse(rest)
  end
  def parse([[rotation | blocks] | rest]) when rotation === 76 do
    [{:L, List.to_integer(blocks)}] ++ parse(rest)
  end

  def final_position(current_position, []), do: current_position

  def final_position(current_position, [head | rest]) do
    final_position(next_position(current_position, head), rest)
  end

  def next_position({[0, 0], :N}, {rotation, blocks}) do
    new_direction = direction(:N, rotation)
    {move([0, 0], new_direction, blocks), new_direction }
  end

  def next_position({current_position, current_direction}, {rotation, blocks}) do
    new_direction = direction(current_direction, rotation)
    {move(current_position, new_direction, blocks), new_direction}
  end

  def direction(:N, :R), do: :E
  def direction(:E, :R), do: :S
  def direction(:S, :R), do: :W
  def direction(:W, :R), do: :N

  def direction(:N, :L), do: :W
  def direction(:E, :L), do: :N
  def direction(:S, :L), do: :E
  def direction(:W, :L), do: :S

  def move([x, y], :E, blocks), do: [ x + blocks, y]
  def move([x, y], :W, blocks), do: [ x + -blocks, y]
  def move([x, y], :S, blocks), do: [ x, y + -blocks]
  def move([x, y], :N, blocks), do: [ x, y + blocks]
end

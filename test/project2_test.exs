defmodule Project2Test do
  use ExUnit.Case
  doctest Project2

  test "greets the world" do
    assert Project2.hello() == :world
  end
end

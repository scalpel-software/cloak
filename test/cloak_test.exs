defmodule CloakTest do
  use ExUnit.Case
  doctest Cloak

  test "greets the world" do
    assert Cloak.hello() == :world
  end
end

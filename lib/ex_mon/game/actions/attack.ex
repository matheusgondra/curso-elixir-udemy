defmodule ExMon.Game.Actions.Attack do
  @move_avg_power 18..25
  @move_rnd_power 10..35

  def attack_opponent(_opponent, move) do
    calculete_power(move)
  end

  defp calculete_power(:move_avg), do: Enum.random(@move_avg_power)
  defp calculete_power(:move_rnd), do: Enum.random(@move_rnd_power)
end

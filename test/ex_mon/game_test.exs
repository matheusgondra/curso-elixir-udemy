defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Player, Game}

  @player_test Player.build("Matheus", :chute, :soco, :cura)
  @computer_test Player.build("Robotinik", :chute, :soco, :cura)

  describe "start/2" do
    test "starts the game state" do
      assert {:ok, _pid} = Game.start(@computer_test, @player_test)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      Game.start(@computer_test, @player_test)

      expected_response = %{
        status: :started,
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Matheus"
        },
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotinik"
        },
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      Game.start(@computer_test, @player_test)

      expected_response = %{
        status: :started,
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Matheus"
        },
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotinik"
        },
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        status: :started,
        player: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Matheus"
        },
        computer: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotinik"
        },
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns a player from game state" do
      Game.start(@computer_test, @player_test)

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Matheus"
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the player turn" do
      Game.start(@computer_test, @player_test)

      expected_response = :player

      assert expected_response == Game.turn()
    end

    test "returns the computer turn" do
      Game.start(@computer_test, @player_test)

      Game.info()
      |> Game.update()

      expected_response = :computer

      assert expected_response == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "returns the player from game state" do
      Game.start(@computer_test, @player_test)

      expected_response = @player_test

      assert expected_response == Game.fetch_player(:player)
    end

    test "returns the computer from game state" do
      Game.start(@computer_test, @player_test)

      expected_response = @computer_test

      assert expected_response == Game.fetch_player(:computer)
    end
  end
end

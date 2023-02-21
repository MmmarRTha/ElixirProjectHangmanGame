defmodule Hangman do
  @moduledoc """
  Documentation for `Hangman`.
  """

  @doc """
  Starts the game.
  """
  def start_game do
    state =  %{word: "hangman", misses: [], matches: [], limit: 5, mask: "_"}
    {mask_word(state), state}
  end

  @doc """
  Lets the user taking a guess.
  """
  def take_a_guess(letter, %{limit: limit}  = state) when limit > 0 do
	  state = guess(letter, state)
  end

  def take_a_guess(_, state), do: format_response(state)

  ## Helpers
  defp format_response(state) do
	  {mask_word(state), state}
  end
  defp mask_word(%{matches: [], word: word, mask: mask} = _state) do
	  String.replace(word, ~r/./, mask)
  end

  defp mask_word(%{matches: matches, word: word, mask: mask} = _state) do
	  matches = Enum.join(matches)
	  String.replace(word, ~r/[^#{matches}}]/, mask)
  end

  defp guess(letter, state) do
	  %{word: word, misses: misses, matches: matches, limit: limit} = state

	  if String.contains?(word, letter) do
		  %{state | matches: [letter | matches]}
	  else
		  %{state | misses: [letter | misses], limit: limit - 1}
	  end
  end
end

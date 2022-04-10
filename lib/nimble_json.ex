defmodule NimbleJson do
  def decode(input) do
    case apply(NimbleJson.Parser, :parse, [input]) do
      {:ok, result, _, _, _, _} ->
        {:ok, result |> List.first() |> NimbleJson.Parser.Evaluator.eval()}

      {:error, message, _, _, _, _} ->
        {:error, message}
    end
  end

  def decode!(input) do
    {:ok, m} = decode(input)
    m
  end
end

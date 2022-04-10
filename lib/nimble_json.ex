defmodule NimbleJson do
  def decode(input) do
    case apply(NimbleJson.Parser, :parse, [input]) do
      {:ok, result, _, _, _, _} ->
        {:ok, result |> List.first() |> NimbleJson.Parser.Evaluator.to_map()}

      {:error, message, _, _, _, _} ->
        {:error, message}
    end
  end

  def decode!(input) do
    {:ok, m} = decode(input)
    m
  end

  def encode(input) do
    try do
      json_string = input |> NimbleJson.Parser.Evaluator.to_json_string()
      {:ok, json_string}
    rescue
      e -> {:error, e}
    end
  end

  def encode!(input) do
    {:ok, json_string} = encode(input)
    json_string
  end
end

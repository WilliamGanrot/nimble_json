defmodule NimbleJson.Parser.Evaluator do
  def eval({:object, key_value_pairs}) do
    key_value_pairs
    |> Enum.map(fn [k, {tag, val}] ->
      {k, eval({tag, val})}
    end)
    |> Enum.into(%{})
  end

  def eval({:litteral, val}), do: val

  def eval({:list, values}) do
    values
    |> Enum.map(fn {tag, val} ->
      eval({tag, val})
    end)
  end

  def eval(key, {tag, val}), do: {key, eval(tag, val)}
end

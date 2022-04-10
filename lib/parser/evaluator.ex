defmodule NimbleJson.Parser.Evaluator do
  def to_map({:object, key_value_pairs}) do
    key_value_pairs
    |> Enum.map(fn [k, {tag, val}] ->
      {k, to_map({tag, val})}
    end)
    |> Enum.into(%{})
  end

  def to_map({:litteral, val}), do: val

  def to_map({:list, values}) do
    values
    |> Enum.map(fn {tag, val} ->
      to_map({tag, val})
    end)
  end

  def to_map(key, {tag, val}), do: {key, to_map(tag, val)}

  def from_struct_rec(s) when is_struct(s) do
    s
    |> Map.from_struct()
    |> Enum.map(fn {key, value} -> {key, from_struct_rec(value)} end)
    |> Enum.into(%{})
  end

  def to_json_string(m) when is_map(m) do
    x =
      m
      |> Enum.map(fn {key, value} -> "\"#{key}\":#{to_json_string(value)}" end)
      |> Enum.join(",")

    "{" <> x <> "}"
  end

  def to_json_string(l) when is_list(l) do
    x =
      l
      |> Enum.map(&to_json_string/1)
      |> Enum.join(",")

    "[" <> x <> "]"
  end

  def to_json_string(a) when is_atom(a) do
    "\"" <> Atom.to_string(a) <> "\""
  end

  def to_json_string(i) when is_integer(i) do
    i
  end

  def to_json_string(f) when is_float(f) do
    f
  end

  def to_json_string(n) when is_nil(n) do
    "null"
  end

  def to_json_string(a) when is_binary(a) do
    "\"" <> a <> "\""
  end
end

defmodule NimbleJsonTest do
  use ExUnit.Case
  doctest NimbleJson

  test "can parse raw string into parsed syntax" do
    encoded = "{\"a\" : null, \"b\": \"hej\", \"c\":{\"d\": [\"this\", \"is\", \"cool\"]}}"
    {:ok, parsed, _, _, _, _} = NimbleJson.Parser.parse(encoded)

    assert [
             object: [
               ["a", {:litteral, nil}],
               ["b", {:litteral, "hej"}],
               [
                 "c",
                 {:object, [["d", {:list, [litteral: "this", litteral: "is", litteral: "cool"]}]]}
               ]
             ]
           ] == parsed
  end

  test "can eval parsed syntax to map" do
    parsed = {
      :object,
      [
        ["a", {:litteral, nil}],
        ["b", {:litteral, "hej"}],
        [
          "c",
          {:object, [["d", {:list, [litteral: "this", litteral: "is", litteral: "cool"]}]]}
        ]
      ]
    }

    expected = %{"a" => nil, "b" => "hej", "c" => %{"d" => ["this", "is", "cool"]}}

    assert expected == parsed |> NimbleJson.Parser.Evaluator.eval()
  end
end

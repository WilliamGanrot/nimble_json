# NimbleJson
A json decoder/encoder solely created to test the parser combinator library [nimble_parsec](https://github.com/dashbitco/nimble_parsec) :)

## Decode

```elixir
json_string = "{\"a\":\"wow\",\"c\":{\"l\":[\"a\",23.2],\"x\":23}}"

{:ok, %{"a" => "wow", "c" => %{"l" => ["a", 23.2], "x" => 23}}} =
      NimbleJson.decode(json_string)
```



## Encode

```elixir
m = %{
      a: "wow",
      c: %{l: ["a", 23.2], x: 23}
    }
    
{:ok, "{\"a\":\"wow\",\"c\":{\"l\":[\"a\",23.2],\"x\":23}}"} = NimbleJson.encode(m)

```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nimble_json` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nimble_json, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/nimble_json>.

## License
Copyright 2022 WilliamGanrot

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```http://www.apache.org/licenses/LICENSE-2.0```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License

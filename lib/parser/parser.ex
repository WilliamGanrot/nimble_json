defmodule NimbleJson.Parser do
  import NimbleParsec
  import NimbleJson.Parser.Helper

  defparsecp(:json_string, quoted_string() |> unwrap_and_tag(:litteral))
  defparsecp(:json_key, quoted_string(1))

  defparsecp(:null, string("null") |> replace(nil) |> unwrap_and_tag(:litteral))

  defparsecp(
    :value,
    choice([parsec(:json_string), parsec(:null), parsec(:object), parsec(:list)])
  )

  defparsecp(
    :key_value_pair,
    parsec(:json_key)
    |> ignore(white_space())
    |> ignore(string(":"))
    |> ignore(white_space())
    |> concat(parsec(:value))
    |> wrap()
  )

  defparsecp(
    :kvp_list,
    list_separated_by(
      parsec(:key_value_pair),
      ignore(concat(string(","), white_space()))
    )
    |> wrap()
  )

  defparsecp(
    :list,
    ignore(string("["))
    |> concat(
      list_separated_by(
        parsec(:value) |> ignore(white_space()),
        ignore(concat(string(","), white_space()))
      )
    )
    |> ignore(string("]"))
    |> tag(:list)
  )

  defparsecp(
    :object,
    ignore(string("{"))
    |> ignore(white_space())
    |> concat(parsec(:kvp_list))
    |> ignore(white_space())
    |> ignore(string("}"))
    |> unwrap_and_tag(:object)
  )

  defparsec(
    :parse,
    choice([parsec(:object), parsec(:list)])
  )
end

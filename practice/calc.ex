defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def tag_token(expr) do
    # Referred to https://elixirschool.com/en/lessons/basics/control-structures/
    case expr do
        n when n in ["+","-","*","/"] ->
            {:op,expr}
        _ ->
            {:num,parse_float(expr)}
    end
  end

  def tag_tokens(splts) do
    # Referred to https://elixirschool.com/en/lessons/basics/enum/#map
    Enum.map(splts,fn(x) -> tag_token(x) end)
  end

  def compute(splts) do
    # IO.inspect 
    splts
    |> compute_div
    |> compute_mul
    |> compute_sub
    |> compute_add
  end

  def compute_div(splts) do
    case splts do
        [{:num,num1},{:op,"/"},{:num,num2} | tail] -> compute_div([{:num,num1/num2} | tail])
        [h1, h2 | tail ] -> [h1] ++ [h2] ++ compute_mul(tail)
        _ -> splts
    end
  end

  def compute_mul(splts) do
    IO.inspect splts
    case splts do
        [{:num,num1},{:op,"*"},{:num,num2} | tail] -> compute_mul([{:num,num1*num2} | tail])
        [h1, h2 | tail ] -> [h1] ++ [h2] ++ compute_mul(tail)
        _ -> splts
    end
  end

  def compute_sub(splts) do
    case splts do
        [{:num,num1},{:op,"-"},{:num,num2} | tail] -> compute_sub([{:num,num1-num2} | tail])
        [h1, h2 | tail ] -> [h1] ++ [h2] ++ compute_mul(tail)
        _ -> splts
    end
  end

  def compute_add(splts) do
    IO.puts("----------------")
    IO.inspect splts
    case splts do
        [{:num,num1},{:op,"+"},{:num,num2} | tail] -> compute_add([{:num,num1+num2} | tail])
        [{:num,num1}] -> num1
        _ -> splts
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> compute

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end

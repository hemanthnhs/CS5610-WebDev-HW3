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
    |> compute_higher_precidence
    |> compute_lower_precidence
  end

  def compute_higher_precidence(splts) do
    case splts do
        # Referred to https://elixirforum.com/t/easiest-pattern-match-for-first-two-elements-of-a-list-of-at-least-two-elements/707
        [{:num,num1},{:op,"/"},{:num,num2} | tail] -> compute_higher_precidence([{:num,num1/num2} | tail])
        [{:num,num1},{:op,"*"},{:num,num2} | tail] -> compute_higher_precidence([{:num,num1*num2} | tail])
        [h1, h2 | tail ] -> [h1] ++ [h2] ++ compute_higher_precidence(tail)
        _ -> splts
    end
  end

  def compute_lower_precidence(splts) do
    case splts do
        [{:num,num1},{:op,"-"},{:num,num2} | tail] -> compute_lower_precidence([{:num,num1-num2} | tail])
        [{:num,num1},{:op,"+"},{:num,num2} | tail] -> compute_lower_precidence([{:num,num1+num2} | tail])
        [{:num,num1}] -> num1
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

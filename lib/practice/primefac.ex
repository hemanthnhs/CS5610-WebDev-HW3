defmodule Practice.Primefac do
  def parse_int(text) do
    # Referred to elixir docs
    {num, _} = Integer.parse(text)
    num
  end

  def check_factor(num, factor, acc) do
    cond do
      rem(num,factor) == 0 ->
        num = trunc(num/factor)
        acc = acc ++ [factor] 
        check_factor(num, factor, acc)
      true -> {num, acc}
    end
  end

  def compute_primes(num, cur_factor, acc) when cur_factor < num/2 do
    IO.inspect(acc)
    IO.puts("hhhhhhhhhhhhhhhhhhhhhhhhhhh")
    cond do
      cur_factor == 2 ->
        {num,acc} = check_factor(num, cur_factor, acc)
        compute_primes(num, cur_factor+1, acc)
      true -> 
        {num,acc} = check_factor(num, cur_factor, acc)
        compute_primes(num, cur_factor+2, acc)
    end
  end

  def compute_primes(num, cur_factor, acc) do
    cond do
      num == 1 ->
        acc
        IO.puts("qqqqqqqqqqqqqqqqqqqqqqqqq")
        IO.inspect(acc)
      true -> 
        acc = acc ++ [num]
        IO.puts("qqqqqqqqqqqqqqqqqqqqqqqqq")
        IO.inspect(acc)
        acc
    end
  end

  def prime(text) do
    # using accumulator approach
    text
    |> parse_int
    |> compute_primes(2, [])
  end
end

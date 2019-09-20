defmodule Practice.Primefac do
  def parse_int(text) do
    # Referred to elixir docs and started code provided as in HomeWork
    cond do
      is_integer(text) -> 
        text
      true ->
        {num, _} = Integer.parse(text)
        num    
    end
  end

  def check_factor(num, factor, acc) do
    # Number of times current factor existed in this
    cond do
      rem(num,factor) == 0 ->
        num = trunc(num/factor)
        acc = acc ++ [factor] 
        check_factor(num, factor, acc)
      true -> {num, acc}
    end
  end

  def compute_primes(num, cur_factor, acc) when cur_factor <= num/2 do
    # Method to check for each factor
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
    # When current factor becomes greater than num/2, if num still remained append and return else return
    # breaking condition
    cond do
      num == 1 ->
        acc
      true -> 
        acc = acc ++ [num]
        acc
    end
  end

  def prime(text) do
    # using accumulator approach
    # 1 doesnt have any prime factors hence returning empty
    cond do
      text == "1" ->
      []
    true ->
      text
      |> parse_int
      |> compute_primes(2, [])
    end
  end
end

defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    # Maybe delegate this too.
    Practice.Primefac.prime(x)
  end

  def palindrome(x) do
    # Referred https://hexdocs.pm/elixir/String.html
    dwn = String.downcase(x)
    reversed  = String.reverse(dwn)
    dwn == reversed
  end
end

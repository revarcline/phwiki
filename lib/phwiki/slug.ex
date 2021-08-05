defmodule Phwiki.Slug do
  @moduledoc "helper module to create slugs"
  def slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end

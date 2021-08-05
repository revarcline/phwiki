defimpl Phoenix.Param, for: Phwiki.Wiki.Article do
  def to_param(%{slug: slug}) do
    "#{slug}"
  end
end

defimpl Phoenix.Param, for: Phwiki.Accounts.User do
  def to_param(%{slug: slug}) do
    "#{slug}"
  end
end

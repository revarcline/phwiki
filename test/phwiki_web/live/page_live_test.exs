defmodule PhwikiWeb.PageLiveTest do
  use PhwikiWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to Phwiki!"
    assert render(page_live) =~ "Welcome to Phwiki!"
  end
end

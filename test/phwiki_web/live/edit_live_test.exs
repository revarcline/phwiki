defmodule PhwikiWeb.EditLiveTest do
  use PhwikiWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Phwiki.Wiki

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  defp fixture(:edit) do
    {:ok, edit} = Wiki.create_edit(@create_attrs)
    edit
  end

  defp create_edit(_) do
    edit = fixture(:edit)
    %{edit: edit}
  end

  describe "Index" do
    setup [:create_edit]

    test "lists all edits", %{conn: conn, edit: edit} do
      {:ok, _index_live, html} = live(conn, Routes.edit_index_path(conn, :index))

      assert html =~ "Listing Edits"
      assert html =~ edit.content
    end

    test "saves new edit", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.edit_index_path(conn, :index))

      assert index_live |> element("a", "New Edit") |> render_click() =~
               "New Edit"

      assert_patch(index_live, Routes.edit_index_path(conn, :new))

      assert index_live
             |> form("#edit-form", edit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#edit-form", edit: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.edit_index_path(conn, :index))

      assert html =~ "Edit created successfully"
      assert html =~ "some content"
    end

    test "updates edit in listing", %{conn: conn, edit: edit} do
      {:ok, index_live, _html} = live(conn, Routes.edit_index_path(conn, :index))

      assert index_live |> element("#edit-#{edit.id} a", "Edit") |> render_click() =~
               "Edit Edit"

      assert_patch(index_live, Routes.edit_index_path(conn, :edit, edit))

      assert index_live
             |> form("#edit-form", edit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#edit-form", edit: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.edit_index_path(conn, :index))

      assert html =~ "Edit updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes edit in listing", %{conn: conn, edit: edit} do
      {:ok, index_live, _html} = live(conn, Routes.edit_index_path(conn, :index))

      assert index_live |> element("#edit-#{edit.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#edit-#{edit.id}")
    end
  end

  describe "Show" do
    setup [:create_edit]

    test "displays edit", %{conn: conn, edit: edit} do
      {:ok, _show_live, html} = live(conn, Routes.edit_show_path(conn, :show, edit))

      assert html =~ "Show Edit"
      assert html =~ edit.content
    end

    test "updates edit within modal", %{conn: conn, edit: edit} do
      {:ok, show_live, _html} = live(conn, Routes.edit_show_path(conn, :show, edit))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Edit"

      assert_patch(show_live, Routes.edit_show_path(conn, :edit, edit))

      assert show_live
             |> form("#edit-form", edit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#edit-form", edit: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.edit_show_path(conn, :show, edit))

      assert html =~ "Edit updated successfully"
      assert html =~ "some updated content"
    end
  end
end

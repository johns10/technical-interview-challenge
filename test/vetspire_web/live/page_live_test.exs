defmodule VetspireWeb.PageLiveTest do
  use VetspireWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Dogs"
    assert render(page_live) =~ "Dogs"
  end
end

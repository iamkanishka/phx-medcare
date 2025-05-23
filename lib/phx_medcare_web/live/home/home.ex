defmodule PhxMedcareWeb.Home.Home do
  use PhxMedcareWeb, :live_view

  alias PhxMedcareWeb.Components.Mainlayout

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(
       is_mobile_open: false,
       is_expanded: false,
       is_hovered: false
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.live_component module={Mainlayout} id={:mainlayout} is_mobile_open={@is_mobile_open} is_expanded={@is_expanded} is_hovered={@is_hovered}>
      <div class="text-2xl font-bold">Welcome to the Home Page!</div>
    </.live_component>
    """
  end
end

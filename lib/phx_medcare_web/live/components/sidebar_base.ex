defmodule PhxMedcareWeb.Components.SidebarBase do
  use PhxMedcareWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div className="fixed inset-0 z-40 bg-gray-900 bg-opacity-50 lg:hidden"></div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end
end

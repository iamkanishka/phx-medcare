defmodule PhxMedcareWeb.Components.Mainlayout do
  use PhxMedcareWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen xl:flex">
      <div>
        <.live_component module={PhxMedcareWeb.Components.Sidebar} id={:sidebar}></.live_component>

        <.live_component module={PhxMedcareWeb.Components.SidebarBase} id={:sidebar_base}>
        </.live_component>
      </div>

      <div class={
    "flex-1 transition-all duration-300 ease-in-out " <>
    if @is_expanded or @is_hovered, do: "lg:ml-[290px]", else: "lg:ml-[90px]" <>
    if @is_mobile_open, do: " ml-0", else: ""
    }>
        <.live_component module={PhxMedcareWeb.Components.Header} id={:sidebar} />
        <div class="p-4 mx-auto max-w-screen-2xl md:p-6">
          {render_slot(@inner_block)}
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end
end

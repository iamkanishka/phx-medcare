defmodule PhxMedcareWeb.Components.Sidebar do
  use PhxMedcareWeb, :live_component
  import Phoenix.HTML
  import Phoenix.HTML.Form

  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  def update(assigns, socket) do
    socket =
      socket
      |> assign_new(:is_expanded, fn -> false end)
      |> assign_new(:is_hovered, fn -> false end)
      |> assign_new(:is_mobile_open, fn -> false end)
      |> assign_new(:open_submenu, fn -> nil end)
      |> assign_new(:current_path, fn -> "" end)
      |> assign_new(:nav_items, fn -> nav_items() end)
      |> assign_new(:others_items, fn -> others_items() end)

    {:ok, assign(socket, assigns)}
  end

  def render(assigns) do
    ~H"""
    <div
      id="sidebar"
      class={
      "fixed z-50 top-0 left-0 h-screen bg-white dark:bg-gray-900 border-r" <>
      unless @is_expanded or @is_mobile_open or @is_hovered, do: "w-[290px]", else: "w-[90px]" <>
      if @is_mobile_open, do: "translate-x-0", else: "-translate-x-full" <>
      "lg:translate-x-0 transition-all duration-300"
    }
      phx-mouseenter={(@is_expanded && "noop") || "sidebar-hover-on"}
      phx-mouseleave="sidebar-hover-off"
      phx-target={@myself}
    >
      <div class={"py-8 flex" <> if @is_expanded or @is_hovered, do: "lg:justify-center", else: "justify-start" }>
        <%!-- <%= live_redirect to: page_path(@socket, :index) do %> --%>
        <%= if @is_expanded or @is_hovered or @is_mobile_open do %>
          <img src="/images/logo/logo.svg" class="dark:hidden" width="150" height="40" />
          <img src="/images/logo/logo-dark.svg" class="hidden dark:block" width="150" height="40" />
        <% else %>
          <img src="/images/logo/logo-icon.svg" width="32" height="32" />
        <% end %>
         <%!-- <% end %> --%>
      </div>

      <nav class="mb-6 overflow-y-auto">
        {render_nav_group(
          "Menu",
          @nav_items,
          :main,
          @open_submenu,
          @is_expanded,
          @is_hovered,
          @is_mobile_open,
          @current_path,
          @socket,
          @myself
        )} {render_nav_group(
          "Others",
          @others_items,
          :others,
          @open_submenu,
          @is_expanded,
          @is_hovered,
          @is_mobile_open,
          @current_path,
          @socket,
          @myself
        )}
      </nav>
    </div>
    """
  end

  def handle_event("toggle-submenu", %{"index" => idx, "type" => type}, socket) do
    type = String.to_existing_atom(type)
    index = String.to_integer(idx)

    new_state =
      case socket.assigns.open_submenu do
        %{type: ^type, index: ^index} -> nil
        _ -> %{type: type, index: index}
      end

    {:noreply, assign(socket, open_submenu: new_state)}
  end

  def handle_event("sidebar-hover-on", _, socket),
    do: {:noreply, assign(socket, is_hovered: true)}

  def handle_event("sidebar-hover-off", _, socket),
    do: {:noreply, assign(socket, is_hovered: false)}

  defp render_nav_group(
         title,
         items,
         type,
         open_submenu,
         expanded,
         hovered,
         mobile_open,
         current_path,
         socket,
         target
       ) do
    assigns = %{
      title: title,
      items: items,
      type: type,
      open_submenu: open_submenu,
      expanded: expanded,
      hovered: hovered,
      mobile_open: mobile_open,
      current_path: current_path,
      socket: socket,
      target: target
    }

    ~H"""
    <div class="mb-4">
      <h2 class="text-xs uppercase text-gray-400 px-4 mb-2">
        {if @expanded or @hovered or @mobile_open, do: @title, else: "..."}
      </h2>

      <%!-- <ul class="flex flex-col gap-2">
        <%= for {item, index} <- Enum.with_index(@items) do %>
          <li>
            <%= if item[:sub_items] do %>
              <button phx-click="toggle-submenu" phx-value-index={index} phx-value-type={@type} phx-target={@target} class="w-full flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                <%= item[:icon] %>
                <%= if @expanded or @hovered or @mobile_open do %>
                  <span class="ml-2"><%= item[:name] %></span>
                  <span class="ml-auto">▼</span>
                <% end %>
              </button>
              <div class={[
                "ml-6 overflow-hidden transition-all duration-300",
                if @open_submenu == %{type: @type, index: index}, do: "max-h-96", else: "max-h-0"
              ]}>
                <ul>
                  <%= for sub <- item[:sub_items] do %>
                    <li>
                      <%= live_redirect sub[:name],
                        to: page_path(@socket, sub[:path]),
                        class: ["block px-4 py-2 text-sm", if @current_path == sub[:path], do: "text-blue-600 font-bold"] %>
                    </li>
                  <% end %>
                </ul>
              </div>
            <% else %>
              <%= live_redirect to: page_path(@socket, item[:path]), class: "flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" do %>
                <%= item[:icon] %>
                <%= if @expanded or @hovered or @mobile_open do %><span class="ml-2"><%= item[:name] %></span><% end %>
              <% end %>
            <% end %>
          </li>
        <% end %>
      </ul> --%>
    </div>
    """
  end

  defp nav_items do
    [
      %{
        name: "Dashboard",
        icon: "📊",
        sub_items: [%{name: "Ecommerce", path: "/"}]
      },
      %{name: "Calendar", icon: "📅", path: "/calendar"}
    ]
  end

  defp others_items do
    [
      %{name: "Settings", icon: "⚙️", path: "/settings"}
    ]
  end
end

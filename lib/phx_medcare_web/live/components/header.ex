defmodule PhxMedcareWeb.Components.Header do
  use PhxMedcareWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <header class="sticky top-0 flex w-full bg-white border-gray-200 z-99999 dark:border-gray-800 dark:bg-gray-900 lg:border-b">
      <div class="flex flex-col items-center justify-between flex-grow lg:flex-row lg:px-6">
        <div class="flex items-center justify-between w-full gap-2 px-3 py-3 border-b border-gray-200 dark:border-gray-800 sm:gap-4 lg:justify-normal lg:border-b-0 lg:px-0 lg:py-4">
          <button
            class="items-center justify-center w-10 h-10 text-gray-500 border-gray-200 rounded-lg z-99999 dark:border-gray-800 lg:flex dark:text-gray-400 lg:h-11 lg:w-11 lg:border"
            phx-click="toggle_sidebar"
            aria-label="Toggle Sidebar"
          >
            <%= if @is_mobile_open do %>
              <!-- Cross Icon -->
              <svg width="24" height="24" fill="none" xmlns="http://www.w3.org/2000/svg">...</svg>
            <% else %>
              <!-- Hamburger Icon -->
              <svg width="16" height="12" fill="none" xmlns="http://www.w3.org/2000/svg">...</svg>
            <% end %>
          </button>

          <.link navigate="/" class="lg:hidden">
            <img class="dark:hidden" src="/images/logo/logo.svg" alt="Logo" />
            <img class="hidden dark:block" src="/images/logo/logo-dark.svg" alt="Logo" />
          </.link>

          <button
            phx-click="toggle_app_menu"
            class="flex items-center justify-center w-10 h-10 text-gray-700 rounded-lg z-99999 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-800 lg:hidden"
          >
            <!-- Dots Icon -->
            <svg width="24" height="24" fill="none" xmlns="http://www.w3.org/2000/svg">...</svg>
          </button>
          <div class="hidden lg:block">
            <form phx-submit="noop">
              <div class="relative">
                <span class="absolute -translate-y-1/2 pointer-events-none left-4 top-1/2">
                  <svg
                    class="fill-gray-500 dark:fill-gray-400"
                    width="20"
                    height="20"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    ...
                  </svg>
                </span>

                <input
                  id="search-input"
                  type="text"
                  placeholder="Search or type command..."
                  class="dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-200 bg-transparent py-2.5 pl-12 pr-14 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-none focus:ring focus:ring-brand-500/10 dark:border-gray-800 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800 xl:w-[430px]"
                  phx-hook="FocusOnShortcut"
                />
                <button
                  type="button"
                  class="absolute right-2.5 top-1/2 inline-flex -translate-y-1/2 items-center gap-0.5 rounded-lg border border-gray-200 bg-gray-50 px-[7px] py-[4.5px] text-xs -tracking-[0.2px] text-gray-500 dark:border-gray-800 dark:bg-white/[0.03] dark:text-gray-400"
                >
                  <span>⌘</span> <span>K</span>
                </button>
              </div>
            </form>
          </div>
        </div>

        <div class={"#{if @is_application_menu_open, do: "flex", else: "hidden"} items-center justify-between w-full gap-4 px-5 py-4 lg:flex shadow-theme-md lg:justify-end lg:px-0 lg:shadow-none"}>
          <div class="flex items-center gap-2 2xsm:gap-3">
            <!-- Dark Mode Toggler -->
            <%!-- {live_component(@socket, MyAppWeb.ThemeToggleComponent)} --%>

    <!-- Notifications -->
            <%!-- {live_component(@socket, MyAppWeb.NotificationDropdownComponent)} --%>
          </div>

    <!-- User -->
          <%!-- {live_component(@socket, MyAppWeb.UserDropdownComponent)} --%>
        </div>
      </div>
    </header>
    """
  end

  @impl true
  def update(assigns, socket) do
    socket =
      socket
      |> assign_new(:is_mobile_open, fn -> false end)
      |> assign_new(:is_application_menu_open, fn -> false end)

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("toggle_sidebar", _params, socket) do
    # Example logic - adjust based on your sidebar implementation
    {:noreply, update(socket, :is_mobile_open, &(!&1))}
  end

  @impl true
  def handle_event("toggle_app_menu", _params, socket) do
    {:noreply, update(socket, :is_application_menu_open, &(!&1))}
  end

  @impl true
  def handle_event("noop", _params, socket) do
    {:noreply, socket}
  end
end

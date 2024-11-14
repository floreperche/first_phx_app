defmodule FirstPhxAppWeb.TestLive do
    use FirstPhxAppWeb, :live_view
    
    #mount
    def mount(_params, _session, socket) do
        socket = assign(socket, brightness: 10)
        {:ok, socket}
    end

    #render
    def render (assigns) do
        ~H"""
        <h1 class="mb-8 text-4xl font-bold text-center">Front Porch Light</h1>
        <div id="light">
            <div class="w-full h-6 bg-gray-200 rounded mb-4">
                <div class="h-6 bg-yellow-300 rounded " style={"width: #{@brightness}%"}>
                    <%= @brightness %>%
                </div>
            </div>
            <div class="flex justify-center gap-4">  
            <button class="bg-gray-200 hover:bg-grey-300 py-2 px-4 rounded" phx-click='off'>
            <img src="/images/lightbulb-outline.svg" />
            </button>
            <button class="bg-gray-200 hover:bg-grey-300 py-2 px-4 rounded" phx-click='down'>
            <img src="/images/down.svg" />
            </button>
            <button class="bg-gray-200 hover:bg-grey-300 py-2 px-4 rounded" phx-click='up'>
            <img src="/images/up.svg" />
            </button>
            <button class="bg-gray-200 hover:bg-grey-300 py-2 px-4 rounded" phx-click='on'>
            <img src="/images/lightbulb.svg" />
            </button></div>
          
        </div>
        """
    end

    #handle_event
    def handle_event("on", _, socket) do
        socket = assign(socket, brightness: 100)
        {:noreply, socket}
    end

    def handle_event("up", _, socket) do
        if socket.assigns.brightness < 100 do
        socket = update(socket, :brightness, &(&1 + 10))
        {:noreply, socket}
        else
            socket = assign(socket, brightness: 100)
            {:noreply, socket}
        end
    end

    def handle_event("down", _, socket) do
        if socket.assigns.brightness > 0 do
            socket = update(socket, :brightness, &(&1 - 10))
            {:noreply, socket}
            else
                socket = assign(socket, brightness: 0)
                {:noreply, socket}
            end
    end

    def handle_event("off", _, socket) do
        socket = assign(socket, brightness: 0)
        {:noreply, socket}
    end
end
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
        <div class="bg-background px-16 py-8 rounded-2xl text-white flex flex-col gap-8 font-zendots text-center font-light">

            <h1 class="text-3xl mb-2">Front Porch Light</h1>
        
            <div class="flex items-center justify-between gap-8 h-10">
                    <div class="w-full bg-grey rounded-3xl relative">
                        <div style={"width: #{@brightness}%"} 
                        class="transition-all duration-300 ease-in-and-out h-10 bg-gradient-to-r from-primary to-secondary rounded-3xl blur-lg absolute"/>
                        <div class="w-full  rounded-3xl overflow-hidden ">                        
                            <div style={"width: #{@brightness}%"} class="transition-all duration-300 ease-in-and-out h-10 bg-gradient-to-r from-primary to-secondary rounded-3xl" />
                        </div>
                    </div>
                    <div class="flex w-28 justify-center items-center relative rounded-3xl">
                        <div style={"opacity: #{@brightness}%"} class="transition-all duration-300 ease-in-and-out w-24 h-full bg-gradient-to-r from-primary to-secondary absolute blur-lg rounded-3xl"></div>
                        <p class="z-10 w-24 bg-background rounded-3xl px-4 py-2 text-lg"><%= @brightness %>%</p>
                    </div>
                    
            </div>
            
            <div class="flex justify-center gap-4">  
                    <button class="border-2 border-white hover:bg-grey rounded-lg p-4 text-center disabled:opacity-50 disabled:cursor-not-allowed" disabled={@brightness == 0} phx-click='off'>
                        <img src="/images/lightbulb-outline.svg" />
                    </button>
                    <button class="border-2 border-white hover:bg-grey rounded-lg p-4 text-center disabled:opacity-50 disabled:cursor-not-allowed" disabled={@brightness == 0} phx-click='down'>
                        <img src="/images/down.svg" />
                    </button>
                    <button class="border-2 border-white hover:bg-grey rounded-lg p-4 text-center disabled:opacity-50 disabled:cursor-not-allowed" disabled={@brightness == 100} phx-click='up'>
                        <img src="/images/up.svg" />
                    </button>
                    <button class="border-2 border-white hover:bg-grey rounded-lg p-4 text-center disabled:opacity-50 disabled:cursor-not-allowed" disabled={@brightness == 100} phx-click='on'>
                        <img src="/images/lightbulb.svg" />
                    </button>
            </div>
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
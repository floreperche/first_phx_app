defmodule FirstPhxAppWeb.PaceLive do
    use FirstPhxAppWeb, :live_view

    
    #mount
    def mount(_params, _session, socket) do
        socket = assign(socket, form: to_form(%{"hour" => nil}))
        socket = assign(socket, form: to_form(%{"minute" => nil}))
        socket = assign(socket, hours: @form[:hour])
        socket = assign(socket, minutes: @form[:minute])
        socket = assign(socket, distance: 5)
        {:ok, socket}
      end

    #render
    def render (assigns) do
        ~H"""
        <h1 class="mb-8 text-4xl font-bold text-center">Pace Calculator</h1>
        <h2 class="mb-4 text-2xl font-semibold">Select your distance</h2>
        <div class="flex justify-center gap-4 mb-8">  
            <button class={"bg-gray-200 hover:bg-grey-300 py-2 px-4 rounded #{if( @distance === 5, do: "bg-indigo-200 font-semibold")}"} phx-click='5'>5km</button>
            <button class={"bg-gray-200 hover:bg-grey-300 py-2 px-4 rounded #{if( @distance === 10, do: "bg-indigo-200 font-semibold")}"} phx-click='10'>10km</button>
            <button class={"bg-gray-200 hover:bg-grey-300 py-2 px-4 rounded #{if( @distance === 21, do: "bg-indigo-200 font-semibold")}"} phx-click='21'>21km</button>
            <button class={"bg-gray-200 hover:bg-grey-300 py-2 px-4 rounded #{if( @distance === 42, do: "bg-indigo-200 font-semibold")}"} phx-click='42'>42km</button>
        </div>
        <h2 class="mb-4 text-2xl font-semibold">Select your total duration</h2>
        <div class="flex justify-center gap-4">
          <.form for={@form} phx-change="save-hour" id="hours" >
            <.input type="number"  field={@form[:hour]} label="Heure" />
          </.form>
          <.form for={@form} phx-change="save-minute" id="minutes" >
            <.input type="number" min="0" field={@form[:minute]} label="Minutes" />
          </.form></div>
          <div>
            <h2 class="mb-4 text-2xl font-semibold">Result</h2>
            <div>Selected distance: <%= @distance %>km</div>
            <div>Selected time: <%= @hours %>h<span :if={@minutes < 10}>0</span><%= @minutes%></div>
            <div>You should run at the following pace: </div>
          </div>
        """
    end

    #handle_event
    def handle_event("save-hour", %{"hour" => q}, socket) do
        socket = assign(socket, hours: q)
        {:noreply, socket }
      end

      def handle_event("save-minute", %{"minute" => q}, socket) do

        socket = assign(socket, minutes: String.to_integer(q))       
        {:noreply, socket }
      end

      def handle_event("5", _, socket) do
        socket = assign(socket, distance: 5)
        {:noreply, socket}
    end

    def handle_event("10", _, socket) do
        socket = assign(socket, distance: 10)
        {:noreply, socket}
    end

    def handle_event("21", _, socket) do
        socket = assign(socket, distance: 21)
        {:noreply, socket}
    end

    def handle_event("42", _, socket) do
        socket = assign(socket, distance: 42)
        {:noreply, socket}
    end

end
defmodule FirstPhxAppWeb.PaceLive do
    use FirstPhxAppWeb, :live_view


    #mount
    def mount(_params, _session, socket) do
        socket = assign(socket, form: to_form(%{"hour" => nil}))
        socket = assign(socket, form: to_form(%{"minute" => nil}))
        socket = assign(socket, hours: nil)
        socket = assign(socket, minutes: nil)
        socket = assign(socket, distance: 5)
        socket = assign(socket, resultMinutes: 0)
        socket = assign(socket, resultSeconds: 0)
        socket = assign(socket, showResult: false)
        socket = assign(socket, errorMessage: "")
        {:ok, socket}
      end

    #render
    def render (assigns) do
        ~H"""
        <div>
        <h1 class="mb-4 text-4xl">Running Pace Calculator</h1>
        <p>Calculate your pace for a variety of race distances (5K, 10K, half marathon and marathon) to achiev your finish time goal.</p>

        <div class="bg-slate-100 mt-8 p-8">
          <h2 class="mb-2 text-2xl">Select your distance</h2>
          <div class="flex justify-center gap-4 mb-8">
              <button  class={"border-2 border-orange hover:bg-lightOrange rounded px-4 py-2 text-center #{if( @distance === 5, do: "bg-orange hover:bg-orange text-white font-semibold")}"} phx-click='5'>5km</button>
              <button class={"border-2 border-orange hover:bg-lightOrange rounded px-4 py-2 text-center #{if( @distance === 10, do: "bg-orange hover:bg-orange text-white font-semibold")}"} phx-click='10'>10km</button>
              <button class={"border-2 border-orange hover:bg-lightOrange rounded px-4 py-2 text-center #{if( @distance === 21, do: "bg-orange hover:bg-orange text-white font-semibold")}"} phx-click='21'>21km</button>
              <button class={"border-2 border-orange hover:bg-lightOrange rounded px-4 py-2 text-center #{if( @distance === 42, do: "bg-orange hover:bg-orange text-white font-semibold")}"} phx-click='42'>42km</button>
          </div>
          <h2 class="mb-2 text-2xl">Select your total duration</h2>
          <div class="flex justify-center gap-4 mb-8">
            <.form for={@form} phx-change="save-hour" id="hours" >
              <.input type="number" min="0" field={@form[:hour]} label="Hours" />
            </.form>
            <.form for={@form} phx-change="save-minute" id="minutes" >
              <.input type="number" min="0" field={@form[:minute]} label="Minutes" />
            </.form>
            
          </div>
          <div class='flex justify-between bg-lightOrange mb-8 px-4 py-2 rounded text-grey' :if={String.length(@errorMessage) > 0}>
            <p><%= @errorMessage %> </p> <button phx-click='hide-error'>x</button>
          </div>
          
          <div class="flex justify-center ">
            <button class="bg-orange font-bold text-white hover:bg-grey-300 py-2 px-4 rounded" phx-click='calculate'>Calculate</button>
          </div>
          
        </div>

          <div :if={@showResult} class="mt-8">
            <div>You should run at the following pace:</div>
            <p class='text-center font-ligth tracking-wider text-6xl py-4'><%= @resultMinutes %>:<span :if={@resultSeconds < 10}>0</span><%= @resultSeconds %> <span class="text-xl text-orange">MIN/KM</span></p>
          </div>
          </div>

        """
    end

    #handle_event
    def handle_event("save-hour", %{"hour" => q}, socket) do
        socket = assign(socket, hours: String.to_integer(q) * 60)
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

    def handle_event("calculate", _, socket) do
      cond do
        socket.assigns.hours === nil && socket.assigns.minutes === nil ->  
          socket = assign(socket, errorMessage: "Oops, missing hour and minute inputs")
          {:noreply, socket}
          socket.assigns.hours === nil -> 
            socket = assign(socket, errorMessage: "Oops, missing hour input")
            {:noreply, socket}
          socket.assigns.minutes === nil -> 
            socket = assign(socket, errorMessage: "Oops, missing minute input")
            {:noreply, socket}
          true -> 
            socket = assign(socket, resultMinutes: trunc((socket.assigns.hours + socket.assigns.minutes) / socket.assigns.distance))
            socket = assign(socket, resultSeconds: rem(trunc((socket.assigns.hours + socket.assigns.minutes) / socket.assigns.distance * 60), 60))
            socket = assign(socket, errorMessage: "")
            socket = assign(socket, showResult: true)
            {:noreply, socket}
      end
  end

  def handle_event("hide-error", _, socket) do
    socket = assign(socket, errorMessage: "")
    {:noreply, socket}
  end

end

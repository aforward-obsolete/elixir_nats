defmodule Nats.Server do
  use GenServer
  alias Nats.Connection

  @initial_state %{socket: nil}

  def start_link do
    GenServer.start_link(__MODULE__, @initial_state)
  end

  def init(state) do
    {:ok, socket} = Connection.connect
    {:ok, %{state | socket: socket}}
  end
end
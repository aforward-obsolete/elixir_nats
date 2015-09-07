defmodule Nats.Worker do
  use GenServer
  require Logger

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{socket: nil})
  end

  def init(state) do
    Logger.debug "Starting Nats worker"
    case Nats.Connection.connect do
      {:ok, socket} -> {:ok, %{state | socket: socket}}
      _ -> {:ok, %{state | socket: nil}}
    end
  end

  def handle_call(command, _from, %{socket: nil} = state) do
    Logger.warn("Ignoring #{command}, unable to connect to NATS server")
    {:reply, [], state}
  end

  def handle_call(command, _from, %{socket: socket} = state) do
    reply = :gen_tcp.send(socket, command)
    Logger.debug("#{command |> inspect} ==> #{reply |> inspect}")
    {:reply, [reply], state}
  end

end

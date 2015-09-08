defmodule Nats.Worker do
  @moduledoc ~S"""
  This module contains GenServer functions for managing a NATS server connection.
  """

  use GenServer
  require Logger

  @doc """
  Start a connection to a NATS server.  The provided arugment is not used.
  """
  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{socket: nil})
  end

  @doc """
  Initialize a TCP connection to your NATS server.  Allow invalid connections
  until such time as tests can mock them out.
  """
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

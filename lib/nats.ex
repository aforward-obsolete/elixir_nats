defmodule Nats do
  @moduledoc ~S"""
  This module contains functions to send messages to your NATS server (http://nats.io).

  For more information on connection parameters, please look at `Nats.Connection`.
  """

  use Application
  require Logger

  def start(_type, _args) do
    opts = Nats.Connection.poolboy_opts
    configs = [{:name, {:local, :nats_pool}},
               {:worker_module, Nats.Worker},
               {:size, opts[:pool_size]},
               {:max_overflow, opts[:pool_max_overflow]}]

    children = [:poolboy.child_spec(:nats_pool, configs,[])]
    options = [strategy: :one_for_one,
               name: Nats.Supervisor]

    Supervisor.start_link(children, options)
  end

  @doc """
  Send a `command` to the NATS server (http://nats.io/)

  ## Example

  Nats.send("PING\r\n")

  """
  def send(command) do
    :poolboy.transaction(:nats_pool, fn(pid) -> :gen_server.call(pid, command) end)
  end

end

defmodule Nats.Connection do
  @moduledoc ~S"""
  This module contains functions to connect to a NATS server.

  The defaults are oriented around getting new people to NATS
  up and running quickly.  Please overwrite for your production
  environment.
  """

  require Logger
  @tcp_attrs [:host, :port, :tcp]
  @poolboy_attrs [:pool_size, :pool_max_overflow]
  @client_attrs [:lang, :version, :verbose, :pedantic, :user, :password]
  @incode_defaults [lang: "elixir",
                   version: Nats.Mixfile.version,
                   verbose: false,
                   pedantic: false,
                   host: "localhost",
                   port: 4222,
                   tcp: [:binary, active: false],
                   pool_size: 1,
                   pool_max_overflow: 1]

  @doc """
  Returns all available options for configuring your NATS client

  Accessing the TCP server

    * `:host`      - Which IP or Hostname to connect to (default: 'localhost')
    * `:port`      - On which port (default: 4222)
    * `:tcp`       - Additional TCP options (default: [:binary, active: false])

  Configuring the client

    * `:lang`     - The client language, which is "elixir" (should not change)
    * `:version`  - The client version, which is found in mix.exs
    * `:verbose`  - Do you want verbose outputs?  Defaults to false
    * `:pedantic` - Do you have a schtickler or not? Defaults to false
    * `:user`     - The user that is accessing the NATS server.
                    This is omitted by default
    * `:password` - The user's password for accessing the NATS server.
                    This is omitted by default

  Configuring the connection pool (based on poolboy)

    * `:pool_size`    - How many connections to maintain (default: 1)
    * `:pool_max_overflow` - How many overflows to support (default: 1)
  """
  def opts(), do: opts([])
  def opts(overwrite), do: _opts(overwrite, @tcp_attrs ++ @poolboy_attrs ++ @client_attrs)
  defp _opts(overwrite, params), do: default_opts |> Keyword.merge(overwrite) |> Keyword.take(params)

  @doc """
  Returns all connection pooling options, including
    * `:pool_size`    - How many connections to maintain (default: 1)
    * `:pool_max_overflow` - How many overflows to support (default: 1)
  """
  def poolboy_opts(), do: poolboy_opts([])
  def poolboy_opts(overwrite), do: _opts(overwrite, @poolboy_attrs)

  @doc """
  Returns all NATS server options, including
    * `:host`      - Which IP or Hostname to connect to (default: 'localhost')
    * `:port`      - On which port (default: 4222)
    * `:tcp`       - Additional TCP options (default: [:binary, active: false])
  """
  def tcp_opts(), do: tcp_opts([])
  def tcp_opts(overwrite), do: _opts(overwrite, @tcp_attrs)

  @doc """
  Attempt to connect to the NATS tcp server using the opts from  `tcp_opts/1` or `tcp_opts/2
  """
  def connect(), do: connect([])
  def connect(overwrite), do: overwrite |> tcp_opts |> _connect
  defp _connect(server) do
    Logger.info("Attempting to connect to NATS Server: #{server[:host]}:#{server[:port]}")
    {ok, socket} = :gen_tcp.connect(server[:host] |> to_char_list,
                                    server[:port] |> to_i,
                                    server[:tcp])
    case ok do
      :ok -> Logger.info("Connected.")
      _   -> Logger.error("Unable to connect to NATS Server: #{ok} (#{socket})")
    end
    {ok, socket}
  end

  defp default_opts do
    configs = Application.get_env(:nats, __MODULE__)
    case configs do
      nil -> Logger.debug("No configs loaded (config :nats, Nats.Connection), using in code defaults")
      _   -> Logger.debug("NATS configs: #{configs |> inspect}")
    end
     Keyword.merge(@incode_defaults, configs || [])
  end

  defp to_i(str) when is_binary(str), do: to_i(Integer.parse(str))
  defp to_i({as_i, _}), do: as_i
  defp to_i(as_i), do: as_i

end

defmodule Nats.Connection do
  @moduledoc ~S"""
  This module contains functions to connect to a NATS server.

  The defaults are oriented around getting new people to NATS
  up and running quickly.  Please overwrite for your production
  environment.
  """

  require Logger
  @default_verbose false
  @default_pedantic false

  @doc """

  """
  def connect(), do: connect(configs)
  def connect(opts), do: opts |> normalize |> _connect
  defp _connect(opts) do
    Logger.info("Attempting to connect to NATS Server: #{opts[:host]}:#{opts[:port]}")
    {ok, socket} = :gen_tcp.connect(opts[:host] |> to_char_list,
                                    opts[:port] |> to_i,
                                    [:binary, active: false])
    # answer = :gen_tcp.connect(opts[:host], opts[:port], [:binary, active: false])
    case ok do
      :ok -> Logger.info("Connected.")
      _   -> Logger.error("Unable to connect to NATS Server: #{ok} (#{socket})")
    end
    {ok, socket}
  end

  @doc """
  Returns the current version of this client libary.

  # Examples
    Connection.version #=> "0.0.1"
  """
  def version(), do: Nats.Mixfile.version

  @doc """
  Returns a JSON representation of the NATS options

  The following configurations should not be changed,
  but could be if you know what you are doing

    * `:lang`     - The client language, which is "elixir"
    * `:version`  - The client version, which is found in mix.exs

  Available configurations that you can overwrite:

    * `:verbose`  - Do you want verbose outputs?  Defaults to false
    * `:pedantic` - Do you have a schtickler or not? Defaults to false
    * `:user`     - The user that is accessing the NATS server.
                    This is omitted by default
    * `:password` - The user's password for accessing the NATS server.
                    This is omitted by default

  In your config/config.exs file, you can provide your connection parameters

    config :nats, Nats.Connection,
      url: "mynatsserver.com",
      port: 4222,
      verbose: true,
      pedantic: false,
      user: "aforward",
      password: "nicetry"

  Here are the default values for each

    config :nats, Nats.Connection,
      url: "localhost",
      port: 4222,
      verbose: false,
      pedantic: false,

  If you must override the connections, you can do so, but configurations should
  really be provided in ./config/config.exs (or the environment specific
  file, e.g. prod.exs)

  ## Examples

    Connection.configs #=> "{\"lang\":\"elixir\",\"version\":\"0.0.1\",\"verbose\":false,\"pedantic\":false}"

    Connection.configs([verbose: true, user: \"aforward\"]) #=> "{\"lang\":\"elixir\",\"version\":\"0.0.1\",\"verbose\":true,\"pedantic\":false,\"user\":\"aforward\"}"
  """
  def configs(), do: configs([])
  def configs(opts), do: opts |> normalize |> limit(:configs) |> encode

  @doc """
  Returns the NATS server URL

  The following options can be overwritten
    * `:host`     - Which IP or Hostname to connect to (default: localhost)
    * `:port`     - On which port (default: 4222)

  ## Examples

    Connection.url #=> "tcp://localhost:4222"
    Connection.url([host: "myhost", port: 3333]) #=> "tcp://myhost:3333"
  """
  def url(), do: url([])
  def url(opts), do: opts |> normalize |> limit(:url) |> _url
  defp _url(opts), do: "tcp://#{opts[:host]}:#{opts[:port]}"

  defp normalize(opts), do: default_options |> Keyword.merge(opts)

  defp limit(opts, :configs), do: opts |> Keyword.take([:lang, :version, :verbose, :pedantic, :user, :password])
  defp limit(opts, :url), do: opts |> Keyword.take([:host, :port])
  defp limit(opts, :tcp), do: opts |> Keyword.get(:tcp)

  defp encode(answer), do: answer # JSON.encode!(answer)

  defp default_options do
    incode = [lang: "elixir",
              version: version,
              verbose: @default_verbose,
              pedantic: @default_pedantic,
              host: "localhost",
              port: 4222,
              tcp: [:binary, active: false]]
    from_app = Application.get_env(:nats, __MODULE__)
    case from_app do
      nil -> Logger.debug("No configs loaded (config :nats, Nats.Connection), using in code defaults")
      _   -> Logger.debug("NATS configs: #{from_app |> inspect}")
    end
     Keyword.merge(incode, from_app || [])
  end

  defp to_i(str) when is_binary(str), do: to_i(Integer.parse(str))
  defp to_i({as_i, _}), do: as_i
  defp to_i(as_i), do: as_i

end

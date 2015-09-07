defmodule Nats.ConnectionTest do
  use ExUnit.Case
  alias Nats.Connection

  test "opts default" do
    assert [lang: "elixir",
            version: Nats.Mixfile.version,
            verbose: false,
            pedantic: false,
            host: "localhost",
            port: 4222,
            tcp: [:binary, {:active, false}],
            pool_size: 1,
            pool_max_overflow: 1] ==
           Connection.opts
  end

  test "opts overwrite all" do
    assert [version: "0.0.999",
            lang: "please don't",
            verbose: true,
            pedantic: true,
            host: "localhost",
            port: 4222,
            tcp: [:binary, {:active, false}],
            pool_size: 1,
            pool_max_overflow: 1] ==
           Connection.opts([version: "0.0.999",
                               lang: "please don't",
                               verbose: true,
                               pedantic: true])
  end

  test "opts add more" do
    assert [user: "a",
            password: "b",
            lang: "elixir",
            version: Nats.Mixfile.version,
            verbose: false,
            pedantic: false,
            host: "localhost",
            port: 4222,
            tcp: [:binary, {:active, false}],
            pool_size: 1,
            pool_max_overflow: 1] ==
           Connection.opts([user: "a", password: "b"])
  end

  test "poolboy_opts default" do
    assert [pool_size: 1, pool_max_overflow: 1] ==
           Connection.poolboy_opts
  end

  test "poolboy_opts overwrite" do
    assert [pool_size: 98, pool_max_overflow: 99] ==
           Connection.poolboy_opts([a: "a", pool_size: 98, pool_max_overflow: 99])
  end

  test "tcp_opts default" do
    assert [host: "localhost", port: 4222, tcp: [:binary, {:active, false}]] ==
           Connection.tcp_opts
  end

  test "tcp_opts overwrite" do
    assert [host: "10.0.0.48", port: 4222, tcp: [:binary, {:active, false}]] ==
           Connection.tcp_opts([a: "a", host: "10.0.0.48"])
  end
end

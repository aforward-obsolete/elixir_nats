defmodule Nats.ConnectionTest do
  use ExUnit.Case
  alias Nats.Connection

  test "configs default" do
    assert JSON.encode!([lang: "elixir",
                         version: Connection.version,
                         verbose: false,
                         pedantic: false]) ==
           Connection.configs
  end

test "configs overwrite some" do
    assert JSON.encode!([version: "0.0.999",
                         lang: "elixir",
                         verbose: false,
                         pedantic: false]) ==
           Connection.configs([version: "0.0.999"])
end

  test "configs overwrite all" do
    assert JSON.encode!([version: "0.0.999",
                         lang: "please don't",
                         verbose: true,
                         pedantic: true]) ==
           Connection.configs([version: "0.0.999",
                               lang: "please don't",
                               verbose: true,
                               pedantic: true])
  end

  test "configs add more" do
    assert JSON.encode!([user: "a",
                         password: "b",
                         lang: "elixir",
                         version: Connection.version,
                         verbose: false,
                         pedantic: false]) ==
           Connection.configs([user: "a", password: "b"])
  end

  test "url default" do
    assert "tcp://localhost:4222" == Connection.url
  end

  test "url overwrite" do
    assert "tcp://myhost:4222" == Connection.url([host: "myhost"])
    assert "tcp://localhost:3333" == Connection.url([port: 3333])
    assert "tcp://localhost:3334" == Connection.url([port: "3334"])
    assert "tcp://yourhost:3335" == Connection.url([host: "yourhost", port: "3335"])
  end

end

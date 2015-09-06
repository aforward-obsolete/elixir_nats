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

end

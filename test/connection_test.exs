defmodule Nats.ConnectionTest do
  use ExUnit.Case
  alias Nats.Connection

  test "configs default" do
    assert [lang: "elixir",
            version: Connection.version,
            verbose: false,
            pedantic: false] ==
           Connection.configs
  end

  test "configs overwrite some" do
      assert [version: "0.0.999",
              lang: "elixir",
              verbose: false,
              pedantic: false] ==
             Connection.configs([version: "0.0.999"])
  end

  test "configs overwrite all" do
    assert [version: "0.0.999",
            lang: "please don't",
            verbose: true,
            pedantic: true] ==
           Connection.configs([version: "0.0.999",
                               lang: "please don't",
                               verbose: true,
                               pedantic: true])
  end

  test "configs remove extra" do
    assert [lang: "elixir",
            version: Connection.version,
            verbose: false,
            pedantic: false] ==
           Connection.configs([blah: 1])
  end

  test "configs add more" do
    assert [user: "a",
            password: "b",
            lang: "elixir",
            version: Connection.version,
            verbose: false,
            pedantic: false] ==
           Connection.configs([user: "a", password: "b"])
  end

end

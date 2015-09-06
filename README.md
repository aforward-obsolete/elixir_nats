# NATS - Elixir Client

A [Elixir](http://elixir-lang.org/) client for the [NATS messaging system](https://nats.io).

[![License MIT](https://img.shields.io/npm/l/express.svg)](http://opensource.org/licenses/MIT)

THIS PROJECT HAS NO FUNCTIONALITY YET, NOT READY FOR ANY SORT OF USE YET

Here is an example configuration to connect to your NATS server.

```elixir
# In your config/config.exs file
config :nats, Nats.Connection,
  url: "mynatsserver.com",
  port: 4222,
  verbose: true,
  pedantic: false,
  user: "aforward",
  password: "nicetry",
  tcp: [:binary, active: false],
```

To integrate into your project, add to your ```mix.exs``` file:

```elixir
defp deps do
  [{:elixir_nats, "~> 0.1"}]
end
```

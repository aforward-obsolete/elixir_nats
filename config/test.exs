use Mix.Config

config :nats, Nats.Connection,
  crap: "test"

config :logger,
  level: :warn,
  truncate: 4096
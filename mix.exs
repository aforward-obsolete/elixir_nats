defmodule Nats.Mixfile do
  use Mix.Project

  def version, do: "0.0.1"
  @source_url "https://github.com/aforward/elixir_nats"

  def project do
    [app: :nats,
     version: version,
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,

     # Hex
     description: description,
     package: package,

     # Docs
     name: "DBus",
     docs: [source_ref: "v#{version}",
            source_url: @source_url]]
  end

  def application do
    [applications: [:logger],
     mod: {Nats, []}]
  end

  defp deps do
    [{:json, "~> 0.3.0"},
     {:poolboy,  "~> 1.4"}]
  end

  defp description do
    """
    A NATS client written in elixir supporting pub/sub for microservices
    """
  end

  defp package do
    [contributors: ["Andrew Forward"],
     licenses: ["MIT"],
     links: %{"GitHub" => @source_url},
     files: ~w(mix.exs README.md CHANGELOG.md lib)]
  end

end

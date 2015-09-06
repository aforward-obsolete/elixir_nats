defmodule Nats.Mixfile do
  use Mix.Project

  def version, do: "0.0.1"

  def project do
    [app: :nats,
     version: version,
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:json, "~> 0.3.0"}]
  end
end

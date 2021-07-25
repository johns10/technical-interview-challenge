defmodule Vetspire.MixFile do
  use Mix.Project

  def project do
    [
      app: :vetspire,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      applications: [:serum],
      extra_applications: [:recase]
    ]
  end

  defp deps do
    [
      {:serum, "~> 1.5"},
      {:serum_theme_essence, "~> 1.0"},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:recase, "~> 0.5"},
      {:jason, "~> 1.2"}
    ]
  end
end

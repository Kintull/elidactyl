defmodule Elidactyl.MixProject do
  use Mix.Project

  def project do
    [
      app: :elidactyl,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Elidactyl.Application, [env: Mix.env]},
      applications: applications(Mix.env),
      extra_applications: [:logger]
    ]
  end

  defp applications(:test), do: applications(:default) ++ [:cowboy, :plug]
  defp applications(_),     do: [:logger, :httpoison]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.6"},
      {:plug_cowboy, "~> 2.0"},
      {:observer_cli, "~> 1.5"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end

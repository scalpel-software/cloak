defmodule Cloak.Mixfile do
  use Mix.Project

  def project do
    [
      app: :cloak,
      version: "0.4.0",
      elixir: "~> 1.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/danielberkompas/cloak",
      description: "Encrypted fields for Ecto.",
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [applications: [:ecto, :jason, :logger]]
  end

  defp deps do
    [
      {:ecto, ">= 1.0.0"},
      {:jason, "~> 1.2", optional: true},
      {:ex_doc, ">= 0.0.0", only: [:dev, :docs]},
      {:inch_ex, ">= 0.0.0", only: :docs}
    ]
  end

  defp docs do
    [
      readme: "README.md",
      main: Cloak
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs"],
      maintainers: ["Daniel Berkompas"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/danielberkompas/cloak"
      }
    ]
  end
end

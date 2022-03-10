defmodule Cloak.Config do
  @moduledoc false

  @spec all() :: Keyword.t()
  def all() do
    Enum.reject(Application.get_all_env(:cloak), fn {key, _} ->
      key in [:migration, :included_applications, :json_library]
    end)
  end

  @spec json_library :: module
  def json_library do
    Application.get_env(:cloak, :json_library, Jason)
  end

  @spec cipher(String.t()) :: {module, Keyword.t()}
  def cipher(tag) do
    # TODO Should we throw here if we can't find?
    Enum.find(all(), fn {_cipher, opts} ->
      opts[:tag] == tag
    end)
  end

  @spec default_cipher() :: {module, Keyword.t()}
  def default_cipher() do
    cipher =
      Enum.find(all(), fn {_cipher, opts} ->
        opts[:default] == true
      end)

    unless cipher do
      raise """
      Please specify a default cipher in your mix configuration. See `Cloak`'s
      documentation to find out how.
      """
    end

    cipher
  end
end

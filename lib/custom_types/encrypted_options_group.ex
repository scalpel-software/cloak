defmodule Cloak.CustomTypes.EncryptedOptionsGroup do
  @moduledoc """
  An `Ecto.Type` to encrypt options groups

  ## Usage

  You should create the field with the type `:binary`.
  Values will be converted back to dates on decryption

    schema "table" do
      field :field_name, Clock.EncryptedOptionsGroup
    end
  """

  use Ecto.Type

  def type, do: :binary

  def cast(params) do
    {:ok, do_cast(params)}
  end

  def dump(value) do
    value =
      value
      |> before_encrypt()
      |> Cloak.encrypt()

    {:ok, value}
  end

  def load(value) do
    value =
      value
      |> Cloak.decrypt()
      |> after_decrypt()

    {:ok, value}
  end

  def before_encrypt(value), do: Jason.encode!(value)
  def after_decrypt(value), do: Jason.decode!(value)

  defp do_cast(params) do
    Enum.reduce(params, %{}, fn {key, value}, acc ->
      Map.put(acc, key, convert(value))
    end)
  end

  defp convert(%{"checked" => checked, "option" => option}) do
    %{"checked" => checked, "option" => option}
  end

  defp convert(%{checked: checked, option: option}) do
    %{"checked" => checked, "option" => option}
  end
end

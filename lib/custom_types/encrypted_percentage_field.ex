defmodule Cloak.CustomTypes.EncryptedPercentageField do
  @moduledoc """
  An Ecto.Type to encrypt a percentage between 0 and 100

  ## Usage

  You should create the field with type `:binary`.
  Values will be converted to decimal on decryption

    schema "table" do
      field :field_name, Cloak.CustomTypes.EncryptedPercentageField
    end
  """

  use Ecto.Type
  use Cloak.CustomTypes.EncryptedField

  def cast(value), do: Decimal.cast(value)

  def after_decrypt(value) do
    case Decimal.cast(value) do
      {:ok, result} -> result
      :error -> :error
    end
  end
end

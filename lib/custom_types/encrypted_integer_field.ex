defmodule Cloak.CustomTypes.EncryptedIntegerField do
  @moduledoc """
  An `Ecto.Type` to encrypt integer fields.

  ## Usage

  You should create the field with type `:binary`. Values will be converted
  back to integers on decryption.

      schema "table" do
        field :field_name, Cloak.CustomTypes.EncryptedIntegerField
      end
  """

  use Ecto.Type
  use Cloak.CustomTypes.EncryptedField

  def cast(value) do
    Ecto.Type.cast(:integer, value)
  end

  def before_encrypt(value) do
    case Ecto.Type.cast(:integer, value) do
      {:ok, value} -> to_string(value)
      _error -> :error
    end
  end

  def after_decrypt("O"), do: 0
  def after_decrypt(value) do 
    String.to_integer(value)
  end
end

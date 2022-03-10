defmodule Cloak.CustomTypes.EncryptedBinaryField do
  @moduledoc """
  An `Ecto.Type` to encrypt a binary field.
  ## Usage
      schema "table" do
        field :field_name, Cloak.CustomTypes.EncryptedBinaryField
      end
  """

  use Ecto.Type
  use Cloak.CustomTypes.EncryptedField
end

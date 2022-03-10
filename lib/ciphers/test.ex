defmodule Cloak.Ciphers.Test do
  @behaviour Cloak.Cipher

  def encrypt(text, _key_tag \\ nil), do: text
  def decrypt(text), do: text
  def version, do: default_key().tag

  defp default_key, do: Cloak.Ciphers.Util.default_key(__MODULE__)
end

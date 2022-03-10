defmodule Cloak.Tags.Decoder do
  @moduledoc """
  A decoder that will let us read tags specified in the Format specified by the `Cloak.Tags.Encoder`

  This scheme follows a Type, Length, Value triplet and is based on DER encoding for certificates
  https://en.wikipedia.org/wiki/X.690#DER_encoding

  It returns a map containing the key_tag and the remainder of the binary which we can use
  to decode the ciphertext.
  """

  @offset 2
  @byte_length 256
  @half_byte 128

  def decode(message) do
    length = tag_length(message)
    <<tlv::binary-size(length), remainder::binary>> = message

    %{key_tag: key_tag(tlv), remainder: remainder}
  end

  defp tag_length(message) do
    <<_type::size(8), len::size(8), rest::binary>> = message

    tag_length(len, :binary.bin_to_list(rest))
  end

  defp tag_length(num, list) when num >= @half_byte do
    @offset + num - @half_byte + value_bytes(list, num - @half_byte)
  end

  defp tag_length(num, _list), do: @offset + num

  defp key_tag(<<_type::size(8), len::size(8), rest::binary>>) when len >= @half_byte do
    size = len - @half_byte
    <<_value_bytes::binary-size(size), key_tag::binary>> = rest

    key_tag
  end

  defp key_tag(<<_type::size(8), _len::size(8), key_tag::binary>>) do
    key_tag
  end

  defp value_bytes(list, num_bytes) do
    list
    |> Enum.take(num_bytes)
    |> Enum.reduce(0, fn value, acc -> acc * @byte_length + value end)
  end
end

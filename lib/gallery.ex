defmodule Gallery do
  #Connection with unsplash to generate images
  @unsplash_url "https://images.unsplash.com"

  @ids [
    "photo-1682284919306-800ab01eef9e",
    "photo-1682319298536-33ac5b48d772",
    "photo-1682048717093-b2b8bd59d294",
    "photo-1682222925217-40650cf10cdd",
    "photo-1553440569-bcc63803a83d",
    "photo-1593544340816-93d84a106415",
    "photo-1464802686167-b939a6910659"
  ]
#Connection small images
  def thumb_url(id), do: image_url(id, %{w: 100, h: 100, fit: "crop"})
 #Connection large images
  def large_url(id), do: image_url(id, %{w: 900, h: 550, fit: "crop"})

  def image_ids(), do: @ids

      def first_id(ids \\ @ids) do
        List.first(ids)
      end

  def prev_image_id(ids\\@ids, id) do
    Enum.at(ids, prev_index(ids, id))
  end

  def prev_index(ids, id) do
    ids
    |> Enum.find_index(& &1 == id)
    |> Kernel.-(1)
  end

  def next_image_id(ids\\@ids, id) do
    Enum.at(ids, next_index(ids, id), first_id(ids))
  end

  def next_index(ids, id) do
    ids
    |> Enum.find_index(& &1 == id)
    |> Kernel.+(1)
  end

  def image_url(image_id, params) do
    URI.parse(@unsplash_url)
    |> URI.merge(image_id)
    |> Map.put(:query, URI.encode_query(params))
    |> URI.to_string()
  end
end

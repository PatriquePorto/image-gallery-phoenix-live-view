defmodule GalleryWeb.PageLive do
  use GalleryWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:current_id, Gallery.first_id())
      |> assign(:slideshow, :stopped)
     {:ok, socket}
  end
#Function play slideshow
  def handle_event("play_slideshow", _, socket) do
    {:ok, ref} = :timer.send_interval(2_000, self(), :slideshow_next)
    {:noreply, assign(socket, :slideshow, ref)}
  end
#Function stop slideshow
  def handle_event("stop_slideshow", _, socket) do
    :timer.cancel(socket.assigns.slideshow)
    {:noreply, assign(socket, :slideshow, :stopped)}
  end

  def handle_info(:slideshow_next, socket) do
    {:noreply, assign_next_id(socket)}
  end
#Function prev click button
  def handle_event("prev", _, socket) do
    {:noreply, assign_prev_id(socket)}
  end
#Function next click button
  def handle_event("next", _, socket) do
    {:noreply, assign_next_id(socket)}
  end

  def assign_prev_id(socket) do
    assign(socket, :current_id,
    Gallery.prev_image_id(socket.assigns.current_id))
  end

  def assign_next_id(socket) do
    assign(socket, :current_id,
    Gallery.next_image_id(socket.assigns.current_id))
  end
#Function thumb-img selected
  def thumb_css_class(thumb_id, current_id) do
    if thumb_id == current_id do
      "thumb-selected"
    else
      "thumb-unselected"
    end
  end
end

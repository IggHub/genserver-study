defmodule Stack do
  @moduledoc """
  Documentation for Stack.
  """
  # source: https://hexdocs.pm/elixir/GenServer.html
  use GenServer
  @name MW
  
  # Client-side stuff

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: MW])
  end
  
  def get_stuff() do
    GenServer.call(@name, :get_stuff)
  end
  
  def add_stuff(stuff) do
    GenServer.cast(@name, {:push, stuff})
  end
  
  def delete_stuff(stuff) do
    GenServer.cast(@name, {:delete, stuff})
  end

  def clear_stuff() do
    GenServer.cast(@name, :clear)
  end
  
  # Server-side stuff

  def init(:ok) do
    {:ok, [:stuff]}
  end

  def handle_call(:get_stuff, _from, stuff) do
    {:reply, stuff, stuff}
  end

  def handle_cast({:push, stuff}, state) do
    {:noreply, [stuff | state]}
  end

  def handle_cast(:clear, _state) do
    {:noreply, []}
  end

  def handle_cast({:delete, stuff}, state) do
    {:noreply, List.delete(state, stuff)}
  end
end

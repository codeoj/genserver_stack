defmodule GenserverStack do
  use GenServer

  # Client

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  def push(pid, value) do
    GenServer.call(pid, {:push, value})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # Server - Callbacks

  @impl true
  def init(state) do
    {:ok, state}
  end

  #SYNC
  @impl true
  def handle_call({:push, value}, _from, state) do
    new_state = [value | state]
    {:reply, new_state, new_state}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    [value | new_state] = state
    {:reply, value, new_state}
  end


  #ASYNC
  @impl true
  def handle_cast({:push, value}, state) do
    new_state = [value | state]
    {:noreply, new_state}
  end
end

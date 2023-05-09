defmodule KVServer do
  require Logger

  # client -> request -> accept -> socket -> <||> -> client socket -> serve

  def accept(port) do
    {:ok, socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    Logger.info("Accepting connections on port #{port}")
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(KVServer.TaskSupervisor, fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    socket
    |> read_lines()
    |> write_lines(socket)

    serve(socket)
  end

  defp read_lines(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data
  end

  defp write_lines(data, socket) do
    :gen_tcp.send(socket, data)
  end
end

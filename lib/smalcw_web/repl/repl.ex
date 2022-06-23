defmodule SmalcwWeb.ReplLive do
  use SmalcwWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{outputs: [], curr_code: "hello", curr_ctx: %{'PI' => "3"}})}
  end

  def handle_event("edit", %{"repl" => %{"code" => code}}, socket) do
    {:noreply, assign(socket, :curr_code, code)}
  end

  def handle_event("run", %{"repl" => %{"code" => code}}, socket) do
    {out, new_ctx} = compile(code, socket.assigns.curr_ctx)
    {:noreply, assign(socket,
      %{
        outputs: socket.assigns.outputs ++ [{code, out}],
        curr_code: code,
        curr_ctx: new_ctx
      })
    }
  end

  def compile(expr, ctx \\ %{'PI' => "3"}) do
    case Smalc.run(expr, ctx) do
      {:ok, v} -> v
      {:error, line, message} ->
        {"""
        Line #{line}:
        #{message}
        """, ctx}
    end
  end
end

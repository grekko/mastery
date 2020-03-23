defmodule ResponseTest do
  use ExUnit.Case
  use QuizBuilders

  defp quiz() do
    fields = template_fields(generators: %{left: [1], right: [2]})

    build_quiz()
    |> Quiz.add_template(fields)
    |> Quiz.select_question()
  end

  defp response(answer) do
    Response.new(quiz(), "mathy@example.com", answer)
  end

  defp correct(context) do
    {:ok, Map.put(context, :correct, response("3"))}
  end

  defp wrong(context) do
    {:ok, Map.put(context, :wrong, response("2"))}
  end

  describe "a correct response and a wrong response" do
    setup [:correct, :wrong]

    test "building responses checks answers", %{correct: correct, wrong: wrong} do
      assert correct.correct
      refute wrong.correct
    end

    test "a timestamp is added at build time", %{correct: response} do
      assert %DateTime{} = response.timestamp
      assert response.timestamp < DateTime.utc_now()
    end
  end
end

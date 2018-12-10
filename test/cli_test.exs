defmodule CliTest do
    use ExUnit.Case
    doctest Issues
    import Issues.CLI

    test "help returned by option parsing with —h and -—help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["-—help”,”anything"]) == :help
    end

    test "three values returned if three given" do
        assert parse_args(["user","project","99"]) == {"user","project",99}
    end

    test "count is defaulted if two values are given" do
        assert parse_args(["user","project"]) == {"user","project",4}
    end

    @doc """
    Testing Decending Sorting Functionality
    Sorts a created list in decending order.
    """
    test "sort decending orders" do
        result = sort_into_decending_order(fake_created_at_list(["c",
        "a","b"]))
        issues = for issue <- result, do: Map.get(issue,"created_at")
        assert issues == ~w{ c b a }
    end

    @doc """
    Helper Function for Sorting Test, formats the data into
    correct map format(set of key value pairs).
    """
    defp fake_created_at_list(values) do
        for value <- values,
        do: %{"created_at" => value, "other_data" => "xxx"}
    end
end

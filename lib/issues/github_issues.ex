defmodule Issues.GithubIssues do
  @user_agent [{"User-agent","Elixir sherbaz.hashmi@gmail.com"}]
  @github_url Application.get_env(:issues, :github_url)
  def fetch(user, project) do
    issues_url(user,project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end
  @doc """
    Generates Issues URL Based on Fetch Parameters
    """
    def issues_url(user,project) do
      "#{@github_url}/repos/#{user}/#{project}/issues"
    end

  @doc """
    Handle Responses from HTTPoison.
    Returns Tuple With an Atom indicating success of response
    and body of response.
    """

  def handle_response({_,%{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_error(),
    body |> Poison.Parser.parse!()
    }
  end



  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end

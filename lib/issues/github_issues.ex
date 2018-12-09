defmodule Issues.GithubIssues do
  @user_agent [{"User-agent","Elixir sherbaz.hashmi@gmail.com"}]
  def fetch(user, project) do
    issues_url(user,project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end
  @doc """
    Generates Issues URL Based on Fetch Parameters
    """
    def issues_url(user,project) do
      "https://api.github.com/repos/#{user}/#{project}/issues"
    end

  @doc """
    Handle Responses from HTTPoison.
    Returns Tuple With an Atom indicating success of response
    and body of response.
    """
  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response {_, %{status_code: _, body: body}} do
    {:error, body}
  end
end

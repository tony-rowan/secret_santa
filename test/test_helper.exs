ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(SecretSanta.Repo, :manual)

Application.put_env(:wallaby, :base_url, SecretSantaWeb.Endpoint.url())
Application.put_env(:wallaby, :screenshot_on_failure, true)
{:ok, _} = Application.ensure_all_started(:wallaby)

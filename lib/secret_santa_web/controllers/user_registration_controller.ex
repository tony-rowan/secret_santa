defmodule SecretSantaWeb.UserRegistrationController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Accounts
  alias SecretSanta.Accounts.User
  alias SecretSanta.Groups
  alias SecretSantaWeb.UserAuth

  plug :set_group_from_join_code when action == :new
  plug :set_group_from_group_id when action == :create

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params, conn.assigns.group) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        UserAuth.log_in_user(conn, user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp set_group_from_join_code(conn, _opts) do
    join_code = conn.params["join_code"]
    group = Groups.get_group_by_join_code(join_code)
    assign(conn, :group, group)
  end

  defp set_group_from_group_id(conn, _opts) do
    group_id = conn.params["user"]["group"]
    group = Groups.get_group(group_id)
    assign(conn, :group, group)
  end
end

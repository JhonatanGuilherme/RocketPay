defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns and user" do
      params = %{
        name: "John",
        password: "123456",
        nickname: "John",
        email: "john@john.com",
        age: 20
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "John", age: 20, id: ^user_id} = user
    end

    test "when there are invalid params, returns and user" do
      params = %{
        name: "John",
        password: "123456",
        nickname: "John",
        email: "john@john.com",
        age: 20
      }

      {:error, changeset} = Create.call(_params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_one(changeset) == expected_response
    end
  end
end

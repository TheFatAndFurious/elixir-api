defmodule  Api.Guardian do
  use Guardian, otp_app: :api

  # Choosing a subject for the JWT, here we are choosing the ID
  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  # How to find the resource from the JWT claim when decoding it
  def resource_from_claims(claims) do
    {:ok, claims["sub"]}
  end

end

require "./spec_helper"

class UserFlux < Flux
  def signup
    step do
      visit "http://localhost:4000/register"
      fill "first_name", "John"
      fill "last_name", "Doe"
      fill "email", "john.doe@example.com"
      fill "password", "example"
      fill "password_confirm", "example"
      checkbox id: "terms-checkbox", checked: true
      submit "submit"
    end
  end
end

describe "User Signup" do
  user = UserFlux.new

  it "User visits site" do
    user.signup
  end
end

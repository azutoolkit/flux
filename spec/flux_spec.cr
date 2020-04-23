require "./spec_helper"

class UserFlux < Flux
  def signup
    step do
      visit "http://localhost:4000/register"
      
      fill "first_name", with: "John"
      fill "last_name", with: "Doe"
      fill "email", with: "john.doe@example.com"
      fill "password", with: "example"
      fill "password_confirm", with: "example"

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

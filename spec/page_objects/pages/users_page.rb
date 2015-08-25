class UsersSignInPage < SitePrism::Page
  set_url '/users/sign_in'
  element :email_field, 'input#user_email'
  element :password_field, 'input#user_password'

  element :login_button, 'input[name="commit"]'

  def sign_in_user(email, password='testtest')
    self.load
    email_field.set email
    password_field.set password
    login_button.click
  end
  def self.sign_in_user(email, password='testtest')
    page = UsersSignInPage.new
    page.sign_in_user(email, password)
  end
end

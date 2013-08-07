include ApplicationHelper


def full_title(page_title) 
  base_title = "Chapter3Demo"
  if page_title.empty? then 
    base_title 
  else
    "#{base_title} | #{page_title}"
  end
end
  
def valid_signin(user, options={})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attributes(:remember_token, User.encrypt(remember_token))
  else
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

def fill_in_valid_signup
  fill_in "Name", with: "Example"
  fill_in "Email", with: "example@gmail.com"
  fill_in "Password", with: "123456"
  fill_in "Confirmation", with: "123456"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end


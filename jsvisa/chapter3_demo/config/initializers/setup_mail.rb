ActionMailer::Base.smtp_settings = {
  :address              => "smtp.163.com",
  :port                 => 25,
  :domain               => "163.com",
  :user_name            => "username",
  :password             => "password",
  :authentication       => "login",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?

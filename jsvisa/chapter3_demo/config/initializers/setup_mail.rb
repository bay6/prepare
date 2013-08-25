ActionMailer::Base.smtp_settings = {
  :address              => "smtp.163.com",
  #:address              => "smtp.qq.com",
  #:address              => "smtp.gmail.com",
  :port                 => 25,
  #:domain               => "google.com",
  :domain               => "163.com",
  #:domain               => "qq.com",
  #:user_name            => "zhen.gwb@163.com",
  #:password             => "QWERTY",
  :user_name            => "username",
  :password             => "password",
  :authentication       => "login",
#  :openssl_verify_mode  => 'none',
#  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?

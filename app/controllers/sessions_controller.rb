class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password]) && user.penalty != true
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back!"
    elsif user.penalty == true
      redirect_to :back, notice: "Your account has been frozen, please contact admin"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def create_oauth
    nickname = env["omniauth.auth"].info.nickname

    if User.find_by_username(nickname).nil?
      # make new User
      password = random_password
      u = User.create(username:nickname, password:password, password_confirmation:password)
      session[:user_id] = u.id
      redirect_to u, notice: "Welcome, #{nickname}"
    else
      # already on the system :)
      user = User.find_by_username(nickname)
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  def random_password
    # one big letter
    password = (65 + Random.rand(25)).chr

    # eight small letters
    for i in 0..7
      password = password + (97 + Random.rand(25)).chr
    end

    # three numbers
    for x in 0..2
      password = password + Random.rand(9).to_s
    end

    return password
  end
end
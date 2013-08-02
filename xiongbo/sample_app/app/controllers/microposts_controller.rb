class MicropostsController < ApplicationController
  before_filter :signed_in_user

  def create
    @micropost = current_user.microposts.new(post_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end 
  end

  def destroy

  end

  private
  
  def post_params
    params.require(:micropost).permit(:content)
  end
end

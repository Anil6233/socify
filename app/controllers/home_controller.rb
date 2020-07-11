class HomeController < ApplicationController
  
  # def front
  # end
  # respond_to :html, :js
  # def index
  #   @activities = PublicActivity::Activity.all
  # end
  before_action :set_user, except: :front
  respond_to :html, :js

  def index
    following_users_ids = current_user.all_following.map {|user| user.id }
    @friends = User.includes(:posts).where(id: following_users_ids)
    @liked_posts = current_user.get_up_voted(Post)
  end

  def front
    @activities = PublicActivity::Activity.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def find_friends
    @users = User.all
    @friends = current_user.all_following.pluck(:id)
  end

  def follow
    byebug
    @user = User.find(params[:user])
    @crnt_user = User.find(params[:crnt_user])
    @crnt_user.follow(@user)
    redirect_to home_find_friends_path(@crnt_user)
  end  
  
  def unfollow
    @user = User.find(params[:user])
    @crnt_user = User.find(params[:crnt_user])
    @crnt_user.stop_following(@user)
    redirect_to home_find_friends_path(@crnt_user)
  end

  

  private
  def set_user
    @user = current_user
  end
end

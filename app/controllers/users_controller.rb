class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :show, only: [:notification_data]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @username_color = 1
    @all_user = User.all
    @like_obj = Like.all
    @like_count = @like_obj.where(status: true).group(:assignment_id).count
    @unlike_count = @like_obj.where(status: false).group(:assignment_id).count

        #@liked_by = User.where(id: @like_obj.where(status: true).map(&:user_id)).map(&:name)
    
    @liked_by = @like_obj.all.where(status: true).group_by(&:assignment_id)
    p "hiii"*20
    #p @liked_by["10"].first
    #p @unliked_by
    #@like_user_data = 
    # {1 => ["name1", "name2"]} like user
    @all_comments = Comment.all
  @users = User.all
  @all_likes = Like.all
  @assignment = Assignment.all
  @comment_array = []
  @like_array = []
  @comment_notify_hash = {}
  @like_notify_hash = {}
  j= 0
  k =0
  @assignment_id_array = @assignment.where(user_id: 4).map(&:id)
  for i in @assignment_id_array
    @comment = @all_comments.where(assignment_id: i)
    for k in @comment
      @comment_array[j] = k
      j= j+1
    end
  end
  j = 0
  for i in @assignment_id_array
    @like = @all_likes.where(assignment_id: i)
    for k in @like
      @like_array[j] = k
      j = j+1
    end
  end 
  j=0
  for i in @comment_array
    @comment_notify_hash[i.updated_at] = "<a href='/users/#{i.user_id}'>#{@users.where(id: i.user_id).first.name}</a>" +
    " commented on idea " + "<a href='/fresh_page_view/#{i.assignment_id}'>#{@assignment.where(id: i.assignment_id).first.title}</a>"
    j = j+1;
  end
  p @comment_notify_hash
  p "d"*100
  for i in @like_array
    @like_notify_hash[i.updated_at] = "<a href='/users/#{i.user_id}'>#{@users.where(id: i.user_id).first.name}</a>" +
    " likes your idea " + "<a href='/fresh_page_view/#{i.assignment_id}'>#{@assignment.where(id: i.assignment_id).first.title}</a>"
    j=j+1;
  end

   @notification_list = @like_notify_hash.merge(@comment_notify_hash).sort.reverse.to_h
    
    i = []
    j = 0
    @notify = 0
    @notification_list.each do |k,v|
        i[j] = k - @users.where(id: 4).first.current_sign_in_at
          if i[j]>0
            @notify = @notify+1
          end
        j = j+1
    end

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver_later
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def liked_by
    p params[:id]
    @assign_id =  params[:id]
    @like_obj = Like.all.where(assignment_id: params[:id])
    p @like_obj
    p "hiii"*20
    @liked_by = User.where(id: @like_obj.where(status: true).map(&:user_id)).map(&:name)
    @unliked_by = User.where(id: @like_obj.where(status: false).map(&:user_id)).map(&:name)
    p @liked_by
    p @unliked_by
       
end

def contributions
  @user = User.all
  @assignment = Assignment.all
  @contribution_color = 1
  @ideas = Assignment.where(status: false).group_by(&:user_id)
  @searched_by = "Search by category"

end

def search_by_category
  category = params[:search_by_category]
  p category
  @searched_by = category
  @ideas = Assignment.where(category: category, status: false).group_by(&:user_id)
  @user = User.all
  @contribution_color = 1
  render "contributions"

end

def public_profile
  @user = User.where(id: params[:id]).first
end

<<<<<<< HEAD
def notify_me
  current_user.update_attributes(notify_me: params[:checked])
  render nothing: true
end  

def notification_data
  #create hash of data with timestamps, follows, likes, comments
  @all_comments = Comment.all
  @users = User.all
  @all_likes = Like.all
  @assignment = Assignment.all
  @comment_array = []
  @like_array = []
  @comment_notify_hash = {}
  @like_notify_hash = {}
  j= 0
  k =0
  @assignment_id_array = @assignment.where(user_id: 4).map(&:id)
  for i in @assignment_id_array
    @comment = @all_comments.where(assignment_id: i)
    for k in @comment
      @comment_array[j] = k
      j= j+1
    end
  end
  j = 0
  for i in @assignment_id_array
    @like = @all_likes.where(assignment_id: i)
    for k in @like
      @like_array[j] = k
      j = j+1
    end
  end 
  j=0
  @comment_array.order(created: :desc)
  for i in @comment_array
    @comment_notify_hash[i.updated_at] = "<a href='/users/#{i.user_id}'>#{@users.where(id: i.user_id).first.name}</a>" +
    " commented on idea " + "<a href='/fresh_page_view/#{i.assignment_id}'>#{@assignment.where(id: i.assignment_id).first.title}</a>"
    j = j+1;
  end
  p @comment_notify_hash
  p "d"*100
  @like_array.order(created: :desc)
  for i in @like_array
    @like_notify_hash[i.updated_at] = "<a href='/users/#{i.user_id}'>#{@users.where(id: i.user_id).first.name}</a>" +
    " likes your idea " + "<a href='/fresh_page_view/#{i.assignment_id}'>#{@assignment.where(id: i.assignment_id).first.title}</a>"
    j=j+1;
  end

   @notification_list = @like_notify_hash.merge(@comment_notify_hash).sort.reverse.to_h


end  


def follow
  Follow.create(user_id: current_user.id, obj_type: Follow::USER, obj_id: params[:user_id])
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    p params[:id]
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :phone, :avatar)
  end
end

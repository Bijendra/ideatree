class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
    @comments = Comment.all.group_by(&:assignment_id)
    @user = User.all
    @like_obj = Like.all
    @like_count = Like.where(status: true).group(:assignment_id).count
    p @like_obj
    @unlike_count = Like.where(status: false).group(:assignment_id).count
    @twocom = Comment.last(2)
    @com = Comment.new #hash 
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.user_id = current_user.id
    Rails.logger.info "S"*100
    Rails.logger.info @assignments
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add_comments_to_assignment_post
    #params = {"id" => "", content => ""}
    post = Assignment.where(id: params[:id])
    if post.present?
      comment = post.comments.create
      post.content = params[:content]
      post.user_id = current_user.id
      post.save
      render :json => {success: "Thanks for commenting"}
    else
      render :json => {errors: "Post is no longer available"}
    end  
  end
     
  def like
  assign = Assignment.find(params[:id])
    if assign.present?
      @assign_id = assign.id
      like_obj = Like.where(assignment_id: assign.id, user_id: current_user.id).first
      if like_obj.blank?
        like_obj = Like.new
        like_obj.user_id = current_user.id
        like_obj.assignment_id = assign.id
      end
     
      if like_obj.status.to_s == params[:status]
        like_obj.status = nil
        @sta = 0
      else
        like_obj.status = params[:status]
        @sta = like_obj.status
      end 


      if like_obj.save 
          @likecount = Like.where(assignment_id: assign.id, status: true).count
          @unlikecount =  Like.where(assignment_id: assign.id, status: false).count
          # @sta = like_obj.status
p like_obj.status.class
p nil.class
p @sta.class
        # render json: { likes: assign.count_likes, id: params[:id], unlikes: assign.count_unlikes }=
        # format.js { render action: 'like', status: :created, location: @comment , locals: {assignment_id: assignment_obj}}
      else
        render json: {errors: like_obj.errors.full_messages}  
      end  
    end  
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:description, :user_id, :category_id, :status, :avatar)
    end
end

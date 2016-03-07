class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all.sort_by(&:created_at) #change it to sort by published date. Show most recent on top
    @comments = Comment.all.group_by(&:assignment_id)
    @twocom = Comment.last(2)
    @com = Comment.new #hash 
    @popular_view = @assignments[0..3] || []
    @popular_list = @assignments[4..8] || []
    render "idea_temp"
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
    like_obj = Like.new
    like_obj.user_id = current_user.id
    like_obj.assignment_id = assign.id
    like_obj.save
  end  
  if request.xhr?
    head :ok
    render json: { count: @content.get_likes.size, id: params[:id] }

  else
    redirect_to assign
  end
end

  def unlike
    assign = Assignment.find(params[:id])
    like_obj = Like.where(assignment_id: assign.id, user_id: current_user.id)
    like_obj.destroy if like_obj.present?
    if request.xhr?
      head :ok

    end
  end

  def search
    #put the search criteria here and try to reuse or combine the index method
    @assignments = Assignment.all
    @comments = Comment.all.group_by(&:assignment_id)
    @twocom = Comment.last(2)
    @com = Comment.new #hash 
    render "idea_temp"
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
      p params
      p "D"*100
      params.require(:assignment).permit(:description, :user_id, :category_id, :status, :avatar)
    end
end

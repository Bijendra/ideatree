class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  before_action :find_assignment_and_comment, :only => [:create, :create_comment_ajax]
  def index
    @user = User.all
    @comments = Comment.all
    @all_comments = @comments
    @all_assignment = Assignment.where(status: false)
    @assignment = @all_assignment.find(params[:format])
    @comment = @comments.new
    render "fresh_page_view"
  end
  
  def fresh_page_view
    @assignment_obj = Assignment.where(status: false)
    if params["fresh"].present?
      list = @assignment = @assignment_obj.where(status: true).map(&:id)
    end 
    @next_page = @assignment_obj.all.map(&:id).index(params[:id].to_i)
    @next_page = @assignment_obj.all.map(&:id)[@next_page-1]
    @previous_page = @assignment_obj.all.map(&:id).index(params[:id].to_i)
    @previous_page = @assignment_obj.all.map(&:id)[@previous_page+1]
    @assignment = @assignment_obj.where(id: params[:id]).first
    @comments = Comment.where(assignment_id: @assignment.id).all
    @like_obj = Like.where(assignment_id: @assignment.id)
    @like_count = Like.where(status: true).where(assignment_id: @assignment.id).count
    p @like_obj
    @unlike_count = Like.where(status: false).where(assignment_id: @assignment.id).count
    @com = Comment.new #hash 
  end  
  # GET /comments/1
  # GET /comments/1.json
  def show
  end

#s = 5
  # GET /comments/new
  def new
    @comment = Comment.new
    @comment.assignment_id = params[:format]
    p "#"*100
    p params
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    # params = {content: "gfgf", assignment_id: 123}
    #redirect_to @comment, notice: 'Comment was successfully created.'
  end
  
  def create_comment_ajax
    assignment_obj = Assignment.find(params[:assignment_id])

      respond_to do |format|
      if @comment.save
        
        format.js { render action: 'show', status: :created, location: @comment , locals: {assignment_id: assignment_obj}}
      else
        format.js { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end  

  def find_assignment_and_comment
    assignment_obj = Assignment.find(params[:assignment_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.assignment_id = assignment_obj.id
    @comment.save
  end 


  def more_comments
    @assignment_obj = Assignment.find(params[:id])
    @com = Comment.where(assignment_id: @assignment_obj).reverse.drop(2).map(&:content)
  end  
  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    comment = Comment.find(params[:id])
    ass_id = comment.assignment_id
    comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_path(ass_id)}

    #   format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
     # @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end

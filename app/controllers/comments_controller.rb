class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  before_action :find_assignment_and_comment, :only => [:create, :create_comment_ajax]
  def index
    p params
    p "S"*100
    @comments = Comment.all
    @all_assignment = Assignment.all
    @assignment = Assignment.find(params[:format])
    @comment = Comment.new
    render "fresh_page"
  end
  
  def fresh_page_view
    # params[:id] as assignment id
    @assignment = Assignment.where(assignment_id: params[:id]).first
    @comments = Comment.where(assignment_id: @assignment.id).all
    
    @like_obj = Like.where(assignment_id: @assignment.id)
    @like_count = Like.where(status: true).where(assignment_id: @assignment.id).count
    p @like_obj
    @unlike_count = Like.where(status: false).where(assignment_id: @assignment.id).count
    #@twocom = Comment.last(2)
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
    # @comment
    # handle ajax call
        assignment_obj = Assignment.find(params[:assignment_id])

      respond_to do |format|
      if @comment.save
        
        # format.html { redirect_to @assignment, notice: 'comment was successfully created.' }
        format.js { render action: 'show', status: :created, location: @comment , locals: {assignment_id: assignment_obj}}
        # added:
        # format.js   { render action: 'show', status: :created, location: @comment }
      else
        # format.html { render action: 'new' }
        format.js { render json: @comment.errors, status: :unprocessable_entity }
        # added:
        # format.js   { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end  

  def find_assignment_and_comment
    assignment_obj = Assignment.find(params[:assignment_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.assignment_id = assignment_obj.id
    @comment.save
    #render "create_comment_ajax"
    p "d"*100

  end 


  def more_comments

        @assignment_obj = Assignment.find(params[:id])
        @com = Comment.where(assignment_id: @assignment_obj).reverse.drop(2).map(&:content)
        p "$"*100
        p @assignment_obj.id
        p @com
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

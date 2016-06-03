class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index

    if ((params[:tag].present? && params[:tag] == "popular") || (params[:List_by].present? && params[:List_by] == "Likes"))
      @popular_assignment1 = Assignment.where(status: false).all
      popular = {}
      s = []
      if params[:List_by].present? 
        for i in @popular_assignment1
          popular[i.id] = Like.where(Assignment_id: i.id,status: true).count
        end
        @listed_by = "Likes"
      else
        for i in @popular_assignment1
          popular[i.id] = (Comment.where(Assignment_id: i.id).all.count * 5) + Like.where(Assignment_id: i.id,status: true).count
        end
        @listed_by = "Popular List"
      end
      @popular_view1 = popular.sort_by{|_key, value| -value}.to_h
      p @popular_view1
      p "D"*100
      order_hsh = @popular_assignment1.group_by(&:id)
      # binding.pry
      @popular_view1.keys.each do |i|
        s << order_hsh[i].first
      end 
      @assignments = s
    elsif params[:List_by].present? && params[:List_by] != "Likes" 
      @assignments = Assignment.where(status: false, category: params[:List_by]).order(created_at: :desc)
      @listed_by = params[:List_by]    
    else 
      @listed_by = "List by"
      @assignments = Assignment.where(status: false).order(created_at: :desc) #change it to sort by published date. Show most recent on top
    end  
    @popular_assignment = Assignment.all
    @comments = Comment.all.group_by(&:assignment_id)
    @user = User.all
    @like_obj = Like.all
    @like_count = @like_obj.where(status: true).group(:assignment_id).count
    p @like_obj
    @unlike_count = @like_obj.where(status: false).group(:assignment_id).count
    @twocom = Comment.last(2)
    @com = Comment.new #hash
    popular = Hash.new
    @browse_color = 1


    likes= @like_obj.all.where(status: true).group_by(&:assignment_id)
    popular = Hash.new
    for i in @assignments
      p i.id
      p @comments[i.id]
      p "$"*100
      
      popular[i.id] = (@comments[i.id].count * 5) unless @comments[i.id].blank?

      popular[i.id] += likes[i.id].count unless likes[i.id].nil?
     
    end
    @popular_view = popular.sort_by{|_key, value| -value}.to_h
        p @popular_view

    # for i in @assignments
    #   popular[i.id] = (Comment.where(Assignment_id: i.id).all.count * 5) + Like.where(Assignment_id: i.id,status: true).count
    # end
    # @popular_view = popular.sort_by{|_key, value| -value}.to_h
    # p @popular_view
    # p "s"*100
    # @popular_view = @assignments[0..3] || []
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
        @submit_color = 1

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

  def search
    #put the search criteria here and try to reuse or combine the index method
    # @assignments = Assignment.where("description LIKE ?","%#{params[:query]}%").all.order(created_at: :desc)
    #@comments = Comment.all.group_by(&:assignment_id)
    #@twocom = Comment.last(2)
    #@com = Comment.new #hash
    @popular_assignment = Assignment.where(status: false)
    p @popular_assignment 
    p "D"*100
    @comments = Comment.all.group_by(&:assignment_id)
    @user = User.all
    @like_obj = Like.all
    @like_count = @like_obj.where(status: true).group(:assignment_id).count
    p @like_obj
    @unlike_count = @like_obj.where(status: false).group(:assignment_id).count
    @twocom = Comment.last(2)
    @com = Comment.new #hash
    query_value = params[:query] 
    p "2"*100
    if @user.where(name: params[:query]).present?
      @assignments = @popular_assignment.where(user_id: @user.where(name: params[:query]).first.id)
    else
     @assignments = @popular_assignment.find_by_sql("SELECT * FROM assignments
      WHERE deleted_at IS NULL AND title LIKE '%#{query_value}%' OR description LIKE '%#{query_value}%' AND deleted_at IS NULL
      ORDER BY CASE
        WHEN (title LIKE '%#{query_value}%' AND description LIKE '%#{query_value}%') THEN 1
        WHEN (title LIKE '%#{query_value}%' AND description NOT LIKE '%#{query_value}%') THEN 2
        ELSE 3
        END, title
    LIMIT 0, 6; ")
     end
     
     @query_value = query_value 
     p @assignments
     p "F"*100
     popular = Hash.new
     for i in @popular_assignment
       popular[i.id] = (Comment.where(Assignment_id: i.id).all.count * 5) + Like.where(Assignment_id: i.id,status: true).count
     end
    @popular_view = popular.sort_by{|_key, value| -value}.to_h
    p @popular_view
    p "s"*100
    @popular_list = @assignments[4..8] || [] 
    render "idea_temp"
  end  
  # DELETE /assignments/1
  # DELETE /assignments/1.json

  def popular

  end

  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def follow
    # idea_id, 
    Follow.create(user_id: current_user.id, obj_type: Follow::IDEA, obj_id: params[:assignment_id])
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
      params.require(:assignment).permit(:description, :user_id, :category_id, :status, :avatar, :title, :quote, :document)
    end
end

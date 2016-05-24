class FollowsController < InheritedResources::Base

  private

    def follow_params
      params.require(:follow).permit(:obj_type, :obj_id, :user_id)
    end
end


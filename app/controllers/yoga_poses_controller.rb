class YogaPosesController < ApplicationController
    def create
        @yoga_pose = YogaPose.new(yoga_pose_params)
        if params[:alternative_names].present?
            params[:alternative_names].each do |name|
                @yoga_pose.alternative_names.build(name: name, yoga_pose_id: @yoga_pose.id)
            end
        end
        if params[:sanskrit_names].present?
            params[:sanskrit_names].each do |name|
                @yoga_pose.sanskrit_names.build(name: name, yoga_pose_id: @yoga_pose.id)
            end
        end
        @yoga_pose.save
    end

    def yoga_pose_params
        params.require(:yoga_pose).permit(:name, :description, :difficulty, :display_name, :video_url, :image_url, :benefits, :category, :alternative_names, :sanskrit_names)
    end
end

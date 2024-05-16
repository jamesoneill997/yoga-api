class YogaPose < ApplicationRecord
    has_many :alternative_names, class_name: "AlternativeName", foreign_key: "yoga_pose_id"
end

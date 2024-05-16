class SearchController < ApplicationController
    SEARCH_TYPES = ['name', 'category', 'level', 'target_areas']
    LEVELS = ['beginner', 'intermediate', 'expert'] 
    CATEGORIES = ["seated", "standing", "arm_leg_support", "supine", "prone", "arm_balance_and_inversion"]
    def search
        @type = params[:type]
        @query = params[:query]
        if @type.nil? || !SEARCH_TYPES.include?(@type)
            return render json: { error: 'Invalid search type' }, status: :bad_request
        end

        if @query.nil? || @query.empty?
            return render json: { error: 'Query cannot be empty' }, status: :bad_request
        end
        
        case @type
            when 'name'
                @results = YogaPose.left_outer_joins(:alternative_names)
                .where("yoga_poses.name LIKE :query OR alternative_names.name LIKE :query", query: "%#{@query}%")
                .distinct
                puts @results
                if @results.empty?
                    return render json: { error: 'No results found' }, status: :ok
                end
                return render json: @results, status: :ok

            when 'category'
                if !CATEGORIES.include?(@query)
                    return render json: { error: "Category should be one of the following: #{CATEGORIES.join(', ')}" }, status: :bad_request
                end
                @results = YogaPose.where('category LIKE ?', "%#{@query}%")
                if @results.empty?
                    return render json: { error: 'No results found' }, status: :ok
                end
                return render json: @results, status: :ok

            when 'level'
                if !LEVELS.include?(@query)
                    return render json: { error: "Level should be one of the following: #{LEVELS.join(', ')}" }, status: :bad_request
                end
                @results = YogaPose.where('difficulty LIKE ?', "%#{@query}%")

                if @results.empty?
                    return render json: { error: 'No results found' }, status: :ok
                end
                return render json: @results, status: :ok
            when 'target_areas'
                @results = YogaPose.where('benefits LIKE ?', "%#{@query}%")
                if @results.empty?
                    return render json: { error: 'No results found' }, status: :ok
                end
            return render json: @results, status: :ok
        end
    end
end

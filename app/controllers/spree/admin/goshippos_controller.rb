module Spree
  module Admin
    class GoshipposController < ResourceController

      # GET /goshippos
      def index
        @goshippos = if params[:ids].present?
                       scope.where(id: params[:ids].split(','))
                     else
                       scope.load.ransack(
                         params[:q]
                       ).result
                     end
      end

      private

        def collection
          params[:q] = {} if params[:q].blank?
          @search = Spree::Goshippo.accessible_by(current_ability).ransack(params[:q])
          
          @collection = @search.result.
              page(params[:page]).
              per(params[:per_page])
          @collection
        end

        def scope
          Spree::Goshippo.accessible_by(current_ability)
        end
    end
  end
end

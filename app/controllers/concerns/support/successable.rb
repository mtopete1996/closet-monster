module Support
  module Successable
    def module_name
      @module_name ||= self.class.module_parent.name.downcase.to_sym
    end

    def save_successful(resource, action: :saved, path: nil)
      path ||= index_path(resource)
      flash[:success] = "#{human_resource(resource)} has been #{action} successfully"
      redirect_to path
    end

    private

    def index_path(resource)
      @index_path ||= [module_name, resource]
    end

    def human_resource(resource)
      @human_resource ||= resource.to_s.humanize.singularize
    end
  end
end

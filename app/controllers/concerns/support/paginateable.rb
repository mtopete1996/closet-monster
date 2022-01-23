module Support
  module Paginateable
    def page
      @page ||= params[:page] || 1
    end

    def per
      @per ||= params[:per] || 12
    end
  end
end

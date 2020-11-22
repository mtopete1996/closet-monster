class CrudController < ApplicationController
  attr_reader :resource

  def index
    instance_variable_set(:"@#{resource_name}", resource.all)
    render layout: 'application'
  end

  private

  def resource_name
    resource.name.pluralize.downcase
  end
end

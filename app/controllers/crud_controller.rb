class CrudController < ApplicationController
  attr_reader :resource

  # index, new, create, show, edit, update, destroy

  def index
    instance_variable_set(:"@#{resource_name(false)}", resource.all)
    render layout: 'application'
  end

  def new
    instance_variable_set(:"@#{resource_name}", resource.new)
    render layout: 'application'
  end

  def create
    res = resource.create(permited_params)
    return flash unless res

    flash[:success] = "#{resource_name.titleize} has been created successfully"
    redirect_to action: :index
  end

  def show
    instance_variable_set(:"@#{resource_name}", show_object)
    render layout: 'application'
  end

  def edit
    instance_variable_set(:"@#{resource_name}", show_object)
    render layout: 'application'
  end

  private

  def show_object
    resource.find_by_id(params.permit(:id)[:id])
  end

  def success_path
    raise NotImplementedError, 'This method must be instanced on the inherited class'
  end

  def permited_params
    raise NotImplementedError, 'This method must be instanced on the inherited class'
  end

  def resource_name(single = true)
    r = resource.name.downcase
    return r if single

    r.pluralize
  end
end

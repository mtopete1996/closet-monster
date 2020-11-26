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
    res = resource.new(permited_params)
    return render_error(res) unless res.save

    flash[:success] = "#{resource_name.titleize} has been created successfully"
    redirect_to action: :index
  end

  def show
    instance_variable_set(:"@#{resource_name}", find_resource)
    render layout: 'application'
  end

  def edit
    instance_variable_set(:"@#{resource_name}", find_resource)
    render layout: 'application'
  end

  def update
    return render_error unless find_resource.update(permited_params)

    flash[:success] = "#{resource_name.titleize} has been updated successfully"
    redirect_to action: :index
  end

  def destroy
    return render_error unless find_resource.destroy

    flash[:success] = "#{resource_name.titleize} has been deleted successfully"
    redirect_to action: :index
  end

  private

  def action
    return :edit if action_name == 'destroy'
    return :new if action_name == 'create'
  end

  def find_resource
    resource.find_by_id(params.permit(:id)[:id])
  end

  def permited_params
    raise NotImplementedError, 'This method must be instanced on the inherited class'
  end

  def render_error(resource)
    instance_variable_set(:"@#{resource_name}", resource)
    render action, layout: 'application'
  end

  def resource_name(single = true)
    r = resource.name.downcase
    return r if single

    r.pluralize
  end

  def success_path
    raise NotImplementedError, 'This method must be instanced on the inherited class'
  end
end

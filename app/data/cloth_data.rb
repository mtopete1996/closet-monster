class ClothData
  def initialize(data)
    @id = data.delete(:id)
    @user = data[:user]
    @data = data
  end

  attr_reader :data, :id, :user

  def cloth
    @cloth ||= new_or_edit
  end

  def find_cloth
    @find_cloth ||= Cloth.find_by(id: id)
  end

  def types_options
    @types_options ||= ClothType.user_types(user).pluck :name, :id
  end

  private

  def new_or_edit
    return find_cloth if id

    Cloth.new(data)
  end
end

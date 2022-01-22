class ClothData
  def initialize(data)
    @id = data.delete(:id)
    @user = data[:user]
    @data = data
  end

  attr_reader :data, :id, :user

  def brands_options
    @brands_options ||= ClothBrand.user_brands(user).by_name.pluck :name, :id
  end

  def cloth
    @cloth ||=
      ## NOTE: For some reason I can't use a guard clause for this inside a block
      if id.present?
        Cloth.find_by(id: id)
      else
        Cloth.new(data)
      end
  end

  def persist
    cloth.assign_attributes(data) unless cloth.new_record?
    cloth.save
  end

  def types_options
    @types_options ||= ClothType.user_types(user).by_name.pluck :name, :id
  end
end

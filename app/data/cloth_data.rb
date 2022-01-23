class ClothData
  def initialize(data)
    @id = data.delete(:id)
    @worn_at = data.delete(:worn_at)
    @user = data[:user]
    @data = data
  end

  attr_reader :data, :id, :user, :worn_at

  def brands_options
    @brands_options ||= ClothBrand.user_brands(user).by_name.pluck :name, :id
  end

  def cloth
    @cloth ||=
      if id.present?
        Cloth.find_by(id: id)
      else
        Cloth.new(data)
      end
  end

  def persist
    cloth.assign_attributes(data) unless cloth.new_record?
    saved = cloth.save
    cloth.logs << ClothLog.create(cloth: cloth, worn_at: worn_at) if worn_at.present?
    saved
  end

  def types_options
    @types_options ||= ClothType.user_types(user).by_name.pluck :name, :id
  end
end

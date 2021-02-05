module ClothHelper
  def using_now_path(cloth_id)
    link_to 'Using now!', [module_name, :cloth, { id: cloth_id, cloth: { last_time_worn: Date.today } }],
            method: :put, class: 'btn btn-success my-3'
  end
end

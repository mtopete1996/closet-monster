module ClothHelper
  def using_now_path(cloth_id)
    link_to 'Using now!', [module_name, :calendar, { cloth_id: cloth_id, worn_at: Date.today }],
            method: :post, class: 'btn btn-success my-3'
  end
end

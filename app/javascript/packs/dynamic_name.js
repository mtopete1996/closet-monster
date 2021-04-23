document.addEventListener('turbolinks:load', function() {
  const $form = $('#cloths-form')

  if ($form) {
    const $nameField = $form.find('input[name="cloth[name]"]')
    const $typeField = $form.find('select[name="cloth[cloth_type_id]"]')
    const $brandField = $form.find('select[name="cloth[cloth_brand_id]"]')
    let has_been_changed = false

    $typeField.change(() => updateName())
    $brandField.change(() => updateName())
    $nameField.change(() => { has_been_changed = true })

    const updateName = () => {
      if (!has_been_changed) {
        const selectedType = $typeField.find('option:selected').text()
        const selectedBrand = $brandField.find('option:selected').text()
        const newName = [selectedType, selectedBrand].join(' ')

        $nameField.val(newName)
      }
    }
  }
})

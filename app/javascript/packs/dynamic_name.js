document.addEventListener("turbolinks:load", function() {
  const $form = $('#cloths-form')

  if ($form) {
    const $nameField = $form.find('input[name="cloth[name]"]')
    const $typeField = $form.find('select[name="cloth[cloth_type_id]"]')
    const $brandField = $form.find('select[name="cloth[cloth_brand_id]"]')

    $typeField.on('change', () => updateName())
    $brandField.on('change', () => updateName())

    const updateName = () => {
      if ($nameField.val() === '') {
        const selectedType = $typeField.find('option:selected').text()
        const selectedBrand = $brandField.find('option:selected').text()
        const newName = [selectedType, selectedBrand].join(' ')

        $nameField.val(newName)
      }
    }
  }
})

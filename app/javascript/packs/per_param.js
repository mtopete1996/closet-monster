import { url_params, json_to_search } from './utils'

document.addEventListener('turbolinks:load', function() {
  const $per_param = $('.pages-per')

  if ($per_param) {
    $per_param.on('change', (e) => per_change_handler(e.target.value))

    const per_change_handler = (per) => {
      const { pathname, search } = window.location
      let params_obj = url_params(search)
      params_obj.per = per

      const srch = json_to_search(params_obj)
      window.location.href = `${pathname}${srch}`
    }
  }
})

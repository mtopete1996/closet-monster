const url_params = params_string => {
  let splitted_params = params_string.substr(1).split('&')
  let params = {}

  splitted_params.map(param => {
    const [title, val] = param.split('=')
    params[title] = val
  })

  return params
}

const json_to_search = (obj) => {
  let srch = '?'
  for(const param in obj) {
    if (obj[param])
      srch = srch.concat(param, '=', obj[param], '&')
    }
  return srch
}

module.exports = { url_params, json_to_search }

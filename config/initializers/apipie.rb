Apipie.configure do |config|
  config.app_name                = "API Document"
  config.api_base_url['public']  = ""
  config.doc_base_url            = "/apipie"
  config.default_locale          = "ja"
  
  # apiに該当するコントローラーのソースの場所
  config.api_controllers_matcher = Rails.root.join('app', 'controllers', '**', '*.rb')
  config.default_version = 'public'

  # ドキュメントのローカライズ
  # /apipie/public/users.ja.html, /apipie/public/users.en.html といった
  # URLでドキュメントが提示されます
  config.languages = %w[en ja]

  # ローカライズの必要がない場合は、コメントインします
  # config.translate = false
end

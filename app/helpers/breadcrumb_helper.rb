module BreadcrumbHelper

  PAGE_TITLES = {
    'user_profile#show' => { title: 'Meu Perfil', subtitle: 'Atualizar Dados' },
    'wallet#index' => { title: 'Dashboard', subtitle: 'Your Balance' },
    'pages#index' => { title: 'Dashboard', subtitle: 'Welcome' },
    }.freeze

  def page_title
    (PAGE_TITLES["#{controller_name}##{action_name}"] || { title: 'Dashboard', subtitle: '' })[:title]
  end

  def page_subtitle
    (PAGE_TITLES["#{controller_name}##{action_name}"] || { title: 'Dashboard', subtitle: '' })[:subtitle]
  end
end
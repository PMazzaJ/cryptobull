class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  allow_browser versions: :modern
end

# pra skippar se precisar:   skip_before_action :authenticate_user!, only: [:index]

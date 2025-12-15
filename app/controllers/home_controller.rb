class HomeController < ApplicationController
  def index
    city = params[:city]
    service = params[:service]

    search_args = []
    if !city.blank?
      search_args << { location: city }
    end
    if !service.blank?
      search_args << { services: service }
    end

    @businesses = Business.search(search_args, current_user)
  end
end

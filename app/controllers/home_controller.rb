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


    if current_user && search_args.any?
      recent_search = RecentSearch.create!(
        user: current_user,
        city: city,
        service: service,
        last_query_date: Time.current
      )

      recent_search.businesses << @businesses
      Rails.logger.warn("recent search: ")
      Rails.logger.warn(recent_search)
    end
  end

  def show
    # cant use Business.seacrh, because it returns an array
    # business = Business.find(id)
    #
    # Business.search() -> [buinsses1, etc]
    # business = businesses[0], only expect one business to be returned, because you search by id (unique)
    # Business.find()
    # Business.where() returns array
    # don't have access to Business.saved?
    # if you want access, you have to write another custom search, that returns one Business with the saved property
  end
end

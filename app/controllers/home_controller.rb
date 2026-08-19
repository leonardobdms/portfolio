# frozen_string_literal: true

class HomeController < InertiaController
  def index
    @profile = Profile.current
  end
end

# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @portfolio = Site::Payload.build
  end
end

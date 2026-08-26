# frozen_string_literal: true

class SitemapsController < ApplicationController
  def show
    @profile = Profile.current
    respond_to :xml
  end
end

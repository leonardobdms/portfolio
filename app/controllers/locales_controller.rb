# frozen_string_literal: true

class LocalesController < ApplicationController
  def update
    locale = params[:locale].to_s
    cookies.permanent[LocaleResolver::COOKIE] = locale if LocaleResolver.available?(locale)

    redirect_back_or_to root_path, allow_other_host: false
  end
end

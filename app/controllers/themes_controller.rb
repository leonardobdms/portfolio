# frozen_string_literal: true

class ThemesController < ApplicationController
  def update
    theme = params[:theme].to_s
    cookies.permanent[ThemeResolver::COOKIE] = theme if ThemeResolver.available?(theme)

    redirect_back_or_to root_path, allow_other_host: false
  end
end

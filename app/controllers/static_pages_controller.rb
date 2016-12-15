class StaticPagesController < ApplicationController
  before_filter :redirect_if_logged_in
  def home
  end

  private
  def redirect_if_logged_in
    redirect_to(parties_path) if user_signed_in? # check if user logged in
  end
end

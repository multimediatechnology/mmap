class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  include ActionView::Helpers::DateHelper

  before_filter :read_settings

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403
  end

  private
  def read_settings
    start_date = Setting.where(name: 'start').first.value
    end_date = Setting.where(name: 'end').first.value
    start_date = DateTime.parse(start_date)
    end_date = DateTime.parse(end_date)

    @start_date = start_date
    @end_date = end_date
    @is_open = start_date.past? && !end_date.past?
    @countdown = distance_of_time_in_words(DateTime.now, start_date)
  end

end

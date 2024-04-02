class Public::TimelinesController < ApplicationController
  
  def index
    @timelines = current_customer.timelines;
  end
end

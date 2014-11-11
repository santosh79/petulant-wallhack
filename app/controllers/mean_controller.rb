class MeanController < ApplicationController
  def index
    numbers_looked_at = session[:numbers_looked_at]
    numbers_looked_at ||= 0
    if numbers_looked_at > 0
      @mean = session[:mean]
    else
      @mean = 0
    end
  end

  def update
    number = params[:number].to_i

    numbers_looked_at = session[:numbers_looked_at]
    numbers_looked_at ||= 0


    if numbers_looked_at == 0
      new_mean = number
    else
      cur_mean = session[:mean]
      cur_sum = cur_mean * numbers_looked_at
      new_sum = cur_sum + number
      new_mean = new_sum / (numbers_looked_at + 1)
    end
    session[:mean] = new_mean
    session[:numbers_looked_at] = (numbers_looked_at + 1)
    redirect_to mean_index_path
  end

  def reset
    session[:mean] = 0
    session[:numbers_looked_at] = 0
    redirect_to mean_index_path
  end
end

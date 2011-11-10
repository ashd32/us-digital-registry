class OutletsController < ApplicationController
  def add
    @outlet = Outlet.resolve(params[:service_url]) || Outlet.new
  end
  
  def update
    @outlet = Outlet.resolve(params[:service_url])
    
    unless @outlet
      @outlet = Outlet.new
      render 'add' and return
    end
    
    # Update the object with any non-empty values provided
    new_params = params.reject do |key, value| 
      value.nil? || 
      value.empty? || 
      key == :service_url
    end
    if @outlet.update_attributes(new_params)
      flash[:success] = "Outlet updated."
      redirect_to add_path
    else
      render 'add'
    end
  end
  
  def verify
    @outlet = Outlet.resolve(params[:service_url])
    
  end

end

class RolesController < ApplicationController

  before_filter :find_client

  def new
    @role = Role.new
  end

  def edit
    @role = @client.roles.find(params[:id])
  end

  def create
    @role = Role.new(params[:role])
    if (@client.roles << @role)
      flash[:notice] = "Resource was successfully created."                      
      redirect_to client_role_url(@client, @role)
    else 
      render :action => :new
    end
  end

  def update
    @role = @client.roles.find(params[:id])
    if @role.update_attributes(params[:role])
      flash[:notice] = "Resource was successfully updated."                      
      redirect_to client_role_url(@client, @role)
    else
      render :action => :edit
    end
  end

  def destroy
    @role = @client.roles.find(params[:id])
    @client.roles.destroy(@role)
    flash[:notice] = "Resource was successfully removed."                      
    redirect_to client_roles_url(@client)    
  end
  
  def show
    @role = @client.roles.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml {render :xml => @role.to_xml }
    end
  end
  

  private
  
  def find_client
    @client_id = params[:client_id]
    redirect_to clients_url unless @client_id
    @client = Client.find(@client_id)
  end

end

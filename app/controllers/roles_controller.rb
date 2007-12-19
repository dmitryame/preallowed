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
      redirect_to client_url(@client)
    else 
      render :action => :new
    end
  end

  def update
    @role = @client.roles.find(params[:id])
    if @role.update_attributes(params[:role])
      redirect_to client_url(@client)
    else
      render :action => :edit
    end
  end

  def destroy
    @role = @client.roles.find(params[:id])
    @client.roles.destroy(@role)
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

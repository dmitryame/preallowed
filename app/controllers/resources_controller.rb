class ResourcesController < ApplicationController

  before_filter :find_scope
  
  def new
    @resource = Resource.new
  end

  def edit
    @resource = @scope.resources.find(params[:id])
  end

  def create
    @resource = Resource.new(params[:resource])
    if (@scope.resources << @resource)
      flash[:notice] = "Resource was successfully created."                  
      redirect_to client_scope_resource_url(@client, @scope, @resource)
    else 
      render :action => :new
    end
  end

  def update
    @resource = @scope.resources.find(params[:id])
    if @resource.update_attributes(params[:resource])
      flash[:notice] = "Resource was successfully updated."                        
      redirect_to client_scope_resource_url(@client, @scope, @resource)
    else
      render :action => :edit
    end
  end

  def destroy
    @resource = @scope.resources.find(params[:id])
    @scope.resources.destroy(@resource)
    flash[:notice] = "Resource was successfully removed."                      
    redirect_to client_scope_resources_url(@client, @scope)    
  end

  def show
    @resource = @scope.resources.find(params[:id])
    @clientroles = @client.roles - @resource.roles
    
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml {render :xml => @resource.to_xml }
    end
  end

  def add_role
    @resource = @scope.resources.find(params[:id])
    
    @role = @client.roles.find(params[:role_id])
    @resource.roles << @role

    @clientroles = @client.roles - @resource.roles
  end

  def remove_role
    @resource = @scope.resources.find(params[:id])

    @role = @client.roles.find(params[:role_id])
    @resource.roles.delete(@role)

    @clientroles = @client.roles - @resource.roles
  end
  
  private
  
  def find_scope
    @client_id = params[:client_id]
    @scope_id = params[:scope_id]

    redirect_to clients_url unless @client_id
    @client = Client.find(@client_id)
        
    redirect_to client_scopes_url(@client.id) unless @scope_id
    @scope = @client.scopes.find(@scope_id)
  end


end

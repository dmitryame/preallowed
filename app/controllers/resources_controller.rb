class ResourcesController < ApplicationController
  before_filter :find_client


  # GET /resources
  # GET /resources.xml
  def index
    @resources = @client.resources

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = @client.resources.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.xml
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = @client.resources.find(params[:id])
  end

  # POST /resources
  # POST /resources.xml
  def create
    @resource = Resource.new(params[:resource])

    respond_to do |format|
      if @client.resources << @resource
        flash[:notice] = 'Resource was successfully created.'
        format.html { redirect_to client_resource_url(@client, @resource) }
        format.xml  { render :xml => @resource, :status => :created, :location => [@client, @resource] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
    @resource = @client.resources.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        flash[:notice] = 'Resource was successfully updated.'
        format.html { redirect_to client_resource_url(@client, @resource) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = @client.resources.find(params[:id])
    @resource.destroy

    respond_to do |format|
      flash[:notice] = 'Resource was successfully removed.'            
      format.html { redirect_to client_resources_url(@client) }
      format.xml  { head :ok }
    end
  end



  def add_role
    @resource = @client.resources.find(params[:id])
    @role = @client.roles.find(params[:role_id])
    respond_to do |format|
      if @role.resources << @resource
        format.xml { head :ok }
        format.js
      else
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  def remove_role
    @resource = @client.resources.find(params[:id])  
    @role = @client.roles.find(params[:role_id])
    respond_to do |format|
      if @role.resources.find(@resource) and @role.resources.delete(@resource)
        format.xml  { head :ok }
        format.js
      else
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end        
    end
  end

  private

    def find_client
      @client_id = params[:client_id]
      redirect_to clients_url unless @client_id
      @client = Client.find(@client_id)
    end

end

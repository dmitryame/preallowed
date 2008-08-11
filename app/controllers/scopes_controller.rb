class ScopesController < ApplicationController

  before_filter :find_client

  def index
    @scopes = @client.scopes
    respond_to do |format|
      format.html # index.html
      format.xml { render :xml => @scopes.to_xml}
    end
  end

  
  def new
    @scope = Scope.new
  end

  def edit
    @scope = @client.scopes.find(params[:id])
  end

  def create
    @scope = Scope.new(params[:scope])
    if (@client.scopes << @scope)
      flash[:notice] = "Scope was successfully created."
      redirect_to client_scope_url(@client, @scope)
    else 
      render :action => :new
    end
  end

  def update
    @scope = @client.scopes.find(params[:id])
    if @scope.update_attributes(params[:scope])
      flash[:notice] = "Scope was successfully updated."      
      redirect_to client_scope_url(@client, @scope)
    else
      render :action => :edit
    end
  end

  def destroy
    @scope = @client.scopes.find(params[:id])
    @client.scopes.destroy(@scope)

    respond_to do |format|
      flash[:notice] = 'Scope was successfully removed.'      
      format.html do
        redirect_to client_scopes_url
      end
      format.js # run the destroy.rjs template
      format.xml  do
        render :nothing => true
      end
    end

  end

  def show
    @scope = @client.scopes.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml {render :xml => @scope.to_xml }
    end
  end
  
  private
  
  def find_client
    @client_id = params[:client_id]
    redirect_to clients_url unless @client_id
    @client = Client.find(@client_id)
  end
end

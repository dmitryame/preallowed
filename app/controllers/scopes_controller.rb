class ScopesController < ApplicationController

  before_filter :find_client
  
  def new
    @scope = Scope.new
  end

  def edit
    @scope = @client.scopes.find(params[:id])
  end

  def create
    @scope = Scope.new(params[:scope])
    if (@client.scopes << @scope)
      redirect_to client_url(@client)
    else 
      render :action => :new
    end
  end

  def update
    @scope = @client.scopes.find(params[:id])
    if @scope.update_attributes(params[:scope])
      redirect_to client_url(@client)
    else
      render :action => :edit
    end
  end

  def show
    @scope = @client.scopes.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml {render :xml => @scope.to_xml }
    end
  end

  def destroy
    @scope = @client.scopes.find(params[:id])
    @client.scopes.destroy(@scope)
  end
  
  private
  
  def find_client
    @client_id = params[:client_id]
    redirect_to clients_url unless @client_id
    @client = Client.find(@client_id)
  end
end

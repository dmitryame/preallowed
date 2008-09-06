class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.xml
  def index    
    logeed_in_subject = Subject.find(session[:subject_id])    
    @clients = logeed_in_subject.managed_clients

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.xml
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.xml
  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        flash[:notice] = 'Client was successfully created.'
        format.html { redirect_to(@client) }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        flash[:notice] = 'Client was successfully updated.'
        format.html { redirect_to(@client) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      flash[:notice] = 'Client was successfully removed.'      
      format.html { redirect_to(clients_url) }
      format.xml  { head :ok }
    end
  end

  # lookup subject_id from name 
  def subject_id_from_name
    @client = Client.find(params[:id])    
    @subject = @client.subjects.find(:first, :conditions => ["name = ?",params[:subject_name]])
    if @subject != nil
      render :text => "<a>" + @subject.id.to_s + "</a>"
    else
      render :text => "<a>0</a>" #this means there is no subject found for this name
    end
  end

  # lookup subject_id from name 
  def role_id_from_name
    @client = Client.find(params[:id])    
    @role = @client.roles.find(:first, :conditions => ["name = ?",params[:role_name]])
    if @role != nil
      render :text => "<a>" + @role.id.to_s + "</a>"
    else
      render :text => "<a>0</a>" #this means there is no subject found for this name
    end
  end


end

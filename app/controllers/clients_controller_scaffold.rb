class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.xml
  def index
    @clients = Client.find(:all)

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
    @subject = Subject.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    @preallowed_client = Client.find(1)    
    @subject = @preallowed_client.subjects.find_by_name(@client.name)    
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])
    @subject = Subject.new(params[:subject])
    Client.transaction do
      @client.save! #save new client so that we can get it's id
      
      @preallowed_client = Client.find(1)
      @preallowed_scope = @preallowed_client.scopes.find(1)

      role = Role.new
      role.name = @client.name + "_admin"
      role.client = @preallowed_client
      role.save! 

      # TODO: build a validation logic for the subject
      @subject.name = @client.name # this is a new master subject that will have all possible access rights to this newly created client
      @subject.client = @preallowed_client
      @subject.roles << role      
      @subject.save!
    
      resource = Resource.new      
      resource.name = "^/clients/"  + @client.id.to_s + "($|.xml$|/.*$)"      
      resource.scope = @preallowed_scope
      resource.resource_type = ResourceType.find(1)
      resource.roles << role
      resource.save!
      
      password = Principal.new
      salt = Principal.new
      password.subject = @subject
      password.principal_type_id = 1    
      salt.subject = @subject
      salt.principal_type_id = 2
      Subject.encriptPasswords password, salt, @subject.password
      password.save!
      salt.save!
      
    end


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
end

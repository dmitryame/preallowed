class EstablishmentsController < ApplicationController


  # GET /establishments/new
  # GET /establishments/new.xml
  def new
    @establishment = Establishment.new
    @managed_client = Client.new
    @administrator = Subject.new
    @establishment.managed_client = @managed_client
    @establishment.administrator = @administrator

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @establishment }
    end
  end

  # GET /establishments/1/edit
  def edit
    @establishment = Establishment.find(params[:id])
  end

  # POST /establishments
  # POST /establishments.xml
  def create
    @establishment = Establishment.new(params[:establishment])

    @managed_client = Client.new(params[:managed_client])
    @administrator = Subject.new(params[:administrator])
    @administrator.client = Client.preallowed_client

    Establishment.transaction do
      @managed_client.save!
      @administrator.save!
            
      @role = Role.new
      @role.name = @managed_client.name + "_admin"
      @role.client = @administrator.client
      @role.save! 

      @resource = Resource.new      
      @resource.name = "^/clients/"  + @managed_client.id.to_s + "($|.xml$|/.*$)"      
      @resource.client = @administrator.client
      @resource.save!

      @resource.roles << @role
      @administrator.roles << @role      
      @administrator.client.resources.find_by_name("^/clients$").roles << @role

      @establishment.managed_client = @managed_client
      @establishment.administrator = @administrator

      respond_to do |format|
        if @establishment.save
          flash[:notice] = 'Establishment was successfully created.'
          format.html { redirect_to(clients_url) }
          format.xml  { render :xml => @establishment, :status => :created, :location => @establishment }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @establishment.errors, :status => :unprocessable_entity }
        end
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render :action => :new
  end

  # PUT /establishments/1
  # PUT /establishments/1.xml
  def update
    @establishment = Establishment.find(params[:id])

    respond_to do |format|
      if @establishment.update_attributes(params[:establishment])
        flash[:notice] = 'Establishment was successfully updated.'
        format.html { redirect_to(@establishment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @establishment.errors, :status => :unprocessable_entity }
      end
    end
  end

end

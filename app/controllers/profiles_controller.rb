class ProfilesController < ApplicationController

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    @profile = Profile.new
    @managed_client = Client.new
    @administrator = Subject.new
    @profile.managed_client = @managed_client
    @profile.administrator = @administrator

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    @profile = Profile.new(params[:profile])

    @managed_client = Client.new(params[:managed_client])
    @administrator = Subject.new(params[:administrator])
    @administrator.client = Client.preallowed_client

    Profile.transaction do
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
      # @administrator.client.resources.find_by_name("^/clients$").roles << @role

      @profile.managed_client = @managed_client
      @profile.administrator = @administrator

      respond_to do |format|
        if @profile.save
          flash[:notice] = 'Profile was successfully created.'
          format.html { redirect_to(clients_url) }
          format.xml  { render :xml => @profile, :status => :created, :location => @profile }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
        end
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render :action => :new
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        flash[:notice] = 'Profile was successfully updated.'
        format.html { redirect_to(@profile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end


  def resolve_profile    
    redirect_to edit_profile_path(Subject.find(session[:subject_id]).profiles.first)
  end

end

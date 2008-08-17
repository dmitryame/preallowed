class ProfilesController < ApplicationController
  before_filter :find_administrator

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
    @profile = @administrator.profiles.find(params[:id])
    @managed_client = @profile.managed_client
    @administrator = @profile.administrator
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
            
      #this profile is to allow preallowed subject to manage the newly created client        
      profile = Profile.new
      profile.subject_id = Client.preallowed_client.administrators.first.id # TODO: this is a little iffy, which one of the administrators of the preallowed.com to give access? initially to the first one
      profile.client_id = @managed_client.id
      profile.save!
            
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
      @profile.save! 

      @profile_resource = Resource.new      
      @profile_resource.name = "^/profiles/"  + @profile.id.to_s + "($|.xml$|/.*$)"      
      @profile_resource.client = @administrator.client
      @profile_resource.save!

      @profile_resource.roles << @role

      respond_to do |format|
        # if @profile.save
          flash[:notice] = 'Profile was successfully created.'
          format.html { redirect_to(clients_url) }
          format.xml  { render :xml => @profile, :status => :created, :location => @profile }
        # else
        #   format.html { render :action => "new" }
        #   format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
        # end
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render :action => :new
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = @administrator.profiles.find(params[:id])

    @managed_client = @profile.managed_client
    @administrator = @profile.administrator

    respond_to do |format|
      if @managed_client.update_attributes(params[:managed_client]) and @administrator.update_attributes(params[:administrator])
        flash[:notice] = 'Profile was successfully updated.'
        format.html { redirect_to clients_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
  def find_administrator
    @administrator = Subject.find(session[:subject_id]) if session[:subject_id]
  end

end

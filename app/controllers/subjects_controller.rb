class SubjectsController < ApplicationController

  before_filter :find_client
  #, :except => has_access
  
  def new
    @subject = Subject.new
     respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @subject }
     end
  end

  def edit
    @subject = @client.subjects.find(params[:id])
  end

  def create
    @subject = Subject.new(params[:subject])
    
    respond_to do |format|
      if @client.subjects << @subject
        flash[:notice] = 'Subject was successfully created.'
        format.html { redirect_to client_subject_url(@client, @subject) }
        format.xml  { render :xml => @subject, :status => :created, :location => [ @client, @subject] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
      end
    end
    
    
  end

  def update
    @subject = @client.subjects.find(params[:id])
    respond_to do |format|
      if @subject.update_attributes(params[:subject])
        flash[:notice] = 'Subject was successfully updated.'
        format.html { redirect_to client_subject_url(@client, @subject) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
      end
    end    
  
  end

  def destroy
    @subject = @client.subjects.find(params[:id])
    @client.subjects.destroy(@subject)
  end

  def show
    @subject = @client.subjects.find(params[:id])
    @clientroles = @client.roles - @subject.roles
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml {render :xml => @subject }
    end
  end

  def add_role
    @subject = @client.subjects.find(params[:id])    
    
    @role = @client.roles.find(params[:role_id])
    @subject.roles << @role

    @clientroles = @client.roles - @subject.roles
  end

  def remove_role
    @subject = @client.subjects.find(params[:id])

    @role = @client.roles.find(params[:role_id])
    @subject.roles.delete(@role)

    @clientroles = @client.roles - @subject.roles
  end
  
  # this method is a core of the solution for verifying if a particular subject has a access to a particular resource.
  # takes a resource as a post parameter, the resource can use wild cards.
  def has_access
    accessible = ApplicationController.check_helper(params[:id], params[:resource])
    if accessible == true # should code a comparison agains ruby regular expressions here
      render :text => "<a>1</a>" 
      return
    end
    # if no matching resouces found by the end of the iteration, return false
    render :text => "<a>0</a>"
  end
  
  # only used for interactive testing to allow post submission of the has_access action from the browser
  def has_access_verify
    @subject = @client.subjects.find(params[:id])
  end


  # a restful web service method that renders back 1 or 0
  def is_subject_in_role
    @subject = @client.subjects.find(params[:id])    
    number_of_roles = @subject.roles.count :conditions => ["id = ?", params[:role_id]] 
    if number_of_roles == 1
      respond_to do |format|
        format.html 
        format.xml {render :text => "<a>1</a>" }
      end
    else
      respond_to do |format|
        format.html 
        format.xml {render :text => "<a>0</a>" }
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

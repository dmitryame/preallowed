class SubjectsController < ApplicationController

  before_filter :find_client

  def new
    @subject = Subject.new
  end

  def edit
    @subject = @client.subjects.find(params[:id])
  end

  def create
    @subject = Subject.new(params[:subject])
    if (@client.subjects << @subject)
      redirect_to client_url(@client)
    else 
      render :action => :new
    end
  end

  def update
    @subject = @client.subjects.find(params[:id])
    if @subject.update_attributes(params[:subject])
      redirect_to client_url(@client)
    else
      render :action => :edit
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
      format.xml {render :xml => @subject.to_xml }
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
    @subject = @client.subjects.find(params[:id])
    resource_to_verify = params[:resource]

    @subject.roles.each do |role|
      puts "there are " + role.resources.count.to_s + " resources"      
      role.resources.each do |resource|
        puts resource_to_verify + " == " + resource.name
        if resource_to_verify == resource.name # should code a comparison agains ruby regular expressions here
          render :text => 1 
          return
        end
      end
    end
    # if no matching resrouces found by the end of the iteration, return false
    render :text => 0
  end
  
  # only used for interactive testing to allow post submission of the has_access action from the browser
  def has_access_verify
    @subject = @client.subjects.find(params[:id])
  end


  private
  
  def find_client
    @client_id = params[:client_id]
    redirect_to clients_url unless @client_id
    @client = Client.find(@client_id)
  end

end

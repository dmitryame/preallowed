class ClientsController < ApplicationController
  #GET /clients
  # GET /clients.xml
  
  def index
    @clients = Client.find(:all)
    respond_to do |format|
      format.html # index.html
      format.xml { render :xml => @clients.to_xml}
    end
  end
  
  # GET /clients/1
  # GET /clients/1.xml
  
  def show
    @client = Client.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml {render :xml => @client.to_xml }
    end
  end
  
  # GET /clients/new
  def new
    @client = Client.new
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
        flash[:notice] = "Client was successfully created"
        format.html {redirect_to client_url(@client)}
        format.xml do
          headers["Location"] = client_url(@client)
          render :nothing => true, :status => "201 Created"
        end
      else
        format.html {render :action => "new"}
        format.xml {render :xml => @client.errors.to_xml}
      end
    end
  end
  
  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])
    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html {redirect_to client_url(@client)}
        format.xml {render :nothing => true}
      else
        format.html {render :action => "edit"}
        format.xml {render :xml => @client.errors.to_xml}
      end
    end
  end
  
  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html do
        redirect_to clients_url
      end
      format.js # run the destroy.rjs template
      format.xml  do
        render :nothing => true
      end
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
  
end
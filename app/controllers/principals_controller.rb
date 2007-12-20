class PrincipalsController < ApplicationController
  before_filter :find_subject

  def new
    @principal = Principal.new
  end

  def edit
    @principal = @subject.principals.find(params[:id])
  end

  def create
    @principal = Principal.new(params[:principal])
    if (@subject.principals << @principal)
      redirect_to client_subject_url(@client, @subject)
    else 
      render :action => :new
    end
  end

  def update
    @principal = @subject.principals.find(params[:id])
    if @principal.update_attributes(params[:principal])
      redirect_to client_subject_url(@client, @subject)
    else
      render :action => :edit
    end
  end

  def destroy
    @principal = @subject.principals.find(params[:id])
    @subject.principals.destroy(@principal)
  end

  def show
    @principal = @subject.principals.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml {render :xml => @principal.to_xml }
    end
  end


  private
  
  def find_subject
    @client_id = params[:client_id]
    @subject_id = params[:subject_id]

    redirect_to clients_url unless @client_id
    @client = Client.find(@client_id)
        
    redirect_to client_subjects_url(@client.id) unless @subject_id
    @subject = @client.subjects.find(@subject_id)
  end

end

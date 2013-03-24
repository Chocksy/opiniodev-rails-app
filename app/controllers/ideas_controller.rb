class IdeasController < ApplicationController

  def index

    respond_to do |format|
      format.json { render :json => @ideas }
      format.html
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json                                     HTML AND AJAX
  #-------------------------------------------------------------------
  def show

    respond_to do |format|
      format.json { render :json => @idea }
      format.html
    end
  end

  # PUT /ideas/1
  # GET /ideas/1.xml
  # GET /ideas/1.json                                HTML AND AJAX
  #-------------------------------------------------------------------
  def update
    @idea = User.find(params[:id])

    respond_to do |format|
      if @idea.update_attributes(params)
        format.html { redirect_to(@idea) }
        format.js {render :template=>"shared/ujs/form_errors.js.erb",:locals=>{ :info => [:notice => "We updated the idea."] } }
      else
        format.html { render :action => "edit",:status => :unprocessable_entity}
        format.js {render :template=>"shared/ujs/form_errors.js.erb",:locals=>{ :info => [:error=>@idea.errors.full_messages.to_a] } }
      end
    end
  end

  # GET /ideas/1/edit
  # GET /ideas/1/edit.json                                HTML AND AJAX
  #-------------------------------------------------------------------
  def edit
    respond_to do |format|
      format.json { render :json => {data:@idea,success:true} }
      format.html
    end
  end


  # DELETE /ideas/1
  # DELETE /ideas/1.json                                  HTML AND AJAX
  #-------------------------------------------------------------------
  def destroy

    @idea.destroy if !@idea.nil?
    respond_to do |format|
      format.json { render :json => {data:@idea.to_json,success:true}, :status => 200}
      format.html { flash[:notice] = "User deleted."
      redirect_to(:back) }
    end
  end

end

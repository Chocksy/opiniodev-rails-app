class IdeasController < ApplicationController

  def index
    ideas_data = Idea.all
    if params[:q] != "undefined"
      ideas_data = ideas_data.any_of({:title=>/.*#{params[:q]}.*/i})
    end
    @total_ideas = ideas_data.count
    ideas_data = ideas_data.order_by(:created_at.desc).paginate(:page=>params[:page],:limit=>params[:per_page])

    @ideas = ideas_data
    render :json => ["ideas"=>@ideas,"total_ideas"=>@total_ideas]
  end

  # GET /ideas/1
  # GET /ideas/1.json                                     HTML AND AJAX
  #-------------------------------------------------------------------
  def show
    @idea = Idea.find(params[:id])
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
    @idea = Idea.find(params[:id])
    params[:idea].delete(:id)
    if @idea.update_attributes(params[:idea])
      @success = true
    else
      @success = false
    end

    render :json => {success:@success}
    #respond_to do |format|
    #  if @idea.update_attributes(params[:idea][:info])
    #    format.html { redirect_to(@idea) }
    #    format.js {render :template=>"shared/ujs/form_errors.js.erb",:locals=>{ :info => [:notice => "We updated the idea."] } }
    #  else
    #    format.html { render :action => "edit",:status => :unprocessable_entity}
    #    format.js {render :template=>"shared/ujs/form_errors.js.erb",:locals=>{ :info => [:error=>@idea.errors.full_messages.to_a] } }
    #  end
    #end
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

  # GET /ideas/new
  # GET /ideas/new.json
  def new
    @idea = Idea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(params[:idea])

    respond_to do |format|
      if @idea.save
        @locals = {:info => [:notice => "New portal created."]}
        format.html { redirect_to(@idea)}
      else
        @locals = {:info => [:error => @idea.errors.full_messages.to_a]}
        format.html { render action: "new", :status => :unprocessable_entity }
      end
      format.json { render json: @idea}
      format.js { render :template => "shared/ujs/form_errors.js.erb", :locals => @locals}
    end
  end


end

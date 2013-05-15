class IdeasController < ApplicationController

  def index
    ideas_data = Idea.all
    if !params[:q].blank? && !params[:q].nil? && params[:q] != "undefined"
      ideas_data = ideas_data.any_of({:title => /.*#{params[:q]}.*/i})
    end
    @total_ideas = ideas_data.count
    ideas_data = ideas_data.order_by(:created_at.desc).paginate(:page => params[:page], :limit => params[:per_page])

    @ideas = []
    ideas_data.each do |idea|
      data = idea
      if !idea.user_id.nil?
        data[:user_info] = idea.user
      end
      @ideas.push(data)
    end

    #@ideas = ideas_data
    render :json => ["ideas" => @ideas, "total_ideas" => @total_ideas]
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
      @locals = {:info => [:notice => "Idea updated."], :success => true}
    else
      @locals = {:info => [:error => @idea.errors.full_messages.to_a], :success => false}
    end

    render :json => @locals
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
      format.json { render :json => {data: @idea, success: true} }
      format.html
    end
  end


  # DELETE /ideas/1
  # DELETE /ideas/1.json                                  HTML AND AJAX
  #-------------------------------------------------------------------
  def destroy

    @idea.destroy if !@idea.nil?
    respond_to do |format|
      format.json { render :json => {data: @idea.to_json, success: true}, :status => 200 }
      format.html { flash[:notice] = "Idea deleted."
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
  def create
    @idea = Idea.new(params[:idea])

    if @idea.save
      @locals = {:info => [:notice => "New idea created."], :success => true}
    else
      @locals = {:info => [:error => @idea.errors.full_messages.to_a], :success => false}
    end
    render :json => @locals
  end

  def upvote
    vote('up')
  end

  def downvote
    vote('down')
  end

  private
  def vote(type)
    @idea = Idea.find(params[:id])
    if current_user.present?
      votable = true
      # search votes by date in descending order, get latest vote of this user and break with outcome
      @idea.voted_by.sort_by{|hsh| hsh["last_vote"]}.reverse.each do |voter|
        next if voter["uid"] != current_user.id
        voter["last_vote"] < 1.day.ago ? votable = true : votable = false
        break
      end
      # error or log vote
      if !votable
        @locals = {:info => [:error => "Already voted."], :success => false}
      else
        @idea.voted_by.push({:uid => current_user.id,:last_vote =>Time.now})
        type == 'up' ? @idea.votes += 1 : @idea.votes = @idea.votes - 1
        # update vote count
        params[:idea].delete(:id)
        if @idea.update_attributes(params[:idea])
          @locals = {:info => [:notice => "Idea updated."], :success => true}
        else
          @locals = {:info => [:error => @idea.errors.full_messages.to_a], :success => false}
        end
      end
    else
      @locals = {:info => [:error => "Not logged in."], :success => false}
    end
    render :json => @locals
  end

end

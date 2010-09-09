class ComponentsController < ApplicationController
  # GET /components
  # GET /components.xml
  def index
    api_key = params[:api_key] or raise 'Missing API key'
    
    api_key && (account = User.find_by_single_access_token(api_key) or raise 'Bad API key')
    
    #api_key && (account = User.find_by_api_key(api_key) or error = 'Bad API key')
    #account && (username = params[:name] or error = 'Missing username')
    #email && (user = User.find_by_email(name) or error = 'Bad username')
    unless account
      return render :text => error, :status => :unprocessable_entity
    end
    
    @components = Component.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @components }
    end
  end
  
  # GET /components/1
  # GET /components/1.xml
  def show
    @component = Component.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @component }
    end
  end
  
  # GET /components/new
  # GET /components/new.xml
  def new
    @component = Component.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @component }
    end
  end
  
  # GET /components/1/edit
  def edit
    @component = Component.find(params[:id])
  end
  
  # POST /components
  # POST /components.xml
  def create
    c_n = params[:comp_name]
    v_num = params[:version]
    comp = {}
    ver = {}
    comp["name"] = c_n
    comp["c_type"] = "gem"
    Component.create(comp)
    last_id = Component.last.id
    ver["version_num"] = v_num
    ver["component_id"] = last_id
    Version.create(ver)
    @component = Component.new(params[:component])
    respond_to do |format|
      if @component.save
        flash[:notice] = 'Component was successfully created.'
        format.html { redirect_to(@component) }
        format.xml { render :xml => @component, :status => :created, :location => @component }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @component.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /components/1
  # PUT /components/1.xml
  def update
    @component = Component.find(params[:id])
    
    respond_to do |format|
      if @component.update_attributes(params[:component])
        flash[:notice] = 'Component was successfully updated.'
        format.html { redirect_to(@component) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @component.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /components/1
  # DELETE /components/1.xml
  def destroy
    @component = Component.find(params[:id])
    @component.destroy
    
    respond_to do |format|
      format.html { redirect_to(components_url) }
      format.xml { head :ok }
    end
  end
  
end
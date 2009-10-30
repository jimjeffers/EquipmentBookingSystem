class ItemsController < ApplicationController
  layout 'admin'
  before_filter :login_required
  before_filter :get_categories
  
  # GET /items
  # GET /items.xml
  def index
    @items = Item.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(edit_item_path(@item)) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(items_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  # POST /items/search
  def search
    if !params[:search].blank?
      if !params[:category_id].blank?
        @items = Item.find_tagged_with(params[:search])
      else
        @items = Item.find_tagged_with(params[:search], :conditions => ["category_id=?",params[:category_id]])
      end
    elsif !params[:category_id].blank?
      @items = Item.find_all_by_category_id(params[:category_id])
    else
      @items = Item.all
    end
    respond_to do |format|
      format.html { render :action => 'index' }
      format.text  { render :partial => 'items_list.html' }
    end
  end
  
  protected
  # Retrieves top level categories for templates.
  def get_categories
    @categories = Category.root_level
  end
end

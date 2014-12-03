class SystemusersController < ApplicationController
  # GET /systemusers
  # GET /systemusers.json
  def index
    @systemusers = Systemuser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @systemusers }
    end
  end

  # GET /systemusers/1
  # GET /systemusers/1.json
  def show
    @systemuser = Systemuser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @systemuser }
    end
  end

  # GET /systemusers/new
  # GET /systemusers/new.json
  def new
    @systemuser = Systemuser.new
    @id = nil

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @systemuser }
    end
  end

  # GET /systemusers/1/edit
  def edit
    @systemuser = Systemuser.find(params[:id])
  end

  # POST /systemusers
  # POST /systemusers.json
  def create
    @systemuser = Systemuser.new(params[:systemuser])
    @systemuser.name = params[:systemuser][:name]
    
    if params[:systemuser][:group_id] == 4
      @systemuser.ro = 1
    else
      @systemuser.ro = 0
    end
    
    @systemuser.enabled = 1

    respond_to do |format|
      if @systemuser.save
        format.html { redirect_to systemusers_path, notice: 'Wizard user was successfully created.' }
        format.json { render json: @systemuser, status: :created, location: @systemuser }
      else
        format.html { render action: "new" }
        format.json { render json: @systemuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /systemusers/1
  # PUT /systemusers/1.json
  def update
    @systemuser = Systemuser.find(params[:id])

    if params[:systemuser][:group_id] == 4
      @systemuser.ro = 1
    else
      @systemuser.ro = 0
    end

    respond_to do |format|
      if @systemuser.update_attributes(params[:systemuser])
        format.html { redirect_to systemusers_path, notice: 'Wizard user was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @systemuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /systemusers/1
  # DELETE /systemusers/1.json
  def destroy
    @systemuser = Systemuser.find(params[:id])
    @systemuser.destroy

    respond_to do |format|
      format.html { redirect_to systemusers_url }
      format.json { head :ok }
    end
  end
end

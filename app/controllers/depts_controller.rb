class DeptsController < ApplicationController
  def index
    @depts = Dept.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @depts }
    end
  end

  def show
    @dept = Dept.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @dept }
    end
  end

  def new
    @dept = Dept.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @dept }
    end
  end

  def edit
    @dept = Dept.find_by_did(params[:id])
  end

  def create
    @dept = Dept.new(params[:dept])

    conn = ActiveRecord::Base.connection
    begin
      conn.execute("insert into dept (did, budget, managerid) \
                   values ( \
                    '#{params[:dept][:did]}', \
                    '#{params[:dept][:budget]}', \ 
                    '#{params[:dept][:managerid]}')")
    rescue => err
      if err.message =~ /FK_MANAGERID/
        flash[:notice] = 'Manager must be an employee'
      else
        flash[:notice] = err.message
      end
    end

    if flash[:notice]
      render :action => "new" 
    else
      redirect_to :action => :index
    end

  end

  # PUT /depts/1
  # PUT /depts/1.json
  def update
    @dept = Dept.find_by_did(params[:id])

    conn = ActiveRecord::Base.connection
    begin
      conn.execute("update dept set
                 budget = '#{params[:dept][:budget]}',
                 managerid = '#{params[:dept][:managerid]}'
                 where did = #{@dept.did} ")
    rescue => err
      flash[:notice] = err.message
    end
    if flash[:notice]
      render :action => "edit" 
    else
      redirect_to :action => :index
    end
  end

  # DELETE /depts/1
  # DELETE /depts/1.json
  def destroy
    @dept = Dept.find(params[:id])
    @dept.destroy

    respond_to do |format|
      format.html { redirect_to depts_url }
      format.json { head :no_content }
    end
  end
end

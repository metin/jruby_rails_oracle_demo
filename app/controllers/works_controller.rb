class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find(params[:id])
  end

  def create
    @work = Work.new(params[:work])
    conn = ActiveRecord::Base.connection
    begin
      conn.execute("insert into works (did, eid, pct_time) \
                   values ( \
                    '#{params[:work][:did]}', \
                    '#{params[:work][:eid]}', \ 
                    '#{params[:work][:pct_time]}')")
    rescue => err
      flash[:notice] = err.message
    end
    if flash[:notice]
      render :action => "new" 
    else
      redirect_to :action => :index
    end
  end

  def update
    @work = Work.find(params[:id])
    respond_to do |format|
      if @work.update_attributes(params[:work])
        format.html { redirect_to @work, :notice => 'Work was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy
    redirect_to works_url
  end
end

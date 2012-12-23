class EmpsController < ApplicationController

  def index
    @emps = Emp.all
  end

  def show
    @emp = Emp.find(params[:id])
  end

  def new
    @emp = Emp.new
  end

  def edit
    @emp = Emp.find_by_eid(params[:id])

  end

  def create
    #conn.execute(["insert into emp (eid, ename, age, salary) values (:eid, :ename, :age, :salary)", params[:emp]])
    @emp = Emp.new(params[:emp])
    # if @emp.save
    #   redirect_to @emp, :notice => 'Emp was successfully created.'
    # else
    #   render :action => "new" 
    # end
    conn = ActiveRecord::Base.connection
    begin
      conn.execute("insert into emp (eid, ename, age, salary) \
                   values ( \
                    '#{params[:emp][:eid]}', \
                    '#{params[:emp][:ename]}', \ 
                    '#{params[:emp][:age]}', \
                    '#{params[:emp][:salary]}')")
    rescue => err
      if err.message =~ /SYS_C00263590/
        flash[:notice] = 'Salary cant be less than 10000'
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

  def update
    @emp = Emp.find_by_eid(params[:id])
    conn = ActiveRecord::Base.connection
    begin
      conn.execute("update emp set
                 ename = '#{params[:emp][:ename]}',
                 age = '#{params[:emp][:age]}',  
                 salary = '#{params[:emp][:salary]}'
                 where eid = #{@emp.eid} ")
    rescue => err
      flash[:notice] = err.message
    end
    if flash[:notice]
      render :action => "edit" 
    else
      redirect_to :action => :index
    end
  end

  def destroy
    @emp = Emp.find(params[:id])
    @emp.destroy
  end
end

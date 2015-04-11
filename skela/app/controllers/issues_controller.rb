class IssuesController < ApplicationController
  before_filter :authenticate, except: [:index, :show]
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  def index
    @issues = Issue.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /issues/1
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new(creator: current_user)
    respond_to do |format|
      if @issue.save
        format.js
      end
    end
  end

  # GET /issues/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /issues
  def create
    @issue = Issue.new(issue_params)
    @issue.creator = current_user
    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue created successfully!' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  def update
    # if issue_params.include? 'tester_id'
    #   if issue_params['tester_id'].blank?
    #     @issue.tested_at = nil
    #   else
    #     @issue.tested_at = Time.now
    #   end
    # end

    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to edit_issue_path(@issue), notice: 'Issue updated successfully!' }
        flash[:notice] = 'Issue updated successfully'
        format.js { }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  def destroy
    @issues = Issue.all
    if @issue.destroy
      # redirect_to issues_path
      # return
    end
    respond_to do |format|
      # format.html { redirect_to issues_url, notice: 'Issue destroyed successfully!' }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id]) rescue redirect_to(issues_path)

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:title, :description, :how_to_test, :completed, :assignee_id, :tester_id, :category,
                                    :target_version, :created_at, :updated_at, :completed_at, :tested_at, :assigned_at)
    end
end

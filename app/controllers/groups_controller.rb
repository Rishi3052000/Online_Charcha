class GroupsController < ApplicationController
  before_action :authenticate_user!
  def index
    @group = Group.new
    @groups = Group.public_groups
    
    
    
    @users = User.all_except(current_user)
    render 'index'
  end

  def show
    @single_group = Group.find(params[:id])

    @group = Group.new
    @groups = Group.public_groups

    @message = Message.new
    @messages = @single_group.messages.order(created_at: :asc)

    @users = User.all_except(current_user)
    render 'index'
  end

  def create
    @group = Group.create(name: params['group']['name'])
  end
end

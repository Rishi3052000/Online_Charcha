class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all_except(current_user)

    @group = Group.new
    @groups = Group.public_groups
    @group_name = get_name(@user, current_user)
    @single_group = Group.where(name: @group_name).first || Group.create_private_group([@user, current_user], @group_name)

    @message = Message.new
    @messages = @single_group.messages.order(created_at: :asc)
    render 'groups/index'
  end

  private

  def get_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end
end

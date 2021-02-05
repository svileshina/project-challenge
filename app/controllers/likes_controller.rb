class LikesController < ApplicationController
  before_action :set_dog
  before_action :set_like, only: :destroy

  def create
    unless already_liked?
      @dog.likes.create(user_id: current_user.id)
      redirect_to @dog
    end
  end
  
  def destroy
    if already_liked?
      @like.destroy
      redirect_to @dog
    end
  end

  private

  def set_dog
    @dog = Dog.find(params[:dog_id])
  end

  def set_like
    @like = @dog.likes.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, dog_id: @dog.id).exists?
  end
end
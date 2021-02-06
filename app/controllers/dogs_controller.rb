class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  before_action :set_like, only: [:show]

  def index
    @dogs = Dog.page(params[:page])
  end

  def show; end

  def new
    @dog = Dog.new
  end

  def edit; end

  def create
    @dog = Dog.new(dog_params)

    respond_to do |format|
      if @dog.save
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @dog
    respond_to do |format|
      if @dog.update(dog_params)
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_dog
      @dog = Dog.find(params[:id])
      authorize @dog
    end

    def set_like
      @like = Like.find_by(user_id: current_user.id, dog_id: @dog.id)
    end

    def dog_params
      params.require(:dog).permit(:name, :description, images: [])
    end
end

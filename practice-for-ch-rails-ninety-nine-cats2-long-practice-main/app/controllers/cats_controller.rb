class CatsController < ApplicationController
  before_action :require_logged_in, :require_authorization, only: [:edit, :update]


  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = current_user.cats.find(params[:id])
    render :edit
  end

  def update
    @cat = current_user.cats.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def edit
    @cat =
  end

  private

  def require_authorization
    @cat = current_user.cats.find_by(id: params[:id])
    redirect_to cats_url unless @cat
  end

  def cat_params
    params.require(:cat).permit(:birth_date, :owner_id, :color, :description, :name, :sex)
  end
end

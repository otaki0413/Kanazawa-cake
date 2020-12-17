class Admin::GenresController < ApplicationController

  # ログイン認証されていなければ、ログイン画面へリダイレクト
  before_action :authenticate_admin!

  def index
    @newgenre = Genre.new
    @genres = Genre.all
  end

  # ジャンル新規登録
  def create
    @newgenre = Genre.new(genre_params)
    @newgenre.save
    flash[:notice] = "You have created new genre successfully."
    redirect_to admin_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  # ジャンル更新
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "You have updated genre successfully."
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  # ジャンル削除
  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to admin_genres_path
  end

  # ストロングパラメータ
  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

end


class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :set_login, only: [:new, :edit, :show] # ログインしていないとトップに戻す

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。

    # 0212 追記 画像保存（create）の際に、キャッシュから画像を復元してから保存する
    @picture.image.retrieve_from_cache! params[:cache][:image]
    @picture.save!

    # 0215 追記
    # binding.pry

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    # @picture = Picture.new(picture_params) なんか違うらしい
    # binding.pry

    # 0212 追記
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。


    # 0215 追記
    # binding.pry

    # 0212 追記 こちらを生かすとダメみたい。。。
    # @picture = current_user.picture.build(picture_params)

    render :new if @picture.invalid?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:title, :content, :image, :user_id)
    end

    # ログインしないと投稿、編集、詳細が開けないようにする
    def set_login
      # binding.pry
      unless !current_user.nil?
        redirect_to tops_path, notice:"まずはログインしたまえ！"
      end
    end

end
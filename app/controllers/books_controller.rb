class BooksController < ApplicationController
	before_action :authenticate_user! 
	before_action :correct_user, only: [:edit, :update]


  def show
		@book = Book.find(params[:id])
		@user = @book.user
		@books =Book.new
  end

  def index
		@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall あれ、これがある、、、ないと思った
		@book = Book.new
  end

  def create
		@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
		@book.user_id = current_user.id
    # 意味：user_idがnilのままだと、子モデルのbookの方が保存できない
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
			@books = Book.all
  		render action: :index
  	end
  end

  def edit
		@book = Book.find(params[:id])
		

  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
			render "edit"
			
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

	def correct_user
    @book = Book.find(params[:id])
    # まず本を取り出した 重要
    @user = @book.user
    # 本に結びついたユーザーを取り出す
    if current_user != @user
      redirect_to books_path
    # 正しいユーザーではない場合本一覧に戻す
    end
  end
end

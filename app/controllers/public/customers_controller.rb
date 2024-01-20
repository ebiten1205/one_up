class Public::CustomersController < ApplicationController
  
   # 今回の場合はIDでデータを分けていないため、ログインしているcustomerという形で
  # 定義してあげるといい。ログインしているcustomer＝current_customer
  def show
    @customer = current_customer
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
  end
  
  def withdrawal
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  def edit
    #@customer = current_customer
    @customer = Customer.find(params[:id])
    if @customer.id != current_customer.id
	    redirect_to root_path
    end
  end
# findメソッドは:idのようにidを探すときに使えるものである。
  def update
		#@customer = current_customer
		@customer = Customer.find(params[:id])
		if @customer.update(customer_params)
			if customer_signed_in?
				flash[:notice] = "登録情報が更新されました。"
				redirect_to customers_my_page_path
			else
			  flash[:notice] = "項目を正しく記入してください"
				redirect_to customers_edit_path
			end
		end
  end
  
  def liked_posts
    @liked_posts = Post.liked_posts(current_customer, params[:page], 12)
  end
  
  # フォロー一覧
def follows
  @customer = Customer.find(params[:id])
  @customers = @customer.following_customers
end

# フォロワー一覧
def followers
  @customer = Customer.find(params[:id])
  @customer = @customer.follower_customers
end
	
	private
	
	def customer_params
	   params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana, :email)
	end
	
end
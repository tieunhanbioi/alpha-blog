require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    # @category = Category.create(name: "sports")
    @category = Category.new(:name => "sports")
    @category.save
    @user = User.create(:username => "anhhungca", :password => "tieunhan", :email => "anhhungca@gmail.com", :admin => true)
  end
   test "should get categories index" do
     get categories_path
     assert_response :success
   end

   test "should get new" do
     # get new_category_path
     # sign_in_as(@user, "tieunhan")
     post "http://localhost:3000/login", params: { session: { email: @user.email, password: "tieunhan" }}
     
     get "http://localhost:3000/categories/new"
     assert_response :success
     # debugger
   end

   test "should get show" do
     get category_path(@category)
     assert_response :success
   end

   test "should redirect create when admin not logged in" do
     # assert that there is no difference when posting params to categories#create
     assert_no_difference 'Category.count' do
       post categories_path, params: {category: {name: "sports" }}
     end
      assert_redirected_to categories_path
   end
end

require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

   test "get new category form and create category" do

     # get new_category_path
     # get the require url
     get "http://localhost:3000/categories/new"
     # assert that the requested template is indeed categories/new
     assert_template 'categories/new'
     # assert that there is a difference of one more item in the database if post
     # to "http://localhost:3000/categories" with the parameters
     # params: {category: {name: 'sports'}} , follow the redirect_to from the
     # categories#new action , assert that the response is success
     assert_difference 'Category.count', 1 do
     # post categories_path, params: {category: {name: 'sports'}}
     post "http://localhost:3000/categories", params: {category: {name: 'sports'}}
     follow_redirect!
     assert_response :success

     end
     assert_template "categories/index"
     assert_match "sports", response.body
   end

   test "invalid category submission results in failure" do

     # get the require url
     get "http://localhost:3000/categories/new"
     # assert that the requested template is indeed the categories/new
     assert_template 'categories/new'
     #assert that there is no difference if http://localhost:3000/categories is
     #posted with empty name attribute , aka categories#create
     assert_no_difference 'Category.count' do
     post "http://localhost:3000/categories", params: {category: {name: ''}}
     end
     # this is the else part of the if else statement , assert that the template
     # is still categories/new after being rerendered
     # assert that h2.panel-title and div.panel-body are presents, which means
     # we have errors
     assert_template "categories/new"
     assert_select "h2.panel-title"
     assert_select "div.panel-body"
   end
end

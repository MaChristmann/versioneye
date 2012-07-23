require 'spec_helper'

describe "follow and unfollow" do

  it "do follow successfully" do 
  	product = Product.new
  	product.versions = Array.new
    product.name = "json_goba"
    product.name_downcase = "json_goba"
    product.prod_key = "json_goba"
    product.prod_type = "RubyGem"
    product.language = "Ruby"
    product.version = "1.0"
    version = Version.new
    version.version = "1.0"
    product.versions.push(version)
    product.save

    user = User.default
    user.save

    post "/sessions", :session => {:email => user.email, :password => user.password}
    assert_response 302
    response.should redirect_to("/news")

    get "/package/json_goba"
    assert_response :success
    assert_tag :tag => "input", :attributes => { :class => "followButtonBig", :type => "submit", :value => "Follow" }

    post "/package/follow", :product_key => "json_goba"
    assert_response 302
    response.should redirect_to("/package/json_goba/version/1~0")

    get "/package/json_goba/version/1~0"
    assert_tag :tag => "input", :attributes => { :class => "unfollowButtonBig", :type => "submit", :value => "Unfollow" }

    post "/package/unfollow", :product_key => "json_goba", :src_hidden => "detail"
    assert_response 302
    response.should redirect_to("/package/json_goba/version/1~0")

    get "/package/json_goba/version/1~0"
    assert_tag :tag => "input", :attributes => { :class => "followButtonBig", :type => "submit", :value => "Follow" }
    
    user.remove
    product.remove
  end

end
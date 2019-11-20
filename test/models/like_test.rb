require 'test_helper'

class LikeTest < ActiveSupport::TestCase
<<<<<<< HEAD

  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
    @like = Like.create(user_id: @user.id, post_id: @micropost.id)
  end

  test "user_id should be present" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "post_id should be present" do
    @like.post_id = nil
    assert_not @like.valid?
  end
=======
  # test "the truth" do
  #   assert true
  # end
>>>>>>> user-myposts
end

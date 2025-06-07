require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:post) { create(:post, title: "Test Title", content: "Test Content") }

  describe "GET /index" do
    it "returns a successful response" do
      get posts_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Test Title")
    end
  end

  describe "GET /show" do
    it "shows a post" do
      get post_path(post)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Test Content")
    end
  end

  describe "PATCH /update" do
    it "updates a post" do
      patch post_path(post), params: { post: { title: "Updated Title" } }
      expect(response).to redirect_to(post_path(post))
      follow_redirect!
      expect(response.body).to include("Updated Title")
    end
  end

  describe "DELETE /destroy" do
    it "deletes the post" do
      expect {
        delete post_path(post)
      }.to change(Post, :count).by(-1)
      expect(response).to redirect_to(posts_path)
    end
  end
end

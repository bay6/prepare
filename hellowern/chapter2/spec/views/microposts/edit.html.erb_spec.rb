require 'spec_helper'

describe "microposts/edit" do
  before(:each) do
    @micropost = assign(:micropost, stub_model(Micropost,
      :content => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit micropost form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", micropost_path(@micropost), "post" do
      assert_select "input#micropost_content[name=?]", "micropost[content]"
      assert_select "input#micropost_user_id[name=?]", "micropost[user_id]"
    end
  end
end

require 'spec_helper'

describe "microposts/new" do
  before(:each) do
    assign(:micropost, stub_model(Micropost,
      :content => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new micropost form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", microposts_path, "post" do
      assert_select "input#micropost_content[name=?]", "micropost[content]"
      assert_select "input#micropost_user_id[name=?]", "micropost[user_id]"
    end
  end
end

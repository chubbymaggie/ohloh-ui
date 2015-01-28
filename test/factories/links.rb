FactoryGirl.define do
  sequence :link_title do |n|
    "link number #{ n }"
  end

  sequence :link_url do |n|
    "http://example#{n}.com/"
  end

  factory :link do
    title { generate(:link_title) }
    url { generate(:link_url) }
    link_category_id Link::CATEGORIES.values.last(6).sample
    before(:create) { |instance| instance.editor_account = create(:admin) }
  end
end
